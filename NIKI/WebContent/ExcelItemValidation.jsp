

<%--
    Document   : ItemValidationReal
    Created on : Jun 6, 2016, 2:58:43 AM
    Author     : vakaniwabo
--%>

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
	
	String fromExceld="";
	if(session.getAttribute("itemOriginal") == null){
		fromExceld = request.getParameter("excelItemValidate");
	}
	else{
		fromExceld = session.getAttribute("itemOriginal").toString();
	}

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
  <title>Validate Excel Item</title>
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
			<h1 style="text-align: center; text-shadow: maroon;">Validate Excel Item</h1>
		</div>         
            

        
        <h3>${itf.insertMsg}</h3>
        <h4>${itf.error} </h4>
        <h3>${subcat.insertMsg}</h3>
        <h4>${subcat.error} </h4>
        <h3>${busin_cat.insertMsg}</h3>
        <h4>${busin_cat.error} </h4>
        
        
        <%

    String codeb="",itmE="",itmK="",itmF="",itmS="",cat="",bus_cat="",status="", fromExcelId = fromExceld;
                        try{
                            Connection conn = ConnectionClass.getConnection();
                            Statement ST = conn.createStatement();
                            ResultSet rs = ST.executeQuery("SELECT * FROM itemsfromexcel where fromExceld='"+ fromExcelId+"'");
                            int i = 0;
                            while (rs.next()) {
                            	
                            	session.setAttribute("itemOriginal",fromExcelId);

                            	String cc = rs.getString(3);
                                String bb = rs.getString(4);
                                codeb=bb;
                                
                                itmE=cc;
                                
                                
                            }

                            conn.close();


                        } catch (Exception e) {
                            e.printStackTrace();

                        }
 
                    %>
          
                           
        <form name="validateItem" action="ExcelItemValidationResponse.jsp" method="POST">
            
            
            <table>
                
                
                <tr>
                    <td>
                       codebar: 
                    </td>
                    <td>
                        <input type="text" name="cdb" value="<%=codeb%>" size="30"/> 
                      <input type="text" name="itmIdOrig" value="<%= fromExcelId %>" hidden="true" size="1"/>
                        
                    </td>
                    
                </tr>
                <tr>
                    <td>
                        item description(ENGL):
                    </td>
                    <td>
                        <input type="text" name="itmdE" value="<%=itmE%>" required=true size="30" >
                    </td>
                    
                </tr>
                
                <tr>
                    <td>
                        item description(KINYA):
                    </td>
                    <td>
                        <input type="text" name="itmdK" value="<%=itmE%>" required=true size="30" >
                    </td>
                    
                </tr>
                
                <tr>
                    <td>
                        item description(FRENCH):
                    </td>
                    <td>
                        <input type="text" name="itmdF" value="<%=itmE%>" required=true size="30" >
                    </td>
                    
                </tr>
                
                <tr>
                    <td>
                        item description (SWAHILI):
                    </td>
                    <td>
                        <input type="text" name="itmdS" value="<%=itmE%>" required=true size="30" >
                    </td>
                    
                </tr>
                
                <tr>
                    <td>
                       Item category: 
                    </td>
                    <td>
                        <select  name="subcat" required="required">
                            <option value="<%=cat%>"></option>

                            <%
                            String orig="yesValidateExcel";
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
                        </select>
                    </td>
                    <td>
<!--                     <a href="SubCategory.jsp"><img src="Images\newer.png" height="30" width="30"></a> -->
                    <a href="SubCategory.jsp?origin=<%=orig %>" class="glyphicon glyphicon-plus btn btn-primary">Add Category</a>
                    </td>
                    
                </tr>
                
                <tr>
                    <td> 
                        taxRate:
                    </td>
                    <td>
                        <select name="txrt" required="required">
                            <option value=""> </option>
                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement("Select taxLabel,taxValue from niki_tax_rates ");

                                    ResultSet rs = st.executeQuery();

                                    while (rs.next()) {
                                        String taxL = rs.getString("taxLabel");
                                        String taxV = rs.getString("taxValue");


                            %>
                                    
                                    <option value="<%=taxL%>"><%=taxV%> (<%=taxL%>)</option>
                            <%

                                    }  


                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>

                        </select>
                    </td>
                    
                </tr>
                
                <br>
                
                <tr>
                    <td>
                       Business category: 
                    </td>
                    <td>
                        <select  name="busin_cat" multiple="multiple" required="required">
                            <option value="<%=bus_cat%>"></option>

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
                    
                    <td>
<!--                     <a href="Business_Category.jsp"><img src="Images\newer.png" height="50" width="50"></a> -->
                    <a href="Business_Category.jsp?origin=<%=orig %>" class="glyphicon glyphicon-plus btn btn-primary">Add Bus_Category</a>
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
