component
{
	public void function init(struct fw)
	{
		variables.fw = arguments.fw;
	}
	
	public void function default(struct rc)
	{
		rc.title = "Home";

		// Visit the cfskeleton home page - remove this to see your own home page.
		fw.redirect(action='cfskeleton:main.default');
	}
}