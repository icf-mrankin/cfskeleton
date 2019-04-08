<cfoutput>
	<script>
		$(document).ready(function()
		{
			$('##cancelBtn').click(function(){
				location.assign("#buildURL('auth:admin.groups')#");
			});

			$('##saveBtn').click(function(){
				$('##polcyFrm').submit();
			});
		});
	</script>
	
	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('auth:admin/pills')#
		</div>	
		<div class="col-sm-9 col-md-10">
			<form id="polcyFrm" method="POST" action="#buildURL('auth:admin.groupPolicyEditAct')#">
				<input type="hidden" name="id" value="#rc.group.getId()#"/>
				<h2>
					Add/Edit Group Policies
					<small class="text-muted">#rc.group.getName()#</small>
				</h2>
				<table class="table table-sm">
					<thead class="thead-inverse">
						<tr>
							<th></th>
							<th>Name</th>
							<th>Description</th>
							<th class="text-sm-center">System</th>
							<th>Created</th>
						</tr>
					</thead>
					<tbody>
						<cfloop array="#rc.policies#" index="policy">
							<tr>
								<td>
									<div class="form-check">
										<label class="form-check-label">
											<input class="form-check-input chk" name="name" type="checkbox" #(rc.group.hasPolicy(policy))?"checked":""# value="#policy.getName_sn()#"/>
										</label>
									</div>
								</td>
								<td>#policy.getName_sn()#</td>
								<td>#policy.getDescription()#</td>
								<td class="text-sm-center">
									<cfif policy.getSystem_yn()>
										<span class="fas fa-check"></span>
									</cfif>
								</td>
								<td>#datetimeformat(policy.getCreated_dtm(),'mm/dd/yyyy h:mm tt')#</td>
							</tr>
						</cfloop>
					</tbody>
				</table>
				<div class="form-group row">
					<div class="offset-sm-3 col-sm-9 mt-5">
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