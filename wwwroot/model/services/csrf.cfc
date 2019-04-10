component 
{
	public string function generate()
	{
		var token = createUUID();
		session.token = token;
		return token;
	}

	public boolean function verify(string token)
	{
		if (arguments.token == session.token)
		{
			return true;
		} else {
			return false;
		}
	}
}