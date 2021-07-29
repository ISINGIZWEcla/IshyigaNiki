<%--
    Document   : ItemValidationReal
    Created on : Jun 6, 2016, 2:58:43 AM
    Author     : vakaniwabo
--%>

<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    String ngezehe =" ndatangiye";
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
	
	String itemId=""; String attachNiki="";
	if(session.getAttribute("itemOriginal") == null){
    	itemId = request.getParameter("itemValidate");

	}
	else{
    	itemId = session.getAttribute("itemOriginal").toString();
	}
attachNiki=  request.getParameter("attachNiki");

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>

<%
session.setAttribute("niki", null); 
String user=session.getAttribute("userInSessionfName").toString(); 

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Validate Item</title>
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
		
		<script type="text/javascript">
			$('button[name="remove_levels"]').on('click', function(e){
	    	    var $form=$(this).closest('form'); 
	    	    e.preventDefault();
	    	    $('#confirm').modal({ backdrop: 'static', keyboard: false })
	    	        .one('click', '#delete', function() {
	    	            $form.trigger('submit'); // submit the form
	    	        });
	    	        // .one() is NOT a typo of .on()
	    	});
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
			<h1 style="text-align: center; text-shadow: maroon;">Validate Item</h1>
		</div>         
            

        
        <h3>${itf.insertMsg}</h3>
        <h4>${itf.error} </h4>
        <h3>${subcat.insertMsg}</h3>
        <h4>${subcat.error} </h4>
        <h3>${busin_cat.insertMsg}</h3>
        <h4>${busin_cat.error} </h4>
        
        <%
            
          //  ngezehe +=" \n ntandiye "+itemId;
    int item_temp_id= Integer.parseInt(itemId);
    String item_commercial_name="";  
    String item_inn="";
    String category_id=""; 
    String tax_vat="";  
    String item_fabricant=""; 
    double item_packet=1; 
    int item_longeur_mm=0; 
    int item_largeur_mm=0; 
    int item_hauteur_mm=0; 
    double item_poids_gr=0; 
    double item_dosage=0; 
    String shipment_type=""; 
    String item_key_words=""; 
    String hs_code=""; 
    String gtin_code=""; 
    String bar_code=""; 
    String created=""; 
    String global_id=""; 
    String bus_category_id="";
    String bus_categName="";
    String categName="";
                        try{
                            Connection conn = ConnectionClass.getConnection();
                            Statement ST = conn.createStatement();
    ResultSet rs = ST.executeQuery("SELECT * FROM niki_items_temp"
            + " where item_id="+ item_temp_id );
                            int i = 0;
                            while (rs.next()) { 	 
                            	session.setAttribute("itemOriginal",""+item_temp_id); 
                                 
                                 
                                    bar_code = rs.getString("codebar");
                                    item_commercial_name = rs.getString("itemDesc").toUpperCase();
                                    category_id = rs.getString("subcategory_id");
                                    bus_category_id = rs.getString("busin_category_id");
                                    String status = rs.getString("status");
                                    String langue = rs.getString("langue");
                                    String user_name = rs.getString("user_name");
                                    item_packet = rs.getDouble("packet");
                                    item_hauteur_mm = rs.getInt("hauteur");
                                    item_longeur_mm = rs.getInt("longeur");
                                    item_largeur_mm = rs.getInt("largeur");
                                    item_poids_gr = rs.getDouble("poids"); 
                                    item_fabricant = rs.getString("fabricant");
                                    tax_vat = rs.getString("tax_rate");
                                    hs_code = rs.getString("hs_code");
                                    String company_id = rs.getString("company_id");
                      
                                
                                Statement ST1 = conn.createStatement();
                                ResultSet rs1 = ST1.executeQuery("SELECT category_descr FROM niki_categories where category_id='"+ category_id + "'");
                                
                                while(rs1.next()){
                                	categName = rs1.getString(1);
                                }
                                
                                Statement ST2 = conn.createStatement();
                                ResultSet rs2 = ST2.executeQuery("SELECT busin_category_descr FROM niki_business_categories where busin_category_id = '"+ bus_category_id+"' ");
                                
                                while(rs2.next()){
                                	bus_categName = rs2.getString(1);
                                }
                                
                          i++;
                            } 
                           

                            if(attachNiki!=null && !attachNiki.equals(""))
                            {  
                              ST = conn.createStatement();
                              rs = ST.executeQuery("SELECT * FROM niki_items"
            + " where niki_code='"+attachNiki+"'"); 
                            while (rs.next()) { 	
                                 
                                    item_inn = rs.getString("item_inn");
                                    category_id = rs.getString("subcategory_id");
                                    bus_category_id = rs.getString("busin_category_id");
                                    item_fabricant = rs.getString("item_fabricant");
                                    tax_vat = rs.getString("tax_rate");
                                    hs_code = rs.getString("hs_code"); 
                                    item_key_words= rs.getString("item_key_words");
                            } 
                            
                             conn.close();
                            
                            }
                            
                            

                        } catch (Exception e) {
                            e.printStackTrace();

                        }
 
                    %>
        
        
        <form name="validateItem" action="ItemValidateResponse.jsp" method="POST">
            
            
            <table id="validateItem" width="700" >
                
                
                <tr>
                    <td bgcolor="green">
                       codebar: 
                    </td>
                    <td>
                        <input type="text" name="bar_code" value="<%=bar_code%>" size="15"/> 
                     <input type="text" name="item_temp_id" value="<%= item_temp_id %>" hidden="true" size="1"/>
                     
                        
                    </td>
                    
                </tr>
                
  <tr>  <td bgcolor="green">  item hs code </td>
 <td> <select name="hs_code" required="required">
 <option value=""> </option>  <% try { 
Connection conn = ConnectionClass.getConnection(); 
 PreparedStatement st = conn.prepareStatement(
 "SELECT niki_authority_code,niki_authority_name FROM niki.niki_authority_items where"
         + " niki_authority_id='HS'   ORDER BY niki_authority_name ");
 ResultSet rs = st.executeQuery();
 while (rs.next()) {  String niki_authority_code = rs.getString("niki_authority_code");
                      String niki_authority_name = rs.getString("niki_authority_name"); %>
                      <option value="<%=niki_authority_code%>">
                          <%=niki_authority_name.substring(0,Math.min(20, niki_authority_name.length()) )  %> </option> <% }  
 } catch (Exception e) {  out.print(e); }  %>  </select>
 </td>  
  
  </tr>                 
                 
                 
                <tr>  <td bgcolor="green"> item gtin code   </td>
                    <td>  <input type="text" name="gtin_code" value="" required=false size="15" >
                    </td>  </tr>  
                <tr>
                
                <tr>
                    <td  width="50%">
                        item description :
                    </td>
                    <td width="50%">
                        <input type="text" name="item_commercial_name"
                               value="<%=item_commercial_name%>" required=true size="25" >
                    </td>
                    
                </tr>
                  <tr>  <td> item molecular   </td>
                    <td>  <input type="text" name="item_inn" 
                                 value="<%=item_inn%>" required=true size="25" >
                    </td>  </tr> 
                  <tr>  <td>  item key word   </td>
                    <td>
                        <input type="text" name="item_key_words" value="<%=item_key_words%>" required=true size="15" >
                    </td>   </tr>
              <tr>  <td>   item form  </td>
 <td  bordercolor="#ff0000" > <select name="item_form" required="required">
 <option value=""> </option>  <% try { 
Connection conn = ConnectionClass.getConnection(); 
 PreparedStatement st = conn.prepareStatement(
         "SELECT niki_form_id,niki_form_name FROM niki.niki_form order by niki_form_name");
 ResultSet rs = st.executeQuery();
 while (rs.next()) {  String niki_form_id = rs.getString("niki_form_id");
                      String niki_form_name = rs.getString("niki_form_name"); %>
 <option value="<%=niki_form_id%>"><%=niki_form_name%> </option> <% }  
 } catch (Exception e) {  out.print(e); }  %>  </select>
 </td>  </tr> 
              
   <tr>  <td> item dose   </td>
                    <td  bordercolor="#ff0000">  <input type="text" name="item_dosage" value="1" required=true size="15" >
                    </td>  </tr>            
                            <tr>  <td>   item package  </td>
 <td  bordercolor="#ff0000"> <select name="item_emballage" required="required">
 <option value=""> </option>  <% try { 
Connection conn = ConnectionClass.getConnection(); 
 PreparedStatement st = conn.prepareStatement(
"SELECT niki_emballage_id,niki_emballage_name FROM niki.niki_emballage order by niki_emballage_name");
 ResultSet rs = st.executeQuery();
 while (rs.next()) {  String niki_emballage_id = rs.getString("niki_emballage_id");
                      String niki_emballage_name = rs.getString("niki_emballage_name"); %>
 <option value="<%=niki_emballage_id%>"><%=niki_emballage_name%> </option> <% }  
 } catch (Exception e) {  out.print(e); }  %>  </select>
 </td>  </tr>
 
                
