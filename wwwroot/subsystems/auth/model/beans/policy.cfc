component entityname="Policy" persistent="true" accessors="true" table="auth_policy" 
{
	property name="name" fieldtype="id" generator="assigned" type="string" ormType="string" sqlType="varchar(255)";
	property name="description" type="string";
	property name="is_system" type="boolean";
	property name="created" type="date";
	property name="created_by" type="string";
	property name="updated" type="date";
	property name="updated_by" type="string";

	// relationships	
	property name="groups" fieldtype="many-to-many" cfc="Group" type="array" singularname="group" orderby="name asc" linktable="auth_group_policy" fkcolumn="policy_name" inversejoincolumn="group_id" lazy="extra";

	public Policy function init(
		string name = '',
		string description = '',
		string is_system = false,
		date created = now(),
		string created_by = '',
		date updated = now(),
		string updated_by = ''
	)
	{
		setName(arguments.name);
		setDescription(arguments.description);
		setIs_system(arguments.is_system);
		setCreated(arguments.created);
		setCreated_by(arguments.created_by);
		setUpdated(arguments.updated);
		setUpdated_by(arguments.updated_by);

		return this;
	}

}