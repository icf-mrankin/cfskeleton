<cfoutput>
	<div class="row">
		<div class="col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<form name="loginFrm" method="post" action="#buildURL('auth:main.forgotAct')#">
				<div class="card login mt-5">
					<p class="h3 card-header">Reset Your Password</p>
					<div class="card-block">
						<p class="card-text">Enter your email address to receive a link to reset your password.</p>
						<div class="form-group row">
							<div class="col-sm-12">
								<div class="input-group">
									<span class="input-group-addon"><i class="fas fa-envelope"></i></span>
									<input type="email" class="form-control" name="email" placeholder="Email"/>
								</div>
							</div>
						</div>
					</div>
					<div class="card-footer">
						<button type="submit" class="btn btn-primary pull-right" id="loginBtn">Send Email</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</cfoutput>