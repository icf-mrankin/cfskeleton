component accessors="true" extends="base"
{
	property CSRFService;

	public any function init(fw)
	{
		variables.fw = arguments.fw;
		variables.db = variables.fw.datasource;
		variables.timezoneService = new subsystems.calendar.model.services.timezone();
		return this;
	}

	public void function before(struct rc)
	{
		if (!IsDefined("cookie.email") || len(cookie.email) == 0)
		{
			variables.fw.redirect(action='auth:main.login');
		} else {
			rc.user = entityLoadByPk('User', cookie.email);
		}

		/* check id is a number */
		if(isDefined("url.id")){
			if(!isValid("integer", url.id)){
				Writedump("There was a problem. (786243876)");
				abort;
			}
		}
		
		rc.userdata = entityLoadByPk('Contacts', rc.user.getContact_id());
		param name="rc.addEditEnable" default="false";
		rc.addEditEnable = true;

		rc.breadcrumbs = [];			
		arrayAppend(rc.breadcrumbs, {name="Settings", url=fw.buildURL(action='auth:mypref.default')});			
	}

	public void function default (struct rc)
	{
		if (isDefined('rc.updatePreferences'))
		{
			if (isDefined('rc.changeSmallBanner'))
			{
				cookie name="banner_size" expires="50" value="1";
			} else {
				structDelete(cookie, 'banner_size', false);
				variables.fw.redirect(action=':');
			}
		}
		rc.changeSmallBannerChecked = '';
		if (isDefined('cookie.banner_size'))
		{
			rc.changeSmallBannerChecked = 'checked="checked"';
		}
		arrayAppend(rc.breadcrumbs, {name='Preferences'})
	}

	public void function passpage (struct rc)
	{
		arrayAppend(rc.breadcrumbs, {name='Change Password'});
		rc.token = CSRFService.generate();
		if (rc.user.holdsPolicy('sysadminFull'))
		{	
			rc.pw_length = 15;
		} else {
			rc.pw_length = 8;
		}

	}

	public void function profilepage(struct rc)
	{
		param name='rc.email' default='';
		arrayAppend(rc.breadcrumbs, {name="Profile"});
		rc.Token = CSRFService.Generate();

		rc.timezones = timezoneService.getTimeZones();
		rc.states = entityLoad('State');

		rc.person = entityLoadByPk('User', cookie.email);

		if (!isDefined('rc.person'))
		{
			rc.person = entityNew('User');
		}

		rc.org = entityLoadByPK('organization', rc.person.getOrganization_id());

		arrayAppend(rc.breadcrumbs,{name="Users", url=fw.buildURL('auth:admin.users')});
		if (len(rc.person.getEmail()))
		{
			arrayAppend(rc.breadcrumbs,{name=rc.person.getFirst_name() & ' ' & rc.person.getLast_name()});		
		} else {
			arrayAppend(rc.breadcrumbs, {name="new user"});
		}
	}

	public void function userProfileAct (struct rc)
	{
		if (!isDefined('rc.token') OR !CSRFService.verify(rc.token))
		{
			variables.fw.redirect(action=':');
		}
		var person = entityLoadByPk('User', rc.email);
		fw.populate(person);

		queryExecute("
			UPDATE contact
			SET first_name = :firstname,
			last_name = :lastname
			WHERE id = :contactid
		", {firstname = rc.first_name,lastname=rc.last_name, contactid=person.getContact_id()})		

		rc.message = new model.beans.message(
			type="success",
			message="Your profile has been saved."
		);
		ORMFlush();
		fw.redirect(action='auth:mypref.profilepage', preserve='all');
	}
}


