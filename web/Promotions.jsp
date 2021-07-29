

<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%    
} else if (!checkUserPrivileges.toString().contains("PROMOTION")) {
    session.setAttribute("errorLogin","you don't have the right to handle promotions :(");

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
  <title>PROMOTIONS</title>
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
        <li><a href="categoriesPage.jsp">Categories</a></li>
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
		 
          <div><h1>Promotions Entry Form</h1> </div>
         
 

        <form name="inputCateg" action="PromotionsResponse.jsp" method="POST">
                
            <table id="inputCateg" > 
                <tr> <td>  promo name:   </td> <td>
                        <input type="text" name="promo_name" value="" required=true size="35"/> 
                    </td>  </tr> 
                <tr>  <td>  start time:  </td>  <td>
                        <input type="text" name="start" value="2021-07-28 00:00:00" required=true size="35" >
                    </td>  </tr>
                 <tr> <td>  end time   </td> <td>
                        <input type="text" name="end" value="2021-08-29 23:59:59" required=true size="35"/> 
                    </td>  </tr> 
                <tr>  <td>  business granted  </td>  
                     <td>
                        <select  name="bus_cat_id" multiple="multiple"  required="required">
                           
                            <% 
                                try {  Connection conn = ConnectionClass.getConnection();
        PreparedStatement st = conn.prepareStatement("Select busin_category_id,busin_category_descr from niki_business_categories where status='LIVE' order by busin_category_descr");

                                    ResultSet rs = st.executeQuery();

                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String catId = rs.getString("busin_category_id");
                                        String catNme = rs.getString("busin_category_descr");


                            %>
                                    
                                    <option value="<%=catId%>"><%=catNme%></option>
                            <%

                                    }


                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>
                        </select><br/>
                    </td>
                    
                    <td>
<!--                     <a href="Business_Category.jsp"><img src="Images\newer.png" height="50" width="50"></a> -->
                    <a href="Business_Category.jsp?" class="glyphicon glyphicon-plus btn btn-primary" >Add Bus_Category</a>
                    </td>
                      
                
                </tr>
                <tr> <td>  maximum budget   </td> <td>
                        <input type="text" name="maximum_budget" value="10000000" required=true size="35"/> 
                    </td>  </tr> 
                <tr>  <td>  maximum qty  </td>  <td>
                        <input type="text" name="maximum_qty" value="99999" required=true size="35" >
                    </td>  </tr>
                 <tr>  <td>  </td> <td>
                        <input value="save promotion" type="submit"/>
                    </td>  </tr>
                
            </table>

            
        </form>
                    
                    
        <div>
                <h3>${itf.insertMsg}</h3>
                <h4>${itf.error} </h4>
                 
                <h3 style="background-color:buttonface">Promotions List</h3>
                
                <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
                    <thead> 
                        <tr>
                            <th> Promo code</th>               
                            <th> Promo name</th>   
                            <th> Start </th>
                            <th> End </th>
                            
                            <th> Granter </th>
                            <th> Business </th>
                            <th> Budget </th>
                            <th> Target </th>
                            <th> EDIT </th>
                        </tr>
                        
                        </thead> 
                        <tbody>
                        <%

                            try { 
String company = session.getAttribute("userInSessionCompany").toString(); 
                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery
        ("SELECT * FROM niki_promotions where niki_company_id='"+company+"' order by promo_name");
                                int i = 0;
                                while (rs.next()) { 
                                    String promo_code = rs.getString("promo_code");
                                    String promo_name = rs.getString("promo_name");
                                    String start = rs.getString("start");
                                    String end = rs.getString("end");
                                    String global_id = rs.getString("global_id");
                                    String bus_cat_id = rs.getString("bus_cat_id");
                                    String maximum_budget = rs.getString("maximum_budget");
                                String maximum_qty = rs.getString("maximum_qty");
String status = rs.getString("status");
                                 

                        %>  
                        <tr> 

                            <td><%=promo_code%>  </td>
                            <td> <%= promo_name%></td>
                            <td> <%= start%></td>
                            <td><%=end%>  </td>
                            <td> <%= global_id%></td>
                            <td> <%= bus_cat_id%></td>
                            <td> <%= maximum_budget%></td>
                           <td> <%= maximum_qty%></td>
                            <td> <a href="PromotionEdit.jsp?promo_code=<%=promo_code%>&action=update"> EDIT </a></td>
                             
                            
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