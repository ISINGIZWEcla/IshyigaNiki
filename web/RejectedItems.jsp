
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
		<link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
		 
        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap.min.js"></script>
        
		<script>
			$(document).ready(function() {
		    	$('#example').DataTable();
			} );
		</script>

<title>Rejected Items</title>
</head>
<body>

		<center> <h2> 
                <% String a=session.getAttribute("userInSessionfName").toString(); 
                out.println("Hello "+a); 
                %> 
            </h2> 
            <br/> <br/> 
            <a href="Logout.jsp">Logout</a>
            <li><a href="index.html"><span>Home</span></a></li>
            <li><a href="temporariesPage.jsp"><span>All temporary items</span></a></li>
        </center>


		<div id="w">
            <h3>${it_tmp.insertMsg}</h3>
                <h4>${it_tmp.error} </h4>
                <h3 style="background-color:buttonface">Rejected Items</h3>
                
                <table  id="example" class="table table-striped table-bordered" cellspacing="0" width="100%" >
                    <thead> 
                        <tr>
                        	<th> item_id </th>
                        	<th> item_external_id </th>
                            <th> Codebar </th>               
                            <th> Item description(ENGL) </th>              
                            <th> Category </th>
                            <th> Busin_Category </th>
                            <th> language </th>
                        	<th> user_name </th>
                        	<th> time </th>
                        	<th> niki_code </th>
                        	<th> Status </th>
                        	<th> Validate </th>
                        	
                           
                        </tr>
                        
                        </thead>
                        <tfoot>
                        <tr>

                            <th> item_id </th>
                        	<th> item_external_id </th>
                            <th> Codebar </th>               
                            <th> Item description </th>              
                            <th> Category </th>
                            <th> Busin_Category </th>
                            <th> language </th>
                        	<th> user_name </th>
                        	<th> time </th>
                        	<th> niki_code </th>
                            <th> Status </th>                        	
                        	<th> Validate </th>
                        
                           

                        </tr>
                        </tfoot>
                        <tbody>
                        <%
                        String categName="";
                        String bus_categName="";

                            try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery("SELECT * FROM niki_items_temp where status='rejected'");
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
                                    String ll = rs.getString(11);

                                    
                                    // This is for getting the item category and nusiness category name and display them for the user
                                    //instead of displaying the ids for them
                                    
                                    
                                    Statement ST1 = con.createStatement();
                                    ResultSet rs1 = ST1.executeQuery("SELECT subcategory_descr FROM niki_subcategories where subcategory_id='"+ ff + "'");
                                    
                                    while(rs1.next()){
                                    	categName = rs1.getString(1);
                                    }
                                    
                                    Statement ST2 = con.createStatement();
                                    ResultSet rs2 = ST2.executeQuery("SELECT busin_category_descr FROM niki_business_categories where busin_category_id = '"+ gg+"' ");
                                    
                                    while(rs2.next()){
                                    	bus_categName = rs2.getString(1);
                                    }

                                 

                        %>  
                        <tr> 

                            <td><%=bb%>  </td>
                            <td> <%= cc%></td>
                            <td><%=dd%>  </td>
                            <td> <%= ee%></td>
                            <td> <%= categName%></td>
                            <td> <%= bus_categName%></td>
                            <td><%=ii%>  </td>
                            <td> <%= jj%></td>
                            <td><%=kk%>  </td>
                            <td> <%= ll%></td>
                            <td> <%= hh%></td>
                            <td> <a href="ItemValidationReal.jsp?itemValidate=<%=bb%>&action=validate"> Validate </a></td>
                            
                            
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

</body>
</html>

<% 
}
%>