<%-- 
    Document   : CategoryResponse
    Created on : Jun 13, 2016, 10:55:15 AM
    Author     : vakaniwabo
--%>


<%@page import="niki.Category" %>

<jsp:useBean id="cat" scope="request" class="niki.Category">
    <jsp:setProperty name="cat" property="*"/>
</jsp:useBean>

<%

String action = request.getParameter("action");

String from="nowhere";

if(session.getAttribute("fromChooseCompany")!=null){
	from=session.getAttribute("fromChooseCompany").toString();
}

cat.setInsertMsg(action+" action update is the action !!");
if(action!=null && action.equals("update")){
	cat.setInsertMsg("update is the action !!");
	
	/*
	getting parameters from update input page
	*/
		String category = request.getParameter("cat").toUpperCase().replaceAll("'", " ");

		session.setAttribute("category", category);	//keeping category_id in a session for later use
		
	    String category_descr = request.getParameter("catDesc").toUpperCase().replaceAll("'", " ");
String parent = request.getParameter("parent").toUpperCase().replaceAll("'", " ");
 String french = request.getParameter("french").toUpperCase().replaceAll("'", " ");
 String kinya = request.getParameter("kinya").toUpperCase().replaceAll("'", " ");

	    
		/*
		setting the class attributes to be used in updating
		*/
		cat.setCategory_id(category);
		cat.setCategory_descr(category_descr);
	    	 cat.setCategory_parent(parent);
    cat.setCategory_french(french);
    cat.setCategory_kinya(kinya);    
	    
	    /*
	    checking the inputs and calling the method to update
	    */
	    if (cat.isValid()) {
	        if (cat.updateCategory2()!=null) {
	        	

	        	cat.setInsertMsg("Successfuly updated");
	        }


	    }else {
	    	cat.setInsertMsg("Invalid data");
	    
	    }
	
}
else if(action!=null && action.equals("catSleep")){
	
	// the action to be performed is sleep
    String catSleep = request.getParameter("catRejectSleep");
    

    
    cat.setCategory_id(catSleep);

    if (cat.isValid()) {
        //the data is valid
		
        //call a method to sleep or make live a business category
        cat.sleepCategory();
        

    } else {
        //the data is not valid
        cat.setInsertMsg("Invalid data");
    }
	
}
else{

    String catDesc = request.getParameter("ctd").toUpperCase().replaceAll("'", " ");
    
    String catN = request.getParameter("ctn").toUpperCase().replaceAll("'", " ");
String parent = request.getParameter("parent").toUpperCase().replaceAll("'", " ");
 String french = request.getParameter("french").toUpperCase().replaceAll("'", " ");
 String kinya = request.getParameter("kinya").toUpperCase().replaceAll("'", " ");

cat.setCategory_descr(catDesc);
    cat.setCategory_id(catN);
	    	 cat.setCategory_parent(parent);
    cat.setCategory_french(french);
    cat.setCategory_kinya(kinya);    
String user = (String)session.getAttribute("userInSessionfName");
    if (cat.isValid()) {
        if (cat.insertCategory(user)) {
            cat.setInsertMsg("Successfuly Inserted");
            
            
             //   out.print("successfully inserted");
            

        } else {
            //us.setInsertMsg("Not inserted:Error:");//+us.getError());
            out.print("not inserted");
        }

    }else {
        cat.setInsertMsg("Invalid data");
    
    }
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
<jsp:forward page="Category.jsp"/>
<%
}
%>

