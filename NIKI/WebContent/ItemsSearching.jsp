<%-- 
    Document   : ItemsSearching
    Created on : Jun 15, 2016, 1:11:21 PM
    Author     : vakaniwabo
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>


<!DOCTYPE html>
<html lang="en">
<head>
  <title>Items Searching</title>
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
        <li><a href="niki.jsp">NIKI</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="Login.jsp" class="btn btn-info btn-lg" style="color: white;">
          <span class="glyphicon glyphicon-log-in"></span> Log in
        </a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">
  <div class="row content">
    
    <div class="col-sm-8 text-left" >
    
		<div class="page-header">
			<h1 style="text-align: center; text-shadow: maroon;">Welcome to NIKI</h1>
		</div>         
            
		
		<form name="srchform" action="ItemsSearching.jsp" method="POST">
            <table>
                <tr>
                    <td>business category</td>
                    
                    <td>
                        <select name="srchBS">
                            <option></option>
                            
                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement("Select busin_category_id,busin_category_descr from niki_business_categories ");

                                    ResultSet rs = st.executeQuery();

                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String busin_catId = rs.getString("busin_category_id");
                                        String busin_catNme = rs.getString("busin_category_descr");


                            %>
                                    
                                    <option value="<%=busin_catId%>"><%=busin_catNme%></option>
                            <%
                            
                                    }
                                    
                                    conn.close(); // close the connection


                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>
                        </select> 
                    </td>
                
                    <td>Item category</td>
                    <td>
                        <select name="srchIC">
                            <option></option>
                            
                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement("Select category_id,category_descr from niki_categories ");

                                    ResultSet rs = st.executeQuery();

                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String catId = rs.getString("category_id");
                                        String catNme = rs.getString("category_descr");


                            %>
                                    
                                    <option value="<%=catId%>"><%=catNme%></option>
                            <%

                                    }
                                    conn.close(); // close the connection

                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>
                        </select> 
                    </td>
                
                    <td>Item sub_category</td>
                	
                	<td>
                        <select name="srchISC">
                            <option></option>
                            
                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement("Select subcategory_id,subcategory_descr from niki_subcategories ");

                                    ResultSet rs = st.executeQuery();

                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String subcatId = rs.getString("subcategory_id");
                                        String subcatNme = rs.getString("subcategory_descr");


                            %>
                                    
                                    <option value="<%=subcatId%>"><%=subcatNme%></option>
                            <%

                                    }

                                    conn.close(); // close the connection
                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>
                        </select> 
                    </td>
                	<td><input value="search" type="submit" /></td>
                </tr>
                
                
            </table>
        </form>
        
        <%
        String search = request.getParameter("srchBS");
        String searchItemCat = request.getParameter("srchIC");
        String searchItemSubCat = request.getParameter("srchISC");
        
        boolean searchFound=false; //variable to control result of a search
        
        %>
        
        <div>       	
        		
                <h3>${itf.insertMsg}</h3>
                <h4>${itf.error} </h4>
                 
                <h3 style="background-color:buttonface">Final Items List </h3>
                
                <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%"  > 
                    <thead> 
                        <tr><td><input  type="submit" value="Export" /></td></tr>
                        <a href="ItemsSearching.jsp">View all</a>
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
                                if(search == null){
                                	/* 
                                    no search has been made                                  
                                    */
                                    
                                    Statement st0 = con.createStatement();
                                    ResultSet rs0 = st0.executeQuery("SELECT * FROM niki_items ");

                                    while (rs0.next()) {

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
                                
								else if(!search.isEmpty() && search != null && !searchItemCat.isEmpty() && searchItemCat != null && !searchItemSubCat.isEmpty() && searchItemSubCat != null ){
                                    
									/*
                                    searching with business_category, item category and subcategory                                   
                                    */
                                    
                                    boolean found=false;
                                    
                                    /*
                                    getting all subcategories in the given category and check if the subcategory searched is among those subcategories
                                    */
                                    Statement st1=con.createStatement();
                                    ResultSet rs1 = st1.executeQuery("SELECT subcategory_id FROM niki_subcategories where category_id='"+searchItemCat+"'");
                                    
                                    while (rs1.next()) {

                                        String subcategory_id = rs1.getString(1);
                                        
                                        if(subcategory_id.equals(searchItemSubCat)){
                                        	found=true;
                                        }
                                    }
                                    
                                    if(found){
                                    

                                    //getting the item's niki_code belonging to the category description entered
                                    //using the category id gotten
                                    Statement st2 = con.createStatement();
                                    ResultSet rs2 = st2.executeQuery("SELECT niki_code FROM niki_item_business_category where busin_category_id='"+search+"'");

                                    while (rs2.next()) {

                                        String niki_code = rs2.getString(1);

                                        /*
                                        getting all the details about the item belonging to the category entered
                                        */
                                        Statement ST = con.createStatement();
                                        ResultSet rs = ST.executeQuery("SELECT * FROM niki_items where niki_code='"+niki_code+"' and subcategory_id ='"+searchItemSubCat+"'");

                                        while (rs.next()) {
                                        	searchFound=true;

                                            String bb = rs.getString(1);
                                            String cc = rs.getString(2);
                                            String dd = rs.getString(3);
                                            String ee = rs.getString(4);
                                            String ff = rs.getString(5);
                                            String gg = rs.getString(6);
                                            String hh = rs.getString(7);
                                            String ii = rs.getString(8);
                                            String jj = rs.getString(9);

                             

                    %>  
                                        <tr> 

                                            <td><%=bb%>  </td>
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
                                    }
                                        
                                    /*
                                        making search once again null, so that when the page is refreshed we see all items
                                        or when one  clicks on view all, they get to see all the items
                                    */
                                        search = null;
                                    
                                }
                                
								else if(!search.isEmpty() && search != null && !searchItemCat.isEmpty() && searchItemCat != null ){
                                    
									/*
                                    searching with business_category and item category                                   
                                    */
                                    

                                    //getting the item's niki_code belonging to the category description entered
                                    //using the category id gotten
                                    Statement st2 = con.createStatement();
                                    ResultSet rs2 = st2.executeQuery("SELECT niki_code FROM niki_item_business_category where busin_category_id='"+search+"'");

                                    while (rs2.next()) {

                                        String niki_code = rs2.getString(1);

                                        /*
                                        getting all the details about the item belonging to the category entered
                                        */
                                        Statement ST = con.createStatement();
                                        ResultSet rs = ST.executeQuery("SELECT * FROM niki_items where niki_code='"+niki_code+"' and subcategory_id IN (SELECT subcategory_id FROM niki_subcategories where category_id='"+searchItemCat+"')");

                                        while (rs.next()) {
                                        	searchFound=true;

                                            String bb = rs.getString(1);
                                            String cc = rs.getString(2);
                                            String dd = rs.getString(3);
                                            String ee = rs.getString(4);
                                            String ff = rs.getString(5);
                                            String gg = rs.getString(6);
                                            String hh = rs.getString(7);
                                            String ii = rs.getString(8);
                                            String jj = rs.getString(9);

                             

                    %>  
                                        <tr> 

                                            <td><%=bb%>  </td>
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
                                        
                                    /*
                                        making search once again null, so that when the page is refreshed we see all items
                                        or when one  clicks on view all, they get to see all the items
                                    */
                                        search = null;
                                }
                                
								else if(!search.isEmpty() && search != null && !searchItemSubCat.isEmpty() && searchItemSubCat != null ){
                                    
									/*
                                    searching with business_category and item subcategory                                   
                                    */
                                    

                                    //getting the item's niki_code belonging to the category description entered
                                    //using the category id gotten
                                    Statement st2 = con.createStatement();
                                    ResultSet rs2 = st2.executeQuery("SELECT niki_code FROM niki_item_business_category where busin_category_id='"+search+"'");

                                    while (rs2.next()) {

                                        String niki_code = rs2.getString(1);

                                        /*
                                        getting all the details about the item belonging to the category entered
                                        */
                                        Statement ST = con.createStatement();
                                        ResultSet rs = ST.executeQuery("SELECT * FROM niki_items where niki_code='"+niki_code+"' and subcategory_id='"+searchItemSubCat+"'");

                                        while (rs.next()) {
                                        	searchFound=true;

                                            String bb = rs.getString(1);
                                            String cc = rs.getString(2);
                                            String dd = rs.getString(3);
                                            String ee = rs.getString(4);
                                            String ff = rs.getString(5);
                                            String gg = rs.getString(6);
                                            String hh = rs.getString(7);
                                            String ii = rs.getString(8);
                                            String jj = rs.getString(9);

                             

                    %>  
                                        <tr> 

                                            <td><%=bb%>  </td>
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
                                        
                                    /*
                                        making search once again null, so that when the page is refreshed we see all items
                                        or when one  clicks on view all, they get to see all the items
                                    */
                                        search = null;
                                }
                                
								else if(!searchItemCat.isEmpty() && searchItemCat != null && !searchItemSubCat.isEmpty() && searchItemSubCat != null ){
                                    
                                    /*
                                    searching with item category and subcategory                                   
                                    */
                                    boolean found=false;
                                    
                                    /*
                                    getting all subcategories in the given category and check if the subcategory searched is among those subcategories
                                    */
                                    Statement st1=con.createStatement();
                                    ResultSet rs1 = st1.executeQuery("SELECT subcategory_id FROM niki_subcategories where category_id='"+searchItemCat+"'");
                                    
                                    while (rs1.next()) {

                                        String subcategory_id = rs1.getString(1);
                                        
                                        if(subcategory_id.equals(searchItemSubCat)){
                                        	found=true;
                                        }
                                    }
                                    
                                    if(found){
                                                           

                                        /*
                                        getting all the details about the item belonging to the category entered
                                        */
                                        Statement ST = con.createStatement();
                                        ResultSet rs = ST.executeQuery("SELECT * FROM niki_items where subcategory_id ='"+searchItemSubCat+"'");

                                        while (rs.next()) {
                                        	searchFound=true;

                                            String bb = rs.getString(1);
                                            String cc = rs.getString(2);
                                            String dd = rs.getString(3);
                                            String ee = rs.getString(4);
                                            String ff = rs.getString(5);
                                            String gg = rs.getString(6);
                                            String hh = rs.getString(7);
                                            String ii = rs.getString(8);
                                            String jj = rs.getString(9);

                             

                    %>  
                                        <tr> 

                                            <td><%=bb%>  </td>
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
                                        
                                    /*
                                        making search once again null, so that when the page is refreshed we see all items
                                        or when one  clicks on view all, they get to see all the items
                                    */
                                        search = null;
                                    
                                }
                                	
								else if(!search.isEmpty() && search != null){
                                    
                                    //search is not null, which means a search has been made
                                    

                                    //getting the item's niki_code belonging to the category description entered
                                    //using the category id gotten
                                    Statement st2 = con.createStatement();
                                    ResultSet rs2 = st2.executeQuery("SELECT niki_code FROM niki_item_business_category where busin_category_id='"+search+"'");

                                    while (rs2.next()) {

                                        String niki_code = rs2.getString(1);

                                        /*
                                        getting all the details about the item belonging to the category entered
                                        */
                                        Statement ST = con.createStatement();
                                        ResultSet rs = ST.executeQuery("SELECT * FROM niki_items where niki_code='"+niki_code+"'");

                                        while (rs.next()) {
                                        	searchFound=true;

                                            String bb = rs.getString(1);
                                            String cc = rs.getString(2);
                                            String dd = rs.getString(3);
                                            String ee = rs.getString(4);
                                            String ff = rs.getString(5);
                                            String gg = rs.getString(6);
                                            String hh = rs.getString(7);
                                            String ii = rs.getString(8);
                                            String jj = rs.getString(9);

                             

                    %>  
                                        <tr> 

                                            <td><%=bb%>  </td>
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
                                        
                                    /*
                                        making search once again null, so that when the page is refreshed we see all items
                                        or when one  clicks on view all, they get to see all the items
                                    */
                                        search = null;
                                    }
                                
								 else if( !searchItemCat.isEmpty() && searchItemCat != null ){
                                    
                                    //search is not null, which means a search has been made
                                    

                                    //getting the item's niki_code belonging to the category description entered
                                    //using the category id gotten
                                    Statement st2 = con.createStatement();
                                    ResultSet rs2 = st2.executeQuery("SELECT subcategory_id FROM niki_subcategories where category_id='"+searchItemCat+"'");

                                    while (rs2.next()) {

                                        String subcategory_id = rs2.getString(1);

                                        /*
                                        getting all the details about the item belonging to the category entered
                                        */
                                        Statement ST = con.createStatement();
                                        ResultSet rs = ST.executeQuery("SELECT * FROM niki_items where subcategory_id='"+subcategory_id+"'");

                                        while (rs.next()) {
                                        	searchFound=true;

                                            String bb = rs.getString(1);
                                            String cc = rs.getString(2);
                                            String dd = rs.getString(3);
                                            String ee = rs.getString(4);
                                            String ff = rs.getString(5);
                                            String gg = rs.getString(6);
                                            String hh = rs.getString(7);
                                            String ii = rs.getString(8);
                                            String jj = rs.getString(9);

                             

                    %>  
                                        <tr> 

                                            <td><%=bb%>  </td>
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
                                        
                                    /*
                                        making search once again null, so that when the page is refreshed we see all items
                                        or when one  clicks on view all, they get to see all the items
                                    */
                                        search = null;
                                    }
                                
									else if(!searchItemSubCat.isEmpty() && searchItemSubCat != null ){
											//searchItemSubCat is not null, which means a searchItemSubCat has been made
                                                                        

                                        /*
                                        getting all the details about the item belonging to the category entered
                                        */
                                        Statement ST = con.createStatement();
                                        ResultSet rs = ST.executeQuery("SELECT * FROM niki_items where subcategory_id='"+searchItemSubCat+"'");

                                        while (rs.next()) {
                                        	searchFound=true;

                                            String bb = rs.getString(1);
                                            String cc = rs.getString(2);
                                            String dd = rs.getString(3);
                                            String ee = rs.getString(4);
                                            String ff = rs.getString(5);
                                            String gg = rs.getString(6);
                                            String hh = rs.getString(7);
                                            String ii = rs.getString(8);
                                            String jj = rs.getString(9);

                             

                    %>  
                                        <tr> 

                                            <td><%=bb%>  </td>
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
                                        
                                        
                                    /*
                                        making search once again null, so that when the page is refreshed we see all items
                                        or when one  clicks on view all, they get to see all the items
                                    */
                                        search = null;
                                    
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
    
  </div>
</div>


<footer class="container-fluid text-center">
  <p><strong> Copyright &#169; 2016 Algorithm,Inc.</strong></p>
</footer>


</body>
</html>
