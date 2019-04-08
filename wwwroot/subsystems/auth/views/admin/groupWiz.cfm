<cfoutput>
	<div class="row">
		<div class="col-sm-3 mt-1">
			<h5 class="text-muted">Create New Group Wizard</h5>
			<ol>
				<li>Step 1: Group Name</li>
				<li class="text-muted">Step 2: Add Policy</li>
				<li class="text-muted">Step 3: Add Users</li>
			</ol>
		</div>
		<div class="col-sm-9 border-left mt-1">
			<h3 class="border-bottom">Set Group Name</h3>
			<p>Set a group name.</p>
			<form action="#buildURL(action='auth:admin.groupWizAct')#" method="post">
				<div class="form-group row">
					<label for="name" class="col-sm-3 col-form-label">Group Name:</label>
					<div class="col-sm-4" id="nameObj">
						<input type="text" class="form-control" id="name" name="name" placeholder="mygroup" maxlength="255" />
						<p class="help-text"><small>Example: Developers or MyGroup</small></p>
					</div>
				</div>
				<div class="form-group row">
					<label for="description" class="col-sm-3 col-form-label">Description:</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="desc" name="description" placeholder="description" maxlength="500"/>
						<p class="help-text"><small>Example: Client administrators with user management</small></p>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-4 offset-sm-3">
						<label class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" name="isSystem" value="1">
							<span class="custom-control-indicator"></span>
							<span class="custom-control-description">System Group</span>
						</label>
						<p class="help-text"><small>Only seen by System Administrators</small></p>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-4 offset-sm-3">
						<label class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" name="isPublic" value="1">
							<span class="custom-control-indicator"></span>
							<span class="custom-control-description">Public Group</span>
						</label>
						<p class="help-text"><small>Can be seen and used by everyone</small></p>
					</div>
				</div>
				<div class="form-group row">
					<div class="offset-sm-3 col-sm-4">
						<button type="submit" class="btn btn-primary">Next Step</button>
					</div>
				</div>
			</form>
	    </div>
	</div>
</cfoutput>