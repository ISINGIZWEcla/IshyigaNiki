<!-- Added by Vicky March 1, 2018: Change Request -->

<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%    
} else if (!checkUserPrivileges.toString().contains("VALIDATE")) {
    session.setAttribute("errorLogin","you don't have the right to validate");

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
session.setAttribute("initialExcelView", "yes");

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Choose Company For excel Items View</title>
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
		    	
		    	$('.modal').on('hidden.bs.modal', function(e)
					    { 
					        $(this).removeData();
					    }) ;
		    	
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
        <li><a href="import&export.jsp">import&export</a></li>
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
    <div class="col-sm-2 sidenav">
      
    </div>
    <div class="col-sm-8 text-left" >
		<div class="page-header">
			<h1 style="text-align: center; text-shadow: maroon;">View Excel Data</h1>
		</div>         
            
		
        
        <h3>${comp.insertMsg}</h3>
        <h4>${comp.error} </h4>
		<form method="post" action="ViewFilesData.jsp">
		<table>
		
		   <tr>
		   <td>Choose Business Category name</td>
		   </tr>
		   <tr>
			<td>
				<select name="busin_categ_selected" required="required" >
					<option></option>
                            
                            <%
                           // String orig="yesSubcatAdd";
                                try {
                                	
                                	
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement("Select busin_category_id,busin_category_descr from niki_business_categories where status='LIVE'");

                                    ResultSet rs = st.executeQuery();

                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String buscatId = rs.getString("busin_category_id");
                                        String buscatNme = rs.getString("busin_category_descr");


                            %>
                                    
                                    <option value="<%=buscatId%>"><%=buscatNme%></option>
                            <%

                                    }


                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>
                        </select> 
                    </td>
                    
                     <td>
                    <a href="Business_Category.jsp?" class="glyphicon glyphicon-plus btn btn-primary">Add Business Category</a>
 
                    </td>
			
		</tr>
		<tr>
			<td><input type="submit" class="btn btn-primary" value="Next"/></td> 
		</tr>
		</table>
	</form>
		
		
        
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
<% 
}
%>
