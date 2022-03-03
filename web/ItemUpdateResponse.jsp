<%-- 
    Document   : ItemUpdateResponse
    Created on : May 31, 2016, 6:34:45 PM
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


<%
    /*
getting parameters from update input page
     */
    String ngezehe = "start";
    String niki_code = request.getParameter("niki_code");
    session.setAttribute("niki", niki_code);	//keeping niki code in a session for letter use

    String category_id = request.getParameter("category_id").toUpperCase().replaceAll("'", " ");

    String item_commercial_name = request.getParameter("item_commercial_name").toUpperCase().replaceAll("'", " ");
    String item_form = request.getParameter("item_form").toUpperCase().replaceAll("'", " ");
    String item_emballage = request.getParameter("item_emballage").toUpperCase().replaceAll("'", " ");
    String item_inn = request.getParameter("item_inn").toUpperCase().replaceAll("'", " ");
    String tax_vat = request.getParameter("tax_vat").toUpperCase().replaceAll("'", " ");
    String tax_excise = "NA";//request.getParameter("tax_excise").toUpperCase().replaceAll("'", " "); 
    String tax_duty = "NA";//request.getParameter("tax_duty").toUpperCase().replaceAll("'", " ");
    String updated_time;
    String item_fabricant = request.getParameter("item_fabricant").toUpperCase().replaceAll("'", " ");
    double item_packet = Double.parseDouble(request.getParameter("item_packet"));
    int item_longeur_mm = Integer.parseInt(request.getParameter("item_longeur_mm"));
    int item_largeur_mm = Integer.parseInt(request.getParameter("item_largeur_mm"));
    int item_hauteur_mm = Integer.parseInt(request.getParameter("item_hauteur_mm"));
    double item_poids_gr = Double.parseDouble(request.getParameter("item_poids_gr"));
    double item_dosage = Double.parseDouble(request.getParameter("item_dosage"));
    String shipment_type = request.getParameter("shipment_type").toUpperCase().replaceAll("'", " ");
    String item_key_words = request.getParameter("item_key_words").toUpperCase().replaceAll("'", " ");
    String hs_code = request.getParameter("hs_code").toUpperCase().replaceAll("'", " ");
    String gtin_code = request.getParameter("gtin_code").toUpperCase().replaceAll("'", " ");
    String bar_code = request.getParameter("bar_code").toUpperCase().replaceAll("'", " ");
    String created;
    String global_id = session.getAttribute("userInSessionfName").toString();
    String bus_category_id = request.getParameter("bus_category_id").toUpperCase().replaceAll("'", " ");
    String item_dosage_unity = request.getParameter("item_dosage_unity");
    String[] bsncatN = request.getParameterValues("bus_category_id");
    ngezehe += "\n " + item_fabricant;
    itf.setItem_Final(niki_code, bar_code, category_id,
            0, item_commercial_name, item_form,
            item_emballage, item_inn, tax_vat, tax_excise,
            tax_duty, item_fabricant, item_packet, item_longeur_mm,
            item_largeur_mm, item_hauteur_mm, item_poids_gr, item_dosage,
            shipment_type, item_key_words, hs_code,
            gtin_code, bar_code, global_id, bus_category_id, item_dosage_unity);

    ngezehe += "\n initiated" + item_commercial_name;
    it_bus_cat.setNiki_code(niki_code);
    /*
    checking the inputs and calling the method to update
     */
    if (tax_vat.isEmpty()) {
        itf.setInsertMsg("please select the taxrate ");
    } else if (item_commercial_name.isEmpty()) {
        itf.setInsertMsg("please select the item_commercial_name ");
    } else if (itf.isValid()) {

        boolean sql = itf.updateItem();

        ngezehe += "\n initiated" + itf.getInsertMsg();
        if (sql) {
            //Matching an item to the selected business categories
            for (String bscat : bsncatN) {
                //for each selected business category
                it_bus_cat.setBusin_category_id(bscat.toUpperCase()); //setting the business category for the item
                it_bus_cat.insertItemBusinCategory(global_id);//inserting the business category

            }
            itf.setInsertMsg("Successfuly updated");
            ngezehe += "\n vyote vyote ni muzuri";
        }
    } else {
        itf.setInsertMsg("Invalid data");
        ngezehe += "\n Invalid data";
    }
    if (ngezehe.contains("vyote vyote")) { ngezehe=item_commercial_name+" well UPDATED! <BR>"; %><%   %> <%} else {%><%=ngezehe%> <%}
%>

<div style="float: left;margin-right:20px">
    <form action="Item.jsp">
        
        <input type="submit" style="font-weight:bold; background: pink; width: 
               15em; height: 12em;color: black;" 
               value="BACK TO NIKI LIST "/>
    </form> 
</div>

