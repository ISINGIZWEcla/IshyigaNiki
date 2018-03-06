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
    
    //here I am getting the first char of the id, I should instead get the first char of the descr (to be done)
    //same on the corresponding category
    char subcatFirstChar =sbcatN.charAt(0);
    String subcatFirstCharStr = Character.toString(subcatFirstChar);
    
    String categName=""; //this is the variable to hold the category corresponding to the subcategory

        
    /*
    connecting to the db and getting the category corresponding to the entered subcategory
    */
    try{
    	Connection con = ConnectionClass.getConnection();
    	Statement ST1 = con.createStatement();
        ResultSet rs1 = ST1.executeQuery("SELECT category_id FROM niki_subcategories where subcategory_id='"+ sbcatN + "'");
        
        while(rs1.next()){
        	categName = rs1.getString(1);
        }
    	
    }catch(Exception e){
    	
    }
    
  //here I am getting the first char of the category_id, 
    char catFirstChar =categName.charAt(0);
    String catFirstCharStr = Character.toString(catFirstChar);//converting it to string

    //getting the first 4chars of itmDescE 
    String itmDescEFirst4;
    String itmDescEWithNoSpace=itmDescE.replace(" ", "");//removing spaces in the string
    if(itmDescEWithNoSpace.length()<4){
    	itmDescEFirst4 = itmDescEWithNoSpace;
    }
    else{
    	itmDescEFirst4 = itmDescEWithNoSpace.substring(0, 4);
    }
    
    //getting autoincrement value
    int autoincr_value = itf.insertCode();
    
    //padding the autoincremented value with zeros
    String autoincr_valueWithZeroes=String.format("%05d", autoincr_value);
    
    //making the niki_code structure
    String niki_code = catFirstCharStr+subcatFirstCharStr+itmDescEFirst4+autoincr_valueWithZeroes;
    out.println(niki_code);

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
 

