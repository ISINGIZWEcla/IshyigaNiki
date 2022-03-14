

<%@page import="java.util.ArrayList"%>
<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    boolean ndemerewe = false;
    class data {

        public String niki_code;
        public String item_commercial_name;
        public String tax_vat;
        public String status;
        public String item_fabricant;
        public String item_inn;
        public double item_packet;
        public String item_key_words;
        public String created;
        public String category_id;

    };

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
    String business_category = session.getAttribute("bussiness_category").toString();

    boolean ndimuritransformation = false;
    String item_temp_id = request.getParameter("itemValidate");

    if (item_temp_id != null && !item_temp_id.equals("")) {
        ndimuritransformation = true;
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
        searchingfor += " Transforming : " + item_temp_id + " | " + itemDescr;
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

        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.min.js"></script>

        <script src="assets/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/dataTables.bootstrap.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="assets/css/respo.css">

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


        <div class="container">
            <div class="version">
                <div>Item super search form</div>
            </div>


            <div class="row content">

                <div class="col-sm-12 text-left" >
                    <h3>${it_tmp.insertMsg}</h3>
                    <h4>${it_tmp.error} </h4> 
                    <form name="inputItem" action="Item.jsp" method="POST">
                        <%
                            if (session.getAttribute("ItemSearched") != null) {
                                String description = session.getAttribute("ItemSearched").toString();
                                it_tmp.setItemDescription(description);
                            }
                        %>
                        <div class="col-sm-12">
                            <div class="col-sm-6">
                                <input type="text" class="form-control" placeholder="Description,Molecular,Keyword" name="itmd" value="${it_tmp.itemDescription}"  required>
                            </div>
                            <div class="col-sm-6">
                                <select  class="form-control" name="fabricant">
                                    <option class="form-control" value=""> SELECT MANUFACTURE</option> 
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

                                    <option class="form-control" value="<%=catId%>"><%=catNme%></option>
                                    <%  }

                                            conn.close();
                                        } catch (Exception e) {
                                            out.print(e);
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <br><br>
                        <div class="col-sm-12">
                            <div class="col-sm-6">
                                <input type="text" class="form-control" placeholder="barcode,HS code"  name="cdb" value="${it_tmp.codebar}" required/>
                                <input type="text" name="itemValidate" value="<%= item_temp_id%>" hidden="true" size="1"/>

                            </div>
                            <div class="col-sm-6">
                                <select class="form-control"  name="itcat">
                                    <option class="form-control" value=""> SELECT CATEGORY</option>

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

                                    <option class="form-control" value="<%=subcatId%>"><%=subcatNme%></option>
                                    <%

                                            }
                                            conn.close();

                                        } catch (Exception e) {
                                            out.print(e);
                                        }
                                    %>
                                </select>

                            </div>
                        </div>
                        <br/><br/>
                        <div class="col-sm-6"></div>
                        <div class="col-sm-3">
                            <input class="form-control btn-info1" type="submit" id="submit" value="SEARCH" name="submit" >
                        </div>
                    </form>

                </div>
            </div>

            <div class="row container">
                <div class="version ">
                    <div class="col-sm-6">NIKI Items List  <%=searchingfor%></div>
                    <% if (ndimuritransformation) {%>
                    <div class="col-sm-6"><a href="ItemValidationReal.jsp?itemValidate=<%=item_temp_id%>&action=validate"  > DIRECT ADD </a></div>
                    <%  } %>
                </div>  
                
                
                  <div class="col-sm-8"></div>  
                <div class="col-xs-4" >
                
                    <form action="" method="get" >
  <input class="form-control" type="text" placeholder="Search here" name="q">
</form>
                
            </div>
                    
                <div class="row">
                    <div class="col-sm-12">
                        <table id="example" class="table table-striped table-bordered" cellspacing="0" width="100%"  >
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
                                    <th> IMAGE </th> 
                                    <th> Edit </th> 
                                    <th> Delete </th> 
                                        <% } else { %>
                                    <th> INN </th>
                                    <th> EXIST </th>
                                        <% } %>
                                </tr>

                            </thead>

                            <tbody>
                                <%
                                    String sqll ;
//                                    if(!sqlToAdd.isEmpty()){
                                    
