

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
	<div><h1>Promotions EDIT Form</h1> </div>	 
          
        
<%
String action = request.getParameter("action");

String from="nowhere";

if(session.getAttribute("fromChooseCompany")!=null){
	from=session.getAttribute("fromChooseCompany").toString();
}
  
 int promo_code=Integer.parseInt(request.getParameter("promo_code"));
  Connection conn = ConnectionClass.getConnection(); 
 Statement ST = conn.createStatement();
 ResultSet rs = ST.executeQuery("SELECT * FROM niki_promotions"
                                        + " where promo_code=" + promo_code + "");
                                
 
    String promo_name =""; 
    String start = "";
    String end = ""; 
    String bus_cat_id = "";
    String global_id= "" ;
    String niki_company_id=  "";
     double maximum_budget =0; 
     int maximum_qty=0;
     
 while (rs.next()) {
 promo_name = rs.getString("promo_name"); 
 start = rs.getString("start"); 
    end = rs.getString("end"); 
    bus_cat_id = rs.getString("bus_cat_id"); 
    global_id= rs.getString("global_id"); 
      niki_company_id= rs.getString("niki_company_id");
     maximum_budget =rs.getDouble("maximum_budget"); 
     maximum_qty=rs.getInt("maximum_qty");
  }
 
    
%>        
        
       
        
        <form name="inputCateg" action="PromotionsEDITResponse.jsp" method="POST">
                
            <table id="inputCateg" > 
                <tr> <td>  promo name:   </td> <td>
                        <input type="text" name="promo_name" value="<%=promo_name%>" required=true size="35"/> 
                    </td>  </tr> 
                <tr>  <td>  start time:  </td>  <td>
                        <input type="text" name="start" value="<%=start%>" required=true size="35" >
                    </td>  </tr>
                 <tr> <td>  end time   </td> <td>
                        <input type="text" name="end" value="<%=end%>" required=true size="35"/> 
                    </td>  </tr> 
                <tr>  <td>  business granted  </td>   
                    <td>
                        <input type="text" name="end" value="<%=bus_cat_id%>" required=true size="35"/> 
                    </td>  </tr> 
                <tr>  <td
                    
                </tr>
                <tr> <td>  maximum budget   </td> <td>
                        <input type="text" name="maximum_budget" value="<%=maximum_budget%>" required=true size="35"/> 
                    </td>  </tr> 
                <tr>  <td>  maximum qty  </td>  <td>
                        <input type="text" name="maximum_qty" value="<%=maximum_qty%>" required=true size="35" >
                    </td>  </tr>
                  <tr>  <td>     </td> <td bgcolor="pink">  Promotion detail of <%=promo_name%> </td>  </tr>
             <tr>   
                            
                            <td> CODE </td>
                            <td> ITEM</td>
                            <td> TYPE____</td>
                            <td> ____QTY____</td>
                            <td> ____AMOUNT___</td>
                            <td> __DISCOUNT</td> 
                        
                        </tr>    
                 
                 
                 <%
 
  
   Statement ST2 = conn.createStatement();
   
   String sql="SELECT `niki_promotions_list`.`promo_code`,"
           + "`niki_items`.`item_commercial_name`,`niki_promotions_list`.`type`,"
           + "`niki_promotions_list`.`niki_promotions_qte`,"
           + " `niki_promotions_list`.`niki_promotions_amount`,"
           + "    `niki_promotions_list`.`niki_promotions_discount`"
           + "FROM `niki`.`niki_promotions_list`,`niki`.`niki_items` where `niki_promotions_list`.`niki_code`=`niki_items`.`niki_code`"
           + "  and `niki_promotions_list`.`promo_code`="+promo_code;
   
  ResultSet rs2 = ST2.executeQuery(sql);
                 
     
 while (rs2.next()) { 
     %>  
                        <tr>   
                            
                            <td> <%= rs2.getString(1)%> </td>
                            <td> <%= rs2.getString(2)%></td>
                            <td> <%= rs2.getString(3)%></td>
                            <td> <%= rs2.getString(4)%></td>
                            <td> <%= rs2.getString(5)%></td>
                            <td> <%= rs2.getString(6)%></td> 
                        
                        </tr>
                        
                        <%
      
  }
 
    //<tr>  <td>  </td> <td>  <input value="Edit promotion" type="submit"/>  </td>  </tr>
%>  
                 
            </table>

            
        </form>
                    
                    
       <div id="w">
                <h3 style="background-color:buttonface">NIKI Items List </h3>
                
                
                <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%"  >
                    <thead> 
                        <tr>
                            <th> Niki code </th>
                            <th width="30%"> Item_Commercial_Description</th>               
                            <th> Molecular </th>
                            <th> Packet </th>
                            <th> Category </th>
                            <th> Manufacture </th> 
                            <th> Tax-rate </th> 
                             <th> ADD </th>
                             <th> REMOVE </th> 
                        </tr>
                        
                        </thead>
                         
                        <tbody>
                        <%
String sqll="SELECT * FROM niki_items ";  //bus_cat_id
                            try {
 
                                 ST = conn.createStatement();
                                 rs = ST.executeQuery(sqll);
                                int i = 0;
                                while (rs.next()) {

                                    String niki_code = rs.getString("niki_code");
                                    String item_commercial_name = rs.getString("item_commercial_name");
                                    String tax_vat = rs.getString("tax_vat");
                                    String status = rs.getString("status");
                                    String item_fabricant = rs.getString("item_fabricant");
                                    String item_inn = rs.getString("item_inn");
                                    double item_packet = rs.getDouble("item_packet");
                                    String item_key_words = rs.getString("item_key_words");
                                    String created = rs.getString("created");
                                    String category_id = rs.getString("category_id");  

                        %>  
                        <tr>   
                            
                            <td><%=niki_code%>  </td>
                            <td width="30%" > <%= item_commercial_name%></td>
                            <td> <%= item_inn%></td>
                            <td> <%= item_packet%></td>
                            <td> <%= category_id%></td>
                            <td> <%= item_fabricant%></td>
                             <td> <%= tax_vat%></td>  
                             <td> <a href="PromotionEditReal.jsp?promo_code=<%=promo_code%>&action=validate&attachNiki=<%=niki_code%>" class="btn btn-primary enable " data-toggle="modal" data-target="#basicModal" > ADD </a></td>
                             <td> <a href="PromotionEditReal.jsp?promo_code=<%=promo_code%>&action=validate&attachNiki=<%=niki_code%>" class="btn btn-primary enable " data-toggle="modal" data-target="#basicModal" > REMOVE </a></td>
                               
                            
                        </tr>
                        
                        <%
                                    i++;
                                }

                                conn.close();

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