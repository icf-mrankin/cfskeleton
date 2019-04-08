<cfoutput>
	<h1>user access tests</h1>
	<p>Is user in group [27]: #rc.user.isInGroup(27)#</p>
	<p>Is user in group [29]: #rc.user.isInGroup(29)#</p>
	<p>Is user in group [100]: #rc.user.isInGroup(100)#</p>
	<p>Does the user hold policy ["sysadminfull"]: #rc.user.holdsPolicy('sysadminFull')#</p>
</cfoutput>
<!--- change --->