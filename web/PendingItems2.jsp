

<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%    
} else if (!checkUserPrivileges.toString().contains("CATEGORY")) {
    session.setAttribute("errorLogin","you don't have the right to handle categories");

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
String user=session.getAttribute("userInSessionfName").toString(); 

session.setAttribute("category",null);

%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Category</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">


	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
 	<link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
 		 
        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        
        <script src="assets/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        
        <link rel="stylesheet" href="assets/css/respo.css">

        <script>
			$(document).ready(function() {
		    	$('#example').DataTable();
		    	
		    	$('.modal').on('hidden.bs.modal', function(e)
					    { 
					        $(this).removeData();
					    }) ;
		    	
			} );
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
                    <li><a href="temporariesPage.jsp">Temporaries</a></li>
                    <li><a href="ItemLookup.jsp">Add Item</a>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a> <span class="glyphicon glyphicon-user"></span> <%=user%></a></li> 
                    <li><a  href="Logout.jsp">
                            <span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>

                </ul>
            </div>
        </nav>

                    
          <div class="container">
            <div class="version">
                <div>Category</div>
            </div>
              
              
          </div>

  
<div class="container-fluid text-center">
  <div class="row content">
    <div class="col-sm-2 sidenav">
      
    </div>
    <div class="col-sm-8 text-left" >
		<div class="page-header">
			<h1 style="text-align: center; text-shadow: maroon;">Category</h1>
		</div>         
            
            
         <div><h1>Category Entry Form</h1> </div>
        
        <h3>${cat.insertMsg}</h3>
        <h4>${cat.error} </h4>
        

        
        <form name="inputCat" action="CategoryResponse.jsp" method="POST"> 
            <table> 
            <tr>  <td> category code  </td>
            <td> <input type="text" name="ctn" value="" required=true size="35"/></td>
            </tr> 
            <tr>  <td> category description: </td>
            <td> <input type="text" name="ctd" value="" required=true size="35" >
            </td> </tr>
            <tr>  <td> Parent </td>
            <td> 
                  <select  name="parent">
                            <option value=""></option>

                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement("SELECT distinct(category_id) FROM niki.niki_categories order by  category_id");

                                    ResultSet rs = st.executeQuery();

                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String category_id = rs.getString(1); 


                            %>
                                    
                                    <option value="<%=category_id%>"><%=category_id%></option>
                            <%

                                    }

conn.close();
                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>
                        </select><br/>
                
                 
            </td> </tr>
            <tr>  <td> French description: </td>
            <td> <input type="text" name="french" value="" required=true size="35" >
            </td> </tr>
            <tr>  <td> Kinya description: </td>
            <td> <input type="text" name="kinya" value="" required=true size="35" >
            </td> </tr>
            <tr>  <td> </td>
                  <td> <input value="save" type="submit"/>  </td>
             </tr> 
            </table>

            
        </form>
        
        <div>
                <h3>${cat.insertMsg}</h3>
                <h4>${cat.error} </h4>
                 
                <h3 style="background-color:buttonface">Categories List</h3>
                
                <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%" >
                    <thead> 
                        <tr>
                            <th> Category Id</th>               
                            <th> Category Desc</th>   
                            <th> Status </th>                            
                            <th> Parent</th>               
                            <th> French</th>   
                            <th> Kinya</th>
                            <th> Edit </th>
                            <th> Sleep </th>
                        </tr>
                        
                        </thead>
                        <tfoot>
                        <tr>

                            <th> Category Id</th>               
                            <th> Category Desc</th>   
                            <th> Status </th>
                            <th> Parent</th>               
                            <th> French</th>   
                            <th> Kinya</th>
                            <th> Edit </th>
                            <th> Sleep </th>
                           

                        </tr>
                        </tfoot>
                        <tbody>
                        <%

                            try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery("SELECT * FROM niki_categories");
                                int i = 0;
                                while (rs.next()) {

                                    String bb = rs.getString(1);
                                    String cc = rs.getString(2);
                                    String dd = rs.getString(3);
                                    String vv = rs.getString(4);
                                    String kk = rs.getString(5);
                                    String oo = rs.getString(6);

                                 

                        %>  
                        <tr> 

                            <td><%=bb%>  </td>
                            <td> <%= cc%></td>
                            <td> <%=dd %></td>
                            <td><%=vv%>  </td>
                            <td> <%= kk%></td>
                            <td> <%=oo %></td>
                            <td> <a href="CategoryUpdate.jsp?catEdit=<%=bb%>&catDesc=<%=cc%>&action=update"> Edit </a></td>
                            <td> <a href="CategoryResponse.jsp?catRejectSleep=<%=bb%>&action=catSleep">Sleep </a></td>
                            
                            
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
    <div class="col-sm-2 sidenav" >
      
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