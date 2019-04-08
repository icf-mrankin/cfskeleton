<cfoutput>
	<script>
		var oTable;
		$(document).ready(function()
		{
			var table = $('##userTbl').DataTable();

			$('##saveBtn').click(function(){
				var data = table.$('input').serialize();
				$.ajax({
					type: "POST",
					url: "#buildURL(action='auth:admin.groupWizUserAddAct&id=' & rc.groupid)#",
					data: data
				}).done(function(){
					location.assign("#buildURL('auth:admin.groups')#");
				});
			});
		});
	</script>
	<div class="row">
		<div class="col-sm-3 mt-1">
			<h5 class="text-muted">Create New Group Wizard</h5>
			<ol>
				<li class="text-success">Step 1: Group Name <span class="fas fa-check"></span></li>
				<li class="text-success">Step 2: Add Policy <span class="fas fa-check"></span></li>
				<li>Step 3: Add Users</li>
			</ol>
		</div>
		<div class="col-sm-9 border-left mt-1">
			<form id="userFrm">
				<input type="hidden" name="groupId" value="#rc.groupId#"/>
				<table class="table table-sm" id="userTbl">
					<thead>
						<tr>
							<th></th>
							<th>Name</th>
							<th>Email</th>
							<th>Organziation</th>
						</tr>
					</thead>
					<tbody>
						<cfloop query="#rc.users#">
							<tr>
								<td>
									<label class="custom-control custom-checkbox">
	  									<input name="email" value="#EMAIL#" type="checkbox" class="custom-control-input">
	  									<span class="custom-control-indicator"></span>
									</label>
								</td>
								<td>#first_name# #last_name#</td>
								<td>#email#</td>
								<td>#organization_id#</td>
							</tr>
						</cfloop>
					</tbody>
				</table>

				<div class="form-group row">
					<div class="offset-sm-3 col-sm-9">
						<div class="float-right">
							<button type="button" class="btn btn-secondary" id="cancelBtn">Cancel</button>
							<button type="button" class="btn btn-primary" id="saveBtn">Continue</button>
						</div>
					</div>
				</div>
			</form>
	    </div>
	</div>
</cfoutput>