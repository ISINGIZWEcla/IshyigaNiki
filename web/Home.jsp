
<%-- 
    Document   : Home
    Created on : Dec 29, 2021, 7:26:29 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">

<head>
    

    <title>NIKI</title>
    <link rel="stylesheet" type="text/css"
        href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<%
     String tempo="";
     String niki="";
     String bus="";
     String promo="";
     String cat="";
     String manu="";
     String company="";

                            try {

Connection con = ConnectionClass.getConnection();
Statement ST = con.createStatement();
ResultSet rs = ST.executeQuery("SELECT count(item_id) FROM niki.niki_items_temp"); 
   while (rs.next()) {  tempo = "("+rs.getInt(1)+")";}
   rs = ST.executeQuery("SELECT count(niki_code) FROM niki.niki_items"); 
   while (rs.next()) {  niki = "("+rs.getInt(1)+")";}
   rs = ST.executeQuery("SELECT count(busin_category_id) FROM niki.niki_business_categories"); 
   while (rs.next()) {  bus = "("+rs.getInt(1)+")";}
   rs = ST.executeQuery("SELECT count(promo_code) FROM niki.niki_promotions"); 
   while (rs.next()) {  promo = "("+rs.getInt(1)+")";}
    rs = ST.executeQuery("SELECT count(category_id) FROM niki.niki_categories"); 
   while (rs.next()) {  cat = "("+rs.getInt(1)+")";}
   rs = ST.executeQuery("SELECT count(fabricant_id) FROM niki.niki_fabricant"); 
   while (rs.next()) {  manu = "("+rs.getInt(1)+")";}
   rs = ST.executeQuery("SELECT count(companyId) FROM niki.niki_companies"); 
   while (rs.next()) {  company = "("+rs.getInt(1)+")";}  
   
   
                                con.close();

                            } catch (Exception e) {
                                e.printStackTrace();

                            }
                        %>
<body style="height: 100vh !important;">
    <div class="Container">
        <div class="NavBar trial">
            <div><img src="./NIKI (1).png" alt="" width="70"></div>
            <div id="btn"><a href="niki.jsp"><i class="fa fa-home"> &nbsp Home</i></a></div>
            <!-- <div id="btn"><a href="#"><i class="fa fa-bell" aria-hidden="true">&nbsp</i></a></div> -->
            <div id="btn"><a href="Logout.jsp"><i class="fa fa-sign-out" aria-hidden="true">&nbsp Signout</i> &nbsp</i></a></div>

        </div>
        <div class="big-container">
            <div class="version">
                <div>Welcome to NIKI 2.9</div>
            </div>

            <div class="Report">
                <div class="profile">
                    
                    
                    <div class="status">
                        <div class="status-report">
                            <a href="PendingItems.jsp">
                            <div id="first" class="buttonBox">
                                <button > <i class="fa fa-exchange" aria-hidden="true" id="icon">&nbsp</i> Transform
                                    <p id="data"><%=tempo%></p>
                                </button>

                                <div class="border"></div>
                                <div class="border"></div>
                            </div>
                            </a>
                        </div>
                        <div class="status-report">
                            <a href="Item.jsp">
                            <div id="first" class="buttonBox">
                                <button><i class="fa fa-list" aria-hidden="true" id="icon">&nbsp</i>Niki List
                                    <p id="data"><%=niki%></p>
                                </button>
                                <div class="border"></div>
                                <div class="border"></div>
                            </div>
                            </a>
                        </div>
                        <div class="status-report">
                            <a href="Category.jsp">
                            <div id="first" class="buttonBox">
                                <button> <i class="fa fa-object-group" aria-hidden="true" id="icon">&nbsp</i>Categories
                                    <p id="data"><%=cat%></p>
                                </button>
                                <div class="border"></div>
                                <div class="border"></div>
                            </div>
                            </a>
                        </div>
                    </div>
                    <div class="status">
                        <div class="status-report">
                            <a href="Business_Category.jsp">
                            <div id="first" class="buttonBox">
                                <button><i class="fa fa-university" aria-hidden="true" id="icon">&nbsp</i>Businnes
                                    Sector
                                    <p id="data"><%=bus%></p>
                                </button>
                                <div class="border"></div>
                                <div class="border"></div>
                            </div>
                            </a>
                        </div>
                        <div class="status-report">
                            <a href="Manufacture.jsp">
                            <div id="first" class="buttonBox">
                                <button> <i class="fa fa-building" aria-hidden="true" id="icon">&nbsp</i>Manufacture
                                    <p id="data"><%=manu%></p>
                                </button>
                                <div class="border"></div>
                                <div class="border"></div>
                            </div>
                            </a>
                        </div>
                        <div class="status-report">
                            <a href="Company.jsp">
                            <div id="first" class="buttonBox">
                                <button><i class="fa fa-building-o" aria-hidden="true" id="icon">&nbsp</i>Companies
                                    <p id="data"><%=company%></p>
                                </button>
                                <div class="border"></div>
                                <div class="border"></div>
                            </div>
                            </a>
                        </div>
                    </div>

                    <div class="status">
                        <div class="status-report">
                            <a href="Promotions.jsp">
                            <div id="first" class="buttonBox">
                                <button><i class="fa fa-superpowers" aria-hidden="true" id="icon">&nbsp</i>Promotion
                                    <p id="data"><%=promo%></p>
                                </button>
                                <div class="border"></div>
                                <div class="border"></div>
                            </div>
                            </a>
                        </div>
                        <div class="status-report">
                            <a href="ItemExport.jsp">
                            <div id="first" class="buttonBox">
                                <button><i class="fa fa-cloud-download" aria-hidden="true" id="icon">&nbsp</i>Export
                                    Excel
                                    <!--<p id="data">20898</p>-->
                                </button>
                                <div class="border"></div>
                                <div class="border"></div>
                            </div>
                            </a>
                        </div>
                        <div class="status-report">
                            <a href="Settings.jsp">
                            <div id="first" class="buttonBox">
                                <button><i class="fa fa-cog" aria-hidden="true" id="icon">&nbsp</i>Settings
                                    <!--<p id="data">20898</p>-->
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
        <div class="footer">
            <div class="inc">
                Copyrihgt © 2020 Algorithm Inc
            </div>
        </div>
</body>

</html>
