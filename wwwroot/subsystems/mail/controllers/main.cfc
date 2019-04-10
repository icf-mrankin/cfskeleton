component
{
	public any function init(fw)
	{
		variables.fw = arguments.fw;
		variables.mailService = new subsystems.mail.model.services.sendMail();
		return this;
	}

	public void function before(struct rc)
	{
		if (!IsDefined("cookie.email") || len(cookie.email) == 0)
		{
			variables.fw.redirect(action='auth:main.login');
		} else {
			rc.user = entityLoadByPk('User', lcase(cookie.email));
		}
	}

	public void function default(struct rc)
	{

	}

	public void function mailtestAct(struct rc)
	{
		var strings = {};
		var fieldAry = listToArray(rc.fieldnames);
		for (fieldname in fieldAry)
		{
			if (listFirst(fieldname,'_') eq 'str')
			{
				strings[listRest(fieldname,'_')] = rc[fieldname]; 
			}
		}

		mailService.send(
			site = variables.fw.getConfig().site,
			siteSSL = variables.fw.getConfig().siteSSL,
			template = rc.template,
			to = rc.to,
			cc = rc.cc,
			bcc = rc.bcc,
			subject = rc.subject,
			strings = strings
		);

		variables.fw.redirect(action='mail:main.default');
	}
}