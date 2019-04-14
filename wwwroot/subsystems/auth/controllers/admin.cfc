component extends="base"
	accessors="true"
{ 
	property saltAndHashService;
	property twoService;

	public void function before(struct rc)
	{
		if (!IsDefined("cookie.email") || len(cookie.email) == 0)
		{
			variables.fw.redirect(action='auth:main.login');
		} else {
			rc.user = entityLoadByPk('User', lcase(cookie.email));
		}

		rc.breadcrumbs = [];
		arrayAppend(rc.breadcrumbs, {name="Admin", url=fw.buildURL(action='admin:main.default')});
	}

	public void function groups(struct rc)
	{
		rc.groups = entityLoad('Group');
		arrayAppend(rc.breadcrumbs, {name="Access Management", url=fw.buildURL('auth:admin.users')});
		arrayAppend(rc.breadcrumbs,{name="Groups"});
	}

	public void function groupWizAct(struct rc)
	{
		rc.group = entityNew('Group');
		fw.populate(rc.group);
		rc.group.setOwner(rc.user.getEmail());
		entitySave(rc.group);
		ORMFlush();
		rc.groupId = rc.group.getId();
		
		fw.redirect(action='auth:admin.groupWizPolicyAdd', preserve='all');
	}

	public void function groupWizPolicyAdd(struct rc)
	{
		rc.group = entityLoadByPk('Group', rc.groupId);
		rc.policies = entityLoad('Policy');
		rc.message = new model.beans.message(
			type="info",
			message="Choose the [share] policy if you are just creating a group to share items.");
	}

	public void function groupWizPolicyAddAct(struct rc)
	{
		var policyAry = listToArray(rc.name);
		rc.group = entityLoadByPk('Group', rc.groupId);
		for (p in policyAry)
		{
			var policy = entityLoadByPk('Policy', p);
			rc.group.addPolicy(policy);
		}
		ORMFlush();
		fw.redirect(action='auth:admin.groupWizUserAdd', preserve='all');
	}

	public void function groupWizUserAdd(struct rc)
	{
		rc.users = queryExecute("
			SELECT
			  u.email,
			  u.first_name,
			  u.last_name,
			  u.title,
			  o.name_ln AS organization_id,
			  u.city,
			  u.state
			FROM auth_user u
			  LEFT JOIN auth_organization o ON u.organization_id = o.id
			  ORDER BY last_name, first_name

		");
	}

	public void function groupWizUserAddAct(struct rc)
	{
		var group = entityLoadByPk('Group', rc.id);
		var userAry = [];
		for (email in listToArray(rc.email))
		{
			var user = entityLoadByPk('User', lcase(email));
			arrayAppend(userAry, user);
		}
		group.setUsers(userAry);
		ORMFlush();
		rc.message = new model.beans.message(type="success", message="Users for [" & group.getName() & "] group where updated.");
		fw.redirect(action='auth:admin.groups', preserve='all');
	}

	public void function groupEdit(struct rc)
	{
		arrayAppend(rc.breadcrumbs, {name="Access Management", url=fw.buildURL('auth:admin.users')});
		arrayAppend(rc.breadcrumbs,{name="Groups", url=fw.buildURL('auth:admin.groups')});
		arrayAppend(rc.breadcrumbs, {name="Edit"});
		rc.group = entityLoadByPk('Group', rc.id);
	}

	public void function groupEditAct(struct rc)
	{
		var group = entityLoadByPk('Group', rc.groupId);
		fw.populate(group);
		// log event
		var eventLog = entityNew('EventLog',{
			email=rc.user.getEmail(),
			filter='admin',
			action=fw.getFullyQualifiedAction(),
			event='group updated',
			severity='info', //'info','warning','error','debug'
			detail='Group description changed to: ' & rc.description
		});
		entitySave(eventLog);
		rc.message = new model.beans.message(
			type="success",
			message="The group description was updated"
		);
		ORMFlush();
		fw.redirect(action='auth:admin.groups', preserve='all');
	}

	public void function groupPolicyEdit(struct rc)
	{
		arrayAppend(rc.breadcrumbs, {name="Access Management", url=fw.buildURL('auth:admin.users')});
		arrayAppend(rc.breadcrumbs,{name="Groups", url=fw.buildURL('auth:admin.groups')});
		arrayAppend(rc.breadcrumbs, {name="Edit Policies"});
		rc.group = entityLoadByPk('Group', rc.id);
		rc.policies = entityLoad('Policy');
	}

	public void function groupPolicyEditAct(struct rc)
	{
		var group = entityLoadByPk('Group', rc.id);
		var policyAry = [];
		for (name in listToArray(rc.name))
		{
			var policy = entityLoadByPk('Policy', name);
			arrayAppend(policyAry,policy);
		}
		group.setPolicies(policyAry);
		ORMFlush();
		rc.message = new model.beans.message(type="success", message="Polices for [" & group.getName() & "] group were updated.");
		fw.redirect(action='auth:admin.groups', preserve='all');
	}

	public void function groupUserEdit(struct rc)
	{
		arrayAppend(rc.breadcrumbs, {name="Access Management", url=fw.buildURL('auth:admin.users')});
		arrayAppend(rc.breadcrumbs,{name="Groups", url=fw.buildURL('auth:admin.groups')});
		arrayAppend(rc.breadcrumbs, {name="Edit Users"});

		rc.users = queryExecute("
			select u.email, u.first_name, u.last_name, u.title
			from auth_user u
			order by last_name, first_name
		");

		var uig = queryExecute("
			select email from auth_user_group where group_id = :groupid
		", {groupId = rc.id});

		rc.usersInGroup = valueList(uig.email);
		rc.group = entityLoadByPk('Group', rc.id);

	}

	public void function groupUserEditAct(struct rc)
	{
		var group = entityLoadByPk('Group', rc.id);
		var userAry = [];
		for (email in listToArray(rc.email))
		{
			var user = entityLoadByPk('User', lcase(email));
			arrayAppend(userAry, user);
		}
		group.setUsers(userAry);
		ORMFlush();
		rc.message = new model.beans.message(type="success", message="Users for [" & group.getName() & "] group where updated.");
		fw.redirect(action='auth:admin.groups', preserve='all');
	}

	public void function groupDeleteAct(struct rc)
	{
		var groupAry = listToArray(rc.id);
			for(id in groupAry)
			{
				var group = entityLoadByPk('Group', id);
				entityDelete(group);
				ORMFlush();
			}
			rc.message = new model.beans.message(
				type="success",
				message = toString(arrayLen(groupAry)) & " group(s) deleted." 
			);

		fw.redirect(action='auth:admin.groups', preserve="all");
	}

	public void function users(struct rc)
	{
		arrayAppend(rc.breadcrumbs, {name="Access Management", url=fw.buildURL('auth:admin.users')});
		arrayAppend(rc.breadcrumbs,{name="Users"});
		rc.users = entityLoad('User', {}, 'last_name asc, first_name asc');
	}

	public void function userDetail(struct rc)
	{
		param name='rc.email' default='';

		rc.states = entityLoad('State');
		rc.person = entityLoadByPk('User', lcase(rc.email));		

		if (!isDefined('rc.person'))
		{
			rc.person = entityNew('User');
		}

		arrayAppend(rc.breadcrumbs,{name="Users", url=fw.buildURL('auth:admin.users')});
		if (len(rc.person.getEmail()))
		{
			arrayAppend(rc.breadcrumbs,{name=rc.person.getFirst_Name() & ' ' & rc.person.getLast_Name()});		
		} else {
			arrayAppend(rc.breadcrumbs, {name="new user"});
		}
	}

	public void function userDetailAct(struct rc)
	{
		param name="rc.is_password_change_required" default="0";
		param name="rc.is_locked" default="0";
		param name="rc.code" default="0";
		param name="rc.is_mfa_exempt" default="0";
		var isNewPerson = false;

		rc.person = entityLoadByPk('User', lcase(rc.email));

		if (!isDefined('rc.person'))
		{
			rc.person = entityNew('User');
			isNewPerson = true;
		}
		fw.populate(rc.person);
		if (!rc.person.getIs_locked())
		{
			rc.person.setLogin_attempts(0);
		}
		if (rc.is_password_change_required)
		{
			rc.person.generateToken();
		}
		if (rc.code)
		{
			rc.person.setSecret32('');
		}
		if (rc.is_mfa_exempt)
		{
			rc.person.setIs_mfa_exempt(1);
		}
		if (!refind("^[a-zA-Z0-9.!##$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$", rc.email))
		{
			rc.message = new model.beans.message(
				type="danger",
				message="Data Entry Error",
				dismissible=true,
				controls=[{id="email", type="danger", helptext="A valid email address is required."}]
			);
			fw.redirect(action="auth:admin.userDetail", preserve="All");
		} else {
			entitySave(rc.person);
			/* this code should be removed when the old user table is removed */

			/* ----------------------------------------------------------------*/
			rc.message = new model.beans.message(
				type="success",
				message="User account saved."
			);
			ORMFlush();
			fw.redirect(action="auth:admin.users", preserve="all");
		}
	}

	public void function userDeleteAct(struct rc)
	{
		person = entityLoadByPk('User', lcase(rc.email));
		entityDelete(person);
		rc.message = new model.beans.message(type="success", message="User deleted.");
		fw.redirect(action='auth:admin.users', preserve="all");
	}

	public void function policies(struct rc)
	{
		rc.policies = entityLoad('Policy');
		arrayAppend(rc.breadcrumbs, {name="Access Management", url=fw.buildURL(action='auth:admin.users')});
		arrayAppend(rc.breadcrumbs, {name="Policies"});
	}

	public void function policyDetail(struct rc)
	{
		param name='rc.name' default="";

		arrayAppend(rc.breadcrumbs, {name="Access Management", url=fw.buildURL(action='auth:admin.users')});
		arrayAppend(rc.breadcrumbs, {name="Policies", url=fw.buildURL(action='auth:admin.policies')});
		arrayAppend(rc.breadcrumbs, {name="Policy Detail"});

		rc.policy = entityLoadByPk('Policy', rc.name);
		if (!isDefined('rc.policy'))
		{
			rc.policy = entityNew('Policy');
		}
	}

	public void function policyDetailAct(struct rc)
	{
		param name="rc.isSystem" default="0";

		if (!REFindNoCase("^[[:alnum:]]*$", rc.name_sn))
		{
			rc.message = new model.beans.message(
				type="danger",
				message="Policy not saved!"
			);
			rc.message.addControl(id='name', type='danger', helptext="Policy names can only contain letters and numbers.");
			fw.redirect(action='auth:admin.policyDetail', preserve="all");
		}

		var policy = entityLoadByPk('Policy', rc.name_sn);
		if (!isDefined('policy'))
		{
			policy = entityNew('Policy');
			variables.fw.populate(policy);
			entitySave(policy);
		} else {
			variables.fw.populate(policy);
		};
		ORMFlush();

		variables.fw.redirect('auth:admin.policies');
	}

	public void function policyDeleteAct(struct rc)
	{
		var policy = entityLoadByPk('Policy', rc.name);
		entityDelete(policy);
		rc.message = new model.beans.message(
			type="success",
			message="Policy deleted.");
		ORMFlush();
		fw.redirect(action='auth:admin.policies', preserve="all");
	}

	public void function organizations(struct rc)
	{
		rc.organizations = entityLoad('Organization', {}, 'name_ln asc');
	}

	public void function organizationDetail(struct rc)
	{
		param name="rc.id" default="-1";
		rc.org = entityLoadByPk('Organization', rc.id) ?: entityNew('Organization');
	}

	public void function organizationDetailAct(struct rc)
	{
		param name="rc.id" default="-1";
		var org = entityLoadByPk('Organization', rc.id) ?: entityNew('Organization');
		entitySave(org);
		fw.populate(org, 'name_ln');
		ORMFlush();
		fw.redirect(action="auth:admin.organizations");
	}
}