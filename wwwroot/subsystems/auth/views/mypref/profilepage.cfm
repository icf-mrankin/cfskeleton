<cfoutput>
  <div class="row">
    <div class="col-sm-12">
        <ul class="nav nav-tabs">
          <li class="nav-item">
            <a class="nav-link" href="#buildURL(action='auth:mypref.default')#">Preferences</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="#buildURL(action='auth:mypref.profilepage')#">Profile</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#buildURL(action='auth:mypref.passpage')#">Password</a>
          </li>
        </ul>
    </div>
  </div>

  <script>
    $(document).ready(function()
    {
      $('##cancelBtn').click(function(){
        location.assign("#buildURL(action='auth:mypref')#");
      });

      $('##saveBtn').click(function(){
        $('##userFrm').submit();
      });

    });
  </script>


  <form id="userFrm" method="post" action="#buildURL(action='auth:mypref.userProfileAct')#">
  <input type="hidden" name="contactId"  value="#rc.person.getContact_id()#">
  <input type="hidden" name="email" value="#rc.person.getEmail()#">
  <input type="hidden" name="organizationId" value="#rc.person.getOrganization_id()#">
  <input type="hidden" name="token" value="#rc.Token#">





   <div class="row mt-3">
      <div class="col-sm-6">
        <div class="form-group row">
          <label for="email" class="col-sm-3 col-form-label">Email</label>
          <div class="col-sm-9" id="email">
            <p class="form-control-static">#rc.person.getEmail()#</p>           
          </div>
        </div>
        <div class="form-group row">
          <label for="firstName" class="col-sm-3 col-form-label">Name</label>
          <div class="col-sm-4">
            <input type="text" class="form-control" id="firstName" name="first_name" placeholder="First" value="#rc.person.getFirst_name()#">
          </div>
          <div class="col-sm-5">
            <input type="text" class="form-control" id="lastName" name="last_name" placeholder="Last" value="#rc.person.getLast_name()#" aria-label="Last Name">
          </div>
        </div>
        <div class="form-group row">
          <label for="organization" class="col-sm-3 col-form-label">Organization</label>
          <div class="col-sm-9">
            <p class="form-control-static">#rc.org.getName_ln()#</p>
          </div>
        </div>  
        <div class="form-group row">
          <label for="title" class="col-sm-3 col-form-label">Title</label>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="title" name="title" placeholder="Title" value="#rc.person.getTitle()#">
          </div>
        </div>
        <div class="form-group row">
          <label for="address1" class="col-sm-3 col-form-label">Address</label>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="address1" name="address1" placeholder="Address Line 1" value="#rc.person.getAddress1()#">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-sm-9 offset-sm-3">
            <input type="text" class="form-control" id="address2" name="address2" placeholder="Address Line 2" value="#rc.person.getAddress2()#">
          </div>
        </div>
        <div class="form-group row">
          <label for="" class="col-sm-3 col-form-label">City, ST Zip</label>
          <div class="col-sm-4">
            <input type="text" class="form-control" id="city" name="city" placeholder="City" value="#rc.person.getCity()#">
          </div>
          <div class="col-sm-2">
            <select class="custom-select">
              <cfloop array="#rc.states#" index="state">
                <option value="#state.getCode()#" #(state.getCode() eq rc.person.getState())?"selected":""#>#state.getCode()#</option>
              </cfloop>
            </select>
          </div>
          <div class="col-sm-3">
            <input type="text" class="form-control" id="zipCode" name="zipcode" placeholder="Zip" value="#rc.person.getZipCode()#">
          </div>
        </div>

      </div>

      <div class="col-sm-6">
        <div class="form-group row">
          <label for="timezone" class="col-sm-3 col-form-label">Time Zone</label>
          <div class="col-sm-9">
            <select class="custom-select" name="timezone">


              <cfloop query="#rc.timezones#" group="region">
                <optgroup label="#region_label#">
                  <cfloop>
                    <option value="#name#" #(name eq rc.person.getTimeZone())?'selected':''#>#name_label#</option>
                  </cfloop>
                </optgroup>
              </cfloop>
            </select>
          </div>
        </div>
        <div class="form-group row">
          <label for="SecondaryEmail" class="col-sm-3 col-form-label">Alternate Email</label>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="SecondaryEmail" name="Secondary_email" placeholder="Alternate Email" value="#rc.person.getSecondary_email()#">
          </div>
        </div>
        <div class="form-group row">
          <label for="businessPhone" class="col-sm-3 col-form-label">Business Phone</label>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="businessPhone" name="business_phone" placeholder="Business Phone" value="#rc.person.getBusiness_phone()#">
          </div>
        </div>
<!---         <div class="form-group row">
          <label for="homePhone" class="col-sm-3 col-form-label">Home Phone</label>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="homePhone" name="home_phone" placeholder="Home Phone" value="#rc.person.getHome_phone()#">
          </div>
        </div> --->
        <input type="hidden" name="home_phone" value="">
        <div class="form-group row">
          <label for="mobilePhone" class="col-sm-3 col-form-label">Mobile Phone</label>
          <div class="col-sm-9">
            <input type="text" class="form-control" id="mobilePhone" name="mobile_phone" placeholder="Mobile Phone" value="#rc.person.getMobile_phone()#">
          </div>
        </div>


      </div>

    </div>
      <div class="row">
        <div class="col-12 d-flex">
              <button type="button" class="btn btn-secondary ml-auto mr-3" id="cancelBtn">Cancel</button>
              <button type="button" class="btn btn-primary" id="saveBtn">Save</button>
          </div>
        </div>
  </form>
</cfoutput>


