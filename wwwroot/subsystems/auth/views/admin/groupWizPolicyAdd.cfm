<cfoutput>
	<script>
		$(document).ready(function()
		{
			$('##saveBtn').click(function(){
				$('##policyFrm').submit();
			});

			$('##cancelBtn').click(function(){
				location.assign("#buildURL(action='auth:admin.groupDeleteAct&id=' & rc.groupId)#");
			})	
		});
	</script>

	<div class="row">
		<div class="col-sm-3 mt-1">
			<h5 class="text-muted">Create New Group Wizard</h5>
			<ol>
				<li class="text-success">Step 1: Group Name <span class="fas fa-check"></span></li>
				<li>Step 2: Add Policy</li>
				<li class="text-muted">Step 3: Add Users</li>
			</ol>
		</div>
		<div class="col-sm-9 border-left mt-1">
			<form id="policyFrm" method="post" action="#buildURL(action='auth:admin.groupWizPolicyAddAct')#">
				<input type="hidden" name="groupId" value="#rc.groupId#"/>
				<table class="table table-sm">
					<thead>
						<tr>
							<th></th>
							<th>Policy</th>
							<th>Description</th>
						</tr>
					</thead>
					<tbody>
						<cfloop array="#rc.policies#" index="policy">
							<tr>
								<td>
									<label class="custom-control custom-checkbox">
		  								<input name="name" value="#policy.getName_sn()#" type="checkbox" class="custom-control-input">
		  								<span class="custom-control-indicator"></span>
									</label>
								</td>
								<td>#policy.getName_sn()#</td>
								<td>#policy.getDescription()#</td>
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