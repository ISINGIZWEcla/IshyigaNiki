
<%-- Document   : ItemResponse
    Created on : May 25, 2016, 4:53:26 PM
    Author     : vakaniwabo
--%>


<%@page import="niki.Item_Temp" %>

<jsp:useBean id="it_tmp" scope="request" class="niki.Item_Temp">
    <jsp:setProperty name="it_tmp" property="*" />
</jsp:useBean>


<%

	String itmNum = request.getParameter("itm_num").toUpperCase().replaceAll("'", " ");
    String codeb = request.getParameter("cdb").toUpperCase().replaceAll("'", " ");
    String itmDesc = request.getParameter("itmd").toUpperCase().replaceAll("'", " ");
    String itmcatN = request.getParameter("itcat").toUpperCase().replaceAll("'", " ");
    String bscatN = request.getParameter("busin_cat").toUpperCase().replaceAll("'", " ");
    String language = request.getParameter("lang").toUpperCase().replaceAll("'", " ");
    String username = session.getAttribute("userInSessionUsername").toString().toUpperCase();
    
    session.setAttribute("ItemSearched", null);

    
    it_tmp.setItem_external_id(itmNum);
    /* if(codeb==""){
    	it_tmp.setCodebar(null);
    }
    else{ */
    	it_tmp.setCodebar(codeb);    	
    //}
    it_tmp.setItemDescription(itmDesc);
    it_tmp.setSubcategory_id(itmcatN);
    it_tmp.setBusin_category_id(bscatN);
    it_tmp.setLanguage(language);
    it_tmp.setUsername(username);
    
   // it_tmp.setTime();
    
    
   
    if(itmcatN.isEmpty()){
        it_tmp.setInsertMsg("please select the item category ");

    }
    else if(bscatN.isEmpty()){
        it_tmp.setInsertMsg("please select your business category ");

    }
    else if (it_tmp.isValid()) {
    	//calling the method to insert the item in temporary items
        it_tmp.insertItem();
    	if(it_tmp.isToberejected()){
    		it_tmp.setInsertMsg("successfully associated to an existing item");
    	}


    }else {
        it_tmp.setInsertMsg("Invalid data");
    
    }
%>


<jsp:forward page="Item.jsp"/>

