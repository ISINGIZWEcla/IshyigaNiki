<%--
    Document   : ItemValidationReal
    Created on : Jun 6, 2016, 2:58:43 AM
    Author     : vakaniwabo
--%>

<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    Object company_aff = session.getAttribute("userInSessionCompany");
    Object bussiness_category = session.getAttribute("bussiness_category");
    String ngezehe = " ndatangiye";
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%
} else if (!checkUserPrivileges.toString().contains("PROMOTION")) {
    session.setAttribute("errorLogin", "you don't have the right to validate");

%>
<jsp:forward page="Login.jsp"/>


<%    } else {
    String userLanguage = session.getAttribute("userInSessionLanguage").toString();

    String promo_code = request.getParameter("promo_code");
    String attachNiki = request.getParameter("attachNiki");
    String user = session.getAttribute("userInSessionfName").toString();
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Validate Item</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!--<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">--> 
        <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">

        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.min.js"></script>

        <script src="assets/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>-->
        <link rel="stylesheet" href="assets/css/respo.css">
        <link rel="stylesheet" href="assets/css/custom.css">

        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/css/bootstrap-select.min.css">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>

        <!-- (Optional) Latest compiled and minified JavaScript translation files -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/i18n/defaults-*.min.js"></script>

        <script>
            $(document).ready(function () {
                $('#example').DataTable();

                $('.modal').on('hidden.bs.modal', function (e)
                {
                    $(this).removeData();
                });


            });
        </script>

        <script type="text/javascript">
            $('button[name="remove_levels"]').on('click', function (e) {
                var $form = $(this).closest('form');
                e.preventDefault();
                $('#confirm').modal({backdrop: 'static', keyboard: false})
                        .one('click', '#delete', function () {
                            $form.trigger('submit'); // submit the form
                        });
                // .one() is NOT a typo of .on()
            });
        </script>

    </head>
    <body>
        <%
            double niki_promotions_qte = 0,niki_promotions_amount=0,niki_promotions_discount=0,niki_promotions_purchase=0;
            String niki_name="";
            try {
                Connection conn = ConnectionClass.getConnection();
                Statement ST = conn.createStatement();
                ResultSet rs;

                if (promo_code != null && !promo_code.equals("")) {
                    ST = conn.createStatement();
                    rs = ST.executeQuery("SELECT * FROM niki_promotions_list"
                            + " where promo_code=" + promo_code + " and niki_code='"+attachNiki+"'");
                    while (rs.next()) {

                        niki_promotions_purchase = rs.getDouble("niki_promotions_purchase");
                        niki_promotions_qte = rs.getDouble("niki_promotions_qte");
                        niki_promotions_amount = rs.getDouble("niki_promotions_amount");
                        niki_promotions_discount = rs.getDouble("niki_promotions_discount");
                    }
                    ST = conn.createStatement();
                    rs = ST.executeQuery("SELECT niki_code,item_commercial_name FROM niki.niki_items where niki_code='"+attachNiki+"'  order by  item_commercial_name");
                                                while (rs.next()) {
                                                     niki_name = rs.getString(2);
                                                }

                    conn.close();

                }

            } catch (Exception e) {
                e.printStackTrace();

            }
            

        %>

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
                        <!--<li><a href="categoriesPage.jsp">Categories</a></li>-->
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
                        <div class="col-sm-6 col-sm-offset-2">
                            PROMO LIST UPDATE <%=niki_name%>
                        </div>
                    </div>
                    <h3 style="color: green">${promo.getInsertMsg()}</h3>
                    <h4 style="color: red">${comp.error} </h4>
                    <div class="row">



                        <form class="form-horizontal" name="validateItem" action="PromoItemValidateResponse.jsp" method="POST">


                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="Name">Qty:</label>  
                                <div class="col-md-5">
                                    <input id="Name" name="niki_promotions_qte" value="<%= (int)(niki_promotions_qte)%>" type="number" placeholder="QTY" class="form-control input-md" required="">

                                    <input type="text" name="promo_code" value="<%= promo_code%>" hidden="true" size="1"/>
                                    <input type="text" name="niki_code" value="<%= attachNiki%>" hidden="true" size="1"/>
                                </div>
                            </div>
                                <!-- Text input-->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="Name">Purchase:</label>  
                                <div class="col-md-5">
                                    <input id="Name" name="niki_promotions_purchase" value="<%=niki_promotions_purchase%>" type="number" placeholder="Amount" class="form-control input-md" required="">

                                </div>
                            </div>
                            <!-- Text input-->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="Name">Prices:</label>  
                                <div class="col-md-5">
                                    <input id="Name" name="niki_promotions_amount" value="<%=niki_promotions_amount%>" type="number" placeholder="Amount" class="form-control input-md" required="">

                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-md-4 control-label" for="Name">Discount</label>  
                                <div class="col-md-5">
                                    <input id="Name" name="niki_promotions_discount" value="<%=niki_promotions_discount %>" type="number" placeholder="Amount" class="form-control input-md" required="">

                                </div>
                            </div>
                            <!-- Button -->
                            <div class="form-group">
                                <label class="col-md-4 control-label" for="submit"></label>
                                <div class="col-md-4">
                                    <input  type="submit" id="submit" name="submit" class="btn btn-success" value="Update ITEM">
                                </div>
                            </div>

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
