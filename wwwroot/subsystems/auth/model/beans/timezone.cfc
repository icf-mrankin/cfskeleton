component entityname="Timezone" persistent="true" accessors="true" table="time_zone_name" readonly="true" 
{
	property name="timezone_id" fieldtype="id" generator="assigned" type="numeric" ormType="integer" sqltype="int";
	property name="name" type="string" sqlType="varchar(64)";
	
	// relationships
	// one owner can have many groups
	/* property name="owner" fieldtype="many-to-one" cfc="User" fkcolumn="owner"; */
	// many groups can have many users
	property name="users" fieldtype="many-to-many" cfc="User" type="array" singularname="user" orderby="last_name asc, first_name asc" linktable="auth_user_group" fkcolumn="group_id" inversejoincolumn="email" inverse="true";
	// many groups can have many policies
	property name="policies" fieldtype="many-to-many" cfc="Policy" type="array" singularname="policy" orderby="name" linktable="auth_group_policy" fkcolumn="group_id" inversejoincolumn="policy_name" inverse="true";

	public Group function init(
		string name = '',
	)
	{
		setName(arguments.name);

		return this;
	}
}