//                                    }else{
//                                        if(business_category.contains("PHARMACY")){
//                  business_category="PHARMACY" ;
//               }
//                                     sqll +=" where bus_category_id like '%"+business_category+"%'";   
//                                    }
int endValue = 0, nItems = 500,totalItems =0 ;
                                    try {
                                        ArrayList<data> records;
//                                        if (records == null) {
                                            records = new ArrayList<>();
                                            Connection con = ConnectionClass.getConnection();
                                            Statement ST = con.createStatement();
                                            String query =request.getParameter("q");
                                            if(query!=null){
                                                sqll = "SELECT * FROM niki_items where niki_code like '%"+query+"%' or item_commercial_name like '%"+query+"%' or item_inn like '%"+query+"%' or item_fabricant like '%"+query+"%'";
                                                
                                            }
                                            else{
                                                sqll ="SELECT * FROM niki_items ";
                                                sqll += sqlToAdd;
                                            }
                                            ResultSet rs = ST.executeQuery(sqll);
                                            
                                            while (rs.next()) {
                                                data singleData = new data();
                                                singleData.niki_code = rs.getString("niki_code");
                                                singleData.item_commercial_name = rs.getString("item_commercial_name");
                                                singleData.tax_vat = rs.getString("tax_vat");
                                                singleData.status = rs.getString("status");
                                                singleData.item_fabricant = rs.getString("item_fabricant");
                                                singleData.item_inn = rs.getString("item_inn");
                                                singleData.item_packet = rs.getDouble("item_packet");
                                                singleData.item_key_words = rs.getString("item_key_words");
                                                singleData.created = rs.getString("global_id");
                                                singleData.category_id = rs.getString("category_id");
                                                
                                                records.add(singleData);
                                            }
                                             totalItems =records.size();
                                            //request.getSession().setAttribute("records", records);
                                            
                                            con.close();
                                        //}
                                        String n = null;
                                        try{
                                            n =request.getParameter("endValue");
                                            
                                        }
                                        catch(Exception e){
                                            n=null;
                                        }
                                        
                                        int inc = n==null?0:Integer.parseInt(n) ;
//                                        inc = inc <=0 ? 0:inc;
                                        if(inc <= 0 ){
                                            inc = 0;
                                        }
                                        else if(inc >= totalItems ){
                                            inc = totalItems -1-nItems;
                                        }
                                        endValue = inc;
                                        while (inc < endValue+nItems ) {
                                            if(inc >= totalItems){
                                                break;
                                            }
                                         
                                            
                                            data singleData = records.get(inc);
                                           


                                %>
                            
                           
                                <tr>   
                                    <%--<%=sqll%>--%>

                                    <td><%=singleData.niki_code%>  </td>
                                    <td width="30%" > <%= singleData.item_commercial_name%></td>
                                    <td> <%= singleData.item_inn%></td>
                                    <td> <%= singleData.item_packet%></td>
                                    <td> <%= singleData.category_id%></td>
                                    <td> <%= singleData.item_fabricant%></td>
                                    <td> <%= singleData.tax_vat%></td> 
                                    <% if (!ndimuritransformation && ndemerewe) {%>
                                    <td> <%=singleData.created%></td>  
                                    <td> 

                                        <%
                                            String imgg = "assets/NIKI_IMAGE/" + singleData.niki_code + ".jpg";
                                        %>
                                        <img src="<%=imgg%>" alt="IMAGE" class="img-fluid" style="height: 65px" /> 
                                    </td>  
                                    <td> <a href="ItemUpdate.jsp?action=update&nikicode=<%=singleData.niki_code%>" class="btn btn-primary enable " data-toggle="modal" data-target="#basicModal" > EDIT </a></td>
                                    <% } else if (!ndimuritransformation) {%>
                                    <td> <%=singleData.created%></td>  
                                    <td> 

                                        <%
                                            String imgg = "assets/NIKI_IMAGE/" + singleData.niki_code + ".jpg";
                                        %>
                                        <img src="<%=imgg%>" alt="IMAGE" class="img-fluid" style="height: 65px" /> 
                                    </td> 
                                    <td> <a href="ItemUpdate.jsp?action=update&nikicode=<%=singleData.niki_code%>" > EDIT </a></td>
                            <form action="ItemsDeleteResponse.jsp"> <input type="hidden" name="nikicode" value="<%=singleData.niki_code%>"/><td> <input type="submit" value="Delete"/></td></form>

                                    <% } else {%>
                                    <td> <a href="ItemValidationReal.jsp?itemValidate=<%=item_temp_id%>&action=validate&attachNiki=<%=singleData.niki_code%>" class="btn btn-primary enable " data-toggle="modal" data-target="#basicModal" > ATTACH </a></td>
                                    <td> <a href="ItemRejectSleepResponse.jsp?itemRejectSleep=<%=item_temp_id%>&action=sleepFinal&attachNiki=<%=singleData.niki_code%>" class="btn btn-primary enable"> SAME </a></td>
                                    <% } %>

                                </tr>
                            

                                <%
                                    inc++;
                                        }

                                        

                                    } catch (Exception e) {
                                        e.printStackTrace();

                                    }

                                %>
                            </tbody>  
                        </table>
                        <div >
                            <div class="mb-5 mt-5 container-fluid pt-sm-5 pb-sm-5" style="position: center;text-align: center">
                                        <div class="row">
                                            <div class="col-sm-2">
                                                <% if(endValue >= nItems){
                                    
                                
                                    %>
                                    
                                    <form action="Item.jsp" class="pb-5">
                                
                                <input name="endValue" type="text" hidden value="<%out.print(endValue - nItems); %>"/>
                                <button class="btn btn-info"   type="submit">prev</button>
                            </form>
                                <%}%>
                                            </div>
                                            <div class="col-sm-2">
                                               
                                                <% if(endValue + nItems < totalItems){
                                    
                                
                                    %>
                                    <form action="Item.jsp" class="pb-5">
                                <input name="endValue" type="text" hidden value="<%out.print(endValue + nItems); %>"/>
                               <button class="btn btn-info" style="" type="submit">next</button>
                               
                            </form>
                               <%}%>
                                            
                                            </div>
                                        </div>
                                    </div>
                            
                                
                               
                        </div>
                               
                </div>
                    </div>
                </div>

            </div>

        



        <div class="container-fluid text-center">
            <div class="row content">

                <div class="col-sm-8 text-left" >	        



                    <div id="w">





                    </div>


                </div>

            </div>
        </div>

        <footer style="background-color: #405a63;" class="container-fluid text-center">
            <p style="color: white"><strong> Copyright &#169; 2016 Algorithm,Inc.  </strong></p>
        </footer>



    </body>
</html>
<%
    }
%>
