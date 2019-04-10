component extends="framework.one"
{
	this.name = "cfskeleton";
	this.loginstorage = "cookie";
	this.clientmanagement = false;
	this.setclientcookies = false;
	this.sessionmanagement = true;
	this.sessiontimeout = createtimespan(0,1,0,0);
	this.applicationTimeout = createtimespan(1,0,0,0);
	this.setDomainCookies = false;
	scriptprotect = "all";
	this.ormEnabled = true;
	this.sessiontype = "jee";
	switch (getEnvironment())
	{
		case "localhost":
			this.datasources.cfskeleton = {
				type = "mysql",
				host = "cfsdb",
				port = "3306",
				database = "cfskeleton",
				username = "ColdFusion",
				password = "cfskeleton"
			};
			this.datasource = "cfskeleton";
			this.ormSettings = {
				datasource = "cfskeleton",
				cfclocation = [
					"model/beans",
					"subsystems/auth/model/beans"
				],
				dbcreate = "none",
				dialect = 'MySQLwithInnoDB',
				logSQL = 'true'
			};
			break;
		default: 
			break;
	}

	// framework 1 config variables
	variables.framework = {
		usingSubsystems = false,
		subsystemDelimiter = ":",
		cacheFileExists = false,
		applicationKey = "framework.one",
		reload = "reloadd",
		password = "true",
		home = ":main.default",
		error = "main.error",
		unhandledErrorCaught = "true",
		trace="false"
	};

	// framework 1 config variables that can differ per environemnt
	// you can put any variables you want in the framwork struct
	// for config items you might want in the rest of the site.
	// the variable must match the string returned from getEnvironment()
	variables.framework.environments = {
		localhost = {
			reloadApplicationOnEveryRequest = true
		}
	}

	public string function getEnvironment()
	{
		// you can rewrite this function to return an environment variable any way you wish.
		var serv = listFirst(CGI.SERVER_NAME, '.');

		if (listFindNoCase('localhost,someotherhost', serv))
		{
			return replace(serv,'-','_');
		} else {
			throw("Environment not found.");
		}
	}

}