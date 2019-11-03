<cfoutput>
	<div class="row">
		<div class="col-12">
			<h3>System Administration</h3>
			<div class="list-group">
				<a href="#buildURL(action='auth:admin.users')#" class="list-group-item list-group-item-action">
					<div class="d-flex w-100 justify-content-between">
						<h5 class="mb-1">Authentication</h5>
					</div>
					<p class="mb-1">Manage Users, Groups and Policies</p>
				</a>
				<a href="#buildURL(action='workflow:admin.default')#" class="list-group-item list-group-item-action">
					<div class="d-flex w-100 justify-content-between">
						<h5 class="mb-1">Workflow</h5>
					</div>
					<p class="mb-1">Manage default workflows for the app.</p>
				</a>
				<a href="##" class="list-group-item list-group-item-action">
					<div class="d-flex w-100 justify-content-between">
						<h5 class="mb-1">List group item heading</h5>
					</div>
					<p class="mb-1">Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit.</p>
					<small class="text-muted">Donec id elit non mi porta.</small>
				</a>
			</div>
		</div>
	</div>
</cfoutput>