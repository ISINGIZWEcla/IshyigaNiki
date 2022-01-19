

<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%
} else if (!checkUserPrivileges.toString().contains("USERS")) {
    session.setAttribute("errorLogin", "you don't have the right to handle users");

%>
<jsp:forward page="Login.jsp"/>


<%    } else {
    String userLanguage = session.getAttribute("userInSessionLanguage").toString();
    String user = session.getAttribute("userInSessionfName").toString();
    session.setAttribute("userToEdit", null);

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Final Users</title>
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
            $(document).ready(function () {
                $('#example').DataTable();

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

        <nav class="navbar nav-niki">
            <div class="container-fluid links">
                <div class="navbar-header">
                    <a class="navbar-brand" href="niki.jsp"><img src="assets/NIKI.png" alt="" width="70"></a>
                </div>
                <ul class="nav navbar-nav">
                    <li class="active"><a href="niki.jsp">Home</a></li>
                    <li><a href="users.jsp">All users</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a> <span class="glyphicon glyphicon-user"></span> <%=user%></a></li> 
                    <li><a  href="Logout.jsp">
                            <span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>

                </ul>
            </div>
        </nav>

        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2"> 
                    <div class="version">
                        <div>Final Users</div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12"> 
                    <h3>${usr.insertMsg}</h3>
                    <h4>${usr.error} </h4>
                    <table id="example" class="table table-striped table-bordered" cellspacing="0">
                        <thead> 
                            <tr>
                                <th> User Name</th>               
                                <th> Email </th>
                                <th> Password</th>
                                <th> First Name</th>
                                <th> Last Name</th>               
                                <th> Affected Company </th>
                                <th> Phone </th>
                                <th> User_type </th>
                                <!--<th> Privileges </th>-->
                                <th> Status </th>
                                <th> Edit </th>
                                <th> Sleep </th>
                            </tr>

                        </thead>
                        <tfoot>
                            <tr>

                                <th> User Name</th>               
                                <th> Email </th>
                                <th> Password</th>
                                <th> First Name</th>
                                <th> Last Name</th>               
                                <th> Affected Company </th>
                                <th> Phone </th>
                                <th> User_type </th>
                                <!--<th> Privileges </th>-->
                                <th> Status </th>
                                <th> Edit </th>
                                <th> Sleep </th>


                            </tr>
                        </tfoot>
                        <tbody>
                            <%

                                try {

                                    Connection con = ConnectionClass.getConnection();
                                    Statement ST = con.createStatement();
                                    ResultSet rs = ST.executeQuery("SELECT * FROM users");
                                    int i = 0;
                                    while (rs.next()) {

                                        String bb = rs.getString(1);
                                        String cc = rs.getString(2);
                                        String dd = rs.getString(3);
                                        String ee = rs.getString(4);
                                        String ff = rs.getString(5);
                                        String gg = rs.getString(14);
                                        String hh = rs.getString(7);
                                        String ii = rs.getString(8);
                                        String jj = rs.getString(9);
                                        String kk = rs.getString(10);


                            %>  
                            <tr> 

                                <td><%=bb%>  </td>
                                <td> <%= cc%></td>
                                <td> <%= dd%></td>
                                <td> <%= ee%></td>
                                <td> <%= ff%></td>
                                <td> <%= gg%></td>
                                <td> <%= hh%></td>
                                <td> <%= ii%></td>
                                <!--<td> <%= jj%></td>-->
                                <td> <%= kk%></td>
                                <td> <a class="btn btn-info" href="UserUpdate.jsp?userEdit=<%=bb%>&action=update"> Edit </a></td>
                                <td> <a class="btn btn-warning" href="UserRejectSleepResponse.jsp?userRejectSleep=<%=bb%>&action=sleepFinal">Sleep </a></td>


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


        <footer style="background-color: #405a63;" class="container-fluid text-center">
            <p style="color: white"><strong> Copyright &#169; 2021 Algorithm,Inc.  </strong></p>
        </footer>


    </body>
</html>
<%
    }
%>
