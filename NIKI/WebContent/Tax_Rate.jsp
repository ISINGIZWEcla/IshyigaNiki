

<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%    
} else if (!checkUserPrivileges.toString().contains("TAXRATE")) {
    session.setAttribute("errorLogin","you don't have the right to handle taxes");

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

session.setAttribute("taxrate",null);

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>TaxRate</title>
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
        <li><a href="niki.jsp">NIKI</a></li>
        <li><a href="taxPage.jsp">Tax Page</a></li>
        
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
			<h1 style="text-align: center; text-shadow: maroon;">Subcategory</h1>
		</div>         
            
           
        <div><h1>Tax_Rate Entry Form</h1> </div>
        
        <h3>${txr.insertMsg}</h3>
        <h4>${txr.error} </h4>
        

        
        <form name="inputCat" action="Tax_RateResponse.jsp" method="POST">
            
            
            <table id="inputTax" >
                
                
                <tr>
                    <td>
                       Tax Label: 
                    </td>
                    <td>
                        <input type="text" name="txlbl" value="" required=true size="35"/> 
                    </td>
                    
                </tr>
                <tr>
                    <td>
                        Tax Value:
                    </td>
                    <td>
                        <input type="text" name="txvl" value="" required=true size="35" >
                    </td>
                    
                </tr>
                
                
                <tr>
                    <td>
                        
                    </td>
                    <td>
                        <input value="save" type="submit"/>
                    </td>
                    
                </tr>
                
            </table>

            
        </form>
        
        <div>
                <h3>${txr.insertMsg}</h3>
                <h4>${txr.error} </h4>
                 
                <h3 style="background-color:buttonface">Tax Rates List</h3>
                
                <table  id="example" class="table table-striped table-bordered" cellspacing="0" width="100%" >
                    <thead> 
                        <tr>
                            <th> Tax label</th>               
                            <th> Tax value</th>   
                            <th> Status </th>
                            <th> Edit </th>
                            <th> Sleep </th>
                        </tr>
                        
                        </thead>
                        <tfoot>
                        <tr>

                            <th> Tax label</th>               
                            <th> Tax value</th>   
                            <th> Status </th>
                            <th> Edit </th>
                            <th> Sleep </th>
                           

                        </tr>
                        </tfoot>
                        <tbody>
                        <%

                            try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery("SELECT * FROM niki_tax_rates");
                                int i = 0;
                                while (rs.next()) {

                                    String bb = rs.getString(1);
                                    String cc = rs.getString(2);
                                    String dd = rs.getString(3);
                                    

                                 

                        %>  
                        <tr> 

                            <td><%=bb%>  </td>
                            <td> <%= cc%></td>
                            <td> <%= dd%></td>
                           
                            <td> <a href="TaxRateUpdate.jsp?taxEdit=<%=bb%>&action=update" class="btn btn-primary"> Edit </a></td>
                            <td> <a href="Tax_RateResponse.jsp?taxRejectSleep=<%=bb%>&action=taxSleep" class="btn btn-primary">Sleep </a></td>
                            
                            
                        </tr>
                        
                        <%
                                    i++;
                                }

                                con.close();

                            } catch (Exception e) {
                                e.printStackTrace();

                            }
                        %>
                    </tbody>
                </table>
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
<% 
}
%>