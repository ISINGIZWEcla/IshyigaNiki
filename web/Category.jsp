

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

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="niki.ConnectionClass" %>

<%    String user = session.getAttribute("userInSessionfName").toString();

    session.setAttribute("category", null);

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Category</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="assets/images/icon.png" />

        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
        <link href="assets/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">

        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.min.js"></script>

          <script src="https://cdn.datatables.net/buttons/2.0.1/js/dataTables.buttons.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js" ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js" ></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.html5.min.js" ></script>
        <script src="https://cdn.datatables.net/buttons/2.0.1/js/buttons.print.min.js" ></script>

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
                $('#example').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    'excel'
                ],
                exclude: 'ex',
                proccesing: true
            });
                $('.modal').on('hidden.bs.modal', function (e)
                {
                    $(this).removeData();
                });

            });
        </script>

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
                        <li><a href="categoriesPage.jsp">Categories</a></li>
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
                    <div class="version">
                        <div>Category Entry Form</div>
                    </div>
                    <h3>${cat.insertMsg}</h3>
                    <h4>${cat.error} </h4>

                    <div class="row">
                        <form class="form-horizontal" action="CategoryResponse.jsp" method="POST">
                            <fieldset>

                                <!-- Text input-->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">Category Name</label>  
                                    <div class="col-md-5">
                                        <input id="Name" name="ctn" type="text" size="35" placeholder="Category NAME" class="form-control input-md" required="">

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">Category Description</label>  
                                    <div class="col-md-5">
                                        <input id="Name" name="ctd" type="text" size="35" placeholder="Category Description" class="form-control input-md" required="">

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">French Description</label>  
                                    <div class="col-md-5">
                                        <input id="Name" name="french" type="text" size="35" placeholder="French Description" class="form-control input-md" required="">

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">Kinya Description</label>  
                                    <div class="col-md-5">
                                        <input id="Name" name="kinya" type="text" size="35" placeholder="Kinya Description" class="form-control input-md" required="">

                                    </div>
                                </div>
                                <!-- Select Basic -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="country">PARENT Category</label>
                                    <div class="col-md-5">
                                        <select  name="parent" class="form-control">
                                            <option value=""> SELECT PARENT CATEGORY</option>

                                            <option value=""></option>

                                            <%
                                                try {
                                                    //connection instance
                                                    Connection conn = ConnectionClass.getConnection();

                                                    PreparedStatement st = conn.prepareStatement("SELECT distinct(category_id) FROM niki.niki_categories order by  category_id");

                                                    ResultSet rs = st.executeQuery();

                                                    while (rs.next()) {
                                                        // Integer ip = rs.getInt("univId");
                                                        String category_id = rs.getString(1);


                                            %>

                                            <option value="<%=category_id%>"><%=category_id%></option>
                                            <%

                                                    }

                                                    conn.close();
                                                } catch (Exception e) {
                                                    out.print(e);
                                                }
                                            %>
                                        </select>  
                                    </div>
<!--                                    <div class="col-md-3">
                                        <a href="Business_Category.jsp?" target="_blank" class="glyphicon glyphicon-plus btn btn-primary">Add Business Category</a>
                                    </div>-->
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



            <div class="row">
                <div class="col-sm-10 col-sm-offset-1"> 
                    <div class="version">
                        <div>Categories List</div>
                    </div>
                    <h3>${cat.insertMsg}</h3>
                    <h4>${cat.error} </h4>

                    <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%" >
                        <thead> 
                            <tr>
                                <th> Category Name</th>               
                                <th> Category Desc</th>                           
                                <th> Parent</th>               
                                <th> French</th>   
                                <th> Kinya</th>   
                                <th> Status </th> 
                                <th> Edit </th>
                                <th> Sleep </th>
                            </tr>

                        </thead>
                        <tfoot>
                            <tr>

                                <th> Category Name</th>               
                                <th> Category Desc</th> 
                                <th> Parent</th>               
                                <th> French</th>   
                                <th> Kinya</th>  
                                <th> Status </th>
                                <th> Edit </th>
                                <th> Sleep </th>


                            </tr>
                        </tfoot>
                        <tbody>
                            <%
                                try {

                                    Connection con = ConnectionClass.getConnection();
                                    Statement ST = con.createStatement();
                                    ResultSet rs = ST.executeQuery("SELECT * FROM niki_categories");
                                    int i = 0;
                                    while (rs.next()) {

                                        String bb = rs.getString(1);
                                        String cc = rs.getString(2);
                                        String dd = rs.getString(3);
                                        String vv = rs.getString(4);
                                        String kk = rs.getString(5);
                                        String oo = rs.getString(6);


                            %>  
                            <tr> 

                                <td><%=bb%>  </td>
                                <td> <%= cc%></td>
                                <td> <%=dd%></td>
                                <td><%=vv%>  </td>
                                <td> <%= kk%></td>
                                <td> <%=oo%></td>
                                <td> <a href="CategoryUpdate.jsp?catEdit=<%=bb%>&catDesc=<%=cc%>&action=update"> Edit </a></td>
                                <td> <a href="CategoryResponse.jsp?catRejectSleep=<%=bb%>&action=catSleep">Sleep </a></td>


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
            <p style="color: white"><strong> Copyright &#169; 2021 Algorithm,Inc.  </strong></p>
        </footer>


    </body>
</html>
<%
    }
%>