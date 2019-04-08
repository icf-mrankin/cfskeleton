<cfoutput>
	<script>
		$(document).ready(function()
		{
			$('##newPolicyBtn').click(function(){
				location.assign("#buildURL(action='auth:admin.policyDetail')#");
			});

			// row clicks
			$('.policy').click(function(){
				location.assign("#buildURL(action='auth:admin.policyDetail', querystring='name=')#" + $(this).data('name'));
			});

			$('##policyTbl').DataTable({
				"autoWidth": false
			});

			$('##policyTbl_wrapper').removeClass('container-fluid');
		});
	</script>

	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('auth:admin/pills')#
		</div>
		<div class="col-sm-9 col-md-10">
			<div class="row">
				<div class="col-sm-12">
					<button class="btn btn-primary" id="newPolicyBtn" type="button">Create New Policy</button>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12 pt-1">
					<table class="table table-hover" id="policyTbl">
						<thead class="thead-inverse">
							<tr>
								<th>Name</th>
								<th>Description</th>
								<th class="text-sm-center">System Policy</th>
								<th>Created</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#rc.policies#" index="policy">
								<tr class="policy" data-name="#policy.getName_sn()#">
									<td>#policy.getName_sn()#</td>
									<td>#policy.getDescription()#</td>
									<td class="text-sm-center">
										<cfif policy.getSystem_yn()>
											<span class="fas fa-check"></span>
										</cfif>
									</td>
									<td>#datetimeformat(policy.getCreated_dtm(), 'mm/dd/yyyy h:mm tt')#</td>
								</tr>
							</cfloop>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</cfoutput>

