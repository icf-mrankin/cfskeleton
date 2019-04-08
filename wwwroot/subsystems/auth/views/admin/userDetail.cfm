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
			<div class="col-sm-9 col-md-10">
				<div class="form-row">
					<div class="form-group col-md-3">
						<label for="email">Email</label>
						<input type="email" class="form-control" name="email" placeholder="Email" value="#rc.person.getEmail()#">
					</div>
					<div class="form-group col-md-3">
						<label for="firstName">First Name</label>
						<input type="text" class="form-control" id="firstName" name="first_name" placeholder="First" value="#rc.person.getFirst_Name()#">
					</div>
					<div class="form-group col-md-3">
						<label for="lastName">Last Name</label>
						<input type="text" class="form-control" id="lastName" name="last_name" placeholder="Last" value="#rc.person.getLast_Name()#" aria-label="Last Name">
					</div>
					<div class="form-group col-md-3">
						<label for="title">Title</label>
						<input type="text" class="form-control" id="title" name="title" placeholder="Title" value="#rc.person.getTitle()#">
					</div>
				</div>
				<div class="form-row">
					<div class="form-group col-md-7 order-1 order-md-1">
						<label for="organization">Organization</label>
						<select class="custom-select" name="organization_Id">
							<cfloop array="#rc.organizations#" index="org">
								<option value="#org.getId()#" #(org.getId() eq rc.person.getOrganization_Id())?'selected':''#>#org.getName_ln()#</option>
							</cfloop>
						</select>
					</div>
					<div class="form-group col-md-5 order-6 order-md-2">
						<label for="timezone">Timezone</label>
						<select class="custom-select" name="timezone" id="timezone">
							<cfloop query="#rc.timezones#" group="region">
								<optgroup label="#region_label#">
									<cfloop>
										<option value="#name#" #(name eq rc.person.getTimeZone())?'selected':''#>#name#</option>
									</cfloop>
								</optgroup>
							</cfloop>
						</select>
					</div>
					<div class="form-group col-md-7 order-2 order-md-3">
						<label for="address1">Address Line 1</label>
						<input type="text" class="form-control" id="address1" name="address1" placeholder="Address Line 1" value="#rc.person.getAddress1()#">
					</div>
					<div class="form-group col-md-5 order-7 order-md-4">
						<label for="secondaryEmail">Alternate Email</label>
						<input type="text" class="form-control" id="SecondaryEmail" name="secondary_email" placeholder="Alternate Email" value="#rc.person.getSecondary_Email()#">
					</div>
					<div class="form-group col-md-7 order-3 order-md-5">
						<label for="address2">Address Line 2</label>
						<input type="text" class="form-control" id="address2" name="address2" placeholder="Address Line 2" value="#rc.person.getAddress2()#">
					</div>
					<div class="form-group col-md-5 order-8 order-md-6">
						<label for="businessPhone">Business Phone</label>
						<input type="text" class="form-control" id="businessPhone" name="business_phone" placeholder="Business Phone" value="#rc.person.getBusiness_Phone()#">
					</div>
					<div class="form-group col-md-3 order-4 order-md-7">
						<label for="city">City</label>
						<input type="text" class="form-control" id="city" name="city" placeholder="City" value="#rc.person.getCity()#">
					</div>
					<div class="form-group col-md-2 order-5 order-md-8">
						<label for="state">State</label>
						<select class="custom-select">
							<cfloop array="#rc.states#" index="state">
								<option value="#state.getCode()#" #(state.getCode() eq rc.person.getState())?"selected":""#>#state.getCode()#</option>
							</cfloop>
						</select>
					</div>
					<div class="form-group col-md-2 order-6 order-md-9">
						<label for="zip">Zip Code</label>
						<input type="text" class="form-control" id="zipCode" name="zipCode" placeholder="Zip" value="#rc.person.getZipCode()#">
					</div>
					<div class="form-group col-md-5 order-7 order-md-10">
						<label for="mobilePhone">Mobile Phone</label>
						<input type="text" class="form-control" id="mobilePhone" name="mobile_phone" placeholder="Mobile Phone" value="#rc.person.getMobile_Phone()#">
					</div>
				</div>
				<div class="form-row">
					<div class="form-group col-md-6 order-1">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" value="1" name="password_change_required_yn" id="password_change_required_yn" #(rc.person.getPassword_Change_Required_yn())?'checked':''#>
							<label class="custom-control-label" for="password_change_required_yn"> Password Change Required</label>
						</div>
					</div>
					<div class="form-group col-md-6 order-2">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" value="1" id="locked_yn" name="locked_yn" #(rc.person.getLocked_yn())?'checked':''#>
							<label class="custom-control-label" for="locked_yn"> Account Locked</label>
						</div>
					</div>
					<div class="form-group col-md-6 order-3">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" value="1" id="code" name="code">
							<label class="custom-control-label" for="code"> Reset Authenticator Code</label>
						</div>
					</div>
					<div class="form-group col-md-6 order-4">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" value="1" id="mfa_exempt_yn" name="mfa_exempt_yn" #(rc.person.getMfa_exempt_yn())?'checked':''#>
							<label class="custom-control-label" for="mfa_exempt_yn"> MFA Exempt</label>
						</div>
					</div>
					<div class="form-group col-md-6 order-6 order-md-5">
						<div class="custom-control custom-checkbox">
							<input type="checkbox" class="custom-control-input" value="1" name="staff_yn" #(rc.person.getstaff_yn())?'checked':''#>
							<label class="custom-control-label"> Staff</label>
						</div>
						<p class="form-text text-muted">If unchecked, user will not appear in the directory or be able to log in.</p>
					</div>
					<div class="form-group col-md-4 order-5 order-md-6">
						<label>Reset ID</label>
						<input type="text" readonly  class="form-control-plaintext" value="#rc.person.getToken_txt()#"/>
					</div>
				</div>
				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="contactId" data-toggle="tooltip" data-placement="top" title="Deprecated: Used to associate a user with a legacy Contact">Contact Id</label>
						<input type="text" readonly class="form-control-plaintext" value="#rc.person.getContact_id()#"/>
					</div>
					<div class="form-group col-md-6">
						<label for="lastLogin">Last Login</label>
						<input type="text" class="form-control" id="lastLogin" name="last_login" data-inputmask="'alias': 'datetime', 'inputFormat': 'mm/dd/yyyy hh:MM tt'" value="#datetimeformat(rc.person.getLast_Login_dtm(),'mm/dd/yyyy hh:nn tt')#">
					</div>
				</div>
				<div class="form-row">
					<div class="form-group col-md-4">
						<label>Groups Owned</label>
						<p class="form-control-plaintext">
							<cfloop array="#rc.person.getOwnedGroups()#" index="group">
								<span class="badge badge-info">#group.getName()#</span>
							</cfloop>
						</p>
					</div>
					<div class="form-group col-md-4">
						<label>Group Member</label>
						<p class="form-control-plaintext">
							<cfloop array="#rc.person.getGroups()#" index="grp">
								<span class="badge badge-info">#grp.getName()#</span>
							</cfloop>
						</p>
					</div>
					<div class="form-group col-md-4">
						<label>Policies</label>
						<p class="form-control-plaintext">
							<cfloop array="#rc.person.getPolicies()#" index="policy">
								<span class="badge badge-info">#policy.getName()#</span>
							</cfloop>
						</p>
					</div>
					<div class="form-group col-md-12 d-flex">
						<button type="button" class="btn btn-danger mr-auto" id="deleteBtn">Delete</button>
						<button type="button" class="btn btn-secondary" id="cancelBtn">Cancel</button>
						<button type="button" class="btn btn-primary ml-2" id="saveBtn">Save</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</cfoutput>
