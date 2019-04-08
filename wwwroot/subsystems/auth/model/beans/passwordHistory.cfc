component entityname="PasswordHistory" persistent="true" accessors="true" table="auth_password_history"
{
	property name="id" fieldtype="id" generator="identity" type="numeric" ormType="integer" sqlType="int";
	property name="created_dtm";
	property name="email";
	property name="password_hash_txt";
	property name="salt_txt";

	public PasswordHistory function init(
		string email = '',
		string password_hash_txt = '',
		string salt_txt = '',
	)
	{
		setEmail(arguments.email);
		setPassword_hash_txt(arguments.password_hash_txt);
		setSalt_txt(arguments.salt_txt);

		return this;
	}

}