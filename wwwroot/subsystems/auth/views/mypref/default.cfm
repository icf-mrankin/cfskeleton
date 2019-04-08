<cfoutput>
	<div class="row">
	  <div class="col-12">
	      <ul class="nav nav-tabs mx-2">
	        <li class="nav-item">
	          <a class="nav-link active" href="#buildURL(action='auth:mypref.default')#">Preferences</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="#buildURL(action='auth:mypref.profilepage')#">Profile</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="#buildURL(action='auth:mypref.passpage')#">Password</a>
	        </li>
	      </ul>
	  </div>
	</div>

	<div class="row">
		<div class="col-12">
			<form class="mt-2" name="myPreferences" method="post" action="#buildURL(action='auth:mypref.default')#" >
				<input type="hidden" name="updatePreferences" value="1" />
				<div class="custom-control custom-checkbox mx-2">
					<input type="checkbox" name="changeSmallBanner" id="changeSmallBanner" class="custom-control-input" #rc.changeSmallBannerChecked# >
					<label class="custom-control-label" for="changeSmallBanner">Change to small Banner</label>
				</div>
				<div  class="col-sm-10  mx-2">
					<button type="button" class="btn btn-outline-primary mt-2" onclick="document.myPreferences.submit();">Save</button>
				</div>
			</form>
		</div>
	</div>
</cfoutput>


