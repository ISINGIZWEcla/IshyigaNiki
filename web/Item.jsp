

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

<jsp:useBean id="it_tmp" scope="request" class="niki.Item_Temp"/>  

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
  <title>Item Entry Page</title>
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
        <li><a href="ItemLookup.jsp">Add Item</a>
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
			<h1 style="text-align: center; text-shadow: maroon;">Item Entry Form</h1>
		</div>         
                    
        <h3>${it_tmp.insertMsg}</h3>
        <h4>${it_tmp.error} </h4>
        

        
        <form name="inputItem" action="ItemResponse.jsp" method="POST">
            
            
            <table id="inputItem" >
                
                <tr>
                    <td>
                       item number: 
                    </td>
                    <td>
                        <input type="text" name="itm_num" value="${it_tmp.item_external_id}" required=true size="35" /> 
                    </td>
                    
                </tr>
                <tr>
                    <td>
                       barcode: 
                    </td>
                    <td>
                        <input type="text" name="cdb" value="${it_tmp.codebar}" size="35"/> 
                    </td>
                    
                </tr>
                <tr>
                <%
                if(session.getAttribute("ItemSearched") != null){
	                String description = session.getAttribute("ItemSearched").toString();
	                it_tmp.setItemDescription(description);
                }
                %>
                    <td>
                        item description:
                    </td>
                    <td>
                        <input type="text" name="itmd" value="${it_tmp.itemDescription}" required=true size="35" onchange="upperMe()" >
                    </td>
                    
                </tr>
                
                
                <br>
                
                <tr>
                    <td>
                       Choose the item category: 
                    </td>
                    <td>
                        <select  name="itcat">
                            <option value=""></option>

                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement("Select subcategory_id,subcategory_descr from niki_subcategories where status='LIVE'");

                                    ResultSet rs = st.executeQuery();

                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String subcatId = rs.getString("subcategory_id");
                                        String subcatNme = rs.getString("subcategory_descr");


                            %>
                                    
                                    <option value="<%=subcatId%>"><%=subcatNme%></option>
                            <%

                                    }


                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>
                        </select><br/>
                    </td>
                    
                </tr>
                
                <tr>
                    <td>
                       Choose your business category: 
                    </td>
                    <td>
                        <select  name="busin_cat">
                            <option value=""></option>

                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement("Select busin_category_id,busin_category_descr from niki_business_categories where status='LIVE'");

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
                    
                </tr>
                
                <tr>
                    <td>
                       Choose the language for the item: 
                    </td>
                    <td>
                        <select  name="lang">
                            <option value=""></option>

   							 <option value="ENGLISH">ENGLISH</option>
   							 <option value="KINYARWANDA">KINYARWANDA</option>
                             <option value="FRENCH">FRENCH</option>       
                             <option value="SWAHILI">SWAHILI</option>
                            
                        </select><br/>
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
                        
                        
        <div id="w">
                <h3 style="background-color:buttonface">Items List</h3>
                
                
                <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%"  >
                    <thead> 
                        <tr>
                        	<th> Niki_code </th>
                            <th> Codebar</th>               
                            <th> Item descr(ENGL) </th>
                            <th> Item descr(KINYA)</th>
                            <th> Item descr(FR)</th>
                            <th> Item descr(SWHLI)</th>               
                            <th> Category </th>
                            <th> Tax-rate </th>
                            <th> Status </th>
                           
                        </tr>
                        
                        </thead>
                        <tfoot>
                        <tr>
                        	<th> Niki_code </th>
                            <th> Codebar</th>               
                            <th> Item descr(ENGL) </th>
                            <th> Item descr(KINYA)</th>
                            <th> Item descr(FR)</th>
                            <th> Item descr(SWHLI)</th>               
                            <th> Category </th>
                            <th> Tax-rate </th>
                            <th> Status </th>
                        
                           

                        </tr>
                        </tfoot>
                        <tbody>
                        <%

                            try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery("SELECT * FROM niki_items");
                                int i = 0;
                                while (rs.next()) {

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
