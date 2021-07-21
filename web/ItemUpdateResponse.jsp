<%-- 
    Document   : ItemUpdateResponse
    Created on : May 31, 2016, 6:34:45 PM
    Author     : vakaniwabo
--%>



<jsp:useBean id="itf" scope="request" class="niki.Item_Final">
    <jsp:setProperty name="itf" property="*" />
</jsp:useBean>

<jsp:useBean id="it_bus_cat" scope="request" class="niki.Item_Business_Category">
    <jsp:setProperty name="it_bus_cat" property="*" />
</jsp:useBean>


<%
/*
getting parameters from update input page
*/
	String niki = request.getParameter("niki");

	session.setAttribute("niki", niki);	//keeping niki code in a session for letter use
	
    String codeb = request.getParameter("cdb").toUpperCase().replaceAll("'", " ");
    String itmDescE = request.getParameter("itmdE").toUpperCase().replaceAll("'", " ");
    String itmDescK = request.getParameter("itmdK").toUpperCase().replaceAll("'", " ");
    String itmDescF = request.getParameter("itmdF").toUpperCase().replaceAll("'", " ");
    String itmDescS = request.getParameter("itmdS").toUpperCase().replaceAll("'", " ");
    String taxR = request.getParameter("txrt").replaceAll("'", " ");
        
    String sbcatN = request.getParameter("subcat").replaceAll("'", " ");
    String []bsncatN = request.getParameterValues("busin_cat");

    
	/*
	setting the class attributes to be used in updating
	*/
    itf.setNiki_code(niki);
    
    itf.setCodebar(codeb);
  
    itf.setItemDescriptionENGL(itmDescE);
    itf.setItemDescriptionKINYA(itmDescK);
    itf.setItemDescriptionFRENCH(itmDescF);
    itf.setItemDescriptionSWAHILI(itmDescS);
    itf.setTaxRate(taxR);
    itf.setSubcategory_id(sbcatN);
    
    it_bus_cat.setNiki_code(niki);
    
    
    /*
    checking the inputs and calling the method to update
    */
    if(taxR.isEmpty()){
        itf.setInsertMsg("please select the taxrate ");
    }
   else if(sbcatN.isEmpty()){
       itf.setInsertMsg("please select the category ");
   }
    else if (itf.isValid()) {
        if (itf.updateItem()) {
        	
        	//Matching an item to the selected business categories
            for (String bscat:bsncatN){ 
            	//for each selected business category
                it_bus_cat.setBusin_category_id(bscat.toUpperCase()); //setting the business category for the item
                it_bus_cat.insertItemBusinCategory();//inserting the business category
                            	
            }
            itf.setInsertMsg("Successfuly updated");
        }


    }else {
        itf.setInsertMsg("Invalid data");
    
    }
%>

<jsp:forward page="FinalItems.jsp"/>
 
