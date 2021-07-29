<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="niki.Promotions_list" %> 
<%@page import="niki.Promotions" %> 
<!-- it_sub_cat ADDED FOR CR (Change Request), March 2018 -->
<jsp:useBean id="id_list" scope="request" class="niki.Promotions_list">
    <jsp:setProperty name="id_list" property="*" />
</jsp:useBean>
<jsp:useBean id="promo" scope="request" class="niki.Promotions">
    <jsp:setProperty name="promo" property="*" />
</jsp:useBean>
<%@page import="javax.servlet.ServletInputStream,javax.servlet.http.HttpServletRequest"%>
<%@page import="java.io.BufferedReader,java.io.InputStreamReader"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>

<%

    BufferedReader br = request.getReader(); 
    PrintWriter writer = new PrintWriter("yourfilenamewithpath", "UTF-8");
    String line = ""; 
    writer.println("----PARAMETERS-----");  
    if(!request.getContentType().equals("SDJUNSHDSD"))
    { %><%=request.getContentType() %> FAIL TO LOG EXITING <%     
    }
else {
    writer.println("----BODY-----");
    String income = "rien";
 %><%="NIKO"%> <%
    Promotions promotion = null;
    while ((line = br.readLine()) != null) {
        writer.println(line);
        income = line;
  %><%=income%> <%
        promotion = new Promotions(line);

    }
    writer.close();

 %><%="NIKO"+promotion%> <%
String today =Promotions.geToday();
%><%="today"+today%> <%
    if (promotion != null) {

 
  try{
  
String sqll="SELECT * FROM niki_promotions where bus_cat_id='" + promotion.bus_cat_id + "'"
+ " and end>'"+today+"' and status='LIVE'";
 %><%=sqll%> <%
 Connection conn = ConnectionClass.getConnection(); 
 Statement ST = conn.createStatement();
 ResultSet rs = ST.executeQuery(sqll);
                       
    String promo_name =""; 
    String start = "";
    String end = ""; 
    String bus_cat_id = "";
    String global_id= "" ;
    String niki_company_id=  "";
     double maximum_budget =0; 
     int maximum_qty=0;
     %><%="<HEAD>"%> <%
 while (rs.next()) {
 promo_name = rs.getString("promo_name"); 
 start = rs.getString("start"); 
    end = rs.getString("end"); 
    bus_cat_id = rs.getString("bus_cat_id"); 
    global_id= rs.getString("global_id"); 
      niki_company_id= rs.getString("niki_company_id");
     maximum_budget =rs.getDouble("maximum_budget"); 
     maximum_qty=rs.getInt("maximum_qty");
     promo.setPromotions(  promo_name,   start,   end,   niki_company_id,
              bus_cat_id,  global_id,   maximum_budget, rs.getInt("promo_code")  ,   maximum_qty) ; 
     %><%=promo.getXml()%> <%
  }
 %><%="</HEAD>"%> <%

   Statement ST2 = conn.createStatement();
   
   String sql="SELECT `niki_promotions_list`.`promo_code`,"
           + "`niki_promotions_list`.`niki_code`,`niki_promotions_list`.`type`,"
           + "`niki_promotions_list`.`niki_promotions_qte`,"
           + " `niki_promotions_list`.`niki_promotions_amount`,"
           + "    `niki_promotions_list`.`niki_promotions_discount`"
           + "FROM `niki`.`niki_promotions_list`  where "
           + "  `niki_promotions_list`.`promo_code`="+promo.promo_code;
  //  %><%=sql%> <%
  ResultSet rs2 = ST2.executeQuery(sql);
                 
  %><%="<BODY>"%> <%    
 while (rs2.next()) { 
            
id_list.setPromotions_list(  promo.promo_code, rs2.getInt(4),
            rs2.getInt(6), rs2.getString(2),rs2.getString(3), 
            rs2.getDouble(5));

String toPrint="<LINE>"+id_list.getXml()+"</LINE>";
      %><%=toPrint%> <%
  }
 
  %><%="</BODY>"%> <%
 conn.close();
  }

  catch(Exception ex)
  {
  
   %><%="nameneste"+ex%> <%
  }
}
}
    
%>        
        
        