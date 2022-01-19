

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
	
	String user=session.getAttribute("userInSessionfName").toString(); 
	session.setAttribute("busin_category",null);

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Business Categories</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
 	<link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
 		 
        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        
        <script src="assets/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap.min.js"></script>
        <link rel="stylesheet" href="assets/css/custom.css">
        
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

<nav class="navbar navbar-inverse nav-niki">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="niki.jsp"><img src="assets/NIKI.png" alt="" width="70"></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="niki.jsp">Home</a></li>
        <li><a href="categoriesPage.jsp">Categories</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	  <li><a> <span class="glyphicon glyphicon-user"></span> <%=user%></a></li> 
                    <li><a  href="Logout.jsp">
                            <span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">
  <div class="row content">
  
  	<div class="col-sm-2 sidenav">
      
    </div>
    
    <div class="col-sm-8 text-left" >
        <div class="version">
                <div>Business Category</div>
        </div>        
            
        <div class="row">
                <h3>${busin_cat.insertMsg}</h3>
                <h4>${busin_cat.error} </h4>
                <form name="inputCateg"  action="Business_CategoryResponse.jsp" method="POST">
                   
                    <div class="col-sm-10">
                       <div class="col-sm-6">
                            <input type="text" class="form-control" placeholder="Business category Id" name="busin_category_id" value="${busin_cat.busin_category_id}"required>
                        </div>
                        <div class="col-sm-6">
                             <input type="text" class="form-control" placeholder="Business category description" name="busin_category_descr" value="${busin_cat.busin_category_descr}" required >
                        </div>
                    </div>
                        <br/><br/>
                    <div class="col-sm-10">
                       <div class="col-sm-6">
                           <input type="text" class="form-control" placeholder="French" name="french_business_name" value="${busin_cat.busin_category_id}" required/>
                        </div>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" placeholder="Kinyarwanda" name="kinya_business_name" value="${busin_cat.busin_category_descr}" required=true size="35" >
                        </div>
                    </div>
                        <br/><br/>
                        <div class="col-sm-3 col-sm-offset-2">
                            <input style="margin-left:10px" type="submit" id="submit" value="Save" name="submit" class="btn btn-primary">
                        </div>
                </form>
        </div>       
                    
        <div>
                
                 <div class="version">
                <div>Business Categories List</div>
        </div>
                <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
                    <thead> 
                        <tr>
                            <th> Business Category Id</th>               
                            <th> Business Category Desc</th>   
                            <th> Status </th>
                            <th> Edit </th>
                            <th> Sleep </th>
                        </tr>
                        
                        </thead> 
                        <tbody>
                        <%

                            try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery("SELECT * FROM niki_business_categories");
                                int i = 0;
                                while (rs.next()) {

                                    String bb = rs.getString(1);
                                    String cc = rs.getString(2);
                                    String dd = rs.getString(3);
                                    
  
                            
    String sqltotal="SELECT COUNT(niki_code) FROM niki.niki_item_business_category "
            + "where busin_category_id='"+bb+"'";                        
                            
                                    PreparedStatement stto = con.prepareStatement
                                           (sqltotal);

                                    ResultSet rsot = stto .executeQuery();
 int countto =0;
                                    while (rsot.next()) {
                                        // Integer ip = rs.getInt("univId");
                                          countto = rsot.getInt(1); 
 }
                            %>

                          
                        <tr> 

                            <td><%=bb%>  </td>
                            <td> <%= cc%></td>
                            <td> <%= dd%></td>
                           
                            <td> <a href="Business_CategoryUpdate.jsp?busCatEdit=<%=bb%>&action=update"> Edit </a></td>
                            <td> <a href="ItemCategory.jsp?item_cat=<%=bb%>&action=busCatSleep"><%=countto %> </a></td>
                            
                            
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
  <p><strong> Copyright &#169; 2021 Algorithm,Inc.</strong></p>
</footer>


</body>
</html>
<% 
}
%>
