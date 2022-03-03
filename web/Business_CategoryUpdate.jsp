

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

    String buscategId = "";
    if (session.getAttribute("busincategory") == null) {
        buscategId = request.getParameter("busCatEdit");
    } else {
        buscategId = session.getAttribute("busincategory").toString();
    }

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>


<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Business Category Update</title>
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
                        <li><a href="Business_Category.jsp">BusinessCategory</a></li>
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
                        <h1 style=" text-align: center;background-color:orange;color: white ">Business Category Update</h1>
                    </div>         


                    <h3>${busin_cat.insertMsg}</h3>
                    <h4>${busin_cat.error} </h4>

                    <%

                        String buscatDesc = "", busincat = buscategId;
                        try {
                            Connection conn = ConnectionClass.getConnection();
                            Statement ST = conn.createStatement();
                            ResultSet rs = ST.executeQuery("SELECT * FROM niki_business_categories where busin_category_id='" + busincat + "'");
                            int i = 0;
                            while (rs.next()) {

                                String bb = rs.getString(1);
                                busincat = bb;
                                String bbc = rs.getString(2);
                                buscatDesc = bbc;

                                i++;
                            }

                            conn.close();

                        } catch (Exception e) {
                            e.printStackTrace();

                        }

                    %>

                    <form   class="form-horizontal" action="Business_CategoryResponse.jsp" method="POST">

                        <fieldset>

                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="Name">Business_category_Id:</label> 
                                <div class="col-md-5">

                                    <input   type="text" name="busincat" value="<%=busincat%>" size="35" readonly="readonly" class="form-control input-md" >
                                    <input type="text" name="action" value="update" size="35" hidden="" /> 
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="Name">Business_category description:</label> 
                                <div class="col-md-5">
                                    <input   type="text" size="35" name="buscatDesc" value="<%=buscatDesc%>" class="form-control input-md" required="true">

                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-4 control-label" for="submit"></label>
                                <div class="col-md-4">
                                    <input  type="submit"  class="btn btn-success" value="UPDATE">
                                </div>
                            </div>

                        </fieldset>



                    </form>      



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
