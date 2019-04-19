<cfoutput>
	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('cfskeleton:devs/_sidebar')#
		</div>
		<div class="col-sm-9 col-md-10">
			<h1>Documentation Overview</h1>
			<p>Add your developers to the developers group in the authentication system to grant access to this section.</p>
			<p>Several pieces of code included with cfskeleton will help you get your app up and running quickly.  Use this
				documentation as a guide to leveraging these bits of code quickly.  Rip out anything you don't need or lock it 
				behind the authentication system.
			<p><strong>Hey, where's my home page?</strong></p>
			<p>In order to see something when you initialize a new system, we redirect from the normal homepage to 
				cfskeleton:main.default.  You'll find this redirect in /wwwroot/controllers/main.cfc.  Feel free to remove 
				it when you are ready to begin work on your project.  If you want to visit the cfskeleton page again, browse to
				http://localhost/index.cfm?action=cfskeleton:main.default.
			<h2>Guides</h2>
			<p>The guides provide some insight into how the application is strucgtured and how to make use of some of the 
			accompanying tools like webpack and liquibase that are bundled in the app.</p>
			<h2>Subsystems</h2>
			<p>Several subsystems have been included to use as the basis for parts of your system.  This section details what 
				you need to know as a developer in order to use and/or extend them for your project.
			<h2>Utilities</h2>
			<p>Of course some items are too small to warrant a section of their own.  They tend to be collections of functions
				wrapped in cfcs that you can use where needed.  Look here for descriptions of any parameters that you might need
			to send.</p>
		</div>
	</div>
</cfoutput>