component extends="base"
	accessors="true"
{ 
	property saltAndHashService;
	property twoService;
	variables.mailService = new subsystems.mail.model.services.sendMail();

	public void function loginAct(struct rc)
	{
		try {
			user = entityLoadByPk('User', lcase(rc.email));
		}
		catch (any e)
		{
			writedump(e);
			abort;
			rc.message = new model.beans.message(type="danger", message=e.message);
			fw.redirect(action='auth:main.login', preserve="all");
		}

		var isLoggedIn = false;
		if (!IsDefined("user"))
		{
			cookie.email = '';
			// log bad email
			var eventLog = entityNew('EventLog',{
				email=rc.email,
				filter='login',
				action=fw.getFullyQualifiedAction(),
				event='Email not found in system.',
				severity='error'
			});
			entitySave(eventLog);
			// bad password message and redirect
			rc.message = new model.beans.message(
				type="danger",
				message="That email address could not be found in our system."
			);
			rc.message.addControl(id='email', type='danger', helptext="Maybe you had a typo in your email address?");
			rc.message.addControl(id='password', type='danger');
			fw.redirect(action='auth:main.login', preserve="all");
		} else {
			// if (!user.getStaff_yn())
			// {
			// 	rc.message = new model.beans.message(
			// 		type="warning",
			// 		message="This account has been disabled. Please contact an {link}administrator{/link} for additional assistance.",
			// 		link="mailto:rkilian@icf.com?subject=" & encodeForHTML(fw.getConfig().sitebrand & " login assistance") & "&body=" & encodeForHTML("My account using [" & rc.email & "] has been disabled.  Please advise." ) 
			// 	);
			// 	fw.redirect(action='auth:main.login', preserve='all');
			// }
			if (user.getIs_Locked())
			{
				// log event
				var log = entityNew('EventLog',{
					email=rc.email,
					filter='login',
					action=fw.getFullyQualifiedAction(),
					event='Account locked',
					severity='error', //'info','warning','error','debug'
					detail=''
				});
				entitySave(log);
				rc.message = new model.beans.message(
					type="danger",
					message="This account is currently locked. Please contact an {link}administrator{/link} for additional assistance.",
					link="mailto:rkilian@icf.com?subject=" & encodeForHTML(fw.getConfig().sitebrand & " login assistance") & "&body=" & encodeForHTML("My account using [" & rc.email & "] has been locked.  Please advise." ) 
					);
				fw.redirect(action='auth:main.login', preserve="all");
			}
			if (user.getIs_password_change_required())
			{
				// log event
				var log = entityNew('EventLog',{
					email=rc.email,
					filter='login',
					action=fw.getFullyQualifiedAction(),
					event='Password change requried',
					severity='info', //'info','warning','error','debug'
					detail=''
				});
				entitySave(log);
				rc.token = user.getToken();
				rc.message = new model.beans.message(
					type="info",
					message="Please update your password. In some cases the minimum requirements have changed.");
				ORMFlush();
				fw.redirect(action='auth:main.resetPassword', preserve="all");
			}

			// check the password
			isLoggedIn = variables.saltAndHashService.validateHashedString(
				stringToBeHashed = rc.password,
				salt = user.getSalt(),
		        hashMethod = 512,
				hashedString = user.getPassword_hash()
			);
			if (isLoggedIn) 
			{
				// log event
				var log = entityNew('EventLog',{
					email=rc.email,
					filter='login',
					action=fw.getFullyQualifiedAction(),
					event='Successful login',
					severity='info', //'info','warning','error','debug'
					detail=''
				});
				entitySave(log);
				if (user.getIs_mfa_exempt() OR isDefined('cookie.MAS'))
				{
					// log event
					var log = entityNew('EventLog',{
						email=user.getEmail(),
						filter='login',
						action=fw.getFullyQualifiedAction(),
						event='MFA exempt',
						severity='warning', //'info','warning','error','debug'
						detail='User was not prompted for TOTP code'
					});
					entitySave(log);
					cookie name="email" value=user.getEmail() httpOnly="true" secure="false";
					//session.email = user.getEmail();
					
					user.setLast_login(dateConvert('local2UTC',now()));
					user.setLogin_attempts(0);
					ORMFlush();
					fw.redirect(action=':main.default', preserve="all");
				} else {
					if (len(user.getSecret32()) eq 0)
					{
						fw.redirect(action='auth:main.setupOTP',querystring='email=' & user.getEmail());
					} else {
						fw.redirect(action='auth:main.checkOTP', querystring='email=' & user.getEmail());
					}					
				}
			} else {
				// log event
				var log = entityNew('EventLog',{
					email=user.getEmail(),
					filter='login',
					action=fw.getFullyQualifiedAction(),
					event='Login failed',
					severity='error', //'info','warning','error','debug'
					detail='Password error'
				});
				entitySave(log);
				rc.message = new model.beans.message(
					type="warning",
					message="That email/password combination could not be found in our system."
				);
				user.setLogin_attempts(user.getLogin_attempts() + 1);
				if (user.getLogin_attempts() gte 5)
				{
					user.setIs_locked(true);
				}
				ORMFlush();
				rc.message.addControl(id="email", type="warning");
				rc.message.addControl(id="password", type="warning");

				fw.redirect(action='auth:main.login', preserve="all");
			} 
		}
	}

 	public void function logout(struct rc)
 	{
 		var user = entityLoadByPk('User', cookie.email);
 		cookie.email = '';

 		// log event
 		var log = entityNew('EventLog',{
 			email=user.getEmail(),
 			filter='logout',
 			action=fw.getFullyQualifiedAction(),
 			event='Successful logout',
 			severity='info', //'info','warning','error','debug'
 			detail=''
 		});
 		entitySave(log);
 		fw.redirect(action='auth:main.login');
 	}

 	public void function forgotAct(struct rc) 
 	{
 		var user = entityLoadByPk('User', lcase(rc.email));
 		if (!IsDefined('user'))
 		{
 			rc.message = createObject('model.beans.message').init(
 				message = 'That email address was not found in our system.',
 				type = 'danger'
 			);
 			// log event
 			var log = entityNew('EventLog',{
 				email=rc.email,
 				filter='password',
 				action=fw.getFullyQualifiedAction(),
 				event='Reset password request failed',
 				severity='warning', //'info','warning','error','debug'
 				detail='The user requested a password reset request for an email address that we do not have on file.'
 			});
 			entitySave(log);
 			fw.redirect(action='auth:main.forgot', preserve='all');
 		} else if (user.getLocked_yn()) {
 			// log event
 			var log = entityNew('EventLog',{
 				email=rc.email,
 				filter='password',
 				action=fw.getFullyQualifiedAction(),
 				event='Reset password request failed',
 				severity='error', //'info','warning','error','debug'
 				detail='The user requested a password reset on a locked account.'
 			});
 			entitySave(log);
 			rc.message = new model.beans.message(
				message="This account is currently locked. Please contact an {link}administrator{/link} for additional assistance.",
				link="mailto:rkilian@icf.com?subject=" & encodeForHTML(fw.getConfig().sitebrand & " login assistance") & "&body=" & encodeForHTML("My account using [" & user.getEmail() & "] has been locked.  Please advise." ) 
 			);
 			fw.redirect(action='auth:main.login', preserve='all');
 		} else {
 			user.generateToken();
 			ORMFlush();
 		}

		if (fw.getConfig().siteSSL)
		{
			var protocol = 'https://';
		} else {
			var protocol = 'http://';
		}
		var strings = {
			"resetLink" = protocol & cgi.SERVER_NAME & '/index.cfm?action=auth:main.resetPassword&token_txt=' & user.getToken_txt(),	
			"passwordResetURL" = protocol & cgi.SERVER_NAME & '/index.cfm?action=auth:main.forgot'
		};

 		mailService.send(
 			site=fw.getConfig().site, 
 			siteSSL=fw.getConfig().siteSSL,
 			template="passwordReset",
 			to=user.getEmail(), 
 			subject=fw.getConfig().siteName & ": Password Reset",
 			strings=strings
 		); 			

 		// log event
 		var log = entityNew('EventLog',{
 			email=rc.email,
 			filter='password',
 			action=fw.getFullyQualifiedAction(),
 			event='Password reset request',
 			severity='info', //'info','warning','error','debug'
 			detail=''
 		});
 		entitySave(log);
 		rc.message = createObject('model.beans.message').init(
 			heading = 'Note',
 			message = 'An email has been sent to you with a link to reset your password',
 			type = 'info'
 		);
 		fw.redirect(action='auth:main.login', preserve="all");
 	}

 	public void function resetPassword(struct rc)
 	{
 		var user = entityLoad('User', {token_txt=rc.token_txt}, true);

 		if(!isDefined('user'))
 		{
 			// log event
 			var log = entityNew('EventLog',{
 				email='not available',
 				filter='password',
 				action=fw.getFullyQualifiedAction(),
 				event='Stale password reset token',
 				severity='error', //'info','warning','error','debug'
 				detail='An expired password reset link was used.'
 			});
 			entitySave(log);
 			rc.message = new model.beans.message(
				type="danger",
				message="The reset link used is no longer valid."
			);
	 		fw.redirect(action='auth:main.forgot', preserve='all');
 		}
 	}

 	public void function resetPasswordAct(struct rc)
 	{
 		// validate password
 		if (!refind("^[a-zA-Z0-9?!@##$%^&*\.-]{8,}$", rc.password))
 		{
 			rc.message = new model.beans.message(
 				type="danger",
 				message="There was a problem with the structure of your new password.");
 			fw.redirect(action='auth:mypref.passpage', preserve='all');
 		}
 		var user = entityLoad('User', {token_txt=rc.token_txt}, true);
  		var pwHistAry = entityLoad('PasswordHistory',{email=user.getEmail()});
 		for (i=1; i <= arrayLen(pwHistAry); i++)
 		{
 			if(saltAndHashService.validateHashedString(
 				stringToBeHashed = rc.password,
 				salt = pwHistAry[i].getSalt_txt(),
 				hashMethod = "512",
 				hashedString = pwHistAry[i].getPassword_hash_txt()
 				))
 			{
 				rc.message = new model.beans.message(
 					type="warning",
 					message="This password has been used recently.  Please choose another.");
 					// log event
		 		var log = entityNew('EventLog',{
		 			email=user.getEmail(),
		 			filter='password',
		 			action=fw.getFullyQualifiedAction(),
		 			event='Recent password reuse attempted.',
		 			severity='warning', //'info','warning','error','debug'
		 			detail='User attempted to change their password to one of their recent old passwords.'
		 		});
		 		entitySave(log);
		 		ORMFlush();
		 		fw.redirect(action='auth:main.resetPassword', preserve="all");
 			}
 		}
 		var pw = saltAndHashService.saltAndHash(rc.password);
  		var pwh = entityNew('PasswordHistory');
 		entitySave(pwh);
 		pwh.setEmail(user.getEmail());
 		pwh.setPassword_hash_txt(pw.hashedString);
 		pwh.setSalt_txt(pw.salt);
 		user.setPassword_hash_txt(pw.hashedString);
 		user.setSalt_txt(pw.salt);
 		user.setToken_txt('');
 		user.setLogin_attempts(0);
 		user.setLocked_yn(false);
 		user.setPassword_change_required_yn(false);
 		// log event
 		var log = entityNew('EventLog',{
 			email=user.getEmail(),
 			filter='password',
 			action=fw.getFullyQualifiedAction(),
 			event='Password reset',
 			severity='info', //'info','warning','error','debug'
 			detail='User updated their password using the forgot password link.'
 		});
 		entitySave(log);

 		ORMFlush();
 		rc.message = new model.beans.message(
 			type="info",
 			message="You have been logged out. Please login with your new password");
 		fw.redirect(action='auth:main.login', preserve="all");
 	}


public void function changePasswordAct(struct rc)
 	{
 		// validate password
 		if (!refind("^[a-zA-Z0-9?!@##$%^&*\.-]{8,}$", rc.password))
 		{
 			rc.message = new model.beans.message(
 				type="danger",
 				message="There was a problem with the structure of your new password.");
 			fw.redirect(action='auth:main.resetPassword', preserve='all');
 		}

 		var user = entityLoadByPk('User', lcase(cookie.email));
 		var pwHistAry = entityLoad('PasswordHistory',{email=user.getEmail()});
 		for (i=1; i <= arrayLen(pwHistAry); i++)
 		{
 			if(saltAndHashService.validateHashedString(
 				stringToBeHashed = rc.password,
 				salt = pwHistAry[i].getSalt_txt(),
 				hashMethod = "512",
 				hashedString = pwHistAry[i].getPassword_hash_txt()
 				))
 			{
 				rc.message = new model.beans.message(
 					type="warning",
 					message="This password has been used recently.  Please choose another.");
 					// log event
		 		var log = entityNew('EventLog',{
		 			email=user.getEmail(),
		 			filter='password',
		 			action=fw.getFullyQualifiedAction(),
		 			event='Recent password reuse attempted.',
		 			severity='warning', //'info','warning','error','debug'
		 			detail='User attempted to change their password to one of their recent old passwords.'
		 		});
		 		entitySave(log);
		 		ORMFlush();
		 		fw.redirect(action='auth:mypref.passpage', preserve="all");
 			}
 		}

 		var pw = saltAndHashService.saltAndHash(rc.password);
 		var pwh = entityNew('PasswordHistory');
 		entitySave(pwh);
 		pwh.setEmail(user.getEmail());
 		pwh.setPassword_hash_txt(pw.hashedString);
 		pwh.setSalt_txt(pw.salt);
 		user.setPassword_hash_txt(pw.hashedString);
 		user.setSalt_txt(pw.salt);
 		user.setToken_txt('');
 		user.setLogin_attempts(0);
 		user.setLocked_yn(false);
 		user.setPassword_change_required_yn(false);
 		// log event
 		var log = entityNew('EventLog',{
 			email=user.getEmail(),
 			filter='password',
 			action=fw.getFullyQualifiedAction(),
 			event='Password change',
 			severity='info', //'info','warning','error','debug'
 			detail='User updated their password on the site after authenticating.'
 		});
 		entitySave(log);

 		ORMFlush();
 		StructClear(session);
 		rc.message = new model.beans.message(
 			type="info",
 			message="You have been logged out. Please login with your new password");
 		fw.redirect(action='auth:main.login', preserve="all");
 	}

 	public void function setupOTP(struct rc)
 	{
 		var user = entityLoadByPk('User',rc.email);
 		if (len(user.getSecret32()) eq 0)
 		{
 			user.setSecret32(twoService.generateKey(user.getEmail()));
 		}
 		rc.secret32 = user.getSecret32();
 		rc.qrURL = twoService.getOTPURL(user.getEmail(), user.getSecret32(), fw.getConfig().SiteBrand & ' ' & fw.getConfig().SiteName);
 	}

 	public void function setupOTPAct(struct rc)
 	{
 		var user = entityLoadByPk('User',rc.email);
 		var isValid = twoService.verifyGoogleToken(user.getSecret32(),rc.code);
 		if (isValid)
 		{
			// session.email = user.getEmail();
			cookie name="email" value=user.getEmail() httpOnly="true" secure="false";
			user.setLast_login_dtm(now());
			user.setLogin_attempts(0);
			ORMFlush();
			// log event
			var log = entityNew('EventLog',{
				email=user.getEmail(),
				filter='auth',
				action=fw.getFullyQualifiedAction(),
				event='Successful MFA authentication',
				severity='info', //'info','warning','error','debug'
				detail=''
			});
			entitySave(log);
			fw.redirect(action=':main.default');
 		} else {
 			// log event
 			var log = entityNew('EventLog',{
 				email=user.getEmail(),
 				filter='auth',
 				action=fw.getFullyQualifiedAction(),
 				event='MFA authentication failure',
 				severity='warning', //'info','warning','error','debug'
 				detail=''
 			});
 			entitySave(log);
 			rc.message = new model.beans.message(
 				type="danger",
 				message="The authentication code was incorrect. Please try again."
 			);
 			fw.redirect(action='auth:main.setupOTP', preserve="all");
 		}
 	}

 	public void function checkOTP(struct rc)
 	{
 		var properties = entityLoadByPk('SystemProperty',1);
 		rc.mfa_timeout = properties.getMfa_timeout();
 	}

 	public void function checkOTPAct(struct rc)
 	{
 		param name="rc.save_mfa_timeout" default="0";

 		var user = entityLoadByPk('User',rc.email);
 		var isValid = twoService.verifyGoogleToken(user.getSecret32(),rc.code,1);
 		if (isValid)
 		{
 			// session.email = user.getEmail();		
 			cookie name="email" value=user.getEmail() httpOnly="true" secure="false";
 			user.setLast_login_dtm(now());
 			user.setLogin_attempts(0);

 			// log event
			var log = entityNew('EventLog',{
				email=user.getEmail(),
				filter='auth',
				action=fw.getFullyQualifiedAction(),
				event='Successful mfa authentication',
				severity='info', //'info','warning','error','debug'
				detail=''
			});
			entitySave(log);

 			ORMFlush()
 			fw.redirect(action=':main.default', preserve="all");
 		} else {
 			 var log = entityNew('EventLog',{
 				email=user.getEmail(),
 				filter='auth',
 				action=fw.getFullyQualifiedAction(),
 				event='mfa authentication failure',
 				severity='warning', //'info','warning','error','debug'
 				detail=''
 			});
 			entitySave(log);
 			rc.message = new model.beans.message(
 				type="danger",
 				message="The authentication code was incorrect. Please try again.  If you continue to have problems, please contact an administrator to have your authentication code reset."
 			);
 			fw.redirect(action='auth:main.checkOTP', preserve="all");
 		}
 	}




}