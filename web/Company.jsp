<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%
} else if (!checkUserPrivileges.toString().contains("VALIDATE")) {
    session.setAttribute("errorLogin", "you don't have the right to validate");

%>
<jsp:forward page="Login.jsp"/>


<%    } else {
    String userLanguage = session.getAttribute("userInSessionLanguage").toString();
    String user_type = session.getAttribute("userInSessionType").toString();
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>

<%    session.setAttribute("company", null);
    String user = session.getAttribute("userInSessionfName").toString();

    String from = request.getParameter("origin");
    session.setAttribute("fromChooseCompany", from);

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Company</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <script src="assets/js/jquery.min.js"></script> -->
        <!--   <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->

        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
        <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">

        <script src="assets/js/jquery-1.12.3.js"></script>
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

    </head>
    <body>
        <nav class="navbar nav-niki">
            <div class="container-fluid links">
                <div class="navbar-header">
                    <a class="navbar-brand" href="niki.jsp"><img src="assets/NIKI.png" alt="" width="70"></a>
                </div>
                <ul class="nav navbar-nav">
                    <li class="active"><a href="niki.jsp">Home</a></li>
                    <li><a href="Item.jsp">Niki List</a></li>
                    <li><a href="temporariesPage.jsp">Temporaries</a></li>
                    <li><a href="ItemLookup.jsp">Add Item</a>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a> <span class="glyphicon glyphicon-user"></span> <%=user%></a></li> 
                    <li><a  href="Logout.jsp">
                            <span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>

                </ul>
            </div>
        </nav>

        <div class="container" style="min-height: 80vh ">
            <%
                if (user_type.contains("ISHYIGA_ADMIN")) {
            %>
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2"> 
                    <div class="version">
                        <div>Company Entry Form</div>
                    </div>
                    <h3 style="color: green">${comp.insertMsg}</h3>
                    <h4 style="color: red">${comp.error} </h4>

                    <div class="row">
                        <form class="form-horizontal" action="CompanyResponse.jsp" method="POST">
                            <fieldset>

                                <!-- Text input-->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">Company NAME</label>  
                                    <div class="col-md-5">
                                        <input id="Name" name="compDesc" type="text" size="35" placeholder="Company NAME" class="form-control input-md" required="">

                                    </div>
                                </div>


                                <!-- Select Basic -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="country">Business Category</label>
                                    <div class="col-md-5">
                                        <select  name="bus_ctn" class="form-control">
                                            <option value=""> SELECT BUSINESS CATEGORY</option>

                                            <%
                                                try {
                                                    //connection instance
                                                    Connection conn = ConnectionClass.getConnection();

                                                    PreparedStatement st = conn.prepareStatement("SELECT busin_category_id,busin_category_descr FROM niki.niki_business_categories order by  busin_category_descr");

                                                    ResultSet rs = st.executeQuery();

                                                    while (rs.next()) {
                                                        // Integer ip = rs.getInt("univId");
                                                        String busin_category_id = rs.getString(1);
                                                        String busin_category_descr = rs.getString(2);

                                            %>

                                            <option value="<%=busin_category_id%>"><%=busin_category_descr%></option>
                                            <%

                                                    }

                                                } catch (Exception e) {
                                                    out.print(e);
                                                }
                                            %>
                                        </select>  
                                    </div>
                                    <div class="col-md-3">
                                        <a href="Business_Category.jsp?" target="_blank" class="glyphicon glyphicon-plus btn btn-primary">Add Business Category</a>
                                    </div>
                                </div>
                                <!-- Button -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="submit"></label>
                                    <div class="col-md-4">
                                        <input  type="submit" id="submit" name="submit" class="btn btn-success" value="SAVE">
                                    </div>
                                </div>

                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
            <%
                                                }%>


            <div class="row">
                <div class="col-sm-12 col-sm-offset-0"> 
                    <div class="version">
                        <div>Companies List</div>
                    </div>

                    <table id="example" class="table table-responsive table-bordered" cellspacing="0" width="100%" >
                        <thead> 
                            <tr>
                                <th> Company Id</th>               
                                <th> Company Desc</th>   
                                <th> Status </th>
                                <th> Busin_Category </th>
                                <th> Total Items </th>
                                <th> Temporaires </th>

                                <th> on NiKi </th>
                                <th> Edit </th>
                                <th> Sleep </th>


                            </tr>

                        </thead>

                        <tbody>
                            <%
                                try {

                                    Connection con = ConnectionClass.getConnection();
                                    Statement ST = con.createStatement();
                                    ResultSet rs = ST.executeQuery("SELECT * FROM niki_companies");
                                    int i = 0;
                                    while (rs.next()) {
                                        String bb = rs.getString(1);
                                        String cc = rs.getString(2);
                                        String dd = rs.getString(3);
                                        String ee = rs.getString(4);
                            %>  
                            <tr> 

                                <td><%=bb%>  </td>
                                <td> <%= cc%></td>
                                <td> <%=dd%></td>
                                <td> <%=ee%></td>
                                <%

                                    String sqltotal = "SELECT COUNT(item_external_id) FROM niki.niki_items_temp where company_id='" + bb + "'";

                                    PreparedStatement stto = con.prepareStatement(sqltotal);

                                    ResultSet rsot = stto.executeQuery();
                                    int countto = 0;
                                    while (rsot.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        countto = rsot.getInt(1);

                                %>
                                <td> <%=countto%></td> 
                                <%

                                    }
                                %>

                                <%
                                    String sqll = "SELECT COUNT(item_external_id) FROM niki.niki_items_temp where company_id='" + bb + "' and status ='PENDING'";

                                    PreparedStatement st = con.prepareStatement(sqll);

                                    ResultSet rso = st.executeQuery();
                                    int count = 0;
                                    while (rso.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        count = rso.getInt(1);

                                %>
                                <td> <%=count%></td> 
                                <%

                                    }
                                %>

                                <%
                                    String sqlll = "SELECT COUNT(item_external_id) FROM niki.niki_items_temp where company_id='" + bb + "' and status !='PENDING'";

                                    PreparedStatement sto = con.prepareStatement(sqlll);

                                    rso = sto.executeQuery();
                                    int countV = 0;
                                    while (rso.next()) {
                                        // Integer ip = rs.getInt("univId");
                                        countV = rso.getInt(1);

                                %>
                                <td> <%=countV%></td> 
                                <%

                                    }
                                %>
                                 <td> <a class="btn btn-info" href="CompanyUpdate.jsp?compEdit=<%=bb%>&compName=<%=cc%>&action=update"> Edit </a></td>
                                <td> <a class="btn btn-warning" href="CompanyResponse.jsp?compRejectSleep=<%=bb%>&action=compSleep">Sleep </a></td>

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

        <footer style="background-color: #405a63; " class="container-fluid text-center">
            <p style="color: white"><strong> Copyright &#169; 2016 Algorithm,Inc.  </strong></p>
        </footer>


    </body>
</html>
<%
    }
%>
