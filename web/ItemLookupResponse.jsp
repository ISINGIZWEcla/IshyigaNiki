

<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%    
} else if (!checkUserPrivileges.toString().contains("ADDITEM")) {
    session.setAttribute("errorLogin","you don't have the right to add an item");

%>
<jsp:forward page="Login.jsp"/>


<%    } else {

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
  <title>Item Lookup</title>
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
        <li><a href="temporariesPage.jsp">Temporaries</a></li>
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
			<h1 style="text-align: center; text-shadow: maroon;">Please search for the item first</h1>
		</div>         
            

		<form name="srchform" action="ItemLookupResponse.jsp" method="POST">
            <table>
                <tr>
                
                    <td>Item description </td>
                    <td>
                        <input type="text" name="searchItem">
                    </td>
                
                   
                	<td><input value="search" type="submit" /></td>
                </tr>
                
                
            </table>
</form>

		<%
        String searchItem = request.getParameter("searchItem");
		session.setAttribute("ItemSearched", searchItem);
        String searchBusCat = request.getParameter("searchCateg");
		boolean found=false;
        %>
        
        <div>
        <h3 style="background-color:buttonface"> Items matching "<%= searchItem %>" </h3>
                
                <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%" > 
                    <thead> 

                        <tr>
                        	<th> niki_code</th>
                            <th> Codebar</th>               
                            <th> Item description(ENGL) </th>
                            <th> Item description(KINYA)</th>
                            <th> Item description(FR)</th>
                            <th> Item description(SWHLI)</th>               
                            <th> Category </th>
                            <th> Tax-rate </th>
                            <th> Status </th>
                            
                        </tr>
                        
                        </thead>
                        <tfoot>
                        <tr>
							<th> niki_code</th>
                            <th> Codebar</th>               
                            <th> Item description(ENGL) </th>
                            <th> Item description(KINYA)</th>
                            <th> Item description(FR)</th>
                            <th> Item description(SWHLI)</th>               
                            <th> Category </th>
                            <th> Tax-rate </th>
                            <th> Status </th>
                           

                        </tr>
                        </tfoot>
                        <tbody>
                        <%

                            try {

                                Connection con = ConnectionClass.getConnection();
                                
                                //checking searching parameters
                                if(searchItem != null && !searchItem.isEmpty()){
                                	/* 
                                    search has been made                                  
                                    */
                                    
                                    Statement st0 = con.createStatement();
                                    ResultSet rs0 = st0.executeQuery("SELECT * FROM niki_items where itemDesc_ENGL like '%"+searchItem +"%' OR itemDesc_FRENCH like '%"+searchItem +"%' OR itemDesc_KINYA like '%"+searchItem +"%' OR itemDesc_SWAHILI like '%"+searchItem +"%' ");

                                    while (rs0.next()) {
                                    	found=true;

                                        String bb = rs0.getString(1);
                                        String cc = rs0.getString(2);
                                        String dd = rs0.getString(3);
                                        String ee = rs0.getString(4);
                                        String ff = rs0.getString(5);
                                        String gg = rs0.getString(6);
                                        String hh = rs0.getString(7);
                                        String ii = rs0.getString(8);
                                        String jj = rs0.getString(9);
                                        
                                     %>
                                      
                                    <tr> 
                                        <td> <%=bb%>  </td>
                                        <td> <%= cc%></td>
                                        <td> <%= dd%></td>
                                        <td> <%= ee%></td>
                                        <td> <%= ff%></td>
                                        <td> <%= gg%></td>
                                        <td> <%= hh%></td>
                                        <td> <%= ii%></td>
                                        <td> <%= jj%></td>
                                    </tr>
                        <%
                                    }
                                }
                                    
                                    con.close();

                                } catch (Exception e) {
                                e.printStackTrace();

                            	}
                        %>
                    </tbody>
                </table>
            </div>
            
            <%
            if(!found){
            %>
            <h3 style="color: red">Not found</h3> 
            <%
            }
            %>
            
            <h3>You can also add an item yourself</h3>            
        <div style="float: left;margin-right:20px;">
        	<form action="Item.jsp">
        		<input type="submit" style="width: 10em; height: 5em;color: black; background: green;font-weight: bold;" value="ADD ITEM"/>
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
