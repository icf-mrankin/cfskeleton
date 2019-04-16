component entityname="Timezone" persistent="true" accessors="true" table="time_zone_name" readonly="true" 
{
	property name="time_zone_id" fieldtype="id" generator="assigned" type="numeric" ormType="integer" sqltype="int";
	property name="name" type="string" sqlType="varchar(64)";
	
	// relationships
	// one timezone can have many transitions
	property name="timezone_transitions" singularname="timezone_transition" fieldtype="one-to-many" cfc="timezoneTransition" fkcolumn="time_zone_id" type="array" lazy="extra" orderby="transition_id";

	public Timezone function init(
		string name = '',
	)
	{
		setName(arguments.name);

		return this;
	}
}