<cfoutput>
<script>
	$(document).ready(function()
	{
		var strings = [];

		$('##template').change(function(){
			$('.strings').empty();
			var template = $("##template option:selected").val();
			switch (template)
			{
				case "test":
					var strings = ["first_name","last_name"];
					break;
				case "passwordReset":
					var strings = ["resetLink","passwordResetURL"];
					break;
				default:
					var strings = [];
			}

			var strDiv = document.getElementById("strDiv");
			console.log(strings.toString());
			for (i=0; i < strings.length; i++)
			{
				var formGroup = document.createElement('div');
				var fgLabel = document.createElement('label');
				var ctrlDiv = document.createElement('div');
				var ctrl = document.createElement('input');
				formGroup.classList.add('form-group', 'row');
				fgLabel.classList.add('col-sm-2', 'col-form-label');
				fgLabel.innerHTML = strings[i];
				ctrlDiv.classList.add('col-sm-10');
				ctrl.setAttribute('type','text');
				ctrl.setAttribute('id',strings[i]);
				ctrl.setAttribute('name','str_' + strings[i]);
				ctrl.classList.add('form-control');
				ctrlDiv.append(ctrl);
				formGroup.append(fgLabel);
				formGroup.append(ctrlDiv);
				strDiv.append(formGroup);
			}
		});	
		$('##template').trigger('change');
	});
</script>

	<div class="row">
		<div class="col-12">
			<h1>Mail test</h1>
			<form method="POST" action="#buildURL(action='mail:main.mailtestAct')#">

				<div class="card mb-3">
					<div class="card-header">Common Email Fields</div>
					<div class="card-block">
						<div class="form-group row">
							<label for="template" class="col-sm-2 col-form-label col-form-label-sm">Template</label>
							<div class="col-sm-10">
								<select class="custom-select form-control-sm" id="template" name="template">
									<option value="test">Test</option>
									<option value="passwordReset">Password Reset</option>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label for="to" class="col-sm-2 col-form-label col-form-label-sm">To</label>
							<div class="col-sm-10">
								<input type="email" class="form-control form-control-sm" id="to" name="to" placeholder="Email" value="#rc.user.getEmail()#" />
							</div>
						</div>
						<div class="form-group row">
							<label for="cc" class="col-sm-2 col-form-label col-form-label-sm">CC</label>
							<div class="col-sm-10">
								<input type="email" class="form-control form-control-sm" id="cc" name="cc" placeholder="Email" />
							</div>
						</div>
						<div class="form-group row">
							<label for="bcc" class="col-sm-2 col-form-label col-form-label-sm">BCC</label>
							<div class="col-sm-10">
								<input type="email" class="form-control form-control-sm" id="bcc" name="bcc" placeholder="Email" />
							</div>
						</div>
						<div class="form-group row">
							<label for="subject" class="col-sm-2 col-form-label col-form-label-sm">Subject</label>
							<div class="col-sm-10">
								<input type="text" class="form-control form-control-sm" id="subject" name="subject" placeholder="The subject of the message" value="#createGUID()#"/>
							</div>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="card-header">Substitution Strings</div>
					<div class="card-block">
						<div class="strings" id="strDiv"></div>
						<div class="form-group row">
							<div class="col-sm-10 offset-sm-2">
								<button type="submit" class="btn btn-primary">Send</button>
							</div>
						</div>
					</div>
				</div>





			</form>
		</div>
	</div>
</cfoutput>