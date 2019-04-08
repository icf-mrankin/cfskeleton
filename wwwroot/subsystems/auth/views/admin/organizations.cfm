<cfoutput>
<script>
	$(document).ready(function()
	{
		$('##newOrgBtn').click(function(){
			location.assign("#buildURL('auth:admin.organizationDetail')#");
		});

		$('.org').click(function(){
			location.assign("#buildURL(action='auth:admin.organizationDetail', queryString='Id=')#" + $(this).data('id'));
		})
	});
</script>

	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('auth:admin/pills')#
		</div>
		<div class="col-sm-9 col-md-10">
			<div class="row">
				<div class="col-sm-12">
					<button class="btn btn-primary" id="newOrgBtn" type="button">Create New Organization</button>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12 pt-1">
					<table class="table table-hover" id="orgTbl">
						<thead class="thead-inverse">
							<tr>
								<th>Name</th>
								<th>Created</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#rc.organizations#" index="org">
								<tr class="org clickable" data-id="#org.getId()#">
									<td>#org.getName_ln()#</td>
									<td>#dateTimeFormat(org.getCreated_dtm(), 'mm/dd/yyyy hh:nn:ss tt', rc.user.getTimezone())#</td>
								</tr>
							</cfloop>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</cfoutput>

