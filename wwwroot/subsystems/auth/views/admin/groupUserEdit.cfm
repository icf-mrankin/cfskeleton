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
					url: "#buildURL(action='auth:admin.groupUserEditAct&id=' & rc.id)#",
					data: data
				}).done(function(){
					location.assign("#buildURL('auth:admin.groups')#");
				});
			});

			$('##cancelBtn').click(function(){
				location.assign("#buildURL('auth:admin.groups')#");
			})
		});
	</script>
	
	<div class="row">
		<div class="col-sm-3 col-md-2">
			#view('auth:admin/pills')#
		</div>
		<div class="col-sm-9 col-md-10">
			<h2>
				Add/Edit Users
				<small class="text-muted">#rc.group.getName()#</small>
			</h2>
				<table class="table" id="userTbl">
					<thead class="thead-inverse">
						<tr>
							<th>Name</th>
							<th>Email</th>
							<th>Title</th>
						</tr>
					</thead>
					<tbody>
						<cfloop query="#rc.users#">
							<tr>
								<td>
									<div class="custom-control custom-checkbox">
	  									<input name="email" value="#EMAIL#" id="#email#" type="checkbox" #(listFind(rc.usersInGroup,email))?"checked":""# class="custom-control-input">
	  									<label class="custom-control-label" for="#email#">#first_name# #last_name#</label>
									</div>
								</td>
								<td>#email#</td>
								<td>#title#</td>
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
		</div>
	</div>
</cfoutput>