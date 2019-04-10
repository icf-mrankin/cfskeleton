component
{
	public void function forgotPassword(
		required subsystems.auth.model.beans.User user, 
		required string site,
		required string replyTo,
		required boolean siteSSL,
		struct smtp)
	{
		//string preprocessing (if any)
		arguments.user.generateToken();
		ORMFlush();

		if (arguments.siteSSL eq true)
		{
			var protocol = 'HTTPS://';
		} else {
			var protocol = 'HTTP://';
		}
		var strings = {
			"resetLink" = protocol & cgi.SERVER_NAME & '/index.cfm?action=auth:main.resetPassword&token_txt=' & arguments.user.getToken_txt(),	
			"email" = arguments.user.getEmail(),
			"server" = protocol & cgi.SERVER_NAME,
			"passwordResetURL" = protocol & cgi.SERVER_NAME & '/index.cfm?action=auth:main.forgot'
		};

		// read mail body
		var body = fileread(expandPath('mail/' & arguments.site & '/PasswordReset/content.txt'));

		//substitution
		for (str in strings)
		{
			body = replace(body, "{" & str & "}", strings[str], "all");			
		}

		//set mail variables
 		var to = arguments.user.getEmail();

 		if (IsDefined("arguments.smtp"))
 		{
 			sendmail(mailbody=body,to=to, replyTo=arguments.replyTo, subject=ucase(arguments.site) & ' Password Reset', smtp=arguments.smtp, type='text');
 		} else {
 			sendmail(mailbody=body, to=to, replyTo=arguments.replyTo, subject=ucase(arguments.site) & ' Password Reset', type='text');
 		}
	}

	public void function sendmail(required string mailbody, required string to, required string replyTo, required string subject, struct smtp, string type='HTML')
	{
		if (IsDefined('arguments.smtp'))
		{
			var mailer = new mail(
				server = arguments.smtp.server,
				port = arguments.smtp.port,
				username = arguments.smtp.user,
				password = arguments.smtp.password,
				usetls = arguments.smtp.tls,
				usessl = arguments.smtp.ssl,
				from = arguments.replyTo,
				to = arguments.to,
				subject = arguments.subject,
				type = arguments.type,
				failto = "mike.rankin@icf.com",
				body = arguments.mailbody);
		} else {
			var mailer = new mail(
				from = arguments.replyTo,
				to = arguments.to,
				subject = arguments.subject,
				type="text",
				failto = "roger.kilian@icf.com",
				body=arguments.mailbody
			);
			
		}
		mailer.send();
	}
}
