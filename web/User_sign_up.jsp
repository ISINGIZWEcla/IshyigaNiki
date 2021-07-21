


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <title>Sign Up</title>
  
  <jsp:useBean id="usr_tmp" scope="request" class="niki.User_Temp"/>
  
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
 		<link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
 		 
        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        
        <script src="assets/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap.min.js"></script>
        
        <script>
			$(document).ready(function() {
		    	$('#example').DataTable();
		    	
			} );
		</script>
		

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
        <li class="active"><a href="accountsPage.jsp">Accounts</a></li>
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
			<h1 style="text-align: center; text-shadow: maroon;">Sign Up</h1>
		</div>         
            
 		<div> 
                <h3>${usr_tmp.insertMsg} </h3>
            </div>
            <div id="me"> 
                
                <form action="User_sign_upResponse.jsp" method="POST" name="users" name="users">


                    <table id="tb">
                        <tr>
                            
                            <td>UserName</td>
                            <td><input type="text" name="username" value="${usr_tmp.username}" required="required" size="35">
                                <span class="error" >${usr_tmp.msgUser} </span> </td>
                        </tr>

                        <tr>
                            <td>E-mail</td>
                            <td><input type="email" name="email" value="${usr_tmp.email}"required="required" size="35">
                                <span class="error">${usr_tmp.msgEm}</span></td>
                        </tr>
                        
                        <tr>
                            <td>Password</td>
                            <td><input type="password" name="password" value="${usr_tmp.password}" required="required" size="35">
                                <span class="error" >${usr_tmp.msgPswd} </span></td>
                        
                        </tr>
                        
                        <tr>
                            <td>First Name</td>
                            <td><input type="text" name="fname" value="${usr_tmp.fname}" required="required" size="35">
                                <span class="error"> ${usr_tmp.msgFn} </span></td>  


                            </td>
                        </tr>
                        <tr>
                            <td>Last Name</td>
                            <td><input type="text" name="lname" value="${usr_tmp.lname}" required="required" size="35">
                                <span class="error"> ${usr_tmp.msgLn} </span></td>  


                            </td>
                        </tr>
                        <tr>
                            <td>Gender</td>
                            <td><select  name="sex" id="sex" required="required">
                            		<option value=""></option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>

                                </select><br/>
                             </td>
                        </tr>
                                                
                        <tr>
                            <td>Phone</td>
                            <td><input type="tel" name="phone" value="${usr_tmp.phone}" required="required" size="35">
                                <span class="error" >${usr_tmp.msgPhone}</span></td>
                        </tr>
                        
                        <tr>
                            <td>Language</td>
                            <td><select  name="lang"  required="required">
                            		<option value=""></option>
                                    <option value="ENGLISH">ENGLISH</option>
                                    <option value="FRENCH">FRENCH</option>
                                    <option value="KINYARWANDA">KINYARWANDA</option>
                                    <option value="SWAHILI">SWAHILI</option>

                                </select><br/>
                             </td>
                            
                        </tr>
                        
                        
                        
                        <tr>
                            <td></td>
                            <td><input class="btn btn-default" type="submit" value="Add" name="save" />
                            <input class="btn btn-default" type="reset" value="cancel" name="cancel" /></td>
                        </tr>

                    </table>

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
