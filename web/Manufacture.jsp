

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
        <li><a href="niki.jsp">NIKI</a></li>
        <li><a href="categoriesPage.jsp">Categories</a></li>
        
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
    <div class="col-sm-2 sidenav">
      
    </div>
    <div class="col-sm-8 text-left" >
		<div class="page-header">
			<h1 style="text-align: center; text-shadow: maroon;">MANUFACTURE</h1>
		</div>         
            
            
         <div><h1>Manufacture Entry Form</h1> </div>
        
        <h3>${cat.insertMsg}</h3>
        <h4>${cat.error} </h4>
        

        
        <form name="inputCat" action="ManufactuResponse.jsp" method="POST"> 
            <table> 
            <tr>  <td> Manufacture ID  </td>
            <td> <input type="text" name="id" value="" required=true size="35"/></td>
            </tr> 
            <tr>  <td> Manufacture NAME : </td>
            <td> <input type="text" name="name" value="" required=true size="35" >
            </td> </tr>
            <tr>  <td> Counrty </td>
            <td> 
                  <select  name="country">
                            <option value=""></option>

                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement
        ("SELECT niki_country_id,niki_country_name FROM niki.niki_country_code order by  niki_country_name");

                                    ResultSet rs = st.executeQuery();

                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String niki_country_id = rs.getString(1); 
String niki_country_name = rs.getString(2); 

                            %>
                                    
                                    <option value="<%=niki_country_id%>"><%=niki_country_name%></option>
                            <%

                                    }


                                } catch (Exception e) {
                                    out.print(e);
                                }
                            %>
                        </select><br/> 
            </td> </tr>
            
            <tr>  <td> </td>
                  <td> <input value="save" type="submit"/>  </td>
             </tr> 
            </table>

            
        </form>
        
        <div>
                <h3>${cat.insertMsg}</h3>
                <h4>${cat.error} </h4>
                 
                <h3 style="background-color:buttonface">Manufacture List</h3>
                
                <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%" >
                    <thead> 
                        <tr>
                            <th> Manufacture id</th>               
                            <th> Manufacture name</th>   
                            <th> Country </th>   
                        </tr>
                        
                        </thead>
                       
                        <tbody>
                        <%

                            try {

                                Connection con = ConnectionClass.getConnection();
                                Statement ST = con.createStatement();
                                ResultSet rs = ST.executeQuery("SELECT * FROM niki_fabricant order by niki_fabricant_name");
                                int i = 0;
                                while (rs.next()) {

                                    String id = rs.getString(1);
                                    String niki_fabricant_name = rs.getString(2);
                                    String country = rs.getString(3); 

                                 

                        %>  
                        <tr> 

                            <td><%=id%>  </td>
                            <td> <%= niki_fabricant_name%></td>
                            <td> <%=country %></td> 
                            
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