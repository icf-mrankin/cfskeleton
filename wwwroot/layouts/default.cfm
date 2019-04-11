<!doctype html>
<html lang="en">
<cfoutput>
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="static/app.css" >
    <script src="static/app.js"></script>
    <cfif structKeyExists(rc, 'title')>
	    <title>#rc.title#</title>
	  </cfif>
  </head>
  <body>
  	#body#
  </body>
</cfoutput>
</html>