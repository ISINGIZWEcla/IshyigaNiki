

<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%
} else if (!checkUserPrivileges.toString().contains("PROMOTION")) {
    session.setAttribute("errorLogin", "you don't have the right to handle promotions :(");

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
<html lang="en">
    <head>
        <title>PROMOTIONS</title>
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
                        <li><a href="Promotions.jsp">Promotions</a></li>

                    </ul>
                    <ul class="nav navbar-nav navbar-right">

                        <li><a> <span class="glyphicon glyphicon-user"></span> <%=user%></a></li> 
                        <li><a  href="Logout.jsp">
                                <span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>


                    </ul>
                </div>
            </div>
        </nav>

        <div class="container" style="min-height: 80vh ">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2"> 
                    <div class="version" >
                        <div>Promotions EDIT Form</div>
                    </div>
                    <%
                        String action = request.getParameter("action");

                        String from = "nowhere";
                        String lesBus = "";

                        if (session.getAttribute("fromChooseCompany") != null) {
                            from = session.getAttribute("fromChooseCompany").toString();
                        }

                        int promo_code = Integer.parseInt(request.getParameter("promo_code"));
                        Connection conn = ConnectionClass.getConnection();
                        Statement ST = conn.createStatement();
                        ResultSet rs = ST.executeQuery("SELECT * FROM niki_promotions"
                                + " where promo_code=" + promo_code + "");

                        String promo_name = "";
                        String start = "";
                        String end = "";
                        String bus_cat_id = "";
                        String global_id = "";
                        String niki_company_id = "";
                        double maximum_budget = 0;
                        int maximum_qty = 0;

                        while (rs.next()) {
                            promo_name = rs.getString("promo_name");
                            start = rs.getString("start");
                            end = rs.getString("end");
                            bus_cat_id = rs.getString("bus_cat_id");
                            global_id = rs.getString("global_id");
                            niki_company_id = rs.getString("niki_company_id");
                            maximum_budget = rs.getDouble("maximum_budget");
                            maximum_qty = rs.getInt("maximum_qty");
                        }
                        rs = ST.executeQuery("SELECT * FROM niki_item_business_category");
                        while (rs.next()) {
                            lesBus += " " + rs.getString("busin_category_id");
                        }
                        // conn.close();     
%>  

                    <form name="inputCateg" class="form-horizontal" action="PromotionsEditResponse.jsp" method="POST">


                        <!-- Text input-->
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="Name">promo name:</label>  
                            <div class="col-md-5">
                                <input id="Name" name="promo_name" value="<%=promo_name%>" type="text" size="35" placeholder="Promo NAME" class="form-control input-md" required="">
                                <input type="hidden" name="promo_code" value="<%=promo_code%>" required=true size="35"/> 
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-md-4 control-label" for="Name">start time:</label>  
                            <div class="col-md-5">
                                <input id="Name" name="start" value="<%=start%>" type="text"  class="form-control input-md" required="">
<input  name="niki_company_id" value="<%=niki_company_id%>" type="hidden"  class="form-control input-md" required="">

                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="Name">End time:</label>  
                            <div class="col-md-5">
                                <input id="Name" name="end" value="<%=end%>" type="text" size="35" class="form-control input-md" required="">

                            </div>
                        </div>

                        <!-- Select Basic -->
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="country">business granted</label>
                            <div class="col-md-5">
                                <select  name="bus_cat_id" multiple="multiple"  required="required" class="form-control">
                                    <%

                                        try {

                                            PreparedStatement st = conn.prepareStatement("Select busin_category_id,busin_category_descr from niki_business_categories where status='LIVE' order by busin_category_descr");

                                            rs = st.executeQuery();

                                            while (rs.next()) {
                                                // Integer ip = rs.getInt("univId");
                                                String catId = rs.getString("busin_category_id");
                                                String catNme = rs.getString("busin_category_descr");

                                                if (lesBus.contains(catId)) {%>
                                    <option value="<%=catId%>" selected><%=catNme%> </option> <% } else {
                                    %>

                                    <option value="<%=catId%>"><%=catNme%></option>
                                    <%
                                                }
                                            }

                                            conn.close();
                                        } catch (Exception e) {
                                            out.print(e);
                                        }
                                    %>

                                </select>  
                            </div>
                            <div class="col-md-3">
                                <a href="Business_Category.jsp?" class="glyphicon glyphicon-plus btn btn-primary" >Add Bus_Category</a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="Name">Maximum Budget:</label>  
                            <div class="col-md-5">
                                <input id="Name" name="maximum_budget" value="<%=maximum_budget%>" type="number" value="10000" class="form-control input-md" required="">

                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="Name">Maximum Quantity:</label>  
                            <div class="col-md-5">
                                <input id="Name" name="maximum_qty" value="<%=maximum_qty%>" type="number" value="99990" placeholder="Maximum Qty" class="form-control input-md" required="">

                            </div>
                        </div>
                        <!-- Button -->
                        <div class="form-group">
                            <label class="col-md-4 control-label" for="submit"></label>
                            <div class="col-md-4">
                                <input  type="submit" id="submit" name="submit" class="btn btn-success" value="UPDATE PROMOTION">
                            </div>
                        </div>  


<!--                        <div class="version" >
                            <div>Promotion detail of <%=promo_name%></div>
                        </div>-->



                    </form>



                </div>
            </div>
        </div>









        <footer style="background-color: #405a63; " class="container-fluid text-center">
            <p style="color: white"><strong> Copyright &#169; 2021 Algorithm,Inc.  </strong></p>
        </footer>


    </body>
</html>
<%
    }
%>