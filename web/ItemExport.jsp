

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
 boolean ndimuritransformation=false; 
  
    String business = request.getParameter("business");
    String itmcatN = request.getParameter("itcat"); 
    String fabricant = request.getParameter("fabricant") ; 
    String itemDescr =  request.getParameter("itemDesc");
    
String searchingfor="";
boolean searchON = false;
String sqlToAdd="";
 
if(business!=null && !business.equals("")){
    searchingfor +=", business "+business; 
    String and="";
    if(searchON){ and =",niki_item_business_category WHERE  ";}
    business=business.toUpperCase().replaceAll("'", " ");
    sqlToAdd += and+" (busin_category_id = '"+business+"' and "
            + " `niki_items`.`niki_code`=`niki_item_business_category`.`niki_code`) ";
    searchON = true;}

if(itmcatN!=null && !itmcatN.equals("")) {searchingfor +=","+itmcatN; 
String and="";
    if(searchON){ and =" AND ";} else { and =" WHERE ";}
    
    sqlToAdd += and+" (category_id = '"+itmcatN+"') ";
    searchON = true;}
if(fabricant!=null && !fabricant.equals("")){searchingfor +=","+fabricant; 
String and="";
    if(searchON){ and =" AND ";} else { and =" WHERE ";}
    
    sqlToAdd += and+" (item_fabricant = '"+fabricant+"') ";
    searchON = true;}

  


%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Niki items Page   </title>
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
			<h1 style="text-align: center; text-shadow: maroon;">
                            Item EXPORT search form </h1>
		</div>         
                    
        <h3>${it_tmp.insertMsg}</h3>
        <h4>${it_tmp.error} </h4>
        

        
        <form name="inputItem" action="Item.jsp" method="POST">
            
            
            <table id="inputItem" >
                  
                <tr>
                <%
                if(session.getAttribute("ItemSearched") != null){
	                String description = session.getAttribute("ItemSearched").toString();
	                it_tmp.setItemDescription(description);
                }
                %>
                    <td>
                        <select  name="business">
                            <option value=""></option> 
                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection(); 
                                    PreparedStatement st = conn.prepareStatement
        ("Select busin_category_id,busin_category_descr from niki_business_categories order by busin_category_descr");
                                    ResultSet rs = st.executeQuery();
                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String catId = rs.getString("busin_category_id");
                                        String catNme = rs.getString("busin_category_descr");
                                     %>
                                    
                                    <option value="<%=catId%>"><%=catNme%></option>
                            <%  } } catch (Exception e) {
                                    out.print(e); }
                            %>
                        </select><br/>
                    </td> 
                    <td>
                       manufacture: 
                    </td>
                    <td>
                        <select  name="fabricant">
                            <option value=""></option> 
                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection(); 
                                    PreparedStatement st = conn.prepareStatement("Select fabricant_id,niki_fabricant_name from niki_fabricant order by niki_fabricant_name");
                                    ResultSet rs = st.executeQuery();
                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String catId = rs.getString("fabricant_id");
                                        String catNme = rs.getString("niki_fabricant_name");
                                     %>
                                    
                                    <option value="<%=catId%>"><%=catNme%></option>
                            <%  } } catch (Exception e) {
                                    out.print(e); }
                            %>
                        </select><br/>
                    </td> 
                </tr>
                
                
                <br>
                
                <tr>
                    <td>
                      
                    </td>
                    <td>
                       
                    </td>
                    <td>
                       category: 
                    </td>
                    <td>
                        <select  name="itcat">
                            <option value=""></option>

                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement("Select category_id,category_descr from niki_categories where status='LIVE'");

                                    ResultSet rs = st.executeQuery();

                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String subcatId = rs.getString("category_id");
                                        String subcatNme = rs.getString("category_descr");


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
                 
                <tr> <td>  </td>
                    <td  bgcolor="green">  <input value="SEARCH" type="submit"/>
                    </td>  </tr> 
            </table>
   
        </form> 
                        
                        
        <div id="w">
                <h3 style="background-color:buttonface">NIKI Items List  <%=searchingfor%>
                      
                </h3>
                
                
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
                             
                        </tr>
                        
                        </thead>
                         
                        <tbody>
                        <%
String sqll="SELECT * FROM niki_items "+sqlToAdd;
                            try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery(sqll);
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
  <p><strong> Copyright &#169; 2016 Algorithm,Inc.  </strong></p>
</footer>



</body>
</html>
<% 
}
%>
