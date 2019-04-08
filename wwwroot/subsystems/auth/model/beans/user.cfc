component entityname="User" persistent="true" accessors="true" table="auth_user"
{
	property name="email" fieldtype="id" generator="assigned" type="string" ormType="string" sqlType="varchar(255)";
	property name="organization_id";
	property name="password_hash_txt";
	property name="salt_txt";
	property name="token_txt";
	property name="first_name";
	property name="last_name";
	property name="contact_id";
	property name="title";
	property name="address1";
	property name="address2";
	property name="city";
	property name="state";
	property name="zipcode";
	property name="secondary_email";
	property name="business_phone";
	property name="home_phone";
	property name="mobile_phone";
	property name="created_dtm";
	property name="created_by";
	property name="updated_dtm";
	property name="updated_by";
	property name="private_yn";
	property name="staff_yn";	
	property name="user_type_id";
	property name="sub_org";
	property name="photo";
	property name="timezone";
	property name="password_change_required_yn";
	property name="locked_yn";
	property name="login_attempts";
	property name="last_login_dtm";
	property name="secret32";
	property name="mfa_exempt_yn" type="boolean";


	// relationships

	// one user can be the owner of many groups
	property name="ownedGroups" singularname="ownedGroup" fieldtype="one-to-many" cfc="Group" fkcolumn="Owner" type="array" orderby="name asc" inverse="true";

	// many users can belong to many user_groups
	property name="groups" fieldtype="many-to-many" cfc="Group" type="array" singularname="group" orderby="name asc" linktable="auth_user_group" fkcolumn="email" inversejoincolumn="group_id";

	// many users can belong to many user_policy s
	property name="policies" fieldtype="many-to-many" cfc="Policy" type="array" singularname="policy" orderby="name_sn" linktable="auth_user_policy" fkcolumn="email" inversejoincolumn="policy_name_sn" inverse="true";

	public User function init(
		string email = '',
		string password_hash_txt = '',
		string salt_txt = '',
		string token_txt = '',
		string first_name = '',
		string last_name = '',
		numeric contact_id = 0,
		string title = '',
		string address1 = '',
		string address2 = '',
		string city = '',
		string state = '',
		string zipCode = '',
		string secondary_email = '',
		string business_phone = '',
		string home_phone = '',
		string mobile_phone = '',
		date created_dtm = now(),
		string created_by = '',
		date updated_dtm = now(),
		string updated_by = '',
		boolean private_yn = false,
		boolean staff_yn = true,
		numeric organization_id = 0,
		numeric user_type_id = 0,
		string sub_org = '',
		string photo = '',
		string timezone = '',
		boolean password_change_required_yn = true,
		boolean locked_yn = false,
		numeric login_attempts = 0,
		date last_login_dtm = now(),
		string secret32 = '',
		boolean mfa_exempt_yn = false	
	)
	{
		setEmail(arguments.email);
		setPassword_hash_txt(arguments.password_hash_txt);
		setSalt_txt(arguments.salt_txt);
		setToken_txt(arguments.token_txt);
		setFirst_Name(arguments.first_name);
		setLast_Name(arguments.last_name);
		setContact_Id(arguments.contact_id);
		setTitle(arguments.title);
		setAddress1(arguments.address1);
		setAddress2(arguments.address2);
		setCity(arguments.city);
		setState(arguments.state);
		setZipCode(arguments.ZipCode);
		setSecondary_Email(arguments.secondary_email);
		setBusiness_Phone(arguments.business_phone);
		setHome_Phone(arguments.home_phone);
		setMobile_Phone(arguments.mobile_phone);
		setCreated_dtm(arguments.created_dtm);
		setCreated_by(arguments.created_by);
		setUpdated_dtm(arguments.updated_dtm);
		setUpdated_by(arguments.updated_by);
		setPrivate_yn(arguments.private_yn);
		setStaff_yn(arguments.staff_yn);
		setOrganization_id(arguments.organization_id);
		setUser_type_id(arguments.user_type_id);
		setSub_org(arguments.sub_org);
		setphoto(arguments.photo);
		setTimezone(arguments.timezone);
		setPassword_change_required_yn(arguments.password_change_required_yn);
		setLocked_yn(arguments.locked_yn);
		setLogin_attempts(arguments.login_attempts);
		setLast_login_dtm(arguments.last_login_dtm);	
		setSecret32(arguments.secret32);
		setMfa_exempt_yn(arguments.mfa_exempt_yn);

		variables.ownedGroups = [];
		variables.groups = [];
		variables.policies = [];

		return this;
	}

	public void function generateToken()
	{
		var t = createUUID();
		setToken_txt(t);
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