

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

<jsp:useBean id="it_tmp" scope="request" class="niki.Item_Temp"/>  

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>

<%    String user = session.getAttribute("userInSessionfName").toString();
    boolean ndimuritransformation = false;
    String item_cat = request.getParameter("item_cat");

    if (item_cat != null && !item_cat.equals("")) {
        ndimuritransformation = false;
    }

    String codeb = request.getParameter("cdb");
    String itmDesc = request.getParameter("itmd");
    String itmcatN = request.getParameter("itcat");
    String fabricant = request.getParameter("fabricant");
    String username = session.getAttribute("userInSessionUsername").toString().toUpperCase();
    String itemDescr = request.getParameter("itemDesc");

    String searchingfor = "";
    boolean searchON = false;
    String sqlToAdd = "";
    if (codeb != null && !codeb.equals("")) {
        searchingfor += "Code:" + codeb;
        searchON = true;

        codeb = codeb.toUpperCase().replaceAll("'", " ");
        sqlToAdd += " (hs_code LIKE '%" + codeb + "%' OR bar_code LIKE '%" + codeb + "%' ) ";
    }
    if (itmDesc != null && !itmDesc.equals("") && !itmDesc.equals("null")) {
        searchingfor += ", desc: " + itmDesc;
        String and = "";
        if (searchON) {
            and = " AND ";
        }
        itmDesc = itmDesc.toUpperCase().replaceAll("'", " ");
        sqlToAdd += and + " (item_commercial_name LIKE '%" + itmDesc + "%' "
                + "OR item_inn LIKE '%" + itmDesc + "%' "
                + "OR item_key_words LIKE '%" + itmDesc + "%' ) ";
        searchON = true;
    }
    if (itmcatN != null && !itmcatN.equals("")) {
        searchingfor += "," + itmcatN;
        String and = "";
        if (searchON) {
            and = " AND ";
        }

        sqlToAdd += and + " (category_id = '" + itmcatN + "') ";
        searchON = true;
    }
    if (fabricant != null && !fabricant.equals("")) {
        searchingfor += "," + fabricant;
        String and = "";
        if (searchON) {
            and = " AND ";
        }

        sqlToAdd += and + " (item_fabricant = '" + fabricant + "') ";
        searchON = true;
    }

    if (searchON) {
        sqlToAdd = " WHERE " + sqlToAdd;
    }
    if (ndimuritransformation) {
        searchingfor += " Transforming : " + 0 + " | " + itemDescr;
    }


