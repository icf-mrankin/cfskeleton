<cfoutput>
	 <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="##navbarTogglerDemo03" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand" href="#buildURL(action=':')#">CFSkeleton</a>

    <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
      <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
        <cfif structKeyExists(rc,'user')>
          <cfif rc.user.holdsPolicy('sysadminFull')>
            <li class="nav-item">
              <a class="nav-link" href="#buildURL(action='admin:main.default')#">Admin</a>
            </li>
          </cfif>
          <li class="nav-item">
            <a class="nav-link" href="#buildURL(action='auth:main.logout')#">logout</a>
          </li>
        <cfelse>
          <li class="nav-item">
            <a class="nav-link" href="#buildURL(action='auth:main.login')#">login</a>
          </li>
        </cfif>
        
      </ul>
    </div>
  </nav>
	<div class="container-fluid">

		<cfif isDefined("rc.message")>
			<script>
				$(document).ready(function()
				{
					<cfloop array="#rc.message.getControls()#" index="control">
						$('###control.id#').addClass('has-#control.type#');
						<cfif len(control.helptext)>
							$('###control.id#').append('<div class="form-control-feedback">#control.helptext#</div>');
						</cfif>
					</cfloop>		
				});
			</script>
			#rc.message.getMessage()#
		</cfif>

	</div>

	<div class="container-fluid">
		#body#
	</div>
</cfoutput>