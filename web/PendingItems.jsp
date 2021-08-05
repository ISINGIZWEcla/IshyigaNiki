
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
	
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>

<% 
String user=session.getAttribute("userInSessionfName").toString(); 
String company = session.getAttribute("userInSessionCompany").toString(); 
String userLanguage = session.getAttribute("userInSessionLanguage").toString();

//setting the original item id to be validated to null
	session.setAttribute("itemOriginal", null); 

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Pending Items of  <%=company  %> </title>
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
			<h1 style="text-align: center; text-shadow: maroon;">Temporary Items of <%=company  %></h1>
		</div>      
        <div id="w">
            <h3>${itf.insertMsg}</h3>
                <h4>${itf.error} </h4>
                <h3>${it_tmp.insertMsg}</h3>
                <h4>${it_tmp.error} </h4>
                
                <table  id="example" class="table table-striped table-bordered" cellspacing="0" width="100%" >
                    <thead> 
                        <tr>
                              <th > Item ID </th>          
                            <th > Description </th>              
                            <th> Category </th>
                            <th> Busines Categ </th> 
                            <th> Status </th>
                        	<th> Manufacture </th>
                        	
                        	<th> Validate </th> 
                           
                        </tr>
                        
                        </thead> 
                        <tbody>
                        <%
                        String categName="";
                        String bus_categName="";
String sql ="SELECT * FROM niki_items_temp where status='PENDING' AND company_id='"+company+"'";
                            try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery(sql);
                                int i = 0;
                                while (rs.next()) {
       
                                    int item_id = rs.getInt("item_id");
                                    String codebar = rs.getString("codebar");
                                    String itemDesc = rs.getString("itemDesc");
                                    String subcategory_id = rs.getString("subcategory_id");
                                    String busin_category_id = rs.getString("busin_category_id");
                                    String status = rs.getString("status");
                                    String langue = rs.getString("langue");
                                    String user_name = rs.getString("user_name");
                                    double packet = rs.getDouble("packet");
                                    int hauteur = rs.getInt("hauteur");
                                    int longeur = rs.getInt("longeur");
                                    int largeur = rs.getInt("largeur");
                                    double poids = rs.getDouble("poids"); 
                                    String fabricant = rs.getString("fabricant");
                                    String tax_rate = rs.getString("tax_rate");
                                    String hs_code = rs.getString("hs_code");
                                    String company_id = rs.getString("company_id");
                                    
                                    Statement ST1 = con.createStatement();
                                    ResultSet rs1 = ST1.executeQuery("SELECT category_descr FROM niki_categories where category_id='"+ subcategory_id + "'");
                                    
                                    while(rs1.next()){
                                    	categName = rs1.getString(1);
                                    }
                                    
                                    Statement ST2 = con.createStatement();
                                    ResultSet rs2 = ST2.executeQuery("SELECT busin_category_descr FROM niki_business_categories where busin_category_id = '"+ busin_category_id+"' ");
                                    
                                    while(rs2.next()){
                                    	bus_categName = rs2.getString(1);
                                    }

                                 
                        if(status.equals("TRANSFORMED")){
                        %>  
                        <tr style="background: green;"> 
 
                            <td> <%= item_id%></td>
                            <td> <%= itemDesc%></td>
                            <td> <%= categName%></td>
                            <td> <%= bus_categName%></td> 
                            <td> <%= status%></td>
                            <td> <%= fabricant%></td>
                            <td> <a href="ItemValidationReal.jsp?itemValidate=<%=item_id%>&action=validate" class="btn btn-primary disabled" data-toggle="modal" data-target="#basicModal" > Validate </a></td>
                            <td> <a href="ItemRejectSleepResponse.jsp?itemRejectSleep=<%=item_id%>&action=rejectTemp" class="btn btn-primary disabled">Reject </a></td>
                            
                            
                        </tr>
                        
                        <%
						}
						else if(status.equals("REJECTED")){
	                    %>
                        
                        <tr style="background:red;"> 
 
                           <td> <%= itemDesc%></td>
                            <td> <%= categName%></td>
                            <td> <%= bus_categName%></td> 
                            <td> <%= status%></td>
                            <td> <%= fabricant%></td>
                                <td> <a href="ItemValidationReal.jsp?itemValidate=<%=item_id%>&action=validate" class="btn btn-primary" data-toggle="modal" data-target="#basicModal" > Validate </a></td>
                                <td> <a href="ItemRejectSleepResponse.jsp?itemRejectSleep=<%=item_id%>&itemDesc=<%=itemDesc%>&action=rejectTemp" class="btn btn-primary">Reject </a></td>

                            
                        </tr>
                        
                        <%
							}
						else{
	                        %> 
                        <tr> 
                            <td> <%= item_id%></td>
                            <td> <%= itemDesc%></td>
                            <td> <%= categName%></td>
                            <td> <%= bus_categName%></td> 
                            <td> <%= status%></td>
                            <td> <%= fabricant%></td>
                            <td> <a href="Item.jsp?itemValidate=<%=item_id%>&itemDesc=<%=itemDesc%>&action=validate" > Validate </a></td>
                              
                            
                        </tr>
                        
                        <%
						}
                        }

                             con.close();

                         } catch (Exception e) {
                             e.printStackTrace();
sql +="dddd "+e;
                         }
                        %>
                    </tbody>
                    
                </table> 

            </div>
	
        
		
        
    </div>
    
  </div>
</div>


<footer class="container-fluid text-center">
  <p><strong> Copyright &#169; 2016 Algorithm,Inc.</strong></p>
</footer>


	<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    		<div class="modal-dialog">
        		<div class="modal-content">
            		<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&amp;times;</button>
            			<h4 class="modal-title" id="myModalLabel">Validate Item</h4>
            		</div>
            		<div class="modal-body">
                		<h3>waiting.....</h3>
            		</div>
            		<div class="modal-footer">
                		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                		<button type="button" class="btn btn-primary">Save changes</button>
        			</div>
    			</div>
  			</div>
		</div>


</body>
</html>
<% 
}
%>
