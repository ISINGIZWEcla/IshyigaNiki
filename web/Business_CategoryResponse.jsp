<%-- 
    Document   : CategoryResponse
    Created on : May 28, 2016, 2:57:47 PM
    Author     : vakaniwabo
--%>

<%@page import="niki.Business_Category" %>

<jsp:useBean id="busin_cat" scope="request" class="niki.Business_Category">
    <jsp:setProperty name="busin_cat" property="*" />
</jsp:useBean>

<%
String action = request.getParameter("action");

String from="nowhere";

if(session.getAttribute("fromChooseCompany")!=null){
	from=session.getAttribute("fromChooseCompany").toString();
}

if(action!=null && action.equals("update")){
	busin_cat.setInsertMsg("update is the action !!");
	
	/*
	getting parameters from update input page
	*/
		String busin_category = request.getParameter("busincat").replaceAll("'", " ");

		session.setAttribute("business_category", busin_category);	//keeping business category id in a session for later use
		
	    String busin_category_descr = request.getParameter("buscatDesc").toUpperCase().replaceAll("'", " ");


	    
		/*
		setting the class attributes to be used in updating
		*/
		busin_cat.setBusin_category_id(busin_category);
		busin_cat.setBusin_category_descr(busin_category_descr);
	    	    
	    
	    /*
	    checking the inputs and calling the method to update
	    */
	    if (busin_cat.isValid()) {
	        if (busin_cat.updateBusinessCategory()) {
	        	

	        	busin_cat.setInsertMsg("Busin-Category Successfuly updated");
	        }


	    }else {
	    	busin_cat.setInsertMsg("Invalid data");
	    
	    }
	
	
}
else if(action!=null && action.equals("busCatSleep")){
	
	// the action to be performed is sleep
    String busCatSleep = request.getParameter("busCatRejectSleep");
    

    
    busin_cat.setBusin_category_id(busCatSleep);

    if (busin_cat.isValid()) {
        //the data is valid
		
        //call a method to sleep or make live a business category
        busin_cat.sleepBusinessCategory();
        

    } else {
        //the data is not valid
        busin_cat.setInsertMsg("Invalid data");
    }
	
}
else{

    String busin_category_id = request.getParameter("busin_category_id").toUpperCase().replaceAll("'", " "); 
    String busin_category_descr = request.getParameter("busin_category_descr").toUpperCase().replaceAll("'", " ");
    String french_business_name = request.getParameter("french_business_name").toUpperCase().replaceAll("'", " "); 
    String kinya_business_name = request.getParameter("kinya_business_name").toUpperCase().replaceAll("'", " ");
    String global_id= (String)session.getAttribute("userInSessionfName") ;
     
    busin_cat.setBusiness_Category(  busin_category_id,  busin_category_descr,
              french_business_name,   kinya_business_name,  global_id); 

    if (busin_cat.isValid()) {
        if (busin_cat.insertBusinCategory()) {
            
            busin_cat.setInsertMsg("Busin-Category successfully inserted");
            

        } else {
            out.print("not inserted");
        }

    }else {
        busin_cat.setInsertMsg("Invalid data");
    
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
else{
	
%>
<jsp:forward page="Business_Category.jsp"/>
<%
}
%>

