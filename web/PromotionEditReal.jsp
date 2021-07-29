<%--
    Document   : ItemValidationReal
    Created on : Jun 6, 2016, 2:58:43 AM
    Author     : vakaniwabo
--%>

<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
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

        <!-- <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <script src="assets/js/jquery.min.js"></script> -->
        <!--   <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->

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

                <div class="col-sm-8 text-left" >
                    <div class="page-header">
                        <h1 style="text-align: center; text-shadow: maroon;">Add Item</h1>
                    </div>         


                    <%
String item_commercial_name="";
String promo_name="";
                        //  ngezehe +=" \n ntandiye "+itemId;
                        int item_temp_id = Integer.parseInt(promo_code);

                        try {
                            Connection conn = ConnectionClass.getConnection();
                            Statement ST = conn.createStatement();
                            ResultSet rs = ST.executeQuery("SELECT * FROM niki_items"
                                    + " where niki_code='" + attachNiki + "'");
                            int i = 0;
                            while (rs.next()) {

                                  item_commercial_name = rs.getString("item_commercial_name");

                            }

                            if (promo_code != null && !promo_code.equals("")) {
                                ST = conn.createStatement();
                                rs = ST.executeQuery("SELECT * FROM niki_promotions"
                                        + " where promo_code=" + promo_code + "");
                                while (rs.next()) {

                                    promo_name = rs.getString("promo_name"); 
                                }

                                conn.close();

                            }

                        } catch (Exception e) {
                            e.printStackTrace();

                        }

                    %>

                    <%=item_commercial_name+" "+promo_name %>
                    <form name="validateItem" action="PromoEditValidateResponse.jsp" method="POST">


                        <table id="validateItem" width="700" >


                            <tr>
                                <td bgcolor="green">
                                    Qty 
                                </td>
                                <td>
<input type="text" name="niki_promotions_qte" value="1" size="15"/> 
<input type="text" name="niki_code" value="<%= attachNiki %>" hidden="true" size="1"/>
<input type="text" name="promo_code" value="<%= promo_code%>" hidden="true" size="1"/> 
                                </td> 
                            </tr> 
  
                            <tr>  <td bgcolor="green"> AMount   </td>
                                <td>  <input type="text" name="niki_promotions_amount" value="" required=false size="15" >
                                </td>  </tr>  
                            <tr>
 
                            <tr>  <td> Discount   </td>
                                <td>  <input type="text" name="niki_promotions_discount" 
                                             value="" required=true size="25" >
                                </td>  </tr>  
                            <tr>   <td> promotion type   </td>
                                <td> <select name="type" required="required">
                                        <option value="TAKE"> TAKE </option>  
                                        <option value="GET"> GET </option>  
                                    </select>
                                </td> 
                            </tr>
 
                            <tr>
                                <td>

                                </td>
                                <td>
                                    <input value="Validate" type="submit"/>
                                </td>

                            </tr>

                        </table>

                    </form>


                </div>

            </div>
        </div>


        <footer class="container-fluid text-center">
            <p><strong> Copyright &#169; 2016 Algorithm,Inc.</strong></p>
        </footer>

        <!-- <div id="confirm" class="modal hide fade">
        <div class="modal-dialog">
                                <div class="modal-content">
                                <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
                                        <h4 class="modal-title" id="myModalLabel">Validate Item</h4>
                                </div>
          <div class="modal-body">
            Are you sure?
          </div>
          <div class="modal-footer">
            <button type="button" data-dismiss="modal" class="btn btn-primary" id="delete">Delete</button>
            <button type="button" data-dismiss="modal" class="btn">Cancel</button>
          </div>
        </div>
        </div>
        </div> -->

        <div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&amp;times;</button>
                        <h4 class="modal-title" id="myModalLabel">Validate Item</h4>
                    </div>
                    <div class="modal-body">
                        <h3>waiting.....<%=ngezehe%></h3>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary">Save changes</button>
                    </div>
                </div>
            </div>
        </div>


    </body>
</html>
<%
    }
%>
