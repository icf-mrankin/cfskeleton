<div class="container-fluid">
	<cfoutput>
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
	</cfoutput>
</div>
<cfoutput>
	#body#
</cfoutput>