
<%@page import="niki.Niki_request"%>
<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@page import="niki.Item_Final" %>
<%@page import="javax.servlet.ServletInputStream,javax.servlet.http.HttpServletRequest"%>
<%@page import="java.io.BufferedReader,java.io.InputStreamReader"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>



<%

    BufferedReader br = request.getReader();
    String prefix = "payment_intimation"; 
    PrintWriter writer = new PrintWriter("yourfilenamewithpath", "UTF-8");
    String line = "";
   
    writer.println("----PARAMETERS-----"); 
 
    
    if(!request.getContentType().equals("SDJUNSHDSD"))
    { %><%=request.getContentType() %> FAIL TO LOG EXITING <%     
    }
else {
    writer.println("----BODY-----");
    String income = "rien";
    Niki_request nikI = null;
    while ((line = br.readLine()) != null) {
        writer.println(line);
        income = line;
        nikI = new Niki_request(line);

    }
    writer.close();
    if (nikI != null) {
        try {
            String sql = "SELECT * FROM niki.niki_items "
                    + " where item_external_id='" + nikI.item_external_id + "' and "
                    + " company_id='" + nikI.id_company + "'";
%>
<%=sql%> <%
    Connection conn = ConnectionClass.getConnection();
    PreparedStatement st = conn.prepareStatement(sql);
    ResultSet rs = st.executeQuery();
    boolean irimo = false;
    boolean irimo2=false;
    while (rs.next()) {
        nikI.item_id = rs.getInt("item_id");
        nikI.status = rs.getString("status");
        nikI.niki_code = rs.getString("niki_code");
        String resultat = nikI.getXml();
        irimo = true;
%>
<%=resultat%> <% }

    if (!irimo) {
          String  irimow = nikI.addNikiRequest(conn);
          nikI.status +=" RESPONSE INSERT "+irimow;
%>
<%=irimow%> <%
        }


if(irimo) {  
st = conn.prepareStatement(sql);
rs = st.executeQuery();
while (rs.next()) {
        nikI.item_id = rs.getInt("item_id");
        nikI.status = rs.getString("status");
        nikI.niki_code = rs.getString("niki_code");
        String resultat = nikI.getXml();
        irimo2 = true;
%>
<%=resultat%> <% } 
}    



if(!irimo2)
{
//nikI.status +="FAILED TO INSERT CALL ISHYIGA";
String resultat = nikI.getXml();
        irimo2 = true;
%>
<%=resultat%> <% }

    } catch (Exception e) {
        out.print(e);
    }
  } else {%> <%=line%> nameneste <% }
}
%>

