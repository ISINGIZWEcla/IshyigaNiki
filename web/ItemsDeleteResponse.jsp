<%-- 
    Document   : ItemsDeleteResponse
    Created on : Mar 13, 2022, 5:42:45 PM
    Author     : Clarisse
--%>


<%@page import="javax.swing.JOptionPane"%>
<%@page import="niki.SheepmentType"%>
<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.*"%>
<%@page import="niki.Item_Final" %>
<%@page import="niki.Item_Temp" %>
<%@page import="niki.Item_Business_Category" %>
<html>

    <%
      class data {

            public String niki_code;
            public String item_commercial_name;
            public String tax_vat;
            public String status;
            public String item_fabricant;
            public String item_inn;
            public double item_packet;
            public String item_key_words;
            public String created;
            public String category_id;
            public int itemTempId;
            public String tax_excise;
            public String tax_duty;
            public String item_embellege;
            public String business_category_id;
            public String item_dosage_unity;
            public String bar_code;
            public String gtin_code;
            public String hs_code;
            public String shipment_type;
            public double item_dosage;
            public double item_poids_gr;
            public int item_longeur_mm;
            public int item_largeur_mm;
            public int item_hauteur_mm;
            public String item_form;
           // public SheepmentType sheepment_type;
            
        };
    
        String nikiCode = request.getParameter("nikicode");
          //String nikiCode="ACIAC.C00010";
        String querry = "select * from niki_items where niki_code='" + nikiCode + "';";
        data singleData = new data();
        try {
            Connection con = ConnectionClass.getConnection();
            Statement ST = con.createStatement();
            //PS.setString(1, nikiCode);
            ResultSet rs = ST.executeQuery(querry);

            while (rs.next()) {
                singleData.niki_code = rs.getString("niki_code");
                singleData.item_commercial_name = rs.getString("item_commercial_name");
                singleData.tax_vat = rs.getString("tax_vat");
                singleData.status = rs.getString("status");
                singleData.item_fabricant = rs.getString("item_fabricant");
                singleData.item_inn = rs.getString("item_inn");
                singleData.item_packet = rs.getDouble("item_packet");
                singleData.item_key_words = rs.getString("item_key_words");
                singleData.created = rs.getString("global_id");
                singleData.category_id = rs.getString("category_id");
                singleData.itemTempId = rs.getInt("item_temp_id");
                singleData.tax_excise = rs.getString("tax_excise");
                singleData.tax_duty = rs.getString("tax_duty");
                singleData.item_embellege = rs.getString("item_emballage");
                singleData.item_form = rs.getString("item_form");
                singleData.shipment_type = rs.getString("shipment_type");
                singleData.hs_code = rs.getString("Hs_code");
                singleData.gtin_code = rs.getString("gtin_code");
                singleData.bar_code = rs.getString("bar_code");
                singleData.item_dosage_unity = rs.getString("item_dosage_unity");
                singleData.business_category_id = rs.getString("bus_category_id");
                singleData.item_dosage = rs.getDouble("item_dosage");
                singleData.item_poids_gr = rs.getDouble("item_poids_gr");
                singleData.item_longeur_mm = rs.getInt("item_longeur_mm");
                singleData.item_largeur_mm = rs.getInt("item_largeur_mm");
                singleData.item_hauteur_mm = rs.getInt("item_hauteur_mm");
              System.out.println("Item form "+singleData.item_form);
            }
        } catch (Exception ex) {
        ex.printStackTrace();
        }
        String InsertQuerry = "INSERT INTO `niki_items_deleted`(`niki_code`, `item_temp_id`, `item_commercial_name`, `item_form`, `item_emballage`, `item_inn`, `category_id`, `bus_category_id`, `tax_vat`, `tax_excise`, `tax_duty`, `status`,`item_fabricant`, `item_packet`, `item_longeur_mm`, `item_largeur_mm`, `item_hauteur_mm`, `item_poids_gr`, `item_dosage`, `shipment_type`, `item_key_words`, `hs_code`, `gtin_code`, `bar_code`, `global_id`, `item_dosage_unity`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            Connection con = ConnectionClass.getConnection();
            Statement ST = con.createStatement();
            PreparedStatement ps = con.prepareStatement(InsertQuerry);
            ps.setString(1, singleData.niki_code);
            ps.setInt(2, singleData.itemTempId);
            ps.setString(3, singleData.item_commercial_name);
            ps.setString(4, singleData.item_form);
            ps.setString(5, singleData.item_embellege);
            ps.setString(6, singleData.item_inn);
            ps.setString(7, singleData.category_id);
            ps.setString(8, singleData.business_category_id);
            ps.setString(9, singleData.tax_vat);
            ps.setString(10, singleData.tax_excise);
            ps.setString(11, singleData.tax_duty);
            ps.setString(12, singleData.status);
            ps.setString(13, singleData.item_fabricant);
            ps.setDouble(14, singleData.item_packet);
            ps.setInt(15, singleData.item_longeur_mm);
            ps.setInt(16, singleData.item_largeur_mm);
            ps.setInt(17, singleData.item_hauteur_mm);
            ps.setDouble(18, singleData.item_poids_gr);
            ps.setDouble(19, singleData.item_poids_gr);
            ps.setString(20,singleData.shipment_type);
            ps.setString(21, singleData.item_key_words);
            ps.setString(22, singleData.hs_code);
            ps.setString(23, singleData.gtin_code);
            ps.setString(24, singleData.bar_code);
            ps.setString(25, singleData.created);
            ps.setString(26, singleData.item_dosage_unity);
            ps.executeUpdate();
            System.out.println("Successfully inserted..");
        } catch (Exception ex) {
          ex.printStackTrace();
        }
        try {
            String updateQuerry = "update niki_items_temp set status='REPLACED' where item_id='" + singleData.itemTempId + "' ";
            Connection con = ConnectionClass.getConnection();
            Statement ST = con.createStatement();
            ST.executeUpdate(updateQuerry);
System.out.println("Successfully updated id ="+singleData.itemTempId+" !");
        } catch (Exception ex) {
           ex.printStackTrace();
        }
  try {
            String deleteQuerry = "delete from niki_items where niki_code='" + nikiCode + "'";
            Connection con = ConnectionClass.getConnection();
            Statement ST = con.createStatement();
            ST.executeUpdate(deleteQuerry);
System.out.println("Successfully deleted niki item with the nic code="+nikiCode+" !");
        } catch (Exception ex) {
           ex.printStackTrace();
        }
    try {
            String deleteQuerry = "delete from niki_item_business_category where niki_code='" + nikiCode + "'";
            Connection con = ConnectionClass.getConnection();
            Statement ST = con.createStatement();

       ST.executeUpdate(deleteQuerry);
       System.out.println("Successfully deleted niki item with the nic code="+nikiCode+" !");
       
 }
        catch (Exception ex) {
          ex.printStackTrace();
        } 
    
     response.sendRedirect("Item.jsp");

   %>
  

   
 
</html>
