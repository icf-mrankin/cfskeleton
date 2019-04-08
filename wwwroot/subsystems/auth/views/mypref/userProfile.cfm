<cfoutput>
	<script>
		$(document).ready(function()
		{
			$('##cancelBtn').click(function(){
				location.assign("#buildURL(action='auth:admin.users')#");
			});

			$('##saveBtn').click(function(){
				$('##userFrm').submit();
			});

			$('##deleteBtn').click(function(){
				if (confirm("Is it OK to completely delete this user?"))
				{
					location.assign("#buildURL(action='auth:admin.userDeleteAct', querystring='email=' & encodeForURL(rc.person.getEmail()))#");
				}
			});
		});
	</script>

	<form id="userFrm" method="post" action="#buildURL(action='auth:admin.userDetailAct')#">
		<div class="row">
			<div class="col-sm-3 col-md-2">
				#view('auth:admin/pills')#
			</div>
			<div class="col-sm-6 col-md-5">
				<div class="form-group row">
					<label for="email" class="col-sm-3 col-form-label">Email</label>
					<div class="col-sm-9" id="email">
						<input type="email" class="form-control" name="email" placeholder="Email" value="#rc.person.getEmail()#">
					</div>
				</div>
				<div class="form-group row">
					<label for="firstName" class="col-sm-3 col-form-label">Name</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="firstName" name="firstName" placeholder="First" value="#rc.person.getFirstName()#">
					</div>
					<div class="col-sm-5">
						<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last" value="#rc.person.getLastName()#" aria-label="Last Name">
					</div>
				</div>
				<div class="form-group row">
					<label for="organization" class="col-sm-3 col-form-label">Organization</label>
					<div class="col-sm-9">
						<select class="custom-select" name="organizationId">
							<cfloop array="#rc.organizations#" index="org">
								<option value="#org.getId()#" #(org.getId() eq rc.person.getOrganizationId())?'selected':''#>#org.getName()#</option>
							</cfloop>
						</select>
					</div>
				</div>	
				<div class="form-group row">
					<label for="title" class="col-sm-3 col-form-label">Title</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="title" name="title" placeholder="Title" value="#rc.person.getTitle()#">
					</div>
				</div>
				<div class="form-group row">
					<label for="address1" class="col-sm-3 col-form-label">Address</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="address1" name="address1" placeholder="Address Line 1" value="#rc.person.getAddress1()#">
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-9 offset-sm-3">
						<input type="text" class="form-control" id="address2" name="address2" placeholder="Address Line 2" value="#rc.person.getAddress2()#">
					</div>
				</div>
				<div class="form-group row">
					<label for="" class="col-sm-3 col-form-label">City, ST Zip</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="city" name="city" placeholder="City" value="#rc.person.getCity()#">
					</div>
					<div class="col-sm-2">
						<select class="custom-select">
							<cfloop array="#rc.states#" index="state">
								<option value="#state.getCode()#" #(state.getCode() eq rc.person.getState())?"selected":""#>#state.getCode()#</option>
							</cfloop>
						</select>
					</div>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="zipCode" name="zipCode" placeholder="Zip" value="#rc.person.getZipCode()#">
					</div>
				</div>
				<div class="form-group row">
					<div class="offset-sm-3 col-sm-9">
						<label class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" value="1" name="PasswordChangeRequired" #(rc.person.getPasswordChangeRequired())?'checked':''#>
							<span class="custom-control-indicator"></span>
							<span class="custom-control-description"> Password Change Required</span>
						</label>
					</div>
				</div>
				<div class="form-group row">
					<div class="offset-sm-3 col-sm-9">
						<label class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" value="1" name="isLocked" #(rc.person.getIsLocked())?'checked':''#>
							<span class="custom-control-indicator"></span>
							<span class="custom-control-description"> Account Locked</span>
						</label>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-3 col-form-label">Groups Owned</label>
					<div class="col-sm-9">
						<p class="form-control-static">
							<cfloop array="#rc.person.getOwnedGroups()#" index="group">
								<span class="badge badge-info">#group.getName()#</span>
							</cfloop>
						</p>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-3 col-form-label">Group Member</label>
					<div class="col-sm-9">
						<p class="form-control-static">
							<cfloop array="#rc.person.getGroups()#" index="grp">
								<span class="badge badge-info">#grp.getName()#</span>
							</cfloop>
						</p>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-3 col-form-label">Policies</label>
					<div class="col-sm-9">
						<p class="form-control-static">
							<cfloop array="#rc.person.getPolicies()#" index="policy">
								<span class="badge badge-info">#policy.getName()#</span>
							</cfloop>
						</p>
					</div>
				</div>
			</div>

			<div class="col-sm-5 col-md-5">
				<div class="form-group row">
					<label for="timezone" class="col-sm-3 col-form-label">Time Zone</label>
					<div class="col-sm-9">
						<select class="custom-select" name="timezone">
							<cfloop query="#rc.timezones#" group="region">
								<optgroup label="#region_label#">
									<cfloop>
										<option value="#name#" #(name eq rc.person.getTimeZone())?'selected':''#>#name_label#</option>
									</cfloop>
								</optgroup>
							</cfloop>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label for="SecondaryEmail" class="col-sm-3 col-form-label">Alternate Email</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="SecondaryEmail" name="SecondaryEmail" placeholder="Alternate Email" value="#rc.person.getSecondaryEmail()#">
					</div>
				</div>
				<div class="form-group row">
					<label for="businessPhone" class="col-sm-3 col-form-label">Business Phone</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="businessPhone" name="businessPhone" placeholder="Business Phone" value="#rc.person.getBusinessPhone()#">
					</div>
				</div>
				<div class="form-group row">
					<label for="homePhone" class="col-sm-3 col-form-label">Home Phone</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="homePhone" name="homePhone" placeholder="Home Phone" value="#rc.person.getHomePhone()#">
					</div>
				</div>
				<div class="form-group row">
					<label for="mobilePhone" class="col-sm-3 col-form-label">Mobile Phone</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="mobilePhone" name="mobilePhone" placeholder="Mobile Phone" value="#rc.person.getMobilePhone()#">
					</div>
				</div>
				<div class="form-group row">
					<div class="offset-sm-3 col-sm-9">
						<label class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" value="1" name="isStaff" #(rc.person.getIsStaff())?'checked':''#>
							<span class="custom-control-indicator"></span>
							<span class="custom-control-description"> Staff</span>
						</label>
						<p class="form-text text-muted">If unchecked, user will not appear in the directory or be able to log in.</p>
					</div>
				</div>
				<div class="form-group row">
					<label for="contactId" class="col-sm-3 col-form-label">Contact Id</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="contactId" name="contactId" placeholder="0" value="#rc.person.getContactId()#">
						<p class="help-text">Deprecated: Used to associate a user with a legacy Contact</p>
					</div>
				</div>

				<div class="form-group row">
					<label for="lastLogin" class="col-sm-3 col-form-label">Last Login</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="lastLogin" name="lastLogin" data-inputmask="'alias': 'datetime', 'inputFormat': 'mm/dd/yyyy hh:MM tt'" value="#datetimeformat(rc.person.getLastLogin(),'mm/dd/yyyy hh:nn tt')#">
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

			</div>
		</div>
	</form>
</cfoutput>
