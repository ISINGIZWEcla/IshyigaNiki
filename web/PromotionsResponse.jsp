<%-- 
    Document   : CategoryResponse
    Created on : May 28, 2016, 2:57:47 PM
    Author     : vakaniwabo
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="niki.Business_Category" %>

<jsp:useBean id="promo" scope="request" class="niki.Promotions">
    <jsp:setProperty name="promo" property="*" />
</jsp:useBean>

<%
String action = request.getParameter("action");

String from="nowhere";

if(session.getAttribute("fromChooseCompany")!=null){
	from=session.getAttribute("fromChooseCompany").toString();
}
  
    String promo_name = request.getParameter("promo_name").toUpperCase().replaceAll("'", " "); 
    String start = request.getParameter("start").replaceAll("T", " ");
    String end = request.getParameter("end").replaceAll("T", " "); 
    String bus_cat_id = request.getParameter("bus_cat_id").toUpperCase().replaceAll("'", " ");
    String global_id= (String)session.getAttribute("userInSessionfName") ;
    String niki_company_id=  session.getAttribute("userInSessionCompany").toString() ;
     double maximum_budget =Double.parseDouble(request.getParameter("maximum_budget"));
     int promo_code=1;//Integer.parseInt(request.getParameter("promo_code"));
     int maximum_qty=Integer.parseInt(request.getParameter("maximum_qty"));
//     Date date1=new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(start.replaceAll("T", " "));
//     Date date2=new SimpleDateFormat("dd/MM/yyyy HH:mm").parse(end);
    promo.setPromotions(  promo_name,  start,   end,  niki_company_id,
              bus_cat_id, global_id,   maximum_budget,   promo_code,   maximum_qty);
             

    if (promo.isValid()) {
        out.print(promo.insertPromotion()) ;
            
            promo.setInsertMsg(promo_name+" Promo successfully inserted"); 
    }else {
        promo.setInsertMsg("Invalid data");
    
    }
%> 
<jsp:forward page="Promotions.jsp"/>
<%--<%=promo.getInsertMsg()

%>--%>

