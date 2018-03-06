<%-- 
    Document   : SubCategoryResponse
    Created on : Jun 13, 2016, 10:55:40 AM
    Author     : vakaniwabo
--%>

<%@page import="niki.Sub_Category" %>

<jsp:useBean id="subcat" scope="request" class="niki.Sub_Category">
    <jsp:setProperty name="subcat" property="*"/>
</jsp:useBean>

<%

String action = request.getParameter("action");

String from="nowhere";

if(session.getAttribute("fromChooseCompany")!=null){
	from=session.getAttribute("fromChooseCompany").toString();
}

if(action!=null && action.equals("update")){
	subcat.setInsertMsg("update is the action !!");
	
	/*
	getting parameters from update input page
	*/
		String subcategory = request.getParameter("subcat").replaceAll("'", " ");

		session.setAttribute("subcategory", subcategory);	//keeping subcategory_id in a session for later use
		
	    String subcategory_descr = request.getParameter("subcatDesc").toUpperCase().replaceAll("'", " ");
	    String categ = request.getParameter("categ").toUpperCase().toUpperCase().replaceAll("'", " ");


	    
		/*
		setting the class attributes to be used in updating
		*/
		subcat.setSubcategory_id(subcategory);
		subcat.setSubcategory_descr(subcategory_descr);
		subcat.setCategory_id(categ);
	    	    
	    
	    /*
	    checking the inputs and calling the method to update
	    */
	    if (subcat.isValid()) {
	        if (subcat.updateSubcategory()) {
	        	

	        	subcat.setInsertMsg("Category Successfuly updated");
	        }


	    }else {
	    	subcat.setInsertMsg("Invalid data");
	    
	    }	
}
else if(action!=null && action.equals("subcatSleep")){
	
	// the action to be performed is sleep
    String subcatSleep = request.getParameter("subcatRejectSleep");
    

    
    subcat.setSubcategory_id(subcatSleep);

    if (subcat.isValid()) {//TODO: why checking if it is valid
        //the data is valid
		
        //call a method to sleep or make live a subcategory
        subcat.sleepSubCategory();
        

    } else {
        //the data is not valid
        subcat.setInsertMsg("Invalid data");
    }
	
}
else{

    String subcatDesc = request.getParameter("subctd").toUpperCase().replaceAll("'", " ");
    String subcatN = request.getParameter("subctn").toUpperCase().replaceAll("'", " ");
    String catN = request.getParameter("ctn").replaceAll("'", " ");

    
    
    subcat.setSubcategory_descr(subcatDesc);
    subcat.setSubcategory_id(subcatN);
    subcat.setCategory_id(catN);

    if (subcat.isValid()) {
        if (subcat.insertSubcategory()) {
            //us.setInsertMsg("Successfuly Inserted");
            
            
                out.print("successfully inserted");
            

        } else {
            //us.setInsertMsg("Not inserted:Error:");//+us.getError());
            out.print("not inserted");
        }

    }else {
        subcat.setInsertMsg("Invalid data");
    
    }
}
if(session.getAttribute("fromChooseCompany") != null && from.equals("yesUpdate")){
%>
	<jsp:forward page="ItemUpdate.jsp"/>
<%
}
else if(session.getAttribute("fromChooseCompany") != null && from.equals("yesValidate")){
%>
	<jsp:forward page="ItemValidationReal.jsp"/>
<%
}
else if(session.getAttribute("fromChooseCompany") != null && from.equals("yesValidateExcel")){
%>
	<jsp:forward page="ExcelItemValidation.jsp"/>
<%
}
else{
	
%>
<jsp:forward page="SubCategory.jsp"/>
<%
}
%>