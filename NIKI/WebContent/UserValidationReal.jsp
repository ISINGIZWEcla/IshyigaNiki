
 
 <%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%    
} else if (!checkUserPrivileges.toString().contains("USERS")) {
    session.setAttribute("errorLogin","you don't have the right to handle users");

%>
<jsp:forward page="Login.jsp"/>


<%    } else {
	String userLanguage = session.getAttribute("userInSessionLanguage").toString();
	String user=session.getAttribute("userInSessionfName").toString(); 
	
	String username = request.getParameter("username");
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <title>User Validation</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  	<!-- <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<script src="assets/js/jquery.min.js"></script> -->
<!--   <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->

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
        <li><a href="users.jsp">All users</a></li>
        <li><a href="TempUsers.jsp">Temporary Users</a></li>
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
			<h1 style="text-align: center; text-shadow: maroon;">User Validation</h1>
		</div>         
            

		   <%

    String eml="",psswd="",fstnm="",lstnm="",gndr="",phn="",usrnm = username,lang="";
                        try{
                            Connection conn = ConnectionClass.getConnection();
                            Statement ST = conn.createStatement();
                            ResultSet rs = ST.executeQuery("SELECT * FROM users_temp where user_name='"+ username+"'");
                            int i = 0;
                            while (rs.next()) {


                                String bb = rs.getString(1);
                                usrnm=bb;
                                String cc = rs.getString(2);
                                eml=cc;
                                String dd = rs.getString(3);
                                psswd=dd;
                                String ee = rs.getString(4);
                                fstnm=ee;
                                String ff = rs.getString(5);
                                lstnm=ff;
                                String gg = rs.getString(6);
                                gndr=gg;
                                String hh = rs.getString(7);
                                phn=hh;
                                String ii = rs.getString(9);
                                lang=ii;
                                
                          i++;
                            }

                            conn.close();


                        } catch (Exception e) {
                            e.printStackTrace();

                        }
 
                    %>
                    
                    
            <div> 
                <h3>${usr.insertMsg} </h3>
            </div>
            <div id="me"> 
                
                <form action="ValidateUserResponse.jsp" method="POST" name="users" name="users">


                    <table id="tb">
                        <tr>
                            
                            <td>UserName</td>
                            <td><input type="text" name="username" value="<%=usrnm %>" required="required" size="35">
                                <span class="error" >${usr.msgUser} </span> </td>
                        </tr>

                        <tr>
                            <td>E-mail</td>
                            <td><input type="email" name="email" value="<%= eml%>"required="required" size="35">
                                <span class="error">${usr.msgEm}</span></td>
                        </tr>
                        
                        <tr>
                            <td>Password</td>
                            <td><input type="password" name="password" value="<%= psswd%>" required="required" size="35">
                                <span class="error" >${usr.msgPswd} </span></td>
                        
                        </tr>
                        
                        <tr>
                            <td>First Name</td>
                            <td><input type="text" name="fname" value="<%=fstnm %>" required="required" size="35">
                                <span class="error"> ${usr.msgFn} </span>
                          	</td>  


                        </tr>
                        <tr>
                            <td>Last Name</td>
                            <td><input type="text" name="lname" value="<%=lstnm %>" required="required" size="35">
                                <span class="error"> ${usr.msgLn} </span>
                            </td>  


                        </tr>
                        <tr>
                            <td>Gender</td>
                            <td><select  name="sex" id="sex" required="required">
                            		<option value="<%=gndr %>"><%=gndr %></option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>

                                </select><br/></td>
                        </tr>
                                                
                        <tr>
                            <td>Phone</td>
                            <td><input type="tel" name="phone" value="<%=phn %>" required="required" size="35">
                                <span class="error" >${usr.msgPhone}</span></td>
                        </tr>
                        
                         <tr>
                            <td>Language</td>
                            <td><select  name="lang"  required="required">
                            		<option value="<%=lang %>"><%=lang %></option>
                                    <option value="ENGLISH">ENGLISH</option>
                                    <option value="FRENCH">FRENCH</option>
                                    <option value="KINYARWANDA">KINYARWANDA</option>
                                    <option value="SWAHILI">SWAHILI</option>

                                </select><br/>
                             </td>
                            
                        </tr>
                        
                        <tr>
                            <td>User_type</td>
                            <td>
	                            <select name="usrtyp" required="required">
	                            	<option value=""></option>
	                            	<option value="GUARDIAN">GUARDIAN</option>
	                            	<option value="ADMIN">ADMIN</option>
	                            	<option value="VENDOR">VENDOR</option>
	                            </select>
                                <span class="error" >${usr.user_type}</span>
                            </td>
                        </tr>
                                               
                        
                        <tr>
                            <td>Privileges</td>
                            <td>
                            	<select name="prvlg" multiple="multiple" required="required">
	                            	<option value=""></option>
	                            	<option value="users">users </option>
	                            	<option value="validate"> validate </option>
	                            	<option value="items">items </option>
	                            	<option value="addItem">addItem </option>
	                            	<option value="category">category </option>
	                            	<option value="excelInput">excelInput </option>
	                            	<option value="taxrate">taxrate </option>
                            	</select>
                            </td>
                        </tr>
                        
                        
                        
                        <tr>
                            <td></td>
                            <td><input class="btn btn-default" type="submit" value="Validate" name="save" />
                            <input class="btn btn-default" type="reset" value="cancel" name="cancel" /></td>
                        </tr>

                    </table>

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
 