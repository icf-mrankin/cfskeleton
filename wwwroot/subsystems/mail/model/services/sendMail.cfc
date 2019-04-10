component
{
	public any function init()
	{
		return this;
	}

	public any function send(
		required string site,
		required boolean siteSSL,
		required string template,
		required string to,
		required string subject,
		string cc = "",
		string bcc = "",
		struct strings = {}
	)
	{
		var paths = getPaths(site=arguments.site, siteSSL=arguments.siteSSL, template=arguments.template);
		var bodies = getBodies(paths=paths,strings=arguments.strings);

		var mailObj = new mail(
			from = 'no-reply@macrocpm.com',
			to = arguments.to,
			subject = arguments.subject
		);
		if (len(arguments.cc)) mailObj.setCC(arguments.cc);
		if (len(arguments.bcc)) mailObj.setBCC(arguments.bcc);

		if (structKeyExists(bodies, "txt"))
		{
			mailObj.addPart(type="text", charset="utf-8", wraptext="72", body=bodies.txt);
		}

		if (structKeyExists(bodies, "html"))
		{
			mailObj.addPart(type="html", charset="utf-8", body=bodies.html);
		}
		mailObj.send();
	}

	private struct function getBodies(
		required struct paths,
		required struct strings
	) 
	{
		var bodies = {}
		if (fileExists(arguments.paths.bodyTxt))
		{
			var txt = fileRead(arguments.paths.bodyTxt);
			bodies.txt = replaceStrings(txt,arguments.strings);
		}
		if (fileExists(arguments.paths.bodyHTML))
		{
			var html = assembleHTML(paths=arguments.paths);
			bodies.html = replaceStrings(html,arguments.strings);
		}

		return bodies;
	}

	private string function assembleHTML(required struct paths)
	{
		var wrapper = fileRead(paths.htmlWrapper);
		var header = fileRead(paths.htmlHeader);
		var footer = fileRead(paths.htmlFooter);
		var body = fileRead(paths.bodyHTML);

		var result = replace(wrapper, "{{header}}", header);
		var result = replace(result, "{{footer}}", footer);
		var result = replace(result,"{{body}}", body);

		return result;
	}

	private struct function getPaths(
		required string site,
		required boolean siteSSL,
		required string template
	)
	{
		var root = expandPath("subsystems/mail/templates/" & arguments.site & "/");
		if (arguments.siteSSL)
		{
			var protocol = 'https://';
		} else {
			var protocol = 'http://';
		}
		var rootURL = protocol & cgi.SERVER_NAME & '/subsystems/mail/templates' & arguments.site & '/';
		var paths = {};

		paths.bodyTxt = root & arguments.template & "/body.txt";
		paths.bodyHTML = root & arguments.template & "/body.html";
		paths.htmlWrapper = root & "wrapper.html";
		paths.htmlHeader = root & "header.html";
		paths.htmlFooter = root & "footer.html";
		paths.rootURL = rootURL;

		return paths;
	}

	private string function replaceStrings(
		required string body,
		required struct strings
	)
	{
		for (str in arguments.strings)
		{
			arguments.body = replace(arguments.body, '{' & str & '}', strings[str],'All');
		}

		return arguments.body;
	}
}