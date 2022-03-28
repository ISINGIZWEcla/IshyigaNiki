<%-- 
    Document   : RemoveProduct
    Created on : Mar 18, 2022, 6:40:09 PM
    Author     : Clarisse
--%>

<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@page import="niki.Promotions_list" %> 
<% 
 
//int promo_code= Integer.parseInt(request.getParameter("promo_code"));
//
//int niki_promotions_qte= Integer.parseInt(request.getParameter("niki_promotions_qte"));
//int niki_promotions_discount= Integer.parseInt(request.getParameter("niki_promotions_discount"));
//double niki_promotions_amount= Double.parseDouble(request.getParameter("niki_promotions_amount"));
//double purchase_price= Double.parseDouble(request.getParameter("purchase_price"));
String niki_code= request.getParameter("attachNiki");
//String type= request.getParameter("type") ; 
System.out.println("the nic code="+niki_code+" !");
 try {
            String deleteQuerry = "delete from  niki_promotions_list where niki_code='" + niki_code + "'";
            Connection con = ConnectionClass.getConnection();
            Statement ST = con.createStatement();
            ST.executeUpdate(deleteQuerry);
System.out.println("Successfully deleted niki item with the nic code="+niki_code+" !");
response.sendRedirect("PromotionEditReal.jsp?promo_code=8&action=add_item");
        } catch (Exception ex) {
           ex.printStackTrace();
        }
 

%>
