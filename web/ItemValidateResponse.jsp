<%-- 
    Document   : ItemValidateResponse
    Created on : Jun 6, 2016, 3:23:35 AM
    Author     : vakaniwabo
--%>


<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@page import="niki.Item_Final" %>
<%@page import="niki.Item_Temp" %>
<%@page import="niki.Item_Business_Category" %>


<jsp:useBean id="itf" scope="request" class="niki.Item_Final">
    <jsp:setProperty name="itf" property="*" />
</jsp:useBean>

<jsp:useBean id="it_tmp" scope="request" class="niki.Item_Temp">
    <jsp:setProperty name="it_tmp" property="*" />
</jsp:useBean>

<jsp:useBean id="it_bus_cat" scope="request" class="niki.Item_Business_Category">
    <jsp:setProperty name="it_bus_cat" property="*" />
</jsp:useBean>

<!-- it_sub_cat ADDED FOR CR (Change Request), March 2018 -->
<jsp:useBean id="it_sub_cat" scope="request" class="niki.Sub_Category">
    <jsp:setProperty name="it_sub_cat" property="*" />
</jsp:useBean>

<% 
    int item_temp_id = Integer.parseInt(request.getParameter("item_temp_id"));
	//setting the original item id to be validated to a session attribute
	session.setAttribute("item_temp_id", ""+item_temp_id);

String category_id= request.getParameter("category_id").toUpperCase().replaceAll("'", " "); 
 
String item_commercial_name= request.getParameter("item_commercial_name").toUpperCase().replaceAll("'", " ");
String item_form= request.getParameter("item_form").toUpperCase().replaceAll("'", " "); 
String item_emballage= request.getParameter("item_emballage").toUpperCase().replaceAll("'", " ");
String item_inn= request.getParameter("item_inn").toUpperCase().replaceAll("'", " ");
String tax_vat= request.getParameter("tax_vat").toUpperCase().replaceAll("'", " ");
String tax_excise= "NA";//request.getParameter("tax_excise").toUpperCase().replaceAll("'", " "); 
String tax_duty= "NA";//request.getParameter("tax_duty").toUpperCase().replaceAll("'", " ");
String updated_time;
String item_fabricant= request.getParameter("item_fabricant").toUpperCase().replaceAll("'", " "); 
double item_packet= Double.parseDouble(request.getParameter("item_packet"));
int item_longeur_mm= Integer.parseInt(request.getParameter("item_longeur_mm"));
int item_largeur_mm= Integer.parseInt(request.getParameter("item_largeur_mm"));
int item_hauteur_mm= Integer.parseInt(request.getParameter("item_hauteur_mm"));
double item_poids_gr= Double.parseDouble(request.getParameter("item_poids_gr"));
double item_dosage= Double.parseDouble(request.getParameter("item_dosage"));
String shipment_type= request.getParameter("shipment_type").toUpperCase().replaceAll("'", " ");
String item_key_words= request.getParameter("item_key_words").toUpperCase().replaceAll("'", " ");
String hs_code= request.getParameter("hs_code").toUpperCase().replaceAll("'", " "); 
String gtin_code= request.getParameter("gtin_code").toUpperCase().replaceAll("'", " ");
String bar_code= request.getParameter("bar_code").toUpperCase().replaceAll("'", " ");
String created;
String global_id=  session.getAttribute("userInSessionfName").toString(); 
String bus_category_id= request.getParameter("bus_category_id").toUpperCase().replaceAll("'", " ");
String item_dose_unity= request.getParameter("item_dose_unity");


    
    
String []bsncatN = request.getParameterValues("bus_category_id");
    

    //getting the first 4chars of itmDescE 
    String itmDescEFirst4;
    String item_commercial_name3=item_commercial_name.replace(" ", "");//removing spaces in the string
    if(item_commercial_name3.length()<4){
    	itmDescEFirst4 = item_commercial_name3+"RRRRRRR";
        itmDescEFirst4 = item_commercial_name3.substring(0, 4);
    }
    else{
    	itmDescEFirst4 = item_commercial_name3.substring(0, 4);
    }

    /*
    STRUCTURING NIKI_CODE, CR (Change Request) March 2018
    */
    //getting subcategory abbreviation to be used in niki_code structuring
    it_sub_cat.setSubcategory_id(category_id.toUpperCase());
    String subCategoryAbbrev = it_sub_cat.getCategory_id().substring(0, 3); //TODO: have to check for the case it returns null
    
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
    if(bar_code.isEmpty() || bar_code=="null" || bar_code == null){
       bar_code=null;    
    } 
    
    itf.setItem_Final(  niki_code,   bar_code,   category_id, 
              item_temp_id,   item_commercial_name,   item_form, 
              item_emballage,   item_inn,   tax_vat,   tax_excise, 
              tax_duty,   item_fabricant,  item_packet,   item_longeur_mm,
                item_largeur_mm, item_hauteur_mm,   item_poids_gr,   item_dosage, 
              shipment_type,   item_key_words,   hs_code, 
              gtin_code,   bar_code,       global_id,   bus_category_id ,item_dose_unity); 
    
    //identifying the temp item we are validating
    it_tmp.setItem_id(item_temp_id); 
    
    it_bus_cat.setNiki_code(niki_code);//setting the niki_code of the item business category instance
    
    /*
    checking if the select values are empty and prompting the users to enter them if they are so
    */
    if(tax_vat.isEmpty()){
        itf.setInsertMsg("please select the taxrate ");
    }
    else if(bus_category_id == null){
        itf.setInsertMsg("please select the business category ");

    }
    /*
    checking if the inputs are valid
    */
    else if (itf.isValid()) {
     
        itf.setInsertMsg("it is valid ");
    	//inserting to the itemfinal
        if (itf.insertItem( )) {  //
        	//item is inserted in itemfinal successfully
            
        	boolean inserted=true; //variable to help to check if business categories are  inserted successfully
        	
        	//Matching an item to the selected business categories
            for (String bscat:bsncatN){ 
            	//for each selected business category
                it_bus_cat.setBusin_category_id(bscat.toUpperCase()); //setting the business category for the item
                inserted=it_bus_cat.insertItemBusinCategory(global_id);//inserting the business category
                            	
            }

            if(inserted){
            	//the item is matched with the business category successfully
                
                it_tmp.transformItem(); //update the status of the pending item to "transformed"

                //updating the niki_code of the transformed item
               it_tmp.setNiki_code(niki_code);
               it_tmp.addItemNiki_code();
               it_tmp.setInsertMsg("item validated successfully"); 
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
    it_tmp.getConn().close();//closing the connection of item temp
    it_bus_cat.getConn().close();//closing the connection of item business category
    itf.getConn().close();//closing the connection of item final
%>
<jsp:forward page="PendingItems.jsp?bus_category_id=<%=bus_category_id%>"/>
 

