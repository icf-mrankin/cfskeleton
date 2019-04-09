<div class="row mt-3">
	<div class="col-md-12">
		<div class="card-deck">
			<div class="card">
				<div class="card-header">
					<p class="h4">NPM is your friend</p>
				</div>
				<div class="card-body">
					<p>We use NPM for the build process including managing your css.</p>
					<p>Initialize it with <strong>npm install</strong></p>
					<p>Work on your site with <strong>npm run watch</strong></p>
					<p>Build your .war with <strong>npm run build-mac</strong> or <strong>npm run build-win</strong></p>
					<p>You'll find the results in /build and /build_archive.  Archive tagged with timestamp for AWS EB</p>
				</div>
			</div>
			<div class="card">
				<div class="card-header">
					<p class="h4">Initialize Database</p>
				</div>
				<div class="card-body">
					<p>Liquibase is included to manage your db like a pro</p>
					<p>navigate to <strong>db/mysql</strong> and run <strong>./liquibase update</strong> to get started.</p>
					<p>You can then use liquibase to manage your db and put it under source control for sharing.</p>
					<p>We'll add postgres and mssql if the need arises</p>
				</div>
			</div>
			<div class="card">
				<div class="card-header">
					<p class="h4">Customize your CSS</p>
				</div>
				<div class="card-body">
					<p>SASS is used to manage your css</p>
					<p>To modify bootstrap, look in <strong>node_modules/bootstrap/scss/_variables.scss</strong>.  Anything you find in there
						can be overridden in <strong>src/sass/_variables</strong>, just make sure not to include the !default directive.</p>
					<p>Put your own scss files in the same directory using the normal sass naming conventions and includes</p>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row mt-3">
	<div class="col-md-12">
		<div class="card-deck">
			<div class="card">
				<div class="card-header">
					<p class="h4">Framework/1 of course</p>
				</div>
				<div class="card-body">
					<p>FW/1 is included so you can get right in and start coding.  Subsystems are enabled, but you don't have to use them.</p>
				</div>
			</div>

			<div class="card">
				<div class="card-header">
					<p class="h4">Message Component</p>
				</div>
				<div class="card-body">
					<p>A message object can be created in your controllers that will create a bootstrap alert on the page.</p>
					<p>Pass in some field messages and redirect back to your form to show server-side validation failures</p>
				</div>
			</div>

			<div class="card">
				<div class="card-header">
					<p class="h4">Authorization</p>
				</div>
				<div class="card-body">
					<p>Login, administration and authorization is handled by our first subsystem.  Optional two-factor authentication is included.</p>
				</div>
			</div>

		</div>
	</div>
</div>

<div class="row mt-3">
	<div class="col-md-4">
		<div class="card-deck">
			<div class="card">
				<div class="card-header">
					<p class="h4">Auditing</p>
				</div>
			</div>
		</div>
	</div>
</div>