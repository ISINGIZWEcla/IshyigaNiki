
<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    boolean ndemerewe = false;

    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%
} else if (!checkUserPrivileges.toString().contains("ADDITEM")) {
    session.setAttribute("errorLogin", "you don't have the right to add an item");

%>
<jsp:forward page="Login.jsp"/>


<%    } else {

%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Users</title>
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
    <%    String user = session.getAttribute("userInSessionfName").toString();
    %>
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
                        <li><a href="accountsPage.jsp">Accounts</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a> <span class="glyphicon glyphicon-user"></span> <%=user%></a></li> 
                        <li><a  href="Logout.jsp">
                                <span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
                    </ul>
                </div>
            </div>
        </nav>


        <div class="container" style="min-height: 82vh">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2"> 
                    <div class="version">
                        <div>NIK-I Users</div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-sm-6">
                            <a href="TempUsers.jsp">
                                <div id="first" class="buttonBox">
                                    <button class="niki_buttons"> <i class="fa fa-user-times" aria-hidden="true" id="icon">&nbsp</i> PENDING USERS

                                    </button>

                                    <div class="border"></div>
                                    <div class="border"></div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-6">
                            <a href="FinalUsers.jsp">
                                <div id="first" class="buttonBox">
                                    <button class="niki_buttons"><i class="fa fa-users" aria-hidden="true" id="icon">&nbsp</i>ALL FINALS USERS
                                    </button>

                                    <div class="border"></div>
                                    <div class="border"></div>
                                </div>
                            </a>
                        </div>
                    </div>

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

