<cfoutput>
	<div class="nav flex-column nav-pills">
		<a class="nav-link #(getFullyQualifiedAction(action) eq 'cfskeleton:devs.default')?'active':''#" href="#buildURL('devs.default')#">Overview</a>
	</div>
	<h4>Guides</h4>
	<div class="nav flex-column nav-pills">
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.build_watch')?'active':''#" href="#buildURL('devs.build_watch')#">build/watch</a>
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.css_sass')?'active':''#" href="#buildURL('devs.css_sass')#">css/sass</a>
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.database')?'active':''#" href="#buildURL('devs.database')#">database</a>
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.javascript')?'active':''#" href="#buildURL('devs.javascript')#">javascript</a>
	</div>
	<h4>Subsystems</h4>
	<div class="nav flex-column nav-pills">
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.admin')?'active':''#" href="#buildURL('devs.admin')#">admin</a>
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.auth')?'active':''#" href="#buildURL('devs.auth')#">auth</a>
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.cfskeleton')?'active':''#" href="#buildURL('devs.cfskeleton')#">cfskeleton</a>
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.mail')?'active':''#" href="#buildURL('devs.mail')#">mail</a>
	</div>
	<h4>Utilities</h4>
	<div class="nav flex-column nav-pills">
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.aws_s3')?'active':''#" href="#buildURL('devs.aws_s3')#">aws/s3</a>
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.csrf')?'active':''#" href="#buildURL('devs.csrf')#">csrf</a>
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.eventlog')?'active':''#" href="#buildURL('devs.eventlog')#">eventLog</a>
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.message')?'active':''#" href="#buildURL('devs.message')#">message</a>
		<a class="nav-link #(getFullyQualifiedAction( action ) eq 'cfskeleton:devs.state')?'active':''#" href="#buildURL('devs.state')#">state</a>
	</div>
</cfoutput>