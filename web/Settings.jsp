<%-- 
    Document   : Settings
    Created on : Jul 21, 2021, 7:34:16 AM
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
  <title>NIKI Settings</title>     
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
  	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<script src="assets/js/jquery.min.js"></script>
<!--   <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
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
           if (checkUserPrivileges != null) {
               String business_category = session.getAttribute("bussiness_category").toString(); 
               if(business_category.contains("PHARMACY")){
                  business_category="PHARMACY" ;
               }
            rs = ST.executeQuery("SELECT count(niki_code) FROM niki.niki_items_temp where busin_category_id like'%"+business_category+"%' AND STATUS ='TRANSFORMED'");
            while (rs.next()) {
                niki = "(" + rs.getInt(1) + ")";
            }
           }else{
              rs = ST.executeQuery("SELECT count(niki_code) FROM niki.niki_items");
            while (rs.next()) {
                niki = "(" + rs.getInt(1) + ")";
            }   
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
                        <li ><a href="niki.jsp">Home</a></li>
                        <li><a href="categoriesPage.jsp">Categories</a></li>
                        <li class="active"><a href="Settings.jsp">Settings</a></li>
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
                <div>Welcome to NIKI Settings</div>
            </div>         
        
         <div class="row">
                <div class="col-sm-4">
                    <a href="Category.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons">  CATEGORIES </button>
                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4">
                    <a href="Emballage.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons">EMBALLAGE</button>
                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4">
                    <a href="Form.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons"> FORMS
                                <a href="../build/web/settings.jsp"></a>
                            </button>
                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-4">
                    <a href="taxPage.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons">TAXES</button>
                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4">
                    <a href="taxPage.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons"> AUTHORITIES</button>
                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
                <div class="col-sm-4">
                    <a href="Business_Category.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons">BUSINESSES</button>
                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-4">
                    <a href="Niki_Report.jsp">
                        <div id="first" class="buttonBox">
                            <button class="niki_buttons">REPORT </button>

                            <div class="border"></div>
                            <div class="border"></div>
                        </div>
                    </a>
                </div>
                
            </div>
            </div>

<!--         <div><a href="testDesign.jsp">Design</a></div> -->
        <!-- <div><a href="PopUpButtonDemo.jsp">Pop up demo</a></div>
        <div><a href="testModal.jsp">Test Modal</a></div> -->
    
		</div>
		<!--<div style="background-color: orange; border-style: solid;width:100%;">
	        <div style="text-align: center; border:medium; "><h1>Welcome To NIKI items codification</h1> </div>         
        </div>-->
                <div class="footer">
            <div class="inc">
                <h4> Copyrihgt © 2021 Algorithm Inc </h4>
            </div>
        </div>
		
</body>
</html>


