
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>NIKI HOME</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css"
              href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="assets/css/respo.css">
        <link rel="stylesheet" href="assets/css/custom.css">
    </head>

    <%
        Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
                            Object checkfName = session.getAttribute("userInSessionfName");
                            Object checkType = session.getAttribute("userInSessionType");
                            String ngezehe = " ndatangiye";
        String user = "";
        String user_type = "";
        String tempo = "";
        String niki = "";
        String bus = "";
        String promo = "";
        String cat = "";
        String manu = "";
        String company = "";

        try {

            Connection con = ConnectionClass.getConnection();
            Statement ST = con.createStatement();
            ResultSet rs = ST.executeQuery("SELECT count(item_id) FROM niki.niki_items_temp");
            while (rs.next()) {
                tempo = "(" + rs.getInt(1) + ")";
            }
            rs = ST.executeQuery("SELECT count(niki_code) FROM niki.niki_items");
            while (rs.next()) {
                niki = "(" + rs.getInt(1) + ")";
            }
            rs = ST.executeQuery("SELECT count(busin_category_id) FROM niki.niki_business_categories");
            while (rs.next()) {
                bus = "(" + rs.getInt(1) + ")";
            }
            rs = ST.executeQuery("SELECT count(promo_code) FROM niki.niki_promotions");
            while (rs.next()) {
                promo = "(" + rs.getInt(1) + ")";
            }
            rs = ST.executeQuery("SELECT count(category_id) FROM niki.niki_categories");
            while (rs.next()) {
                cat = "(" + rs.getInt(1) + ")";
            }
            rs = ST.executeQuery("SELECT count(fabricant_id) FROM niki.niki_fabricant");
            while (rs.next()) {
                manu = "(" + rs.getInt(1) + ")";
            }
            rs = ST.executeQuery("SELECT count(companyId) FROM niki.niki_companies");
            while (rs.next()) {
                company = "(" + rs.getInt(1) + ")";
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();

        }
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
                        <li><a href="categoriesPage.jsp">Categories</a></li>
                        <%if (checkUserPrivileges != null) {
                            user_type=session.getAttribute("userInSessionType").toString();
                            if(user_type.contains("ISHYIGA_ADMIN")){
                            %>
                        <li><a href="accountsPage.jsp">ADMINISTRATION</a></li>
                        <%
                            }}%>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <%
                            
                            if (checkUserPrivileges == null) {
                        %>
                        <!--<li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>-->
                        <li><a class="btn btn-info" href="Login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>

                        <%
                        } else {
                            user = session.getAttribute("userInSessionfName").toString();
                            session.setAttribute("busin_category", null);

                        %>
                       <li><a> <span class="glyphicon glyphicon-user"></span> <%=user%></a></li> 
                        <li><a  href="Logout.jsp">
                                <span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
                        <%                       }
                            %>  
                        
                    </ul>
                </div>
            </div>
        </nav>


        <div class="container data-reports">
            <div class="version">
                <div>Welcome to NIKI 2.9</div>
            </div>
            <div class="row">
                <div class="col-sm-4">
                    <a href="PendingItems.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons"> <i class="fa fa-exchange" aria-hidden=="niki_buttons"true" id="icon">&nbsp</i> Transform
                                <p id="data"><%=tempo%></p>
                            </button>

                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4">
                    <a href="Item.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons"><i class="fa fa-list" aria-hidden="true" id="icon">&nbsp</i>Niki List
                                <p id="data"><%=niki%></p>
                            </button>

                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4">
                    <a href="Category.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons"> <i class="fa fa-object-group" aria-hidden="true" id="icon">&nbsp</i>Categories
                                <p id="data"><%=cat%></p>
                            </button>

                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-4">
                    <a href="Business_Category.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons"><i class="fa fa-university" aria-hidden="true" id="icon">&nbsp</i>Businnes
                                Sector
                                <p id="data"><%=bus%></p>
                            </button>

                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4">
                    <a href="Manufacture.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons"> <i class="fa fa-building" aria-hidden="true" id="icon">&nbsp</i>Manufacture
                                <p id="data"><%=manu%></p>
                            </button>

                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4">
                    <a href="Company.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons"><i class="fa fa-building-o" aria-hidden="true" id="icon">&nbsp</i>Companies
                                <p id="data"><%=company%></p>
                            </button>

                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-4">
                    <a href="Promotions.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons"><i class="fa fa-superpowers" aria-hidden="true" id="icon">&nbsp</i>Promotion
                                <p id="data"><%=promo%></p>
                            </button>

                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4">
                    <a href="ItemExport.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons"><i class="fa fa-cloud-download" aria-hidden="true" id="icon">&nbsp</i>Export
                                Excel
                                <!--<p id="data">20898</p>-->
                            </button>

                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4">
                    <a href="Settings.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons"><i class="fa fa-cog" aria-hidden="true" id="icon">&nbsp</i>Settings
                                <!--<p id="data">20898</p>-->
                            </button>

                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
            </div>

        </div>
        <div class="footer">
            <div class="inc">
                <h4> Copyrihgt © 2021 Algorithm Inc </h4>
            </div>
        </div>
    </body>

</html>
