component entityname="Policy" persistent="true" accessors="true" table="auth_policy" 
{
	property name="name_sn" fieldtype="id" generator="assigned" type="string" ormType="string" sqlType="varchar(255)";
	property name="description" type="string";
	property name="system_yn" type="boolean";
	property name="created_dtm" type="date";

	// relationships	
	property name="groups" fieldtype="many-to-many" cfc="Group" type="array" singularname="group" orderby="name asc" linktable="auth_group_policy" fkcolumn="policy_name_sn" inversejoincolumn="group_id" lazy="extra";

	public Policy function init(
		string name_sn = '',
		string description = '',
		string system_yn = false,
		date created_dtm = now()
	)
	{
		setName_sn(arguments.name_sn);
		setDescription(arguments.description);
		setSystem_yn(arguments.system_yn);
		setCreated_dtm(arguments.created_dtm);

		return this;
	}

}