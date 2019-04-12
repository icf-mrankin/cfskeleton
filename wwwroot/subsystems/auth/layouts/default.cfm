<cfoutput>
	#view('cfskeleton:main/_navbar')#
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