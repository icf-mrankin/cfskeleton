<cfoutput>
	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('cfskeleton:devs/_sidebar')#
		</div>
		<div class="col-sm-9 col-md-10">
			<h1>Watch/Build</h1>
			<h2>Watch</h2>
			<p>We'll start with the watch process since this is what you will most likely use first.  The watch command instructs webpack to monitor
				your javascript, sass, and images for changes.  When a change is detected, webpack automatically fires off a build process for these
				files and puts the resulting css and js files in your static directory under your webroot.<p>
			<p>You start the watch process by launching your shell (bash) and navigating to the project root and issuing:<p>
			<code>npm run watch</code>
			<p><strong>Note: </strong> There are times when you've created some extensive changes that the watch process picks up before you're finished.
				Most of the time, you'll see an error or two slide by in your bash terminal and it will get corrected when you finish.  Some times, though,
				the javascript or sass parser bomb on certain types of errors and the watch process will freeze.  You'll notice this when your expected
				changes don't appear when you refresh your browser.  To recover from this, simple terminate the watch process with ctrl-c and run the watch
			command again.  It should build again or give you details of the error.</p>

			<h2>Build</h2>
			<p>We've included a complete build process for the app that you can use to generate a deployable .war file.  The resulting file has a full
			copy of Lucee included with it so you don't have to do a Lucee install on your destination (jee) server.</p>
			<p>You run the build process with:</p>
			<code>npm run build-win</code>
			<p>if you are on windows or </p>
			<code>npm run build-mac</code>
			<p>if you are on a mac. (this will probably work on linux, too, but we haven't had anybody test it yet.)</p>
			<p>After you run the build process the first time, you will have two new directories created in your project root, "build" and "build_archive".</p>
			<p>In the build folder you will find your project as "ROOT.war", which you can use to replace the root application on a jee server (like tomcat).
			You will also find a few staging files used during the build process which you can pretty much ignore.</p>
			<p>In the build_archive folder, you will find a copy of the ROOT.war file renamed with a timestamp as the filename.  This file is suitable for 
				keeping a copy of your builds.  Old ones can be used for recovery processes if things go wrong.  Also, this type of nameing works great for 
			deploying to AWS Elastic Beanstalk since they require a unique name for each upload you do.</p>
			<p>You should probably add those two directories to your .gitignore file so that you don't commit them.</p>
			<p>As you work, the build directory gets cleaned with each run of the build command, but the build_archive does not and can accumulate a lot of
			data if you don't watch it.  You'll probably want to just discard a bunch of them occasionally to save disk space.</p>
		</div>
	</div>
</cfoutput>