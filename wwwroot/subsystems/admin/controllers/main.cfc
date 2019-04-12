component
{
	public void function before(struct rc)
	{
		if (structKeyExists(cookie,'email')) rc.user = entityLoadByPk('User', cookie.email);
	}
	public void function default(struct rc)
	{
		rc.title = "CFSkeleton Admin";
	}
}