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
session.setAttribute("company",null); 
String user=session.getAttribute("userInSessionfName").toString(); 

String from = request.getParameter("origin");
session.setAttribute("fromChooseCompany", from);

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Company</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  	<!-- <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<script src="assets/js/jquery.min.js"></script> -->
<!--   <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
 		<link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
 		 
        <script src="assets/js/jquery-1.12.3.js"></script>
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
        <li class="active"><a href="niki.jsp">Home</a></li>
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
			<h1 style="text-align: center; text-shadow: maroon;">Welcome to NIKI</h1>
		</div>         
            

		<div><h1>Company Entry Form</h1> </div>
        
        <h3>${comp.insertMsg}</h3>
        <h4>${comp.error} </h4>
        

        
        <form name="inputCat" action="CompanyResponse.jsp" method="POST">
            
            
            <table>
                
               
                <tr>
                    <td>
                       Company Id: 
                    </td>
                    <td>
                        <input type="text" name="compN" value="" required="required" size="35"/> 
                    </td>
                    
                </tr> 
                <tr>
                    <td>
                        Company Name:
                    </td>
                    <td>
                        <input type="text" name="compD" value="" required="required" size="35" >
                    </td>
                    
                </tr>
                
                <tr>
                    <td>
                       Business category Id: 
                    </td>
                    <td>
                        <select name="bus_ctn">
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

conn.close();
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
                    <td>
                        
                    </td>
                    <td>
                        <input value="save" type="submit"/>
                    </td>
                    
                </tr>
                
            </table>

            
        </form>
        
        <div>
                <h3>${comp.insertMsg}</h3>
                <h4>${comp.error} </h4>
                 
                <h3 style="background-color:buttonface">Companies List</h3>
                
                <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%" >
                    <thead> 
                        <tr>
                            <th> Company Id</th>               
                            <th> Company Desc</th>   
                            <th> Status </th>
                            <th> Busin_Category </th>
                            <th> Total Items </th>
                            <th> Temporaires </th>
                            
                            <th> on NiKi </th>
                            <th> Edit </th>
                            <th> Sleep </th>
                            
                            
                        </tr>
                        
                        </thead>
                       
                        <tbody>
                        <%

                            try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery("SELECT * FROM niki_companies");
                                int i = 0;
                                while (rs.next()) { 
                                    String bb = rs.getString(1);
                                    String cc = rs.getString(2);
                                    String dd = rs.getString(3);
                                    String ee = rs.getString(4); 
                        %>  
                        <tr> 

                            <td><%=bb%>  </td>
                            <td> <%= cc%></td>
                            <td> <%=dd %></td>
                            <td> <%=ee %></td>
                                                        <% 
                            
    String sqltotal="SELECT COUNT(item_external_id) FROM niki.niki_items_temp where company_id='"+bb+"'";                        
                            
                                    PreparedStatement stto = con.prepareStatement
                                           (sqltotal);

                                    ResultSet rsot = stto .executeQuery();
 int countto =0;
                                    while (rsot.next()) {
                                        // Integer ip = rs.getInt("univId");
                                          countto = rsot.getInt(1); 

                            %>
                               <td> <%=countto %></td> 
                            <%

                                    }
                            %>
                            
                            <% 
                            
    String sqll="SELECT COUNT(item_external_id) FROM niki.niki_items_temp where company_id='"+bb+"' and status ='PENDING'";                        
                            
                                    PreparedStatement st = con.prepareStatement
        (sqll);

                                    ResultSet rso = st.executeQuery();
 int count =0;
                                    while (rso.next()) {
                                        // Integer ip = rs.getInt("univId");
                                          count = rso.getInt(1); 

                            %>
                               <td> <%=count %></td> 
                            <%

                                    }
                            %>
                            
                             <% 
                            
    String sqlll="SELECT COUNT(item_external_id) FROM niki.niki_items_temp where company_id='"+bb+"' and status !='PENDING'";                        
                            
                                    PreparedStatement sto = con.prepareStatement
        (sqlll);

                                     rso = sto.executeQuery();
 int countV =0;
                                    while (rso.next()) {
                                        // Integer ip = rs.getInt("univId");
                                          countV = rso.getInt(1); 

                            %>
                               <td> <%=countV %></td> 
                            <%

                                    }
                            %>
                        <td> <a href="CompanyUpdate.jsp?compEdit=<%=bb%>&compName=<%=cc%>&action=update"> Edit </a></td>
                        <td> <a href="CompanyResponse.jsp?compRejectSleep=<%=bb%>&action=compSleep">Sleep </a></td>
                            
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
