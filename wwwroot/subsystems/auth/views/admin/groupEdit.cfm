<cfoutput>
	<script>
		$(document).ready(function()
		{
			$('##cancelBtn').click(function(){
				location.assign("#buildURL(action='auth:admin.groups')#");
			});	

			$('##saveBtn').click(function(){
				$('##groupFrm').submit();
			});
		});
	</script>
	
	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('auth:admin/pills')#
		</div>
		<div class="col-sm-6">
			<h2>Edit Group</h2>
			<form id="groupFrm" method="post" action="#buildURL(action='auth:admin.groupEditAct')#">
				<input type="hidden" name="groupId" value="#rc.group.getId()#"/>
				<div class="form-group row">
					<label for="Name" class="col-sm-3 col-form-label">Name</label>
					<div class="col-sm-9" id="name">
						<p class="form-control-static">#rc.group.getName()#</p>
						<p class="form-text text-muted">A group name cannot be altered once created.</p>
					</div>
				</div>
				<div class="form-group row">
					<label for="description" class="col-sm-3 col-form-label">Description</label>
					<div class="col-sm-9" id="description">
						<input type="text" class="form-control" name="description_ln" placeholder="Description" value="#rc.group.getDescription_ln()#">
					</div>
				</div>
				<div class="form-group row">
					<div class="offset-sm-3 col-sm-9">
						<div class="float-right">
							<button type="button" class="btn btn-secondary" id="cancelBtn">Cancel</button>
							<button type="button" class="btn btn-primary" id="saveBtn">Save</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</cfoutput>