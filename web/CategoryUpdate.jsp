

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
    String userLanguage = session.getAttribute("userInSessionLanguage").toString();
    String user = session.getAttribute("userInSessionfName").toString();

    String categId = "";
    if (session.getAttribute("category") == null) {
        categId = request.getParameter("catEdit");
    } else {
        categId = session.getAttribute("category").toString();
    }

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Category Update NIKI</title>
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
            $(document).ready(function () {
                $('#example').DataTable();

                $('.modal').on('hidden.bs.modal', function (e)
                {
                    $(this).removeData();
                });

            });
        </script>


        <style>
            /* Remove the navbar's default margin-bottom and rounded borders */
            .navbar {
                margin-bottom: 0;
                border-radius: 0;
            }

            /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
            .row.content {
                height: 450px
            }

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
                .row.content {
                    height:auto;
                }
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
                        <li><a href="Category.jsp">Category</a></li>
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
                        <h1 style=" text-align: center;background-color:orange;color: white ">Category Update</h1>
                    </div>         


                    <h3>${cat.insertMsg}</h3>
                    <h4>${cat.error} </h4>

                    <%

                        String category_descr = "", status = "",
                                parent_category = "", french_catagory_name = "",
                                kinya_catagory_name = "", category_id = categId;

                        try {
                            Connection conn = ConnectionClass.getConnection();
                            Statement ST = conn.createStatement();
                            ResultSet rs = ST.executeQuery("SELECT * FROM niki_categories where category_id='" + categId + "'");
                            int i = 0;
                            while (rs.next()) {

                                category_id = rs.getString(1);
                                category_descr = rs.getString(2);
                                parent_category = rs.getString("parent_category");
                                french_catagory_name = rs.getString("french_catagory_name");
                                kinya_catagory_name = rs.getString("kinya_catagory_name");

                                i++;
                            }

                            conn.close();

                        } catch (Exception e) {
                            e.printStackTrace();

                        }

                    %>

                    <form class="form-horizontal" action="CategoryResponse.jsp" method="POST">
                        <fieldset>

                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="Name">Category Id:</label>  
                                <div class="col-md-5">

                                    <input  name="cat" type="text" size="35" value="<%=category_id%>" class="form-control input-md" readonly="readonly">
                                    <input type="text" name="action" value="update" size="35" hidden="" /> 

                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="Name">Category description:</label>  
                                <div class="col-md-5">

                                    <input  name="catDesc" type="text" size="35" value="<%=category_descr%>" class="form-control input-md" required="required">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="Name">Parent Category:</label>  
                                <div class="col-md-5">
                                    <input  name="parent" type="text" size="35" value="<%=parent_category%>" class="form-control input-md" required="required">


                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="Name">French Description:</label>  
                                <div class="col-md-5">

                                    <input name="french" type="text" size="35" value="<%=french_catagory_name%>" class="form-control input-md" required="required">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="Name">Kinya Description:</label>  
                                <div class="col-md-5">

                                    <input  name="kinya" type="text" size="35" value="<%=kinya_catagory_name%>" class="form-control input-md" required="required">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="submit"></label>
                                <div class="col-md-5">
                                    <input  type="submit" id="submit" name="submit" class="btn btn-success" value="UPDATE">
                                </div>
                            </div>
                            </div>
                            <!-- Button -->


                        </fieldset>
                    </form>







                </div>
                <div class="col-sm-2 sidenav" >

                </div>
            </div>



            <footer class="container-fluid text-center">
                <p><strong> Copyright &#169; 2021 Algorithm,Inc.</strong></p>
            </footer>


    </body>
</html>
<%
    }
%>
