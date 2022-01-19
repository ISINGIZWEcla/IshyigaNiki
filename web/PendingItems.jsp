

<%@page import="HTTP_URL.Igicu"%>
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
String company = session.getAttribute("userInSessionCompany").toString(); 
String userLanguage = session.getAttribute("userInSessionLanguage").toString();
String sql ="SELECT * FROM niki_items_temp where status='PENDING' AND company_id='"+company+"' order by itemDesc";
 
//setting the original item id to be validated to null
	session.setAttribute("itemOriginal", null); 

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Pending Items of  <%=company  %> </title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
	<!--<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">--> 
 	<link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css"> 
        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        
        <script src="assets/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap.min.js"></script>
        
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/dataTables.buttons.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js" ></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.html5.min.js" ></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.print.min.js" ></script>

    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/css/respo.css">

        <script>
        $(document).ready(function () {
            $('#exampleTemp').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    'excel'
                ],
                exclude: 'ex',
                proccesing: true
            });
        });
    </script>
  
</head>
<body>
    
    
     <nav class="navbar nav-niki">
        <div class="container-fluid links">
            <div class="navbar-header">
                <a class="navbar-brand" href="niki.jsp"><img src="assets/NIKI.png" alt="" width="70"></a>
            </div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="niki.jsp">Home</a></li>
                <li><a href="Item.jsp">Niki List</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a> <span class="glyphicon glyphicon-user"></span> <%=user%></a></li> 
                <li><a  href="Logout.jsp">
                        <span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
                           
            </ul>
        </div>
    </nav>

   <div class="container data-reports">
        <div class="version">
            <div>Temporary Items of <%=company  %></div>
        </div>
       
        
          <div class="row content">
    
    <div class="col-sm-12 text-left" >
	      
        <div id="w">
            <h3>${itf.insertMsg}</h3>
                <h4>${itf.error} </h4>
                <h3>${it_tmp.insertMsg}</h3>
                <h4>${it_tmp.error} </h4>
                
                <table  id="exampleTemp" class="table table-striped table-bordered" cellspacing="0" width="100%" >
                    <thead> 
                        <tr>
                              <th > Item ID </th>          
                            <th > Description </th>              
                            <th> Category </th>
                            <th> Busines Categ </th> 
                            <th> Status </th>
                        	<th> Manufacture </th>
                        	
                        	<th> Validate </th> 
                           
                        </tr>
                        
                        </thead> 
                        <tbody>
                        <%
                        String categName="";
                        String bus_categName="";
                           try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery(sql);
                                int i = 0;
                                while (rs.next()) {
       
                                    int item_id = rs.getInt("item_id");
                                    String codebar = rs.getString("codebar");
                                    String itemDesc = rs.getString("itemDesc");
                                    String subcategory_id = rs.getString("subcategory_id");
                                    String busin_category_id = rs.getString("busin_category_id");
                                    String status = rs.getString("status");
                                    String langue = rs.getString("langue");
                                    String user_name = rs.getString("user_name");
                                    double packet = rs.getDouble("packet");
                                    int hauteur = rs.getInt("hauteur");
                                    int longeur = rs.getInt("longeur");
                                    int largeur = rs.getInt("largeur");
                                    double poids = rs.getDouble("poids"); 
                                    String fabricant = rs.getString("fabricant");
                                    String tax_rate = rs.getString("tax_rate");
                                    String hs_code = rs.getString("hs_code");
                                    String company_id = rs.getString("company_id");
                                    
                                   
                                    
                                    /*Statement ST1 = con.createStatement();
                                    ResultSet rs1 = ST1.executeQuery("SELECT category_descr FROM niki_categories where category_id='"+ subcategory_id + "'");
                                    
                                    while(rs1.next()){
                                    	categName = rs1.getString(1);
                                    }*/
                                    categName =subcategory_id;
                                    Statement ST2 = con.createStatement();
                                    ResultSet rs2 = ST2.executeQuery("SELECT busin_category_descr FROM niki_business_categories where busin_category_id = '"+ busin_category_id+"' ");
                                    
                                    while(rs2.next()){
                                    	bus_categName = rs2.getString(1);
                                    }

                                 
                        if(status.equals("TRANSFORMED")){
                        %>  
                        <tr style="background: green;"> 
 
                            <td> <%= item_id%></td>
                            <td> <%= itemDesc%></td>
                            <td> <%= categName%></td>
                            <td> <%= bus_categName%></td> 
                            <td> <%= status%></td>
                            <td> <%= fabricant%></td>
                            <td> <a href="ItemValidationReal.jsp?itemValidate=<%=item_id%>&action=validate" class="btn btn-primary disabled" data-toggle="modal" data-target="#basicModal" > Validate </a></td>
                            <td> <a href="ItemRejectSleepResponse.jsp?itemRejectSleep=<%=item_id%>&action=rejectTemp" class="btn btn-primary disabled">Reject </a></td>
                            
                            
                        </tr>
                        
                        <%
						}
						else if(status.equals("REJECTED")){
	                    %>
                        
                        <tr style="background:red;"> 
 
                           <td> <%= itemDesc%></td>
                            <td> <%= categName%></td>
                            <td> <%= bus_categName%></td> 
                            <td> <%= status%></td>
                            <td> <%= fabricant%></td>
                                <td> <a href="ItemValidationReal.jsp?itemValidate=<%=item_id%>&action=validate" class="btn btn-primary" data-toggle="modal" data-target="#basicModal" > Validate </a></td>
                                <td> <a href="ItemRejectSleepResponse.jsp?itemRejectSleep=<%=item_id%>&itemDesc=<%=itemDesc%>&action=rejectTemp" class="btn btn-primary">Reject </a></td>

                            
                        </tr>
                        
                        <%
							}
						else{
	                        %> 
                        <tr> 
                            <td> <%= item_id%></td>
                            <td> <%= itemDesc%></td>
                            <td> <%= categName%></td>
                            <td> <%= bus_categName%></td> 
                            <td> <%= status%></td>
                            <td> <%= fabricant%></td>
                            <td> <a href="Item.jsp?itemValidate=<%=item_id%>&itemDesc=<%=Igicu.gusukuraInteruro(itemDesc)%>&action=validate" > Validate </a></td>
                              
                            
                        </tr>
                        
                        <%
						}
                        }

                             con.close();

                         } catch (Exception e) {
                             e.printStackTrace();
sql +="dddd "+e;
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
