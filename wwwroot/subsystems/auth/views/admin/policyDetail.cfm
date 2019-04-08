<cfoutput>
	<script>
		$(document).ready(function()
		{
			$('##cancelBtn').click(function(){
				location.assign("#buildURL(action='auth:admin.policies')#");;
			});	
			$('##deleteBtn').click(function(){
				if (confirm("Delete #rc.policy.getName_sn()#?"))
				{
					location.assign("#buildURL(action='auth:admin.policyDeleteAct', querystring={name=rc.policy.getName_sn()})#");
				}
			});
			$('##saveBtn').click(function(){
				$('##policyFrm').submit();
			});
		});
	</script>
	
	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('auth:admin/pills')#
		</div>
		<div class="col-sm-6">
			<h2>
				Add/Edit Policy
			</h2>
			<form id="policyFrm" action="#buildURL('auth:admin.policyDetailAct')#" method="post">
				<div class="form-group row">
					<label for="Name" class="col-sm-3 col-form-label">Name</label>
					<div class="col-sm-9" id="name">
						<input type="text" class="form-control" name="name_sn" placeholder="Name" value="#rc.policy.getName_sn()#">
						<p class="help-block">Upper/lower case letters and number only.</p>
					</div>
				</div>
				<div class="form-group row">
					<label for="Description" class="col-sm-3 col-form-label">Description</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="Description" name="Description" placeholder="Description" value="#rc.policy.getDescription()#">
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-9 offset-sm-3">
						<div class="form-check">
							<label class="form-check-label">
								<input class="form-check-input" type="checkbox" name="system_yn" value="1" #(rc.policy.getSystem_yn())?"checked":""#> System
							</label>
						</div>
					</div>
				</div>
				<div class="form-group row">
					<div class="offset-sm-3 col-sm-9">
						<div class="float-left">
							<button type="button" class="btn btn-danger" id="deleteBtn">Delete</button>
						</div>
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