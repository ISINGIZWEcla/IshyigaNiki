<%-- 
    Document   : CategoryResponse
    Created on : Jun 13, 2016, 10:55:15 AM
    Author     : vakaniwabo
--%>


<%@page import="niki.Category" %>

<jsp:useBean id="cat" scope="request" class="niki.Emballage">
    <jsp:setProperty name="cat" property="*"/>
</jsp:useBean>

<%

String action = request.getParameter("action");

String from="nowhere";

if(session.getAttribute("fromChooseCompany")!=null){
	from=session.getAttribute("fromChooseCompany").toString();
}
 

    String niki_emballage_id = request.getParameter("niki_emballage_id").toUpperCase().replaceAll("'", " "); 
    String niki_emballage_name = request.getParameter("niki_emballage_name").toUpperCase().replaceAll("'", " ");
String niki_emballage_info = request.getParameter("niki_emballage_info").toUpperCase().replaceAll("'", " ");
String global_id = (String)session.getAttribute("userInSessionfName");
cat.setEmballage(  niki_emballage_id,   niki_emballage_name, 
        niki_emballage_info,   global_id)   ;    

    
        if (cat.insertPack()) {
            cat.insertMsg="Successfuly Inserted";
            
            
             //   out.print("successfully inserted");
            

        } else {
            //us.setInsertMsg("Not inserted:Error:");//+us.getError());
            out.print("not inserted");
        }
 
 
if(session.getAttribute("fromChooseCompany") != null && from.equals("yesSubcatUpdate")){
%>
	<jsp:forward page="SubcategoryUpdate.jsp"/>
<%
}
else if(session.getAttribute("fromChooseCompany") != null && from.equals("yesSubcatAdd")){
%>
	<jsp:forward page="SubCategory.jsp"/>
<%
}
else{
	
%>
<jsp:forward page="Settings.jsp"/>
<%
}
%>

