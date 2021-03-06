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
session.setAttribute("niki", null); 
String user=session.getAttribute("userInSessionfName").toString(); 

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Final Items</title>
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
			<h1 style="text-align: center; text-shadow: maroon;">Welcome to NIKI</h1>
		</div>         
            

		<div>
                <h3>${itf.insertMsg}</h3>
                <h4>${itf.error} </h4>
                 
                <h3 style="background-color:buttonface">Final Items List</h3>
                
                <table  id="example" class="table table-striped table-bordered" cellspacing="0" width="100%" >
                    <thead> 
                        <tr>
                        	<th style="width: 5em">niki_code</th>
                            <th style="width: 5em"> Codebar</th>               
                         
                            <%
                            if(userLanguage!=null && userLanguage.equals("ENGLISH")){
                            %>
								<th style="width: 20em"> Item description(ENGL) </th>                            <%
                            }
                            else if(userLanguage!=null && userLanguage.equals("KINYARWANDA")){
                            %>
                            	<th style="width: 20em"> Item description(KINYA)</th>
                            <%
                            }
                            else if(userLanguage!=null && userLanguage.equals("FRENCH")){
                            %>
                            	<th style="width: 20em"> Item description(FR)</th>
                            <%
                            }
                            else if(userLanguage!=null && userLanguage.equals("SWAHILI")){
                            %>
                            	<th style="width: 20em;"> Item description(SWHLI)</th>
                            <%
                            }
                            %>
                            
                                          
                            <th style="width: 20em"> Category </th>
                            <th style="width: 5em"> Tax-rate </th>
                            <th style="width: 5em"> Time </th>
                            <th style="width: 1em"> Status </th>
                            <th style="width: 1em"> Edit </th>
                            <th style="width: 1em"> Sleep </th>
                        </tr>
                        
                        </thead>
                        <tfoot>
                        <tr>
                            
               <!--                           
                            <th> Item description(ENGL) </th>
                            <th> Item description(KINYA)</th>
                            <th> Item description(FR)</th>
                            <th> Item description(SWHLI)</th>  --> 
                            
                            <th style="width: 5em">niki_code</th>
                            <th style="width: 5em"> Codebar</th>               
                         
                            <%
                            if(userLanguage!=null && userLanguage.equals("ENGLISH")){
                            %>
								<th style="width: 20em"> Item description(ENGL) </th>                            
							<%
                            }
                            else if(userLanguage!=null && userLanguage.equals("KINYARWANDA")){
                            %>
                            	<th style="width: 20em"> Item description(KINYA)</th>
                            <%
                            }
                            else if(userLanguage!=null && userLanguage.equals("FRENCH")){
                            %>
                            	<th style="width: 20em"> Item description(FR)</th>
                            <%
                            }
                            else if(userLanguage!=null && userLanguage.equals("SWAHILI")){
                            %>
                            	<th style="width: 20em;"> Item description(SWHLI)</th>
                            <%
                            }
                            %>
                            
                                          
                            <th style="width: 20em"> Category </th>
                            <th style="width: 5em"> Tax-rate </th>
                            <th style="width: 5em"> Time </th>
                            <th style="width: 1em"> Status </th>
                            <th style="width: 1em"> Edit </th>
                            <th style="width: 1em"> Sleep </th>
                           

                        </tr>
                        </tfoot>
                        <tbody>
                        <%

                            try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                PreparedStatement pst = con.prepareStatement("SELECT * FROM niki_items");
                                //ResultSet rs = pst.executeQuery("SELECT * FROM niki_items");
                                ResultSet rs = pst.executeQuery();
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
                                    String kk = rs.getString(10);
                                    
 
                        %>  
                        <tr> 

                            <td><%=bb%>  </td>
                            <td> <%= cc%></td>
                            
                            <%
                            if(userLanguage!=null && userLanguage.equals("ENGLISH")){
                            %>
                            	<td> <%= dd%></td>
                            <%
                            }
                            else if(userLanguage!=null && userLanguage.equals("KINYARWANDA")){
                            %>
                            	<td> <%= ee%></td>
                            <%
                            }
                            else if(userLanguage!=null && userLanguage.equals("FRENCH")){
                            %>
                            	<td> <%= ff%></td>
                            <%
                            }
                            else if(userLanguage!=null && userLanguage.equals("SWAHILI")){
                            %>
                            	<td> <%= gg%></td>
                            <%
                            }
                            %>
                            <td> <%= hh%></td>
                            <td> <%= ii%></td>
                            <td> <%= kk%></td>
                            <td> <%= jj%></td>
                            <td> <a href="ItemUpdate.jsp?itemEdit=<%=bb%>&action=update"  class="btn btn-primary" data-toggle="modal" data-target="#basicModal"> Edit </a></td>
                            <td> <a href="ItemRejectSleepResponse.jsp?itemRejectSleep=<%=bb%>&action=sleepFinal" name="remove_levels" class="btn btn-primary"  ><span class="fa fa-times"></span>Sleep </a></td>
                            
                            
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
