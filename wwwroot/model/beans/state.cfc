component entityname="State" persistent="true" accessors="true" table="us_state" 
{
	property name="Code" fieldtype="id" generator="assigned" ormtype="string" sqlType="varchar(3)";
	property name="Name" type="string";

	public State function init(
		code = "",
		name = ""
	)
	{
		setCode(arguments.code);
		setName(arguments.name);

		return this;
	}
}