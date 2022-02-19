<%-- 
    Document   : ItemValidateResponse
    Created on : Jun 6, 2016, 3:23:35 AM
    Author     : vakaniwabo
--%>


<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@page import="niki.Promotions_list" %> 

<!-- it_sub_cat ADDED FOR CR (Change Request), March 2018 -->
<jsp:useBean id="id_list" scope="request" class="niki.Promotions_list">
    <jsp:setProperty name="id_list" property="*" />
</jsp:useBean>

<% 
 
int promo_code= Integer.parseInt(request.getParameter("promo_code"));
int niki_promotions_qte= Integer.parseInt(request.getParameter("niki_promotions_qte"));
int niki_promotions_discount= Integer.parseInt(request.getParameter("niki_promotions_discount"));
double niki_promotions_amount= Double.parseDouble(request.getParameter("niki_promotions_amount"));
double purchase_price= Double.parseDouble(request.getParameter("purchase_price"));
String niki_code= request.getParameter("niki_code") ;
String type= request.getParameter("type") ; 

id_list.setPromotions_list(  promo_code,   niki_promotions_qte,
              niki_promotions_discount,niki_code,type,niki_promotions_amount);
id_list.insertPromoList();

%>
<%=id_list.getInsertMsg() %>
 %>
<%--<jsp:forward page="PromotionEdit.jsp?promo_code=<%=promo_code %>&action=update"/>--%>
<jsp:forward page="PromotionEditReal.jsp?promo_code=<%=promo_code%>&action=add_item"/>
<% %>


