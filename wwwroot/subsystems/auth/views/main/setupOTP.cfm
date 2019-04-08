<cfoutput>
	<script>
		$(document).ready(function()
		{
			// new QRCode(document.getElementById('qrcode'),'#rc.qrURL#');
		});
	</script>
	
	
	<div class="row">
		<div class="col-sm-6 mt-3">
			<div class="card">
				<div class="card-block">
					<h4 class="card-title">2-factor Authentication</h4>
					<h6 class="card-subtitle mb-2 text-muted">REQUIRED</h6>
					<p>This site uses enhanced security that requiers entering a six digit security code that changes every 30 seconds. You generate this code on your smart phone using FreeOTP, Google Authenticator or some other <a href="https://en.wikipedia.org/wiki/Time-based_One-time_Password_Algorithm" target="_blank"><i class="fas fa-external-link-alt"></i>TOTP</a> compliant tool.</p>
					<p>Using your smart phone or device and one of the apps below, scan your <i>Authenticator Scan Target</i> to set up this site.
				</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item flex-column align-items-start">
						<h5>FreeOTP (recommended)</h5>
						<div class="d-flex w-100">
							<a class="storeBtn" id="ios" href="https://itunes.apple.com/us/app/freeotp-authenticator/id872559395?mt=8" target="_blank"></a>
							<a class="storeBtn" id="android" href="https://play.google.com/store/apps/details?id=org.fedorahosted.freeotp" target="_blank"></a>
						</div>
					</li>
					<li class="list-group-item flex-column align-items-start">
						<h5>Microsoft Authenticator</h5>
						<div class="d-flex w-100">
							<a class="storeBtn" id="windows" href="https://www.microsoft.com/en-us/store/p/microsoft-authenticator/9nblgggzmcj6?SilentAuth=1&wa=wsignin1.0&rtc=1" target="_blank"></a>
							<a class="storeBtn" id="ios" href="https://itunes.apple.com/app/id983156458?mt=8" target="_blank"></a>
							<a class="storeBtn" id="android" href="https://play.google.com/store/apps/details?id=com.azure.authenticator" target="_blank"></a>
						</div>
					</li>
					<li class="list-group-item flex-column align-items-start">
						<h5>Google Authenticator</h5>
						<div class="d-flex w-100">
							<a class="storeBtn" id="ios" href="https://itunes.apple.com/us/app/google-authenticator/id388497605?mt=8" target="_blank"></a>
							<a class="storeBtn" id="android" href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2" target="_blank"></a>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div class="col-sm-4 mt-3">
			<h3>Authenticator Scan Target</h3>
			<hr />
			<canvas id="qrCanvas" data-qrURL="#rc.qrURL#"></canvas>
			<p>Your Key: #rc.secret32#</p>
			<form class="mt-3" method="post" action="#buildURL('auth:main.setupOTPAct')#">
				<input type="hidden" name="email" value="#rc.email#"/>
				<div class="form-group">
					<label for="code">6-digit Authentication Code</label>
					<input class="form-control" id="code" type="text" name="code" value="" data-inputmask="'mask':'999999'" />
				</div>
				<button type="submit" class="btn btn-primary">Authenticate</button>
			</form>
		</div>
	</div>
</cfoutput>