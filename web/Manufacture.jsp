

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
        <link rel="stylesheet" href="assets/css/custom.css">
        
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

<nav class="navbar navbar-inverse nav-niki">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="niki.jsp"><img src="assets/NIKI.png" alt="" width="70"></a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="niki.jsp">Home</a></li>
                        <li><a href="categoriesPage.jsp">Categories</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a> <span class="glyphicon glyphicon-user"></span> <%=user%></a></li> 
                        <li><a  href="Logout.jsp">
                                <span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
                    </ul>
                </div>
            </div>
        </nav>
  
                        <div class="container-fluid" style="min-height: 85vh">                       
                        <div class="row">             
                            <div class="col-sm-4 col-md-4">
                             <div class="row">
                <div class="col-sm-12"> 
                    <div class="version">
                        <div>Manufacture Entry Form</div>
                    </div>
                     <h3>${cat.insertMsg}</h3>
                     <h4>${cat.error} </h4>

                    <div class="row">
                        <form class="form-horizontal" action="ManufactuResponse.jsp" method="POST">
                            <fieldset>

                                <!-- Text input-->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">Manufacture NAME</label>  
                                    <div class="col-md-7">
                                        <input id="Name" name="name" type="text" size="35" placeholder="Manufacture NAME" class="form-control input-md" required="">

                                    </div>
                                </div>
                            

                                <!-- Select Basic -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="country">Country</label>
                                    <div class="col-md-7">
                                        <select  name="country" class="form-control">
                            <option value=""> SELECT COUNTRY</option>

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
                        </select>  
                         
                                    </div>
                                </div>
                                <!-- Button -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="submit"></label>
                                    <div class="col-md-4">
                                        <input  type="submit" id="submit" name="submit" class="btn btn-success" value="SAVE">
                                    </div>
                                </div>

                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>   
                            </div>             
                            <div class="col-sm-8 col-md-8">
                                <div class="row">
                <div class="col-sm-12"> 
                    <div class="version">
                        <div>Manufacture List</div>
                    </div>
                    <h3>${cat.insertMsg}</h3>
                <h4>${cat.error} </h4>
                    
                 <table id="example" class="table table-responsive table-bordered" cellspacing="0" width="100%" >
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
                            </div>   
</div>             
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
  </div>                     
                        
                        



<footer style="background-color: #405a63;" class="container-fluid text-center">
          <p style="color: white"><strong> Copyright &#169; 2016 Algorithm,Inc.  </strong></p>
        </footer>


</body>
</html>
<% 
}
%>