

<jsp:useBean id="txr" scope="request" class="niki.Tax_Rate">
    <jsp:setProperty name="txr" property="*"/>
</jsp:useBean>

<%

String action = request.getParameter("action");
String global_id=  session.getAttribute("userInSessionfName").toString(); 


if(action!=null && action.equals("update")){
	txr.setInsertMsg("update is the action !!");
 String taxLabel = request.getParameter("taxL").replaceAll("'", " ");
session.setAttribute("taxlabelS", taxLabel);	//keeping taxlabel in a session for later use
String taxValue = request.getParameter("taxV").toUpperCase().replaceAll("'", " ");
String taxClass = request.getParameter("taxClass").toUpperCase().replaceAll("'", " ");
 
		txr.setTaxLabel(taxLabel);
		txr.setTaxValue(Double.parseDouble(taxValue));
		txr.setTaxClass(taxClass);
	    	    
	    
	    /*
	    checking the inputs and calling the method to update
	    */
	    if (txr.isValid()) {
	        if (txr.updateTaxrate()) {
	        	

	        	txr.setInsertMsg("taxrate Successfuly updated");
	        }


	    }else {
	    	txr.setInsertMsg("Invalid data");
	    
	    }	
}
else if(action!=null && action.equals("taxSleep")){
	
	// the action to be performed is sleep
    String taxSleep = request.getParameter("taxRejectSleep");
    

    
    txr.setTaxLabel(taxSleep);

    if (txr.isValid()) {//TODO: why checking if it is valid
        //the data is valid
		
        //call a method to sleep or make live a subcategory
        txr.sleepTaxrate();
        

    } else {
        //the data is not valid
        txr.setInsertMsg("Invalid data");
    }
	
}
else{

String taxLabel = request.getParameter("txlbl").replaceAll("'", " ");
session.setAttribute("taxlabelS", taxLabel);	//keeping taxlabel in a session for later use
String taxValue = request.getParameter("txvl").toUpperCase().replaceAll("'", " ");
String taxClass = request.getParameter("taxClass").toUpperCase().replaceAll("'", " ");
 
		txr.setTaxLabel(taxLabel);
		txr.setTaxValue(Double.parseDouble(taxValue));
		txr.setTaxClass(taxClass);
    
     

    if (txr.isValid()) {
        if (txr.insertTaxRate(global_id)) {
            //us.setInsertMsg("Successfuly Inserted");
            
            
                out.print("successfully inserted");
            

        } else {
            //us.setInsertMsg("Not inserted:Error:");//+us.getError());
            out.print("not inserted");
        }

    }else {
        txr.setInsertMsg("Invalid data");
    
    }
}
%>
<jsp:forward page="Tax_Rate.jsp"/>
