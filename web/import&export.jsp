


<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%    
} else if (!checkUserPrivileges.toString().contains("CATEGORY")) {
    session.setAttribute("errorLogin","you don't have the right to handle categories");

%>
<jsp:forward page="Login.jsp"/>


<%    } else {
	String userLanguage = session.getAttribute("userInSessionLanguage").toString();

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>

<%
String user=session.getAttribute("userInSessionfName").toString(); 

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Categories</title>
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
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<li><i class="glyphicon glyphicon-user" style="color: white;font-size: 2em;"> <%=user%></i></li>
        <li><a href="Logout.jsp" class="btn btn-info btn-lg" style="color: white;">
          <span class="glyphicon glyphicon-log-out"></span> Log out
        </a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">
  <div class="row content">
    
    <div class="col-sm-8 text-left" >
		<div class="page-header">
			<h1 style="text-align: center; text-shadow: maroon;">NIK-I IMPORT & EXPORT FILES</h1>
		</div>  
		
		
	
        <div style="float: left;margin-right:20px">
        	<form action="chooseCompany.jsp">
        		<input type="submit" style="width: 15em; height: 12em;color: black; background: blue ; font-weight: bold;" value="UPLOAD FILE"/>
        	</form> 
        </div>
        
        <div style="float: left;margin-right:20px">
        	<form action="ChooseBusinCategForExcelView.jsp">
        		<input type="submit" style="width: 15em; height: 12em;color: black; background: gray ; font-weight: bold;" value="VIEW EXCEL DATA"/>
        	</form> 
        </div>
        <div style="margin-right:20px;margin-bottom:20px;">
        	<form action="smartExcelSearch.jsp">
        		<input type="submit" style="width: 15em; height: 12em;color: black; background: red ; font-weight: bold;" value="SMART EXCEL VIEW"/>
        	</form> 
        </div>
        
        <div style="float: left;margin-right:20px">
        	<form action="">
        		<input type="submit" style="width: 15em; height: 12em;color: black; background: orange ; font-weight: bold;" value="DOWNLOAD FILE"/>
        	</form> 
        </div>
        
        <div style="float: left;margin-right:20px">
        	<form action="Company.jsp">
        		<input type="submit" style="width: 15em; height: 12em;color: black; background: green ; font-weight: bold;" value="COMPANIES"/>
        	</form> 
        </div>
        
        <div style="float: left;margin-right:20px">
        	<form action="ViewExcelTrash.jsp">
        		<input type="submit" style="width: 15em; height: 12em;color: black; background: yellow ; font-weight: bold;" value="TRASH"/>
        	</form> 
        </div>
            
            
            
        
    </div>
    
  </div>
</div>


<footer class="container-fluid text-center">
  <p><strong> Copyright &#169; 2016 Algorithm,Inc.</strong></p>
</footer>


</body>
</html>
<% 
}
%>
