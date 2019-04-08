component entityname="Group" persistent="true" accessors="true" table="auth_group" 
{
	property name="id" fieldtype="id" generator="identity" type="numeric" ormType="integer" sqltype="int";
	property name="name" type="string" sqlType="varchar(255)";
	property name="owner" type="string";
	property name="description_ln" type="string";
	property name="system_yn" type="boolean";
	property name="created_dtm" type="date";

	// relationships
	// one owner can have many groups
	/* property name="owner" fieldtype="many-to-one" cfc="User" fkcolumn="owner"; */
	// many groups can have many users
	property name="users" fieldtype="many-to-many" cfc="User" type="array" singularname="user" orderby="last_name asc, first_name asc" linktable="auth_user_group" fkcolumn="group_id" inversejoincolumn="email" inverse="true";
	// many groups can have many policies
	property name="policies" fieldtype="many-to-many" cfc="Policy" type="array" singularname="policy" orderby="name_sn" linktable="auth_group_policy" fkcolumn="group_id" inversejoincolumn="policy_name_sn" inverse="true";

	public Group function init(
		string name = '',
		string owner = '',
		string description_ln = '',
		string system_yn = false,
		date created_dtm = now()
	)
	{
		setName(arguments.name);
		setOwner(arguments.owner);
		setDescription_ln(arguments.description_ln);
		setSystem_yn(arguments.system_yn);
		setCreated_dtm(arguments.created_dtm);

		return this;
	}

	public void function addPolicy (required policy policy)
	{
		param name="variables.policies" default="#arrayNew(1)#";
		if (!hasPolicy(arguments.policy))
		{
			arrayAppend(variables.policies, arguments.policy);
			arguments.policy.addGroup(this);	
		}
	}

	public void function removePolicy(required policy policy)
	{
		if (hasPolicy(arguments.policy))
		{
			arrayDelete(variables.policies, arguments.policy);
			arguments.policy.removeGroup(this);
		}
	}

	public void function setPolicies(required array policies)
	{
		var policy = "";
		for (policy in variables.policies)
		{
			if (!arrayContains(arguments.policies, policy))
			{
				policy.removeGroup(this);
			}
		}
		for (policy in arguments.policies)
		{
			if (!policy.hasGroup(this))
			{
				policy.addGroup(this);
			}
		}
		variables.policies = arguments.policies;
	}

	public void function addUser(required user user)
	{
		param name="variables.users" default="#arrayNew(1)#";
		if (!hasUser(arguments.user))
		{
			arrayAppend(variables.users, arguments.user);
			arguments.user.addGroup(this);
		}
	}

	public void function removeUser(required user user)
	{
		if(hasUser(arguments.user))
		{
			arrayDelete(variables.users, arguments.user);
			arguments.user.removeGroup(this);
		}
	}

	public void function setUsers(required array users)
	{
		var user = "";
		for (user in variables.users)
		{
			if (!arrayContains(arguments.users, user))
			{
				user.removeGroup(this);
			}
		}
		for (user in arguments.users)
		{
			if (!user.hasGroup(this))
			{
				user.addGroup(this);
			}
		}
		variables.users = arguments.users;
	}

}