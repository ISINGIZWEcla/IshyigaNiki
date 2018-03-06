

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

String busin_categ = request.getParameter("busin_categ_selected");

String userLanguage = session.getAttribute("userInSessionLanguage").toString();

//setting the original item id to be validated to null
	session.setAttribute("itemOriginal",null);

	String initial = session.getAttribute("initialExcelView").toString();

	if(initial.equals("yes")){
		session.setAttribute("bus_cat_selected",busin_categ);
	}
	String busin_categ_selected = session.getAttribute("bus_cat_selected").toString();
	System.out.println("busin_categ_selected: "+busin_categ_selected);
	
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Items From Files</title>
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
        <li><a href="import&export.jsp">Import&Export</a></li>
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
			<h1 style="text-align: center; text-shadow: maroon;">Excel Temporary Items</h1>
		</div>         
            
            <h3>${itf.insertMsg}</h3>
            <h4>${itf.error} </h4>
            
            <h3>${it_excl.insertMsg}</h3>
            <h4>${it_excl.error} </h4>
            
<%--             <h3>${trsh_excl.insertMsg}</h3> --%>
<%--             <h4>${trsh_excl.error} </h4> --%>
                
                <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%" >
                
                    <thead> 
                        <tr>
                        	<th> item_id </th>
                        	<th> item_external_id </th>
                            <th> Item description </th>   
                            <th> Codebar </th>
                            <th> Company </th>                            
                        	<th> ext_info_1 </th>   
                        	<th> ext_info_2 </th>
                        	<th> time </th>             
                        	<!-- <th> user_name </th>
                        	<th> file_name </th>  -->
                        	<th> niki_code </th>
                        	<th> status </th>
                        	
                        	<th> Validate </th>
                        	<th> Reject </th>
                        	
                           
                        </tr>
                        
                        </thead>
                        <tfoot>
                        <tr>

                            <th> item_id </th>
                        	<th> item_external_id </th>
                            <th> Item description </th>   
                            <th> Codebar </th>
                            <th> Company </th>                            
                        	<th> ext_info_1 </th>   
                        	<th> ext_info_2 </th>
                        	<th> time </th>             
                        	<!-- <th> user_name </th>
                        	<th> file_name </th>  -->
                        	<th> niki_code </th>
                        	<th> status </th>
                        	
                        	<th> Validate </th>
                        	<th> Reject </th>
                        
                           

                        </tr>
                        </tfoot>
                        <tbody>
                        <%
                        String busin_categ_id="";

                            try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery("SELECT * FROM itemsfromexcel where status = 'PENDING' or status = 'REJECTED' ");
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
                                    //String jj = rs.getString(9);
                                    //String kk = rs.getString(10);
                                    String ll = rs.getString(11);
                                    String mm = rs.getString(12);

                                 
                                    Statement ST1 = con.createStatement();
                                    ResultSet rs1 = ST1.executeQuery("SELECT busin_category_id FROM niki_companies where companyId= '"+ ff +"' ");
                                    if(rs1.next()){
                                    	busin_categ_id = rs1.getString(1);
                                    }
                                    
						if(mm.equals("TRANSFORMED")){
                        %>  
                        
                        <tr style="background: green;" > 

                            <td><%=bb%>  </td>
                            <td> <%= cc%></td>
                            <td><%=dd%>  </td>
                            <td> <%= ee%></td>
                            <td> <%= ff%></td>
                            <td> <%= gg%></td>
                            <td> <%= hh%></td>
                            <td> <%= ii%></td>
                           <!-- <td> </td>
                            <td> </td>  -->
                            <td> <%= ll%> </td>
                            <td> <%= mm%> </td>
                          
                            <td> <a href="ExcelItemValidation.jsp?excelItemValidate=<%=bb%>&action=validate" class="btn btn-primary disabled" data-toggle="modal" data-target="#basicModal" > Validate </a></td>
                            <td> <a href="ItemRejectSleepResponse.jsp?itemRejectSleep=<%=bb%>&action=rejectExcel" class="btn btn-primary disabled">Reject </a></td>
                            
                            
                        </tr>
                        
                        <%
						}
						else if(mm.equals("REJECTED") && busin_categ_id.equals(busin_categ_selected)){
	                        %>  
	                        
	                        <tr style="background:red; " > 

	                            <td><%=bb%>  </td>
	                            <td> <%= cc%></td>
	                            <td><%=dd%>  </td>
	                            <td> <%= ee%></td>
	                            <td> <%= ff%></td>
	                            <td> <%= gg%></td>
	                            <td> <%= hh%></td>
	                            <td> <%= ii%></td>
	                           <!-- <td> </td>
	                            <td> </td>  -->
	                            <td> <%= ll%> </td>
	                            <td> <%= mm%> </td>
	                          
	                            <td> <a href="ExcelItemValidation.jsp?excelItemValidate=<%=bb%>&action=validate" class="btn btn-primary" data-toggle="modal" data-target="#basicModal" > Validate </a></td>
	                            <td> <a href="ItemRejectSleepResponse.jsp?itemRejectSleep=<%=bb%>&itemDesc=<%=dd%>&action=rejectExcel"  class="btn btn-primary">Reject </a></td>
	                            
	                            
	                        </tr>
	                        
	                        <%
							}
						else if (busin_categ_id.equals(busin_categ_selected)){
	                        %>  
	                        
	                        <tr> 

	                            <td><%=bb%>  </td>
	                            <td> <%= cc%></td>
	                            <td><%=dd%>  </td>
	                            <td> <%= ee%></td>
	                            <td> <%= ff%></td>
	                            <td> <%= gg%></td>
	                            <td> <%= hh%></td>
	                            <td> <%= ii%></td>
	                           <!-- <td> </td>
	                            <td> </td>  -->
	                            <td> <%= ll%> </td>
	                            <td> <%= mm%> </td>
	                          
	                            <td> <a href="ExcelItemValidation.jsp?excelItemValidate=<%=bb%>&action=validate" class="btn btn-primary" data-toggle="modal" data-target="#basicModal" > Validate </a></td>
	                            <td> <a href="ItemRejectSleepResponse.jsp?itemRejectSleep=<%=bb%>&itemDesc=<%=dd%>&action=rejectExcel"  class="btn btn-primary">Reject </a></td>
	                            
	                            
	                        </tr>
	                        
	                        <%
							}
						
						
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
