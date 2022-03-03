

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
                        <div>Promotions Entry Form</div>
                    </div>
                    <h3 style="color: green">${promo.getInsertMsg()}</h3>
                    <h4 style="color: red">${comp.error} </h4>

                    <div class="row">
                        <form class="form-horizontal" action="PromotionsResponse.jsp" method="POST">
                            <fieldset>

                                <!-- Text input-->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">promo name:</label>  
                                    <div class="col-md-5">
                                        <input id="Name" name="promo_name" type="text" size="35" placeholder="Promo NAME" class="form-control input-md" required="">

                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">start time:</label>  
                                    <div class="col-md-5">
                                        <input id="Name" name="start" type="datetime-local"  class="form-control input-md" required="">

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">End time:</label>  
                                    <div class="col-md-5">
                                        <input id="Name" name="end" type="datetime-local" size="35" class="form-control input-md" required="">

                                    </div>
                                </div>

                                <!-- Select Basic -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="country">business granted</label>
                                    <div class="col-md-5">
                                        <select  name="bus_cat_id"   required="required" class="form-control">
                                            <option value=""> SELECT BUSINESS CATEGORY</option>

                                            <%
                                                try {
                                                    //connection instance
                                                    Connection conn = ConnectionClass.getConnection();

                                                    PreparedStatement st = conn.prepareStatement("SELECT busin_category_id,busin_category_descr FROM niki.niki_business_categories where status='LIVE' order by  busin_category_descr");

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
                                        <a href="Business_Category.jsp?" class="glyphicon glyphicon-plus btn btn-primary" >Add Bus_Category</a>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">Maximum Budget:</label>  
                                    <div class="col-md-5">
                                        <input id="Name" name="maximum_budget" type="number" value="10000" class="form-control input-md" required="">

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="Name">Maximum Quantity:</label>  
                                    <div class="col-md-5">
                                        <input id="Name" name="maximum_qty" type="number" value="99990" placeholder="Maximum Qty" class="form-control input-md" required="">

                                    </div>
                                </div>
                                <!-- Button -->
                                <div class="form-group">
                                    <label class="col-md-4 control-label" for="submit"></label>
                                    <div class="col-md-4">
                                        <input  type="submit" id="submit" name="submit" class="btn btn-success" value="SAVE PROMOTION">
                                    </div>
                                </div>

                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>



            <div class="row content">

                <div class="col-sm-12 text-left" >
                    <div class="version">
                        <div>Promotions List</div>
                    </div>
                    <h3>${itf.insertMsg}</h3>
                    <h4>${itf.error} </h4>

                    <h3 style="background-color:buttonface">Promotions List</h3>

                    <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%">
                        <thead> 
                            <tr>
                                <th> Promo code</th>               
                                <th> Promo name</th>   
                                <th> Start </th>
                                <th> End </th>

                                <th> Granter </th>
                                <th> Business </th>
                                <th> Budget </th>
                                <th> Target </th>
                                <th> EDIT </th>
                                <th> Action </th>
                            </tr>

                        </thead> 
                        <tbody>
                            <%
                                try {
                                    String company = session.getAttribute("userInSessionCompany").toString();
                                    Connection con = ConnectionClass.getConnection();
                                    Statement ST = con.createStatement();
                                    ResultSet rs = ST.executeQuery("SELECT * FROM niki_promotions where niki_company_id='" + company + "' order by promo_name");
                                    int i = 0;
                                    while (rs.next()) {
                                        String promo_code = rs.getString("promo_code");
                                        String promo_name = rs.getString("promo_name");
                                        String start = rs.getString("start");
                                        String end = rs.getString("end");
                                        String global_id = rs.getString("global_id");
                                        String bus_cat_id = rs.getString("bus_cat_id");
                                        String maximum_budget = rs.getString("maximum_budget");
                                        String maximum_qty = rs.getString("maximum_qty");
                                        String status = rs.getString("status");


                            %>  
                            <tr> 

                                <td><%=promo_code%>  </td>
                                <td> <%= promo_name%></td>
                                <td> <%= start%></td>
                                <td><%=end%>  </td>
                                <td> <%= global_id%></td>
                                <td> <%= bus_cat_id%></td>
                                <td> <%= maximum_budget%></td>
                                <td> <%= maximum_qty%></td>
                                <td> <a class="btn btn-success" href="PromotionEdit.jsp?promo_code=<%=promo_code%>&action=update"> EDIT </a></td>
                                <td> <a class="btn btn-success" href="PromotionEditReal.jsp?promo_code=<%=promo_code%>&action=add_item"> ADD PRODUCTS </a></td>


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