<cfoutput>
	<script>
		$(document).ready(function()
		{
			$('##cancelBtn').click(function()
			{
				location.assign("#buildURL(action='auth:main.login')#");
			});	

			$('##registerBtn').click(function()
			{
				$('##registrationFrm').submit();
			});
		});
	</script>

	<div class="row">
		<div class="col-xs-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<div class="card login">
				<p class="h3 card-header">Register</p>
				<div class="card-block">
					<form name="registrationFrm" id="registrationFrm" method="post" action="#buildURL(action='registerAct')#">
						<div class="form-group row">
							<label for="firstName" class="col-sm-2 col-form-label">Name</label>
							<div class="col-sm-5">
								<input type="text" class="form-control" name="firstName" placeholder="First">
							</div>
							<div class="col-sm-5">
								<input type="text" class="form-control" name="lastName" placeholder="Last">
							</div>
						</div>
						<div class="form-group row">
							<label for="email" class="col-sm-2 col-form-label">Email</label>
							<div class="col-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fas fa-envelope"></i></span>
									<input type="email" class="form-control" name="email" required="true" placeholder="Email"/>
								</div>
								<p id="passwordHelpBlock" class="form-text text-muted">
		 							Your Email address is going to be used during login.
								</p>
							</div>
						</div>
						<div class="form-group row">
							<label for="password" class="col-sm-2 col-form-label">Password</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" name="password1" placeholder="Enter a password" />
							</div>
						</div>
						<div class="form-group row">
							<label for="password2" class="col-sm-2 col-form-label">Password</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" name="password2" placeholder="Enter that password again" />
							</div>
						</div>
					</form>
				</div>
				<div class="card-footer">
					<button class="btn btn-secondary" type="button" id="cancelBtn">Cancel</button>
					<button class="btn btn-primary pull-right" type="button" id="registerBtn">Register</button>
				</div>
			</div>
		</div>
	</div>
</cfoutput>
