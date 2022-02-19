
<%@page import="i_m_e.me"%>
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
    
    if (true) {
        try {


String sql="SELECT * FROM niki.niki_categories"; 

%>
 <%
    Connection conn = ConnectionClass.getConnection();
    PreparedStatement st = conn.prepareStatement(sql);
    ResultSet rs = st.executeQuery(); 
    
    String resultat="<START>";
 
    while (rs.next()) { 
       String category_id = rs.getString("category_id");
       String category_descr = rs.getString("category_descr");
       String parent_category = rs.getString("parent_category");
       String french_catagory_name = rs.getString("french_catagory_name");
       String kinya_catagory_name = rs.getString("kinya_catagory_name"); 
       
         resultat +="<LINE>"
                 + "<category_id>"+category_id+"</category_id>"
                 + "<category_descr>"+category_descr+"</category_descr>"
                 + "<parent_category>"+parent_category+"</parent_category>"
                 + "<french_catagory_name>"+french_catagory_name+"</french_catagory_name>"
                 + "<kinya_catagory_name>"+kinya_catagory_name+"</kinya_catagory_name>" 
                 + "</LINE>";  
   }
    
    resultat +="</START>";
    %>
<%=resultat%> <%
   
conn.close();
    } catch (Exception e) {
        out.print(e);
%> <%=e%> danger <%
    }
  } else {%> <%=line%> nameneste <% }
}
%>
