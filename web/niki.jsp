
<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>NIKI</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<script src="assets/js/jquery.min.js"></script>
<!--   <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
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
 <%
     String tempo="";
     String niki="";
     String bus="";
     String promo="";
     String cat="";
     String manu="";
     String company="";

                            try {

Connection con = ConnectionClass.getConnection();
Statement ST = con.createStatement();
ResultSet rs = ST.executeQuery("SELECT count(item_id) FROM niki.niki_items_temp"); 
   while (rs.next()) {  tempo = "("+rs.getInt(1)+")";}
   rs = ST.executeQuery("SELECT count(niki_code) FROM niki.niki_items"); 
   while (rs.next()) {  niki = "("+rs.getInt(1)+")";}
   rs = ST.executeQuery("SELECT count(busin_category_id) FROM niki.niki_business_categories"); 
   while (rs.next()) {  bus = "("+rs.getInt(1)+")";}
   rs = ST.executeQuery("SELECT count(promo_code) FROM niki.niki_promotions"); 
   while (rs.next()) {  promo = "("+rs.getInt(1)+")";}
    rs = ST.executeQuery("SELECT count(category_id) FROM niki.niki_categories"); 
   while (rs.next()) {  cat = "("+rs.getInt(1)+")";}
   rs = ST.executeQuery("SELECT count(fabricant_id) FROM niki.niki_fabricant"); 
   while (rs.next()) {  manu = "("+rs.getInt(1)+")";}
   rs = ST.executeQuery("SELECT count(companyId) FROM niki.niki_companies"); 
   while (rs.next()) {  company = "("+rs.getInt(1)+")";}  
   
   
                                con.close();

                            } catch (Exception e) {
                                e.printStackTrace();

                            }
                        %>
 <meta charset="UTF-8"> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
    
    	<div style="background-color: orange; border-style: solid;width:100%;">
	        <div style="text-align: center; border:medium; "><h1>Welcome To NIKI 2.9</h1> </div>         
        </div>
        <div style="background: #CCCCCC; position:absolute;width:100%;height:100%">
	        <div style=" margin-left:25%; margin-top:5%;">  
	        
		        <div style="float: left;margin-right:20px">
		        <form action="PendingItems.jsp">
		        		<input type="submit" style="font-weight:bold; 
                                               width: 15em; height: 12em;color: black; 
                                               background-color: powderblue;" 
                                               value="TRANSFORM <%=tempo%>"/>
		        		
                            	</form> 
		        </div> 
		        <div style="float: left;margin-right:20px">
		        	<form action="Item.jsp">
		        		<input type="submit" style="font-weight:bold; background: pink; width: 
                                               15em; height: 12em;color: black;" 
                                               value="NIKI LIST <%=niki%>"/>
		        	</form> 
		        </div>
		        <div style="margin-right:20px;margin-bottom:20px;"> 
		        	<form action="Category.jsp">
		        		<input type="submit" style="font-weight:bold;
                                               width: 15em; height: 12em;color: black ; 
                                               background: red;" 
                                               value="CATEGORIES <%=cat%>"/>
		        	</form> 
		        </div>
                    <div style="float: left;margin-right:20px">
		        	<form action="Manufacture.jsp">
		        		<input type="submit" style="font-weight:bold; 
                                               width: 15em; height: 12em;color: black; 
                                               background-color: gray;" 
                                               value="MANUFACTURE <%=manu%>"/>
		        	</form> 
		        </div>
		        
		        <div style="float: left;margin-right:20px">
		        	<form action="Business_Category.jsp">
		        		<input type="submit" style="font-weight:bold; 
                                               width: 15em; height: 12em;color: black; 
                                               background-color:  lightgreen; " 
                                               value="BUSINESS SECTOR <%=bus%>"/>
		        	</form> 
		        </div>
		        <div style="margin-right:20px;margin-bottom:20px;">
		        	<form action="Company.jsp">
		        		<input type="submit" style="font-weight:bold; 
                                               width: 15em; height: 12em;color: black;
                                               background-color: yellow; " 
                                               value="COMPANIES <%=company%>"/>
		        	</form> 
		        </div>
                       <div style="float: left;margin-right:20px">
		        	<form action="Promotions.jsp">
		        		<input type="submit" style="font-weight:bold;
                                               width: 15em; height: 12em;color: black;
                                               font-size: 100; background-color:  orange;
                                               " value="PROMOTIONS <%=promo%>"/>
		        </form> 
		        </div>
		        <div style="float: left;margin-right:20px">
		        	<form action="ItemExport.jsp">
		        		<input type="submit" style="font-weight:bold; 
                                               width: 15em; height: 12em;color: black; 
                                               background-color:  mediumvioletred; " 
                                               value="EXPORT EXCEL"/>
		        	</form> 
		        </div>
		        <div style="margin-right:20px">
		        	<form action="Settings.jsp">
		        		<input type="submit" style="font-weight:bold; 
                                               width: 15em; height: 12em;color: black;
                                               background-color: lightskyblue; " 
                                               value="SETTINGS"/>
		        	</form> 
		        </div>
	        </div>

<!--         <div><a href="testDesign.jsp">Design</a></div> -->
        <!-- <div><a href="PopUpButtonDemo.jsp">Pop up demo</a></div>
        <div><a href="testModal.jsp">Test Modal</a></div> -->
    
		</div>
		<div style="background-color: orange; border-style: solid;width:100%;">
	        <div style="text-align: center; border:medium; "><h1>Welcome To NIKI items codification</h1> </div>         
        </div>
		

</html>

