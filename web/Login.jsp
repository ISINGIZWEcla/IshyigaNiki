<%-- 
    Document   : Login
    Created on : Jun 20, 2016, 3:26:11 PM
    Author     : vakaniwabo
--%>


<!DOCTYPE html>
<html lang="en">
<head>
  <title>Login</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> -->
  <script src="assets/js/jquery.min.js"></script>
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
            
        <br/> <br/> 
        
			<div id="smsG" style="color: red;">

                <%
                    Object recMsg = session.getAttribute("errorLogin");
                    
                    /*
                    this prevents from just printing null when there is no error
                    */
                    if(recMsg!=null ){
                     out.print(recMsg);
                     }else{
                     out.print("");                     
                     }

                %>
            </div>
            <div id="tlog">
                <form action="LoginResponse.jsp" method="POST">
                    <fieldset style="width: 300px;">

                        <legend style="color:#368BC1;font-size: 120%;"><em>Login </em></legend>
                        
                        <table border="0">
                            <tbody>
                                <tr>
                                    <td>  User_name</td>
                                    <td> <input class="form-control" type="text" name="username" value="${usr.username}" required=true /></td>
                                </tr>
                                
                                
                                <tr>
                                    <td>  Password</td>
                                    <td> <input class="form-control" type="password" name="password" value="${usr.password}" required=true /></td>
                                </tr>
                                

                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td></td>
                            <td><input class="btn btn-success" type="submit" value="Login" name="save" />
                            <input class="btn btn-danger" type="reset" value="cancel" name="cancel" /></td>
                        </tr>

                            </tbody>
                        </table>
                        
                        
                    </fieldset>
                </form>
            </div>
        

        
    </div>
    <div class="col-sm-2 sidenav" >
      
    </div>
  </div>
</div>


<footer class="container-fluid text-center">
  <p><strong> Copyright &#169; 2021 Algorithm,Inc.</strong></p>
</footer>

</body>
</html>






