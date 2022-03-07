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
<%@page import="niki.ItemFormeDose" %>

<%
} else if (!checkUserPrivileges.toString().contains("VALIDATE")) {
    session.setAttribute("errorLogin", "you don't have the right to validate");

%>
<jsp:forward page="Login.jsp"/>


<%    } else {
    String userLanguage = session.getAttribute("userInSessionLanguage").toString();

    String nikicode = request.getParameter("nikicode");

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>

<%    session.setAttribute("niki", null);
    String user = session.getAttribute("userInSessionfName").toString();

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Update Item</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">


        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
        <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">

        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.min.js"></script>

        <script src="assets/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.5.3/js/bootstrapValidator.js" type="text/javascript"></script>
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
            $(document).ready(function () {
                $('#validateItem').bootstrapValidator({
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        hs_code: {
                            validators: {
                                integer: {
                                    message: 'The value is not an integer'
                                }
                            }
                        },
                        item_dosage: {
                            validators: {
                                numeric: {
                                    message: ' Only numbers are allowed please'
                                }
                            }
                        },
                        item_packet: {
                            validators: {
                               numeric: {
                                    message: ' Only numbers are allowed please'
                                }
                            }
                        },
                        item_poids_gr: {
                            validators: {
                                integer: {
                                    message: 'The value is not an integer'
                                }
                            }
                        },
                        item_longeur_mm: {
                            validators: {
                                numeric: {
                                    message: ' Only numbers are allowed please'
                                }
                            }
                        },
                        item_largeur_mm: {
                            validators: {
                                numeric: {
                                    message: ' Only numbers are allowed please'
                                }
                            }
                        },
                        item_hauteur_mm: {
                            validators: {
                                numeric: {
                                    message: ' Only numbers are allowed please'
                                }
                            }
                        }

                    }
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
                        <li class="active"><a href="niki.jsp">Home</a></li>
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



                <%
                    String status = "";
                    String tax_duty = "";
                    String tax_excise = "";
                    String item_dosage_unity = "";
                    String item_commercial_name = "";
                    String item_inn = "";
                    String category_id = "";
                    String tax_vat = "";
                    String item_fabricant = "";
                    double item_packet = 1;
                    int item_longeur_mm = 0;
                    int item_largeur_mm = 0;
                    int item_hauteur_mm = 0;
                    double item_poids_gr = 0;
                    double item_dosage = 0;
                    String shipment_type = "";
                    String item_key_words = "";
                    String hs_code = "";
                    String gtin_code = "";
                    String bar_code = "";
                    String global_id = "";
                    String bus_category_id = "";
                    String bus_categName = "";
                    String categName = "";
                    String lesBus = "";
                    String item_emballage = "";
                    String item_form = "";

                    try {
                        Connection conn = ConnectionClass.getConnection();

                        if (nikicode != null && !nikicode.equals("")) {
                            Statement ST = conn.createStatement();
                            ResultSet rs = ST.executeQuery("SELECT * FROM niki_items"
                                    + " where niki_code='" + nikicode + "'");
                            while (rs.next()) {
                                item_key_words = rs.getString("item_key_words");
                                item_inn = rs.getString("item_inn");
                                category_id = rs.getString("category_id");
                                item_fabricant = rs.getString("item_fabricant");
                                tax_vat = rs.getString("tax_vat");
                                hs_code = rs.getString("hs_code");
                                item_emballage = rs.getString("item_emballage");
                                item_form = rs.getString("item_form");
                                shipment_type = rs.getString("shipment_type");
                                status = rs.getString("status");
                                tax_duty = rs.getString("tax_duty");
                                tax_excise = rs.getString("tax_excise");
                                item_dosage_unity = rs.getString("item_dosage_unity");
                                item_commercial_name = rs.getString("item_commercial_name");

                                item_packet = rs.getDouble("item_packet");
                                item_longeur_mm = rs.getInt("item_longeur_mm");
                                item_largeur_mm = rs.getInt("item_largeur_mm");
                                item_hauteur_mm = rs.getInt("item_hauteur_mm");
                                item_poids_gr = rs.getDouble("item_poids_gr");
                                item_dosage = rs.getDouble("item_dosage");
                                bar_code = rs.getString("bar_code");
                            }

                            rs = ST.executeQuery("SELECT * FROM niki_item_business_category"
                                    + " where niki_code='" + nikicode + "'");
                            while (rs.next()) {
                                lesBus += " " + rs.getString("busin_category_id");
                            }

                            conn.close();

                        }

                    } catch (Exception e) {
                        e.printStackTrace();

                    }

                %>

                <div class="col-sm-8 text-left" >
                    <div class="page-header">
                        <h1 style=" text-align: center;background-color:orange;color: white ">UPDATE ITEM <%=item_commercial_name%></h1>
                    </div>         



                    <h3>${itf.insertMsg}</h3>
                    <h4>${itf.error} </h4>
                    <h3>${subcat.insertMsg}</h3>
                    <h4>${subcat.error} </h4>
                    <h3>${busin_cat.insertMsg}</h3>
                    <h4>${busin_cat.error} </h4>


                    <form  "name="validateItem" id="validateItem" action="ItemUpdateResponse.jsp" method="POST">

                        <div class="container">

                            <div class="row">

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div id="texts" class="content" style=" font-weight: bold ">codebar</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"> <input type="text" name="bar_code" value="<%=bar_code%>" size="15"/> 
                                                <input type="text" name="gtin_code" value="" hidden="true" size="1"/>
                                                <input type="text" name="niki_code" value="<%=nikicode%>" hidden="true" size="1"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>      
                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content with-margin" style=" font-weight: bold ">item hs code </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><input type="text" name="hs_code" value="<%=hs_code%>" size="15"/>
                                                <a href="Hs_Code.jsp?" class="glyphicon glyphicon-plus btn btn-primary">View HSs</a></div>
                                        </div>
                                    </div>
                                </div></div>

                            <div class="row">

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content" style=" font-weight: bold ">item description :</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><input type="text" name="item_commercial_name"
                                                                        value="<%=item_commercial_name%>" required=true size="40" > 
                                            </div>
                                        </div>
                                    </div>
                                </div>  
                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content with-margin" style=" font-weight: bold ">item molecular  </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><input type="text" name="item_inn" 
                                                                        value="<%=item_inn%>" required=true size="40" ></div>
                                        </div>
                                    </div>
                                </div> </div>  
                            <div class="row">

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content" style=" font-weight: bold ">item key word  :</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"> <input type="text" name="item_key_words" value="<%=item_key_words%>" required=true size="40" > 
                                            </div>
                                        </div>
                                    </div>
                                </div>  
                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content with-margin" style=" font-weight: bold ">item form   </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><select name="item_form" required="required">
                                                    <% try {
                                                            Connection conn = ConnectionClass.getConnection();
                                                            PreparedStatement st = conn.prepareStatement(
                                                                    "SELECT niki_form_id,niki_form_name FROM niki.niki_form order by niki_form_name");
                                                            ResultSet rs = st.executeQuery();
                                                            while (rs.next()) {
                                                                String niki_form_id = rs.getString("niki_form_id");
                                                                String niki_form_name = rs.getString("niki_form_name");
                                                    if (niki_form_id.equals(item_form)) {%>
                                                    <option value="<%=niki_form_id%>" selected><%=niki_form_name%> </option> <% } else {%>
                                                    <option value="<%=niki_form_id%>"><%=niki_form_name%> </option> <% }
                                                            }
                                                            conn.close();
                                                        } catch (Exception e) {
                                                            out.print(e);
                                                        }%>  </select>
                                                <a href="Form.jsp?" class="glyphicon glyphicon-plus btn btn-primary">Add Form</a></div>
                                        </div>
                                    </div>
                                </div></div> 

                            <div class="row">

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content" style=" font-weight: bold ">item dose </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><input type="text" name="item_dosage" value="<%=item_dosage%>" required=true size="15" ></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content with-margin" style=" font-weight: bold ">item dose unity </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"> <select name="item_dosage_unity" required="required">
                                                    <% try {
                                                            Connection conn = ConnectionClass.getConnection();
                                                            PreparedStatement st = conn.prepareStatement(
                                                                    "SELECT niki_dose_unity_id,niki_dose_unity_name FROM niki.niki_dose_unity order by niki_dose_unity_name");
                                                            ResultSet rs = st.executeQuery();
                                                            while (rs.next()) {
                                                                String niki_form_id = rs.getString("niki_dose_unity_id");
                                                                String niki_form_name = rs.getString("niki_dose_unity_name");
                                                                if (niki_form_id.equals(item_dosage_unity)) {%>
                                                    <option value="<%=niki_form_id%>" selected><%=niki_form_name%> </option> <% } else {%>
                                                    <option value="<%=niki_form_id%>"><%=niki_form_name%> </option> <% }
                                                            }
                                                            conn.close();
                                                        } catch (Exception e) {
                                                            out.print(e);
                                                        }%>  </select>
                                                <a href="Dosage_unity.jsp?" class="glyphicon glyphicon-plus btn btn-primary">Add Dosage Unity</a></div>
                                        </div>
                                    </div>
                                </div></div>

                            <div class="row">

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content" style=" font-weight: bold ">item package</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><select name="item_emballage" required="required">
                                                    <% try {
                                                            Connection conn = ConnectionClass.getConnection();
                                                            PreparedStatement st = conn.prepareStatement(
                                                                    "SELECT niki_emballage_id,niki_emballage_name FROM niki.niki_emballage order by niki_emballage_name");
                                                            ResultSet rs = st.executeQuery();
                                                            while (rs.next()) {
                                                                String niki_emballage_id = rs.getString("niki_emballage_id");
                                                                String niki_emballage_name = rs.getString("niki_emballage_name");
                                                                if (niki_emballage_id.equals(item_emballage)) {%>
                                                    <option value="<%=niki_emballage_id%>" selected><%=niki_emballage_name%> </option> <% } else {
                                                    %>
                                                    <option value="<%=niki_emballage_id%>"><%=niki_emballage_name%> </option> <%}
                                                            }
                                                            conn.close();
                                                        } catch (Exception e) {
                                                            out.print(e);
                                                        }%>  </select>  <a href="Emballage.jsp?" class="glyphicon glyphicon-plus btn btn-primary">Add Package</a></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content with-margin" style=" font-weight: bold ">item packet</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><input type="text" name="item_packet" value="<%=item_packet%>"
                                                                        required=true size="10" ></div>
                                        </div>
                                    </div>
                                </div></div>
                            <div class="row">

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content" style=" font-weight: bold ">length MM </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><input type="text" name="item_longeur_mm" value="<%=item_longeur_mm%>"
                                                                        required=true size="10" ></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content with-margin" style=" font-weight: bold ">width MM</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><input type="text" name="item_largeur_mm" value="<%=item_largeur_mm%>"
                                                                        required=true size="10" ></div>
                                        </div>
                                    </div>
                                </div></div>

                            <div class="row">

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content" style=" font-weight: bold ">height MM </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><input type="text" name="item_hauteur_mm" value="<%=item_hauteur_mm%>"
                                                                        required=true size="10" ></div></div>
                                    </div>
                                </div>


                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content with-margin"style=" font-weight: bold ">item poids GR  </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><input type="text" name="item_poids_gr" value="<%=item_poids_gr%>" required=true size="15" ></div>
                                        </div>
                                    </div>
                                </div></div>
                            <div class="row">

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content" style=" font-weight: bold ">shipment type</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><select class="selectpicker" data-live-search="true" name="shipment_type" required="required">
                                                    <option value="NORMAL"> NORMAL </option>  
                                                    <option value="COOL"> COOL </option> 
                                                    <option value="FRIGO"> FRIGO </option> 
                                                    <option value="HOT"> HOT </option>  
                                                </select></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content with-margin" style=" font-weight: bold ">Item category:</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><select  name="category_id" required="required">
                                                    <option value="<%=category_id%>"><%=categName%></option>

                                                    <%
                                                        String orig = "yesValidate";
                                                        try {

                                                            //connection instance
                                                            Connection conn = ConnectionClass.getConnection();

                                                            PreparedStatement st = conn.prepareStatement(
                                                                    "Select category_id,category_descr from niki_categories where status='LIVE' ");

                                                            ResultSet rs = st.executeQuery();

                                                            while (rs.next()) {
                                                                // Integer ip = rs.getInt("univId");
                                                                String subcatId = rs.getString("category_id");
                                                                String subcatNme = rs.getString("category_id");

                                                if (subcatId.equals(category_id)) {%>
                                                    <option value="<%=subcatId%>" selected><%=subcatNme%> </option> <% } else {
                                                    %>

                                                    <option value="<%=subcatId%>"><%=subcatNme%></option>
                                                    <%
                                                                }
                                                            }

                                                            conn.close();
                                                        } catch (Exception e) {
                                                            out.print(e);
                                                        }
                                                    %>
                                                </select> <a href="Category.jsp?origin=<%=orig%>" class="glyphicon glyphicon-plus btn btn-primary">Add Category</a> </div>
                                        </div>
                                    </div>
                                </div></div>
                            <div class="row">

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content" style=" font-weight: bold ">TaxRate:</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><select name="tax_vat" required="required">
                                                    <option value=""> </option>  <% try {
                                                            Connection conn = ConnectionClass.getConnection();
                                                            PreparedStatement st = conn.prepareStatement("Select taxLabel,taxValue from niki_tax_rates ");
                                                            ResultSet rs = st.executeQuery();
                                                            while (rs.next()) {
                                                                String taxL = rs.getString("taxLabel");
                                                                String taxV = rs.getString("taxValue");
                                                    if (tax_vat.equals(taxL)) {%>
                                                    <option value="<%=taxL%>" selected><%=taxV%> (<%=taxL%>) </option> <% } else {
                                                    %>
                                                    <option value="<%=taxL%>"><%=taxV%> (<%=taxL%>)</option> <% }
                                                            }
                                                            conn.close();
                                                        } catch (Exception e) {
                                                            out.print(e);
                                                        }%>  </select></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content with-margin" style=" font-weight: bold ">item fabricant</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><select name="item_fabricant" required="required">
                                                    <option value=""> </option>  <% try {
                                                            Connection conn = ConnectionClass.getConnection();
                                                            PreparedStatement st = conn.prepareStatement(
                                                                    "SELECT fabricant_id,niki_fabricant_name FROM niki.niki_fabricant ORDER BY niki_fabricant_name");
                                                            ResultSet rs = st.executeQuery();
                                                            while (rs.next()) {
                                                                String fabricant_id2 = rs.getString("fabricant_id");
                                                                String niki_fabricant_name = rs.getString("niki_fabricant_name");
                                                                if (item_fabricant.equals(fabricant_id2)) {%>
                                                    <option value="<%=fabricant_id2%>" selected><%=niki_fabricant_name%> </option> <% } else {
                                                    %>
                                                    <option value="<%=fabricant_id2%>"><%=niki_fabricant_name%> </option> <% }
                                                            }
                                                            conn.close();
                                                        } catch (Exception e) {
                                                            out.print(e);
                                                        }%>  </select> <a href="Manufacture.jsp?" class="glyphicon glyphicon-plus btn btn-primary">Add Manufacture</a></div>
                                        </div>
                                    </div>
                                </div></div>
                            <div class="row">

                                <div class="col-sm-4">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content" style=" font-weight: bold ">Business category:</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="content"><select class="selectpicker" data-live-search="true" name="bus_category_id"  required="required">
                                                    <option value="<%=bus_category_id%>"><%=bus_categName%></option>

                                                    <%

                                                        try {

                                                            //connection instance
                                                            Connection conn = ConnectionClass.getConnection();

                                                            PreparedStatement st = conn.prepareStatement("Select busin_category_id,busin_category_descr from niki_business_categories where status='LIVE' order by busin_category_descr");

                                                            ResultSet rs = st.executeQuery();

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
                                                </select><a href="Business_Category.jsp?origin=<%=orig%>" class="glyphicon glyphicon-plus btn btn-primary" >Add Bus_Category</a></div>
                                        </div>
                                    </div>
                                </div></div>



                                   
                
                
<button type="submit" class="btn btn-secondary btn-lg btn-block">UPDATE</button>

                            
                           

                        </div>
                    </form>



                </div>

                <div class="col-sm-4 text-left" >
                    <div class="page-header">
                        <h4 style="text-align: center; text-shadow: maroon;"><%=item_commercial_name%> IMAGE</h1>
                    </div>
                    <%
                        String imgg = "assets/NIKI_IMAGE/" + nikicode + ".jpg";
                    %>
                    <img src="<%=imgg%>" alt="NIKI IMAGE" class="img-fluid" style="height: 60vh" /> 
                </div>
            </div>
        </div>


        <footer class="container-fluid text-center">
            <p><strong> Copyright &#169; 2021 Algorithm Inc.</strong></p>
        </footer>


    </body>
</html>
<%
    }
%>
