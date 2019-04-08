<cfoutput>
	<script>
		$(document).ready(function()
		{
			$('##cancelBtn').click(function(){
				location.assign("#buildURL('auth:admin.organizations')#");
			})

			$('##saveBtn').click(function(){
				$('##orgFrm').submit();
			})
		});
	</script>
	
	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('auth:admin/pills')#
		</div>
		<div class="col-sm-5 col-md-6">
			<h2>Add/Edit Organization</h2>
			<form id="orgFrm" action="#buildURL('auth:admin.organizationDetailAct')#" method="POST">
				<input type="hidden" name="id" value="#rc.org.getId()#"/>
				<div class="form-group row">
					<label for="name" class="col-sm-2 col-form-label">Name</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="name" name="name_ln" value="#rc.org.getName_ln()#">
					</div>
				</div>
				<div class="form-group row">
					<label for="created" class="col-sm-2 col-form-label">Created</label>
					<div class="col-sm-10">
						<input type="text" disabled class="form-control" id="created" name="created" value="#datetimeFormat(rc.org.getCreated_dtm(), 'mm/dd/yyyy hh:nn:ss tt', rc.user.getTimezone())#" data-inputmask="'alias': 'datetime', 'inputFormat': 'mm/dd/yyyy hh:MM tt'">
					</div>
				</div>
				<div class="form-group row">
					<div class="offset-sm-2 col-sm-10">
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