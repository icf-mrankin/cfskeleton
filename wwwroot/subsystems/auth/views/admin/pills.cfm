<cfoutput>
<nav class="nav nav-pills flex-column">
	<a href="#buildURL('auth:admin.users')#" class="nav-link #(left(getItem(),4) eq 'user')?'active':''#">Users</a>
	<a href="#buildURL('auth:admin.groups')#" class="nav-link #(left(getItem(),5) eq 'group')?'active':''#">Groups</a>
	<a href="#buildURL('auth:admin.policies')#" class="nav-link #(left(getItem(),5) eq 'polic')?'active':''#">Policies</a>
</nav>
</cfoutput>