<tr>
<td width="50%"> item packet   </td>
    <td width="25%">  <input type="text" name="item_packet" value="<%=item_packet%>"
                 required=true size="10" >
    </td>
</tr>
                
 
  <tr>  <td>   item fabricant <%=item_fabricant%> </td>
 <td> <select name="item_fabricant" required="required">
 <option value=""> </option>  <% try { 
Connection conn = ConnectionClass.getConnection(); 
 PreparedStatement st = conn.prepareStatement(
"SELECT fabricant_id,niki_fabricant_name FROM niki.niki_fabricant ORDER BY niki_fabricant_name");
 ResultSet rs = st.executeQuery();
 while (rs.next()) {  String fabricant_id = rs.getString("fabricant_id");
                      String niki_fabricant_name = rs.getString("niki_fabricant_name"); %>
 <option value="<%=fabricant_id%>"><%=niki_fabricant_name%> </option> <% }  
 } catch (Exception e) {  out.print(e); }  %>  </select>
 </td>  </tr>              
                
                 <tr>  
                    <td width="25%"> longeur MM </td>
                    <td  >  <input type="text" name="item_longeur_mm" value="<%=item_longeur_mm%>"
                                 required=true size="10" >
                    </td>  </tr> 
                  <tr> <td width="25%"> largeur MM </td>
                    <td  >  <input type="text" name="item_largeur_mm" value="<%=item_largeur_mm%>"
                                 required=true size="10" >
                    </td>  </tr> 
                  <tr>    <td width="25%"> hauteur MM </td>
                    <td  >  <input type="text" name="item_hauteur_mm" value="<%=item_hauteur_mm%>"
                                 required=true size="10" >
                    </td>
                </tr> 
 
   
    
                <tr>  <td> item poids GR  </td>
                    <td>  <input type="text" name="item_poids_gr" value="<%=item_poids_gr%>" required=true size="15" >
                    </td>  </tr>
               
                <tr>   <td> shipment type   </td>
                 <td> <select name="shipment_type" required="required">
 <option value="NORMAL"> NORMAL </option>  
 <option value="COOL"> COOL </option> 
 <option value="FRIGO"> FRIGO </option> 
 <option value="HOT"> HOT </option>  
                     </select>
 </td> 
  </tr>
  
                    <td>
                       Item category:  <%=categName%>
                    </td>
                    <td>
                        <select  name="category_id" required="required">
                            <option value="<%=category_id%>"><%=categName%></option>

                            <%
                            String orig="yesValidate";
                                try {

                                	//connection instance
                                    Connection conn = ConnectionClass.getConnection();
  
                                    PreparedStatement st = conn.prepareStatement(
                                            "Select category_id,category_descr from niki_categories where status='LIVE' ");

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
                        </select>
                    </td>
                    
                    <td>
<!--                     <a href="SubCategory.jsp"><img src="Images\newer.png" height="30" width="30"></a> -->
                    <a href="SubCategory.jsp?origin=<%=orig %>" class="glyphicon glyphicon-plus btn btn-primary">Add Category</a>
                    </td>
                    
                </tr>
                
 <tr>  <td>   taxRate:  </td>
 <td> <select name="tax_vat" required="required">
 <option value=""> </option>  <% try { 
Connection conn = ConnectionClass.getConnection(); 
 PreparedStatement st = conn.prepareStatement("Select taxLabel,taxValue from niki_tax_rates ");
 ResultSet rs = st.executeQuery();
 while (rs.next()) {  String taxL = rs.getString("taxLabel");
                      String taxV = rs.getString("taxValue"); %>
 <option value="<%=taxL%>"><%=taxV%> (<%=taxL%>)</option> <% }  
 } catch (Exception e) {  out.print(e); }  %>  </select>
 </td>  </tr>
                
                
                <tr>
                    <td>
                       Business category: 
                    </td>
                    <td>
                        <select  name="bus_category_id" multiple="multiple"  required="required">
                            <option value="<%=bus_category_id%>"><%=bus_categName%></option>

                            <%
                            
                                try {
                                	
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement
        ("Select busin_category_id,busin_category_descr from niki_business_categories where status='LIVE' order by busin_category_descr");

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
                    <a href="Business_Category.jsp?origin=<%=orig %>" class="glyphicon glyphicon-plus btn btn-primary" >Add Bus_Category</a>
                    </td>
                    
                    
                </tr>
                
                <tr>
                    <td>
                        
                    </td>
                    <td>
                        <input value="Validate" type="submit"/>
                    </td>
                    
                </tr>
                
            </table>
   
        </form>
		
        
    </div>
    
  </div>
</div>


<footer class="container-fluid text-center">
  <p><strong> Copyright &#169; 2016 Algorithm,Inc.</strong></p>
</footer>

<!-- <div id="confirm" class="modal hide fade">
<div class="modal-dialog">
        		<div class="modal-content">
            		<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
            			<h4 class="modal-title" id="myModalLabel">Validate Item</h4>
            		</div>
  <div class="modal-body">
    Are you sure?
  </div>
  <div class="modal-footer">
    <button type="button" data-dismiss="modal" class="btn btn-primary" id="delete">Delete</button>
    <button type="button" data-dismiss="modal" class="btn">Cancel</button>
  </div>
</div>
</div>
</div> -->

	<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
    		<div class="modal-dialog">
        		<div class="modal-content">
            		<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&amp;times;</button>
            			<h4 class="modal-title" id="myModalLabel">Validate Item</h4>
            		</div>
            		<div class="modal-body">
                		<h3>waiting.....<%=ngezehe %></h3>
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
