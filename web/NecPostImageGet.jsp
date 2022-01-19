
<%@page import="niki.Niki_request"%>
<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.*"%> 
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

    if (!request.getContentType().equals("SDJUNSHDSD")) {%><%=request.getContentType()%> FAIL TO LOG EXITING <%
    } else {
        writer.println("----BODY-----");
        String xmlTrack = null;
        while ((line = br.readLine()) != null) {
            writer.println(line);
            xmlTrack = line;

        }
        writer.close();
        if (xmlTrack != null) {
            String niki_code = Niki_request.getTagValue("NIKI_CODE", xmlTrack);
            try {
                String sql = "SELECT * FROM nec.track_trace_line where niki_code"
                        + "='" + niki_code + "'"; 
    Connection conn = ConnectionClass.getConnection();
    PreparedStatement st = conn.prepareStatement(sql);
    ResultSet rs = st.executeQuery();
    String igisubizo = "";
    while (rs.next()) {

        igisubizo += "<line>"
                + "<id_track_trace>" + rs.getInt("id_track_trace") + "</id_track_trace>"
                + "<tracked_time>" + rs.getString("tracked_time") + "</tracked_time>"
                + "<global_account>" + rs.getString("global_account") + "</global_account>"
                + "<transaction_type>" + rs.getString("transaction_type") + "</transaction_type>"
                + "<transaction_time>" + rs.getString("transaction_time") + "</transaction_time>"
                + "<niki_code>" + rs.getString("niki_code") + "</niki_code>"
                + "<quantity>" + rs.getInt("quantity") + "</quantity>"
                + "<bacth_serial>" + rs.getString("bacth_serial") + "</bacth_serial>"
                + "<node_produce_id>" + rs.getString("node_produce_id") + "</node_produce_id>"
                + "<node_produce_doc>" + rs.getString("node_produce_doc") + "</node_produce_doc>"
                + "<node_consume_id>" + rs.getString("node_consume_id") + "</node_consume_id>"
                + "<dot_id>" + rs.getString("dot_id") + "</dot_id>"
                + "<different_compared>" + rs.getDouble("different_compared") + "</different_compared>"
                + "<image_size>" + rs.getDouble("image_size") + "</image_size>"
                + "<quality_of_image>" + rs.getDouble("quality_of_image") + "</quality_of_image>"
                + "</line>";
    }
 if(igisubizo.equals(""))   {igisubizo= "NO DATA FOUND FOR "+niki_code;}
%><%=igisubizo%> <%
    
        conn.close();
    } catch (Exception e) {
        out.print(e);
    }
} else {%> <%=line%> nameneste <% }
      }
%>
