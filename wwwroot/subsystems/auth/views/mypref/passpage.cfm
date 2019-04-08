<cfoutput>
  <div class="col-sm-12">
      <ul class="nav nav-tabs mx-2">
        <li class="nav-item">
          <a class="nav-link" href="#buildURL(action='auth:mypref.default')#">Preferences</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#buildURL(action='auth:mypref.profilepage')#">Profile</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="#buildURL(action='auth:mypref.passpage')#">Password</a>
        </li>
      </ul>
  </div>

  <script>
    $(document).ready(function()
    {

      $('##password, ##password2').keyup(function(){
        var pw = $('##password').val();
        var pw2 = $('##password2').val();
        var lc = /[a-z]/;
        var uc = /[A-Z]/;
        var num = /[0-9]/;
        var sc = /[##?!@$%^&*\.-]/;
        var x = /[^a-zA-Z0-9##?!@$%^&*\.-]/;
        var score = 0;
        var pwlength = #rc.pw_length#;

        if (pw.match(lc)){score++}
        if (pw.match(uc)){score++}
        if (pw.match(num)){score++}
        if (pw.match(sc)){score++}
        if (pw.length >= pwlength){score = score + 2}
        if (pw.match(x)){score = 0}

        switch(score) 
        {
          case 0:
            if (pw.length > 0)
            {
              $('##progressbar').attr('style','width: 100%;').html('bad character').attr('class', 'progress-bar bg-danger');
            } else {
              $('##progressbar').attr('style','width: 0%;').html('').attr('class', 'progress-bar bg-danger');
            }
            break;
          case 1:
            $('##progressbar').attr('style','width: 20%').html('weak').attr('class', 'progress-bar bg-danger');
            break;
          case 2:
            $('##progressbar').attr('style','width: 40%').html('weak').attr('class', 'progress-bar bg-warning');
            break;
          case 3:
            $('##progressbar').attr('style','width: 60%').html('poor').attr('class', 'progress-bar bg-warning');
            break;
          case 4: 
            $('##progressbar').attr('style','width: 80%').html('better').attr('class', 'progress-bar bg-warning');
            break;
          default:
            $('##progressbar').attr('style','width: 100%').html('good').attr('class', 'progress-bar bg-success');
        }

        if (pw == pw2)
        {
          if (pw.length == 0)
          {
            $('##saveBtn').html('Enter a New Password');
            $('##saveBtn').attr('disabled',true);
          } else if (score < 5) {
            $('##saveBtn').html('Add Complexity');
            $('##saveBtn').attr('disabled',true);
          } else {
            $('##saveBtn').html('Update Password');
            $('##saveBtn').removeAttr('disabled');
          }
        } else {
          $('##saveBtn').html('Passwords don\'t Match');
          $('##saveBtn').attr('disabled', true);
        }
      });

      $('##saveBtn').click(function(){
        $('##resetFrm').submit();
      });
    });
  </script>

  <div class="row">
    <div class="col-md-8 offset-md-2 col-lg-6 offset-lg-3">
      <form name="resetFrm" method="post" action="#buildURL('auth:main.changePasswordAct')#">
        <input type="hidden" name="token" value="#rc.token#"/>
        <div class="card login mt-5">
          <p class="h3 card-header">Change Password</p>
          <div class="card-block">
            <p>Passwords must be at least:</p>
            <cfif rc.pw_length == 15>
              <ul><li>Fifteen (#rc.pw_length#) characters in length</li></ul>
            <cfelse>
              <ul><li>Eight (#rc.pw_length#) characters in length</li></ul>
            </cfif>
            <p>And contain at least 3 of the following features:</p>
            <ul>
              <li>Upper Case Letters: <span class="text-muted bg-faded">ABCDEFGHIJKLMNOPQRSTUVWXYZ</span></li>
              <li>Lower Case Letters: <span class="text-muted bg-faded">abcdefghijklmnopqrstuvwxyz</span></li>
              <li>Numbers: <span class="text-muted bg-faded">0123456789</span></li>
              <li>Special Characters: <span class="text-muted bg-faded">##?!@$%^&amp;*.-</span></li>
            </ul>
            <div class="form-group row">
              <div class="col-sm-12">
                <div class="input-group">
                  <span class="input-group-addon"><i class="fas fa-key"></i></span>
                  <input type="password" class="form-control" id="password" name="password" placeholder="password"/>
                </div>
              </div>
            </div>
            <div class="form-group row">
              <div class="col-sm-12">
                <div class="input-group">
                  <span class="input-group-addon"><i class="fas fa-key"></i></span>
                  <input type="password" class="form-control" id="password2" name="password2" placeholder="password again"/>
                </div>
              </div>
            </div>
            <div class="progress">
              <div class="progress-bar bg-danger" role="progressbar" id="progressbar" style="width:0%;" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
            </div>
          </div>
          <div class="card-footer">
            <button type="submit" class="btn btn-primary pull-right" disabled id="saveBtn">Enter a New Password</button>
          </div>
        </div>
      </form>
    </div>
  </div>


 
</cfoutput>


