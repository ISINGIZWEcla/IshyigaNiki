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

    int promo_code = Integer.parseInt(request.getParameter("promo_code"));
    int niki_promotions_qte = Integer.parseInt(request.getParameter("niki_promotions_qte"));
//int niki_promotions_discount= (int)request.getParameter("niki_promotions_discount");
    double niki_promotions_amount = Double.parseDouble(request.getParameter("niki_promotions_amount"));
    double purchase_price = Double.parseDouble(request.getParameter("niki_promotions_purchase"));
    String niki_code = request.getParameter("niki_code");

//id_list.setPromotions_list2( 5,1,0,"CONCOFF01020",800.0,500.0);
//id_list.updatePromoList();
    String errors = "", sql1 = "";
    try {
        Connection conn = ConnectionClass.getConnection();

        sql1 = "update niki_promotions_list set niki_promotions_amount =" + niki_promotions_amount + ",niki_promotions_purchase=" + purchase_price + ",niki_promotions_qte=" + niki_promotions_qte + ",niki_promotions_discount=0.0  where promo_code=" + promo_code + " and niki_code='" + niki_code + "'";

        Statement stm = conn.createStatement();
        stm.execute(sql1);

        errors = "Successfully Updated";
        conn.close();

    } catch (Exception e) {
        errors = "ERROR" + e.getMessage();
    }

%>
<%=id_list.getInsertMsg()%>
%>
<%--<jsp:forward page="PromotionEdit.jsp?promo_code=<%=promo_code %>&action=update"/>--%>
<jsp:forward page="PromotionEditReal.jsp?promo_code=<%=promo_code%>&action=add_item"/>
<%%>