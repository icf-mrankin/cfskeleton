<cfoutput>
	<script>
		$(document).ready(function()
		{
			$('##code').inputmask("999999");		
		});
	</script>
	
	<div class="row ">
		<div class="col-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<form name="loginFrm" id="loginFrm" method="post" action="#buildURL('auth:main.checkOTPAct')#">
				<div class="card login mt-5">
					<div class="card-header">
						<p class="h3">Authenticate</p>
					</div>
					<div class="card-body">
						<p>Use the authenticator app you set up earlier on your smart phone or device to generate the 6-digit authentication code.</p> 
						<input type="hidden" name="email" value="#rc.email#">
						<div class="form-group row">
							<label for="email" class="col-sm-2 col-form-label">Code</label>
							<div class="col-sm-10" id="email">
								<div class="input-group">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="fas fa-user-secret"></i></span>
									</div>
									<input type="text" class="form-control" name="code" id="code" value="" />
								</div>
							</div>
						</div>
						<cfif rc.mfa_timeout gt 0>
							<div class="form-group row">
								<div class="offset-sm-2 col-sm-10">
									<label class="custom-control custom-checkbox">
										<input type="checkbox" class="custom-control-input" name="save_mfa_timeout" value="1">
										<span class="custom-control-indicator"></span>
										<span class="custom-control-description">Don't ask again for #rc.mfa_timeout# 
											day<cfif rc.mfa_timeout gt 1>s</cfif>											
										</span>
									</label>
									<p class="form-text text-danger">WARNING! Don't check this box on a shared computer.</p>
								</div>
							</div>
						</cfif>
					</div>
					<div class="card-footer">
						<div class="d-md-none">
							<button class="btn btn-primary pull-right btn-sm loginBtn" id="authBtnx" type="submit">Authenticate</button>
						</div>
						<div class="d-none d-md-block">
							<button class="btn btn-primary pull-right loginBtn" id="authBtn" name="loginBtn" type="submit">Authenticate</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</cfoutput>