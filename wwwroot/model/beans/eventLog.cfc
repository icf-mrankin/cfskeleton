component entityname="EventLog" persistent="true" accessors="true" table="event_log"
{
	property name="id" fieldtype="id" type="numeric" generator="identity" ormType="int";
	property name="created" type="datetime";
	property name="email" type="string";
	property name="filter" type="string";
	property name="action" type="string";
	property name="event" type="string";
	property name="severity" type="string"; //'info','warning','error','debug'
	property name="detail" type="string";

	public EventLog function init(
		date created = now(),
		string email = "",
		string filter = "",
		string action = "",
		string event = "",
		string severity = "",
		string detail = ""	
	)
	{
		variables.created = arguments.created;
		variables.email = arguments.email;
		variables.filter = arguments.filter;
		variables.action = arguments.action;
		variables.event = arguments.event;
		variables.severity = arguments.severity;
		variables.detail = arguments.detail;

		return this;
	}
 
 	public string function setSeverity(severity)
 	{
 		if (!listFind('info,warning,error,debug',arguments.severity))
 		{
 			throw(
 				message="Severity can only be one of 'info','warning','error','debug'",
 				type="bean",
 				detail="Attempted to set severity to: [" & arguments.severity & "].",
 				extendedinfo="model.beans.event_log.cfc"
 			);
 		} else {
 			variables.severity = arguments.severity;
 		}
 	}
	
}