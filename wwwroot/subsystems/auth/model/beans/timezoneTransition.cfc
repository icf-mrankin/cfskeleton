component accessors="true" table="time_zone_transition" persistent="true" readonly="true"
{
	property name="timezone_id" fieldtype="id" generator="assigned" type="numeric" ormType="integer" sqltype="int";
	property name="transition_id" fieldtype="id" generator="assigned" table="numeric" ormType="integer" sqltype="int";
	property name="offset" type="integer";
	property name="is_dst" type="boolean";
	property name="abbreviation" type="string";

	// relationships
	// many transitions can belong to one timeone
 
}