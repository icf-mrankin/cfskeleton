component entityname="User" persistent="true" accessors="true" table="auth_user"
{
	property name="email" fieldtype="id" generator="assigned" type="string" ormType="string" sqlType="varchar(255)";
	property name="password_hash";
	property name="salt";
	property name="token";
	property name="first_name";
	property name="last_name";
	property name="title";
	property name="address1";
	property name="address2";
	property name="city";
	property name="state";
	property name="zipcode";
	property name="created";
	property name="created_by";
	property name="updated";
	property name="updated_by";
	property name="timezone";
	property name="is_password_change_required" type="boolean";
	property name="is_locked" type="boolean";
	property name="login_attempts";
	property name="last_login";
	property name="secret32";
	property name="is_mfa_exempt" type="boolean";


	// relationships

	// one user can be the owner of many groups
	property name="ownedGroups" singularname="ownedGroup" fieldtype="one-to-many" cfc="Group" fkcolumn="Owner" type="array" orderby="name asc" inverse="true";

	// many users can belong to many user_groups
	property name="groups" fieldtype="many-to-many" cfc="Group" type="array" singularname="group" orderby="name asc" linktable="auth_user_group" fkcolumn="email" inversejoincolumn="group_id";

	// many users can belong to many user_policy s
	property name="policies" fieldtype="many-to-many" cfc="Policy" type="array" singularname="policy" orderby="name" linktable="auth_user_policy" fkcolumn="email" inversejoincolumn="policy_name" inverse="true";

	public User function init(
		string email = '',
		string password_hash = '',
		string salt = '',
		string token = '',
		string first_name = '',
		string last_name = '',
		string title = '',
		string address1 = '',
		string address2 = '',
		string city = '',
		string state = '',
		string zipCode = '',
		date created = now(),
		string created_by = '',
		date updated = now(),
		string updated_by = '',
		boolean is_staff = true,
		string timezone = '',
		boolean is_password_change_required = true,
		boolean is_locked = false,
		numeric login_attempts = 0,
		date last_login = now(),
		string secret32 = '',
		boolean is_mfa_exempt = false	
	)
	{
		setEmail(arguments.email);
		setPassword_hash(arguments.password_hash);
		setSalt(arguments.salt);
		setToken(arguments.token);
		setFirst_Name(arguments.first_name);
		setLast_Name(arguments.last_name);
		setTitle(arguments.title);
		setAddress1(arguments.address1);
		setAddress2(arguments.address2);
		setCity(arguments.city);
		setState(arguments.state);
		setZipCode(arguments.ZipCode);
		setCreated(arguments.created);
		setCreated_by(arguments.created_by);
		setUpdated(arguments.updated);
		setUpdated_by(arguments.updated_by);
		setTimezone(arguments.timezone);
		setIs_password_change_required(arguments.is_password_change_required);
		setIs_Locked(arguments.is_locked);
		setLogin_attempts(arguments.login_attempts);
		setLast_login(arguments.last_login);	
		setSecret32(arguments.secret32);
		setIs_Mfa_exempt(arguments.is_mfa_exempt);

		variables.ownedGroups = [];
		variables.groups = [];
		variables.policies = [];

		return this;
	}

	public void function generateToken()
	{
		var t = createUUID();
		setToken(t);
	}

	public boolean function isInGroup(required string groupId)
	{
		var group = entityLoadByPk('Group', groupId);
		if (isNull(group))
		{
			return false;
		}
		return (arrayContains(variables.groups,group)) ? true : false;
	}

	public boolean function holdsPolicy(required string policyName)
	{
		var result = false;
		var policy = entityLoadByPk('Policy', arguments.policyName);
		if (!IsDefined("policy"))
		{
			throw(message="policy not found. Contact Administrator as the Policy #arguments.policyName# does not exist.");
		}

		if (hasPolicy(policy)) 
		{
			result = true;
		} else {
			for (group in getGroups())
			{
				if (group.hasPolicy(policy))
				{
					result = true;
				}
			}
		}

		return result;
	}

	public boolean function holdsAnyPolicy(required string policies)
	{
		var policyAry = listToArray(arguments.policies);
		for (policy in policyAry) {
			if (holdsPolicy(policy)) return true;
		}
		return false;
	}

	public void function addOwnedGroup( required Group)
	{
		if (!hasOwnedGroup())
		{
			variables.ownedGroups = [];
		}
		ArrayAppend(variables.ownedGroups, arguments.Group);
		arguments.Group.setOwner(this);
	}

	// policy helpers
	public void function addPolicy(required policy policy)
	{
		param name="variables.policies" default="#arrayNew(1)#";
		if (!hasPolicy(arguments.policy))
		{
			arrayAppend(variables.policies, arguments.policy);
			arguments.policy.addUser(this);
		}
	}

	public void function removePolicy(required policy policy)
	{
		if(hasPolicy(arguments.policy))
		{
			arrayDelete(variables.policies, arguments.policy);
			arguments.policy.removeUser(this);
		}
	}

	public void function setPolicies(required array policies)
	{
		var policy = "";
		for (policy in variables.policies)
		{
			if (!arrayContains(arguments.policies, policy))
			{
				policy.removeUser(this);
			}
		}
		for (policy in arguments.policies)
		{
			if (!policy.hasUser(this))
			{
				policy.addUser(this);
			}
		}
		variables.policies = arguments.policies;
	}
}