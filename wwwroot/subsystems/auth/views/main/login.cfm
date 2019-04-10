<cfoutput>
	<script>
		$(document).ready(function()
		{
			$('.forgotBtn').click(function()
			{
				location.assign("#buildURL(action='auth:main.forgot')#");
			});

			$('.registerBtn').click(function(){
				location.assign("#buildURL(action='auth:main.register')#");
			});

			$('.loginBtn').click(function(){
				$('##loginFrm').submit();
			})

			// allow form submission with enter key
			$('input').keypress(function(event) {
   				if (event.which == 13) {
        			event.preventDefault();
        			$('##loginFrm').submit();
    			}
			});
		});
	</script>
	<div class="row ">
		<div class="col-12 col-md-8 offset-md-2 col-lg-6 offset-lg-3">
			<div class="card login mt-5">
				<div class="card-header">
					<p class="h3">Login</p>
				</div>
				<div class="card-body">
					<form name="loginFrm" id="loginFrm" method="post" action="#buildURL('auth:main.loginAct')#">
						<div class="form-group row">
							<div class="col-sm-12" id="email">
								<div class="input-group">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="fas fa-envelope"></i></span>
									</div>
									<input type="email" class="form-control" name="email" placeholder="Email"/>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<div class="col-sm-12" id="password">
								<div class="input-group">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="fas fa-key"></i></span>
									</div>
									<input type="password" class="form-control" name="password" placeholder="Password"/>
								</div>
							</div>
						</div>
					</form>

				</div>
				<div class="card-footer">
					<!--- <button class="btn btn-secondary" type="button" id="registerBtn">Register</button> --->
					<div class="d-md-none">
						<button class="btn btn-secondary btn-sm forgotBtn" type="button">Forgot Password?</button>
						<button class="btn btn-primary pull-right btn-sm loginBtn" id="loginBtnx" type="button">Login</button>
					</div>
					<div class="d-none d-md-block">
						<button class="btn btn-secondary forgotBtn" type="button">Forgot Password?</button>
						<button class="btn btn-primary pull-right loginBtn float-right" id="loginBtn" name="loginBtn" type="button">Login</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</cfoutput>
