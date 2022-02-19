<%@page import="niki.Company" %>

<jsp:useBean id="comp" scope="request" class="niki.Company">
    <jsp:setProperty name="comp" property="*"/>
</jsp:useBean>

<%

String action = request.getParameter("action");
String from="nowhere";

if(session.getAttribute("fromChooseCompany")!=null){
	from=session.getAttribute("fromChooseCompany").toString();
}


if(action!=null && action.equals("update")){
	comp.setInsertMsg("update is the action !!");
	
	/*
	getting parameters from update input page
	*/
		String company_id = request.getParameter("comp").toUpperCase().replaceAll("'", " ");

		session.setAttribute("company", company_id);	//keeping company_id in a session for later use
		
	    String company_descr = request.getParameter("compDesc").toUpperCase().replaceAll("'", " ");
 
	    String busin_categ_id = request.getParameter("bus_ctn").toUpperCase().replaceAll("'", " ");
	    
	    
		/*
		setting the class attributes to be used in updating
		*/
		comp.setCompany_id(company_id);
		comp.setCompany_descr(company_descr);
		comp.setBusin_category(busin_categ_id);
	    	    
	    
	    /*
	    checking the inputs and calling the method to update
	    */
	    if (comp.isValid()) {
	        if (comp.updateCompany()) {
	        	

	        	comp.setInsertMsg("Successfuly updated");
	        }


	    }else {
	    	comp.setInsertMsg("Invalid data");
	    
	    }
	
}
else if(action!=null && action.equals("compSleep")){
	
	// the action to be performed is sleep
    String compSleep = request.getParameter("compRejectSleep");
    

    
    comp.setCompany_id(compSleep);

    if (comp.isValid()) {
        //the data is valid
		
        //call a method to sleep or make live a business category
        comp.sleepCompany();
        

    } else {
        //the data is not valid
        comp.setInsertMsg("Invalid data");
    }
	
}
else{

    String temp = request.getParameter("compDesc").toUpperCase().replaceAll("'", " ");
		String compN = temp.replaceAll(" ", "_");
    String compDesc = request.getParameter("compDesc").toUpperCase().replaceAll("'", " ");
    String busin_categ_id = request.getParameter("bus_ctn").toUpperCase().replaceAll("'", " ");

    
    
    comp.setCompany_descr(compDesc);
    comp.setCompany_id(compN);
    comp.setBusin_category(busin_categ_id);

    if (comp.isValid()) {
        if (comp.insertCompany()) {
            comp.setInsertMsg("Successfuly Inserted");
            
            
                out.print("successfully inserted");
            

        } else {
            out.print("not inserted NN");
        }

    }else {
    	comp.setInsertMsg("Invalid data");
    
    }
}
if(session.getAttribute("fromChooseCompany") != null && from.equals("yes")){
%>
	<jsp:forward page="chooseCompany.jsp"/>
<%
}
else{
	
%>
<jsp:forward page="Company.jsp"/>
<%
}
%>
