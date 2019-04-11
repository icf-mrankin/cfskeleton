component
accessors="true" persistent="false"
{
	property name="type" type="string";
	property name="heading" type="string";
	property name="message" type="string";
	property name="link" type="string";
	property name="dismissible" type="boolean";
	property name="controls" type="array";

	public message function init(
		string heading = '',
		string message = '',
		string type = 'danger',
		string link = '',
		boolean dismissible = true,
		array controls = []
	)
	{
		setHeading(arguments.heading);
		setMessage(arguments.message);
		setType(arguments.type);
		setLink(arguments.link);
		setDismissible(arguments.dismissible);
		setControls(arguments.controls);

		return this;
	}

	public void function setType(required string type)
	{
		if (!refind("success|info|warning|danger", arguments.type))
		{
			throw(type="validation", message="type must be 'success', 'info', 'warning', or 'danger'", extendedInfo="object:model.beans.message");
		} else {
			variables.type = arguments.type;
		}
	}

	public string function getMessage()
	{
		var result = '<div class="alert pb-0 alert-dismissible alert-' & variables.type & '" role="alert">';

		if (variables.dismissible)
		{
			result &= '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>';		
		}
		
		if (len(getHeading()))
		{
			result &= '<h4 class="alert-heading">';
			result &= getHeading();
			result &= '</h4>';
		}
		result &= '<p class="">' & variables.message & '</p>';
		var htmllink = '<a class="alert-link" href="' & variables.link & '">'; 

		if (len(variables.link))
		{
			result = replace(result, '{link}', htmllink);
			result = replace(result, '{/link}', '</a>');
		}

		result &= '</div>';

		return result;
	}

	public void function addControl(required string id, string type = 'danger', string helptext = '')
	{
		var control = {id=arguments.id, type=arguments.type, helptext=arguments.helptext};
		arrayAppend(variables.controls, control);
	}
}