component entityname="Organization" persistent="true" accessors="true" table="auth_organization" 
{
	property name="id" fieldtype="id" generator="identity" type="numeric" ormType="integer" sqltype="int";
	property name="name_ln" type="string" sqlType="varchar(100)";
	property name="created_dtm" type="date";

	// relationships

	public Organization function init(
		string name_ln = '',
		date created_dtm = now()
	)
	{
		setName_ln(arguments.name_ln);
		setCreated_dtm(arguments.created_dtm);

		return this;
	}
}