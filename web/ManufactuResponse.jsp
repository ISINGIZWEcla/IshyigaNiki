<%-- 
    Document   : CategoryResponse
    Created on : Jun 13, 2016, 10:55:15 AM
    Author     : vakaniwabo
--%>


<%@page import="niki.Category" %>

<jsp:useBean id="cat" scope="request" class="niki.Manufacture">
    <jsp:setProperty name="cat" property="*"/>
</jsp:useBean>

<%

String action = request.getParameter("action");
String global_id=session.getAttribute("userInSessionfName").toString(); 
String from="nowhere";

if(session.getAttribute("fromChooseCompany")!=null){
	from=session.getAttribute("fromChooseCompany").toString();
}

 

    String fabricant_id = request.getParameter("id").toUpperCase().replaceAll("'", " "); 
    String niki_fabricant_name = request.getParameter("name").toUpperCase().replaceAll("'", " ");
    String niki_fabricant_country = request.getParameter("country").toUpperCase().replaceAll("'", " "); 

cat.setManufacture(  fabricant_id,   niki_fabricant_name, 
              niki_fabricant_country, global_id); 
    
        if (cat.insertFabricant()) {
            cat.insertMsg ="Successfuly Inserted";
            
            
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
<jsp:forward page="niki.jsp"/>
<%
}
%>

