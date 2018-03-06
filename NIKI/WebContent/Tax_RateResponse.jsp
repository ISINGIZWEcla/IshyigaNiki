

<jsp:useBean id="txr" scope="request" class="niki.Tax_Rate">
    <jsp:setProperty name="txr" property="*"/>
</jsp:useBean>

<%

String action = request.getParameter("action");



if(action!=null && action.equals("update")){
	txr.setInsertMsg("update is the action !!");
	
	/*
	getting parameters from update input page
	*/
		String taxLabel = request.getParameter("taxL").replaceAll("'", " ");

		session.setAttribute("taxlabelS", taxLabel);	//keeping taxlabel in a session for later use
		
	    String taxValue = request.getParameter("taxV").toUpperCase().replaceAll("'", " ");


	    
		/*
		setting the class attributes to be used in updating
		*/
		txr.setTaxLabel(taxLabel);
		txr.setTaxValue(taxValue);
		
	    	    
	    
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

    String txvl = request.getParameter("txvl").toUpperCase().replaceAll("'", " ");
    
    String txlbl = request.getParameter("txlbl").toUpperCase().replaceAll("'", " ");

    
    
    txr.setTaxValue(txvl);
    txr.setTaxLabel(txlbl);

    if (txr.isValid()) {
        if (txr.insertTaxRate()) {
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
