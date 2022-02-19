
       
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
 String xml="";
    while ((line = br.readLine()) != null) {
        writer.println(line);
        xml += line; 
   
    } 
String pathImageNec="E:\\NEC\\";
String reso= " hey";
try{
 String folder = niki.Niki_request.getTagValue("FOLDER", xml);
    String file   = niki.Niki_request.getTagValue("CATEGORY", xml);
    String niki_Code   = niki.Niki_request.getTagValue("NIKI_CODE", xml); 
    String data   = niki.Niki_request.getTagValue("IMAGE", xml); 
     
    String filename = pathImageNec+folder+"\\"+file+"\\"+niki_Code;
   
        try { 
            
            File f = new File(filename);
            try (PrintWriter sorti = new PrintWriter(new FileWriter(f))) {
                sorti.println(data); 
            } 
 
  
  reso = "<response>SUCCESS</response>"
                 + "<filename>"+filename+"</filename>";
  //+ "<tracked>"+ORT_track.insertLimitTrack(  con,xml )+"</tracked>";
 
        } catch (IOException ex) { 
            reso = "<response>FAIL"+ex+filename+"</response>";  
        }
}
catch(Throwable ss) { reso +="ERROR "+ss;}


    writer.close();
 %> <%=reso%>  <% 
}
%>

