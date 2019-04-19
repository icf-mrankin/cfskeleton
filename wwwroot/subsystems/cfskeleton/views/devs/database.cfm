<cfoutput>
	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('cfskeleton:devs/_sidebar')#
		</div>
		<div class="col-sm-9 col-md-10">
			<h1>Database</h1>
			<h2>MySQL</h2>
			<p>We've included and configured a utility called liquibase to manage our mysql database.  You can connect to the local database using any
				mysql tool like MySQL Workbench or DataGrip. Use 127.0.0.1 as your host name.  You can connect as ROOT using ROOT for the username and 
			MyDogHas1Flea as the password.  You'll want to change that if you move your app anywhere besides your local computer.</p>
			<p>Liquibse is a great tool for managing your database structure.  It lets you build your database as you work, making changes along the way that
				can be shared with sourc control to the rest of your team.  At some point, you'll want to stick your nose into the 
				<a href="https://www.liquibase.org/documentation/index.html" target="_blank">liquibase documentation</a> to dive into all of the cool stuff it
				can do.  Unfortunately, they leave it up to you to figure out a decent strategy for managing your change files.  The following process seems to 
			work for our team, so you might want to do something like this:</p>
			<h3>Changelogs</h3>
			<p>Originally, liquibase had you make all of your changes sequentially in a single changlog.xml file.  This can quickly become unwieldy, so they
			introduced the ability to include one changelog file in another.</p>
			<p>When you started cfskeleton, you ran the <code>./liquibase update</code> command to build the initial database.  All of the other commandline 
				parameters that are necessary for the command to run were included and read from a file called liquibase.properties.  We set that one up to work
				with your local environment.  That file, in turn, tells liquibase to read and execute the instructions in a file called changelog.xml.  If you 
				open up that file (located at /db/mysql/changelog.xml) you'll see that instead of directly issuing changes to the database, we included all
				of the files in the /db/mysql/init directory.  You can add files to that directory or even better create a directory scheme that follows your
				development process.  One strategy would be to create a folder for each sprint you work on and name them something like Sprint_01, Sprint_02, etc.
			As you become ready to execute them, you would add the includeAll tag to the bottom of the changelog.xml file.</p>
			<p>Creating directories to organize your code is great, but there is still more to consider about the files inside the directories.  Liquibase 
				executes your additional changelog files sequentially sorted alphabetically by the filename.  What we found was that in order to avoid situations
			where refactorings get executed in the wrong order (and often fail) you should follow a naming convention that helps you to avoid that.</p>
			<p>We wound up using a pattern of yyyy-mm-dd-developer-anystring.xml.  By starting the filenames with the reverse date, we avoided most of the 
				collisions that came up.  Next we added a developer id like "jsmith" to help identify who on the team supplied the file, and finally
				we added an additional string like a short description or a ticket number.  Even with this sort of approach, you may wind up in a situation
				where you might still have a problem, for example, one person working on multiple tickets on the same day and they wind up sorting in the wrong
				order.  You can solve this with a one-off of either putting all of the changes for that day in the same file or adjusting the trailing string in 
			some manner that makes the sort correctly.</p>
			<h3>Properties</h3>
			<p>The properties files provide some additional information that you need to run liquibase commands.  Technically, all of the items in the properties
			files can be passed directly on the commandline, but who wants to constantly type all of that.  You'll find items like these in there:</p>
			<table>
				<tr><th>Attribute</th><th>Value</th></tr>
				<tr><td>driver</td><td>:com.mysql.jdbc.Driver</td></tr>
				<tr><td>classpath</td><td>:mysql-connector-java-5.1.43-bin.jar</td></tr>
				<tr><td>url</td><td>:jdbc:mysql://localhost:3306/cfskeleton?autoReconnect=true&useSSL=false</td></tr>
				<tr><td>username</td><td>:ColdFusion</td></tr>
				<tr><td>password</td><td>:cfskeleton</td></tr>
				<tr><td>changeLogFile</td><td>:changelog.xml</td></tr>
				<tr><td>logLevel</td><td>:debug</td></tr>
			</table>
			<p>You specify which properties file to use like this: <code>./liquibase --defaultsFile=liquibase.properties update</code>.  If your file
				is actually called liqiubase.properties and is located at the same directory level as the liquibase executable, you don't actually have to 
			add the --defaultsFile parameter (case sensitive, btw).</p>
			<h3>Environments</h3>
			<p>A neat trick you can use to keep things running smoothly between environments is to use multple changelog.xml files and liquibase.properties logs
			for your different environments.</p>
			<p>You could create changelog-stage.xml and changelog-prod.xml files for your staging and production environments.  The nice thing about doing this 
				and dividing your supporting changelogs by sprint is that you can now have your staging server at sprint_05 while your production server sits on 
			sprint_04 waiting for things to get approved.</p>
			<p>You're going to want to create corresponding properties files for those environments and name them something like stage.properties and prod.properties.
			Use those to control the connections to the respective databases and root changelogs.</p>
			<h3>Caveat</h3>
			<p>You may be tempted to come up with a scheme for your changelogs dividing them by database assets, like tables, indexes and procedures.  Generally,
				this ends badly.  Databases behave a bit differently than our normal code.  Changes need to be applied in sequence to avoid breaking.  To use that sort
				of strategy, you would need to create changes that were migrations/diffs between databases.  There are tools out there that can do that, but Liquibase
				is not one of them.
		</div>
	</div>
</cfoutput>