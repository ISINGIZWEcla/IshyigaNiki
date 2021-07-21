
<!DOCTYPE html>
<html lang="en">
<head>
  <title>niki</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<script src="assets/js/jquery.min.js"></script>
<!--   <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;}
    }
  </style>
</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="index.html">Home</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="Login.jsp" class="btn btn-info btn-lg" style="color: white;">
          <span class="glyphicon glyphicon-log-in"></span> Login
        </a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">
  <div class="row content">
    <div class="col-sm-2 sidenav">
      
    </div>
    <div class="col-sm-8 text-left" >
		<div class="page-header">
			<h1 style="text-align: center; text-shadow: maroon;">Welcome to NIKI</h1>
		</div>         
            

        <div style="float: left;margin-right:20px">
        	<form action="FinalItems.jsp">
        		<input type="submit" style="font-weight:bold; background: blue; width: 15em; height: 12em;color: black;" value="VIEW"/>
        	</form> 
        </div>
        <div style="float: left;margin-right:20px">
        	<form action="ItemsSearching.jsp">
        		<input type="submit" style="font-weight:bold; background: red ; width: 15em; height: 12em;color: black;" value="SEARCH"/>
        	</form> 
        </div>
        <div style="margin-right:20px;margin-bottom:20px">
        	<form action="PendingItems.jsp">
        		<input type="submit" style="font-weight:bold; background: orange; width: 15em; height: 12em;color: black;" value="ADD"/>
        	</form> 
        </div>
        <div style="float: left;margin-right:20px">
        	<form action="FinalItems.jsp">
        		<input type="submit" style="font-weight:bold; background: yellow; width: 15em; height: 12em;color: black;" value="UPDATE"/>
        	</form> 
        </div>
        <div style="float: left;margin-right:20px">
        	<form action="">
        		<input type="submit" style="font-weight:bold; background: green ; width: 15em; height: 12em;color: black;" value="ATTACH"/>
        	</form> 
        </div>
    </div>
    <div class="col-sm-2 sidenav" >
      
    </div>
  </div>
</div>


<footer class="container-fluid text-center">
  <p><strong> Copyright &#169; 2016 Algorithm,Inc.</strong></p>
</footer>

</body>
</html>

