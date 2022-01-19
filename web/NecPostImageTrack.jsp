
       
<%@page import="niki.Niki_request"%>
<%@page import="java.sql.PreparedStatement"%> 
<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.File"%>
<%@page import="niki.Niki_request"%>
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
    String contentType = request.getContentType();
    
    writer.println("----PARAMETERS-----"); 
 
    if(request.getContentType() == null)
    { %>EMPTY DATA FAIL TO LOG EXITING <%     
    }
else if(!request.getContentType().equals("SDJUNSHDSD"))
   { %> <%= contentType %> FAIL TO LOG EXITING  <%     
    }
else {



    writer.println("----BODY-----");
 String xmlTrack="";
    while ((line = br.readLine()) != null) {
        writer.println(line);
        xmlTrack += line; 
   
    } 
 
 
 Connection con = ConnectionClass.getConnection(); 

String responses = "WAPI";

try {

 String transaction_type = Niki_request.getTagValue("transaction_type", xmlTrack);
 String global_account = Niki_request.getTagValue("global_account", xmlTrack);
  String transaction_time = Niki_request.getTagValue("transaction_time", xmlTrack);
 String node_produce_id = Niki_request.getTagValue("node_produce_id", xmlTrack);
 String niki_code = Niki_request.getTagValue("NIKI_CODE", xmlTrack);
 int quantity = 1;
 String bacth_serial = "test"; 
 String node_produce_doc= "AB232";
 String node_consume_id ="bnm0239";
 String dot_id = "B29qH0AAAA";
 double different_compared = Double.parseDouble(
Niki_request.getTagValue("different_compared", xmlTrack));
 double image_size = 0;
 double quality_of_image =0 ;   
 
String sql1 = "INSERT INTO `nec`.`track_trace_line` " +
"(`global_account`," +
"`transaction_type`," +
"`transaction_time`," +
"`niki_code`," +
"`quantity`," +
"`bacth_serial`," +
"`node_produce_id`," +
"`node_produce_doc`," +
"`node_consume_id`," +
"`dot_id`," +
"`different_compared`," +
"`image_size`," +
"`quality_of_image`)" +
"VALUES(?,?,?,?,"
     + "?,?,?,?,"
     + "?,?,?,?," 
     + "?)" ;    
 
PreparedStatement ps = con.prepareStatement(sql1) ;
              ps.setString(1,global_account);
              ps.setString(2,transaction_type);
              ps.setString(3,transaction_time);
              ps.setString(4,niki_code);
              ps.setInt(5,quantity);
              ps.setString(6,bacth_serial);
              ps.setString(7,node_produce_id);
              ps.setString(8,node_produce_doc);
              ps.setString(9,node_consume_id);
              ps.setString(10,dot_id);
              ps.setDouble(11,different_compared);
              ps.setDouble(12,image_size);
              ps.setDouble(13,quality_of_image);
              ps.execute(); 
}
catch (Throwable t) { responses = "-----------"+t;}
 String reso = "<response>SUCCESS</response>"+
"<connected>WAPI</connected>"
+ "<tracked>"+responses+"</tracked>"; 

    writer.close();
 %> <%=reso+responses%>  <% 
}
%>

