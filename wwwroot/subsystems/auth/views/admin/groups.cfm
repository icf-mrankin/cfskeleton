<cfoutput>
	<script>
		$(document).ready(function()
		{
			// control drop downs for selections
			$('.chk').change(function(){
				var num = $('.chk:checked').length;
				if (num == 0){
					$('.dropdown-item').addClass('disabled');
				} else if (num == 1){
					$('.dropdown-item').removeClass('disabled');
				} else {
					$('.dropdown-item').addClass('disabled');
					$('##deleteGroup').removeClass('disabled');
				}
			});	
			
			// create new group
			$('.newGroup').click(function(){
				location.assign("#buildURL('auth:admin.groupWiz')#");
			})

			$('##editPolicies').click(function(){
				if ($(this).hasClass('disabled'))
				{return false} else {
					$('##groupFrm').prop('action','#buildURL(action="auth:admin.groupPolicyEdit")#');
					$('##groupFrm').submit();
				}
			})

			$('##editUsers').click(function(){
				if ($(this).hasClass("disabled"))
				{return false} else {
					$('##groupFrm').prop('action','#buildURL(action="auth:admin.groupUserEdit")#');
					$('##groupFrm').submit();
				}
			});

			$('##deleteGroup').click(function(){
				if($(this).hasClass('disabled'))
				{return false} else {
					$('##groupFrm').prop('action','#buildURL(action="auth:admin.groupDeleteAct")#');
					$('##groupFrm').submit();
				}
			});

			$('##editName').click(function(){
				if($(this).hasClass('disabled'))
				{return false} else {
					$('##groupFrm').prop('action','#buildURL(action="auth:admin.groupEdit")#');
					$('##groupFrm').submit();
				}
			});
		});
	</script>
	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('auth:admin/pills')#
		</div>
		<div class="col-sm-9 col-md-10">
			<div class="row">
				<div class="col-sm-12">
						<button class="btn btn-primary newGroup" type="button">Create New Group</button>
						<div class="btn-group">
							<div class="dropdown">
								<button class="btn btn-outline-primary dropdown-toggle" type="button" id="ddActions" data-toggle="dropdown">Group Actions</button>
								<div class="dropdown-menu">
									<div class="dropdown-item disabled" id="editName">Edit Description</div>
									<div class="dropdown-item disabled" id="editPolicies">Add/Remove Policies</div>
									<div class="dropdown-item disabled" id="editUsers">Add/Remove Users</div>
									<div class="dropdown-divider"></div>
									<div class="dropdown-item disabled" id="deleteGroup">Delete</div>
								</div>
							</div>
						</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12 pt-1">
					<form id="groupFrm" method="post" action="">
						<table class="table table-hover table-sm">
							<thead class="thead-inverse">
								<tr>
									<th></th>
									<th>Group Name</th>
									<th>Description</th>
									<th>Policies</th>
									<th>Users</th>
									<th class="text-sm-center">System Group</th>
									<th>Created</th>
								</tr>
							</thead>
							<tbody>
								<cfloop array="#rc.groups#" index="group">
									<tr>
										<td>
											<div class="form-check">
												<label class="form-check-label">
													<input class="form-check-input chk" name="id" type="checkbox" value="#group.getId()#"/>
												</label>
											</div>
										</td>
										<td>#group.getName()#</td>
										<td>#group.getDescription_ln()#</td>
										<td>#arrayLen(group.getPolicies())#</td>
										<td>#arrayLen(group.getUsers())#</td>
										<td class="text-sm-center">
											<cfif group.getSystem_yn()>
												<span class="fas fa-check"></span>
											</cfif>
										</td>
										<td>#dateFormat(group.getCreated_dtm(), "long")#</td>
									</tr>
								</cfloop>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</cfoutput>
