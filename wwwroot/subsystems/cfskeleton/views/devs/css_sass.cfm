<cfoutput>
	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('cfskeleton:devs/_sidebar')#
		</div>
		<div class="col-sm-9 col-md-10">
			<h1>CSS and SASS</h1>
			<h2>Bootstrap</h2>
			<p>We've included Bootstrap in such a way that it is easy to customize.  During the watch and build processes, the bootstrap source files
				are used from within the node_modules directory and combined with your site specific modifications to create a single app.css file in
			the wwwroot/static folder.  You only have to include a singe file in your html to get all of the css for your site.</p>
			<p>You'll want to write your css rules in .scss files in the src/sass directory.  You can look at the files we've already included for 
			some additional ideas about organizing your code.</p>
			<p>Don't worry if you're not up to speed on SASS.  SASS is a superset of CSS, so any regular css rules you put in a .scss file will work.
			when you are more comfortable with some of the additional features of SASS, you can code them up with the rest of your css.</p>
			<p>We make use of SASS includes to help organize our code.  You'll probably want to do that to so you can find your css when you're working
				on a specific part of your project.  Files that start with an underscore are meant to be included in other files.  If you look at our base
			app.scss file, you'll see a bunch of other includes for pieces of code we've broken out as well as pulling in fontawesome.</p>
			<p>SASS includes are not terribly sophisticated, so you may see some duplicated code like the _functions.scss file.  This allows us to use 
				those functions in our custom css.
			<h2>Customizing Bootstrap</h2>
			<p>You'll notice that we're using a customized version of Bootstrap on this site with a dark theme.  While we've only customized a few things,
			you can use and extend the pattern we've created to make your site look the way you want.</p>
			<p>Because of the way we're building Bootstrap with the watch and build commands, you can override the hundreds of variables that Bootstrap
				uses.  If you dig through the node_modules directory to "node_modules/boostrap/scss/_variables.scss" and examine that file, you will see
				lots of things you can change.  To preserve the ability to update Bootstrap, you can override any of the rules you find in that file in
				our file located at "src/sass/_variables.scss".  Copy any variable from the node_modules file into the src file and edit.  Make sure you remove
			the !default directive in your override.  If you don't, the original default will be used.</p>
		</div>
	</div>
</cfoutput>