<%-- 
    Document   : addManufacture
    Created on : Jan 8, 2022, 7:00:40 AM
    Author     : tuyan
--%>
<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%
} else if (!checkUserPrivileges.toString().contains("CATEGORY")) {
    session.setAttribute("errorLogin", "you don't have the right to handle categories");

%>
<jsp:forward page="Login.jsp"/>


<%    } else {

    String user = session.getAttribute("userInSessionfName").toString();
    session.setAttribute("busin_category", null);

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register   </title>
        <jsp:useBean id="usr_tmp" scope="request" class="niki.User_Temp"/>
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
                        <li><a href="categoriesPage.jsp">User List</a></li>
                        <li ><a href="accountsPage.jsp">Accounts</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a> <span class="glyphicon glyphicon-user"></span> <%=user%></a></li> 
                        <li><a  href="Logout.jsp">
                                <span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container" style="min-height: 85vh">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2"> 
                    <div class="version">
                        <div>Create Account Form</div>
                    </div>

                    <div class="row">
                        <h3 style="color: red">${usr_tmp.insertMsg} </h3>
                        <form class="form-horizontal" action="registerResponse.jsp" method="POST" name="users" name="users">
                            <fieldset>

                                <!-- Text input-->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">UserName</label>  
                                    <div class="col-md-5">
                                        <input id="username" name="username" type="text" size="35" placeholder="Username" class="form-control input-md" required="">
                                        <span class="error" >${usr_tmp.msgUser} </span>
                                    </div>
                                </div>
                            
 <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">First Name</label>  
                                    <div class="col-md-5">
                                        <input id="first_name" name="fname" type="text" size="35" placeholder="First Name" class="form-control input-md" required="">

                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">Last Name</label>  
                                    <div class="col-md-5">
                                        <input id="last_name" name="lname" type="text" size="35" placeholder="last Name" class="form-control input-md" required="">

                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">Email</label>  
                                    <div class="col-md-5">
                                        <input id="email" name="email" type="email" size="35" placeholder="Email" class="form-control input-md" required="">

                                    </div>
                                </div>
                                 <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">Phone</label>  
                                    <div class="col-md-5">
                                        <input id="phone" name="phone" type="text" size="35" placeholder="Phone" class="form-control input-md" required="">

                                    </div>
                                </div>
                                  <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">Password</label>  
                                    <div class="col-md-5">
                                        <input id="password" name="password" type="password" size="35" placeholder="******" class="form-control input-md" required="">

                                    </div>
                                </div>
                                          <!-- Select Basic -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="sex">Gender</label>
                                    <div class="col-md-5">
                                        <select  name="sex" class="form-control">
                            <option value=""> SELECT GENDER</option>
                            <option value="M" selected> Male</option>
                            <option value="F"> Female</option>
                        </select>  
                         
                                    </div>
                                </div>
                                                      <!-- Select Basic -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="country">Language</label>
                                    <div class="col-md-5">
                                        <select  name="lang" class="form-control">
                            <option value=""> SELECT LANGUAGE</option>
                            <option value="ENGLISH">ENGLISH</option>
                                    <option value="FRENCH">FRENCH</option>
                                    <option value="KINYARWANDA">KINYARWANDA</option>
                                    <option value="SWAHILI">SWAHILI</option>
                        </select>  
                         
                                    </div>
                                </div>
                                <!-- Select Basic -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="country">Company Affected</label>
                                    <div class="col-md-5">
                                        <select  name="company" class="form-control">
                            <option value=""> SELECT COMPANY</option>

                            <%
                                try {
                                    //connection instance
                                    Connection conn = ConnectionClass.getConnection();

                                    PreparedStatement st = conn.prepareStatement
        ("SELECT companyId,companyName FROM niki.niki_companies order by  companyName");

                                    ResultSet rs = st.executeQuery();

                                    while (rs.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        String companyId = rs.getString(1); 
String companyName = rs.getString(2); 

                            %>
                                    
                                    <option value="<%=companyId%>"><%=companyName%></option>
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
                                    <input class="btn btn-default" type="reset" value="cancel" name="cancel" />
                                    </div>
                                </div>

                            </fieldset>
                        </form>
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