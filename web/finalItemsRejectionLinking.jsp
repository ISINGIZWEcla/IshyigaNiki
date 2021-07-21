
<%
String item=request.getParameter("itemRej");
String itemDescription=request.getParameter("itemDesc");

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
        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap.min.js"></script>
        
		<script>
			$(document).ready(function() {
		    	$('#example').DataTable();
			} );
		</script>


<title>Insert title here</title>
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
            <li><a href="niki.jsp"><span>NIKI</span></a></li>
        </center>


		<div>
		<h3 style="color: green;">Select an item you want to link to the rejected item: "<%=itemDescription%>"</h3>
                <h3>${itf.insertMsg}</h3>
                <h4>${itf.error} </h4>
                 
                <h3 style="background-color:buttonface">Final Items List</h3>
                
                <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%" >
                    <thead> 
                        <tr>
                        	<th>niki_code</th>
                            <th> Codebar</th>               
                            <th> Item description(ENGL) </th>
                            <th> Item description(KINYA)</th>
                            <th> Item description(FR)</th>
                            <th> Item description(SWHLI)</th>               
                            <th> Category </th>
                            <th> Tax-rate </th>
                            <th> Status </th>
                            <th> Select </th>
                        </tr>
                        
                        </thead>
                        <tfoot>
                        <tr>
							<th>niki_code</th>
                            <th> Codebar</th>               
                            <th> Item description(ENGL) </th>
                            <th> Item description(KINYA)</th>
                            <th> Item description(FR)</th>
                            <th> Item description(SWHLI)</th>               
                            <th> Category </th>
                            <th> Tax-rate </th>
                            <th> Status </th>
                            <th> Select </th>
 
                           

                        </tr>
                        </tfoot>
                        <tbody>
                        <%

                            try {
                               String categName="";

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
                                    
                                 // This is for getting the item category and nusiness category name and display them for the user
                                    //instead of displaying the ids for them
                                    
                                    
                                    Statement ST1 = con.createStatement();
                                    ResultSet rs1 = ST1.executeQuery("SELECT subcategory_descr FROM niki_subcategories where subcategory_id='"+ hh + "'");
                                    
                                    while(rs1.next()){
                                    	categName = rs1.getString(1);
                                    }

                                 

                        %>  
                        <tr> 

                            <td><%=bb%>  </td>
                            <td> <%= cc%></td>
                            <td> <%= dd%></td>
                            <td> <%= ee%></td>
                            <td> <%= ff%></td>
                            <td> <%= gg%></td>
                            <td> <%= categName%></td>
                            <td> <%= ii%></td>
                            <td> <%= jj%></td>
                            <td> <a href="AddNikiCodeResponse.jsp?nikicode=<%=bb%>&itemReject=<%=item %>"> select </a></td>
                            
                            
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