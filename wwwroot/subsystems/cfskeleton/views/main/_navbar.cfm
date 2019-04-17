<cfoutput>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-3">
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="##navbarTogglerDemo03" aria-controls="navbarTogglerDemo03" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <a class="navbar-brand" href="#buildURL(action=':')#">CFSkeleton</a>

	  <div class="collapse navbar-collapse" id="navbarTogglerDemo03">
	    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
	      <cfif structKeyExists(rc,'user')>
	      	<cfif rc.user.holdsAnyPolicy('sysadminFull','developer')>
	      		<li class="nav-item">
	      			<a class="nav-link" href="#buildURL(action='cfskeleton:devs.default')#">Developers</a>
	      		</li>
	      	</cfif>
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
</cfoutput>