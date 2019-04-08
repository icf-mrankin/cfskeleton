<cfoutput>
	<script>
		$(document).ready(function()
		{
			$('##newUserBtn').click(function(){
				location.assign("#buildURL(action='auth:admin.userDetail')#");
			})
			// row clicks
			$('.user').click(function(){
				location.assign("#buildURL(action='auth:admin.userDetail', querystring='email=')#" + $(this).data('email'));
			});

			$('##userTbl').DataTable();
			$('##userTbl_wrapper').removeClass('container-fluid');
		});
	</script>
	
	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('auth:admin/pills')#
		</div>
		<div class="col-sm-9 col-md-10">
			<div class="row">
				<div class="col-sm-12">
					<button class="btn btn-primary" type="button" id="newUserBtn">Create New User</button>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12 mt-3">
					<table id="userTbl" class="table table-hover">
						<thead class="thead-inverse">
							<tr>
								<th>Name</th>
								<th>Email</th>
								<th>Timezone</th>
								<th>Last login</th>
							</tr>
						</thead>
						<tbody>
							<cfloop array="#rc.users#" index="user">
								<tr class="user #(!user.getStaff_yn())?'table-warning':''#" data-email="#encodeForURL(user.getEmail())#">
									<td>#user.getLast_Name()#, #user.getFirst_Name()#</td>
									<td>#user.getEmail()#</td>
									<td>#user.getTimeZone()#</td>
									<td>#dateFormat(user.getlast_login_dtm(), 'mm/dd/yyyy')#</td>
								</tr>
							</cfloop>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</cfoutput>
