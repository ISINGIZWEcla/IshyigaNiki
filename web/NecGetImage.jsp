
  
<%@page import="niki.NecSaveReadImg"%>
<%@page import="java.sql.Connection"%> 
<%@page import="niki.ConnectionClass"%> 
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
 String income="";
    while ((line = br.readLine()) != null) {
        writer.println(line);
        income += line;  
    }  
String reso = income;
try{
  reso =NecSaveReadImg.getFichier(income);
}
catch(Throwable ss) { reso +="err "+ss;}

    writer.close();
 %> <%=reso%>  <% 
}
%>

