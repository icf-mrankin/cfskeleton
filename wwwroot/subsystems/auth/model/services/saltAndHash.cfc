component
{
	public saltAndHash function init()
	{
		variables.validHashes = [256,384,512];

		return this;
	}

	private string function makeSalt()
	{
		return generateRandomString(38,46,true,true);
	}

	public string function generateRandomString(
		numeric minLength = 0,
		numeric maxLength = 10,
		boolean numeric = true,
		boolean symbols = true)
	{
		local.randomString = "";
		sleep(1);
		local.length = arguments.minLength;
		local.symbolArray = ["@","^","$","~"];

		if (arguments.minLength LT arguments.maxLength)
		{
			local.length = randrange(arguments.minLength, arguments.maxLength);
		} else if (arguments.minLength EQ 0 and arguments.maxlength EQ 0) {
			local.length = 6;
		}

		for (local.i=1; local.i lte local.length; local.i++)
		{
			local.charType = 1;
			if (arguments.numeric)
			{
				if (arguments.symbols)
				{
					local.charType = randRange(1,3);
				} else {
					local.chartype = randRange(1,2);
				}
			} else {
				if (arguments.symbols)
				{
					local.charType = 3;
				}
			}

			switch (local.charType)
			{
				case "1":
				{
					local.char = chr(randRange(97,122));
					break;
				}
				case "2":
				{
					local.char = chr(randRange(48,57));
					break;
				}
				case "3":
				{
					local.char = local.symbolArray[randRange(1,4)];
				}
			}
			local.randomString &= local.char;
		}
		return local.randomString;
	}

	public numeric function pickHashMethod()
	{
		sleep(1);
		randomize(TimeFormat(now(),"l"));
		return variables.validHashes[randRange(1,3)];
	}

	public struct function saltAndHash(
		required string stringToBeHashed,
		string salt = "",
		numeric hashMethod = "0"
		)
	{
		local.returnStruct = {};
		hashedString = arguments.stringToBeHashed;
		hashCount = 0;

		sleep(1); 

		if (arguments.hashMethod AND NOT arrayFind(variables.validhashes, arguments.hashMethod))
		{
			throw (message = "Invalid hash method provided. Must be one of the following: 0, 256, 384 or 512");	
		}

		if (!arguments.hashMethod)
		{
			//arguments.hashMethod = pickHashMethod();
			// lets always use 512
			arguments.hashMethod = '512';
		}

		if (!len(arguments.salt))
		{
			arguments.salt = makeSalt();
		}

		returnStruct["hashMethod"] = arguments.hashMethod;
		returnStruct["salt"] = arguments.salt;

		for (local.i=1;local.i lte 5000;local.i++)
		{
			hashedString = hash(hashedString & arguments.salt, "SHA-" & arguments.hashMethod);
		}

		returnStruct["hashedString"] = hashedString;
		return returnStruct;
	}

	public boolean function validateHashedString(
		required string stringToBeHashed,
		required string salt,
		required numeric hashMethod,
		required string hashedString
		)
	{
		local.newhash = saltAndHash(arguments.stringToBeHashed, arguments.salt, arguments.hashMethod);
		local.newAry = charsetdecode(local.newHash.hashedString, "us-ascii");
		local.oldAry = charsetdecode(arguments.hashedString, "us-ascii");

		return slowEquals(oldAry,newAry);
	}

	public boolean function slowEquals(
		required array a,
		required array b
		)
	{
		local.diff = arraylen(arguments.a) NEQ arrayLen(arguments.b);
		for (local.i=1; local.i LTE arrayLen(arguments.a) AND local.i LTE arrayLen(arguments.b); i++)
		{
			local.diff = (arguments.a[local.i] NEQ arguments.b[local.i]) OR local.diff;	
		}
		return !diff;
	}

}
