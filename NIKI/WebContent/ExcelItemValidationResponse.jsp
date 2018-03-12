<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@page import="niki.Item_Final" %>
<%@page import="niki.Item_Temp" %>
<%@page import="niki.Item_Business_Category" %>


<jsp:useBean id="itf" scope="request" class="niki.Item_Final">
    <jsp:setProperty name="itf" property="*" />
</jsp:useBean>

<jsp:useBean id="it_excl" scope="request" class="niki.ExcelInput">
    <jsp:setProperty name="it_excl" property="*" />
</jsp:useBean>

<jsp:useBean id="it_bus_cat" scope="request" class="niki.Item_Business_Category">
    <jsp:setProperty name="it_bus_cat" property="*" />
</jsp:useBean>

<!-- it_sub_cat ADDED FOR CR (Change Request), March 2018 -->
<jsp:useBean id="it_sub_cat" scope="request" class="niki.Sub_Category">
    <jsp:setProperty name="it_sub_cat" property="*" />
</jsp:useBean>

<%
    String itemValidate = request.getParameter("itmIdOrig").toUpperCase();

	//setting the original item id to be validated to a session attribute
	session.setAttribute("itemOriginal", itemValidate);

    String codeb = request.getParameter("cdb").toUpperCase().replaceAll("'", " ");
    String itmDescE = request.getParameter("itmdE").toUpperCase().replaceAll("'", " ");
    String itmDescK = request.getParameter("itmdK").toUpperCase().replaceAll("'", " ");
    String itmDescF = request.getParameter("itmdF").toUpperCase().replaceAll("'", " ");
    String itmDescS = request.getParameter("itmdS").toUpperCase().replaceAll("'", " ");
    String taxR = request.getParameter("txrt").toUpperCase().replaceAll("'", " ");
    String sbcatN = request.getParameter("subcat").toUpperCase().replaceAll("'", " ");
    String []bsncatN = request.getParameterValues("busin_cat");
    
    
    //getting the first 4chars of itmDescE 
    String itmDescEFirst4;
    String itmDescEWithNoSpace=itmDescE.replace(" ", "");//removing spaces in the string
    if(itmDescEWithNoSpace.length()<4){
    	itmDescEFirst4 = itmDescEWithNoSpace;
    }
    else{
    	itmDescEFirst4 = itmDescEWithNoSpace.substring(0, 4);
    }
    
    /*
    STRUCTURING NIKI_CODE, CR (Change Request) March 2018
    */
    //getting subcategory abbreviation to be used in niki_code structuring
    it_sub_cat.setSubcategory_id(sbcatN);
    String subCategoryAbbrev = it_sub_cat.findSubcategoryAbbrev(); //TODO: have to check for the case it returns null
    
    //count current number of items of the same subcategory in the Final items table
    Integer countItemsInSubcategory = itf.countItemsInSubcategory(subCategoryAbbrev); // TODO: have to check for the case when it returns 0
    
    //getting the number of the next item in the subcategory by incrementing and padding the value with zeros
    String nextItemInSubcategory = String.format("%05d", (countItemsInSubcategory+1)); 
    
    //making the niki_code structure
    String niki_code = subCategoryAbbrev + itmDescEFirst4 + nextItemInSubcategory;
    
    /*
    end of niki_code formatting
    */

    itf.setNiki_code(niki_code);
    if(codeb.isEmpty() || codeb=="null" || codeb == null){
        itf.setCodebar(null);    
    }
    else{
        itf.setCodebar(codeb);    	
    }
    itf.setItemDescriptionENGL(itmDescE);
    itf.setItemDescriptionKINYA(itmDescK);
    itf.setItemDescriptionFRENCH(itmDescF);
    itf.setItemDescriptionSWAHILI(itmDescS);
    itf.setSubcategory_id(sbcatN);
    itf.setTaxRate(taxR);
    
    //identifying the temp item we are validating
    it_excl.setFromExcelId(itemValidate); 
    
    it_bus_cat.setNiki_code(niki_code);//setting the niki_code of the item business category instance
    
    /*
    checking if the select values are empty and prompting the users to enter them if they are so
    */
    if(taxR.isEmpty()){
        itf.setInsertMsg("please select the taxrate ");
    }
    else if(bsncatN == null){
        itf.setInsertMsg("please select the business category ");

    }
    /*
    checking if the inputs are valid
    */
    else if (itf.isValid()) {
    	//the inputs are valid
    	itf.setInsertMsg("it is valid");
    	//inserting to the itemfinal
        if (itf.insertItem()) {
        	//item is inserted in itemfinal successfully
            
        	boolean inserted=false; //variable to help to check if business categories are  inserted successfully
        	
        	//Matching an item to the selected business categories
            for (String bscat:bsncatN){ 
            	//for each selected business category
                it_bus_cat.setBusin_category_id(bscat.toUpperCase()); //setting the business category for the item
                inserted=it_bus_cat.insertItemBusinCategory();//inserting the business category
                            	
            }

            if(inserted){
            	//the item is matched with the business category successfully
                
                it_excl.transformItem(); //update the status of the pending item to "transformed"

                //updating the niki_code of the transformed item
               it_excl.setNiki_code(niki_code);
               it_excl.addItemNiki_code();
               it_excl.setInsertMsg("item validated successfully");
               itf.setInsertMsg("");
               //when it reaches here it is inserted successfully
            }
            else{

                //only inserted in Items
                //didnt insert in ItemCategory 
                
            }

        } else {
        	//not validated successfully
        	
        }

    }else {
        itf.setInsertMsg("Invalid data");
    
    }
    it_excl.getConn().close();//closing the connection of item temp
    it_bus_cat.getConn().close();//closing the connection of item business category
    itf.getConn().close();//closing the connection of item final
    
  //part of CR setting initialExcelView attrubute to No, cause we are directing to View excel data, and it is not initial. 
  	 session.setAttribute("initialExcelView", "no");
%>
<jsp:forward page="ViewFilesData.jsp"/>
 