%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Niki items Page   </title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
        <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
        <link rel="shortcut icon" href="http://urugendo.com/assets/img/icon.png" />	 
        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.min.js"></script>

        <script src="assets/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap.min.js"></script>

        <script src="https://cdn.datatables.net/buttons/2.0.1/js/dataTables.buttons.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js" ></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.html5.min.js" ></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.print.min.js" ></script>

        <script>
            $(document).ready(function () {
                $('#item-info').DataTable({
                    dom: 'Bfrtip',
                    buttons: [
                        'csv', 'excel', 'pdf'
                    ],
                    exclude: 'ex',
                    proccesing: true
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
                        <li><a href="temporariesPage.jsp">Temporaries</a></li>
                        <li><a href="ItemLookup.jsp">Add Item</a>
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
                        <h1 style="text-align: center; text-shadow: maroon;">
                            Item for <%=item_cat%> super search </h1>
                    </div>         

                    <h3>${it_tmp.insertMsg}</h3>
                    <h4>${it_tmp.error} </h4>



                    <form name="inputItem" action="Item.jsp" method="POST">


                        <table id="inputItem" >

                            <tr>
                                <%
                                    if (session.getAttribute("ItemSearched") != null) {
                                        String description = session.getAttribute("ItemSearched").toString();
                                        it_tmp.setItemDescription(description);
                                    }
                                %>
                                <td bgcolor="pink">
                                    descr,molecular,key word
                                </td>
                                <td>
                                    <input type="text" name="itmd" value="${it_tmp.itemDescription}"  size="35" onchange="upperMe()" >
                                </td>
                                <td>
                                    manufacture: 
                                </td>
                                <td>
                                    <select  name="fabricant">
                                        <option value=""></option> 
                                        <%
                                            try {
                                                //connection instance
                                                Connection conn = ConnectionClass.getConnection();
                                                PreparedStatement st = conn.prepareStatement("Select fabricant_id,niki_fabricant_name from niki_fabricant order by niki_fabricant_name");
                                                ResultSet rs = st.executeQuery();
                                                while (rs.next()) {
                                                    // Integer ip = rs.getInt("univId");
                                                    String catId = rs.getString("fabricant_id");
                                                    String catNme = rs.getString("niki_fabricant_name");
                                        %>

                                        <option value="<%=catId%>"><%=catNme%></option>
                                        <%  }

                                                conn.close();
                                            } catch (Exception e) {
                                                out.print(e);
                                            }
                                        %>
                                    </select><br/>
                                </td> 
                            </tr>


                            <br>

                            <tr>
                                <td>
                                    barcode,HS code 
                                </td>
                                <td>
                                    <input type="text" name="cdb" value="${it_tmp.codebar}" size="35"/> 

                                </td>
                                <td>
                                    category: 
                                </td>
                                <td>
                                    <select  name="itcat">
                                        <option value=""></option>

                                        <%
                                            try {
                                                //connection instance
                                                Connection conn = ConnectionClass.getConnection();

                                                PreparedStatement st = conn.prepareStatement("Select category_id,category_descr from niki_categories where status='LIVE'");

                                                ResultSet rs = st.executeQuery();

                                                while (rs.next()) {
                                                    // Integer ip = rs.getInt("univId");
                                                    String subcatId = rs.getString("category_id");
                                                    String subcatNme = rs.getString("category_descr");


                                        %>

                                        <option value="<%=subcatId%>"><%=subcatNme%></option>
                                        <%

                                                }
                                                conn.close();

                                            } catch (Exception e) {
                                                out.print(e);
                                            }
                                        %>
                                    </select><br/>
                                </td>

                            </tr>

                            <tr> <td>  </td>
                                <td  bgcolor="green">  <input value="SEARCH" type="submit"/>
                                </td>  </tr> 
                        </table>

                    </form> 


                    <div id="w">
                        <h3 style="background-color:buttonface">NIKI Items List  <%=searchingfor%>
                            <% if (ndimuritransformation) {%>
                            <%  } %>         
                        </h3>


                        <table id="item-info" class="table table-striped table-bordered" cellspacing="0" width="100%"  >
                            <thead> 
                                <tr>
                                    <th> Niki code </th>
                                    <th width="30%"> Item_Commercial_Description</th>               
                                    <th> Molecular </th>
                                    <th> Packet </th>
                                    <th> Category </th>
                                    <th> Manufacture </th> 
                                    <th> Tax-rate </th>

                                    <% if (!ndimuritransformation) { %>
                                    <th> creator </th> 
                                    <th> Edit </th> 
                                        <% } else { %>
                                    <th> INN </th>
                                    <th> EXIST </th>
                                        <% } %>
                                </tr>

                            </thead>

                            <tbody>
                                <%
                                    String sqll = "SELECT * FROM niki_items,niki_item_business_category " + sqlToAdd
                                            + " WHERE busin_category_id='" + item_cat + "' and niki_items.niki_code=niki_item_business_category.niki_code  ";
                                    try {

                                        Connection con = ConnectionClass.getConnection();
                                        Statement ST = con.createStatement();
                                        ResultSet rs = ST.executeQuery(sqll);
                                        int i = 0;
                                        while (rs.next()) {

                                            String niki_code = rs.getString(1);
                                            String item_commercial_name = rs.getString("item_commercial_name");
                                            String tax_vat = rs.getString("tax_vat");
                                            String status = rs.getString("status");
                                            String item_fabricant = rs.getString("item_fabricant");
                                            String item_inn = rs.getString("item_inn");
                                            double item_packet = rs.getDouble("item_packet");
                                            String item_key_words = rs.getString("item_key_words");
                                            String created = rs.getString("global_id");
                                            String category_id = rs.getString("category_id");

                                %>  
                                <tr>   

                                    <td><%=niki_code%>  </td>
                                    <td width="30%" > <%= item_commercial_name%></td>
                                    <td> <%= item_inn%></td>
                                    <td> <%= item_packet%></td>
                                    <td> <%= category_id%></td>
                                    <td> <%= item_fabricant%></td>
                                    <td> <%= tax_vat%></td> 
                                    <% if (!ndimuritransformation && ndemerewe) {%>
                                    <td> <%=created%></td>  
                                    <td> <a href="ItemUpdate.jsp?action=update&nikicode=<%=niki_code%>" class="btn btn-primary enable " data-toggle="modal" data-target="#basicModal" > EDIT </a></td>
                                    <% } else if (!ndimuritransformation) {%>
                                    <td> <%=created%></td>  
                                    <td> <a href="ItemUpdate.jsp?action=update&nikicode=<%=niki_code%>" > EDIT </a></td>

                                    <% } else { %>
                                    <td>  </td>
                                    <% } %>

                                </tr>

                                <%
                                            i++;
                                        }

                                        con.close();

                                    } catch (Exception e) {
                                        e.printStackTrace();

                                    }
                                %>
                            </tbody>  
                        </table>

                    </div>


                </div>

            </div>
        </div>


        <footer class="container-fluid text-center">
            <p><strong> Copyright &#169; 2016 Algorithm,Inc.  </strong></p>
        </footer>



    </body>
</html>
<%
    }
%>
