/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package niki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Administrator
 */
public class Niki_request {

    public int item_id;
    public String item_external_id;
    public String id_company;
    String codebar;
    public String itemDesc,itemInn;
    String subcategory_id;
    public String busin_category_id;
    public String status;
    String langue;
    String user_name;
    String time;
    public String niki_code;
    double packet;
    int hauteur;
    int longeur;
    int largeur;
    double poids;
    String fabricant;
    String tax_rate;
    String hs_codeString;
    String NIKI;
    String STATUS;
    int dosage;
    String brand,form,dosage_unity,emballage;

    public Niki_request(int item_id, String item_external_id, String codebar,
            String itemDesc, String subcategory_id, String busin_category_id,
            String status, String langue, String user_name, String time, String niki_code,
            double packet, int hauteur, int longeur, int largeur, double poids,
            String fabricant, String tax_rate, String hs_codeString, String id_company) {
        this.id_company = id_company;
        this.item_id = item_id;
        this.item_external_id = item_external_id;
        this.codebar = codebar;
        this.itemDesc = itemDesc;
        this.subcategory_id = subcategory_id;
        this.busin_category_id = busin_category_id;
        this.status = status;
        this.langue = langue;
        this.user_name = user_name;
        this.time = time;
        this.niki_code = niki_code;
        this.packet = packet;
        this.hauteur = hauteur;
        this.longeur = longeur;
        this.largeur = largeur;
        this.poids = poids;
        this.fabricant = fabricant;
        this.tax_rate = tax_rate;
        this.hs_codeString = hs_codeString;
    }

       public Niki_request(int item_id, String item_external_id, String codebar,
            String itemDesc, String subcategory_id, String busin_category_id,
            String status, String langue, String user_name, String time, String niki_code,
            double packet, int hauteur, int longeur, int largeur, double poids,
            String fabricant, String tax_rate, String hs_codeString, String id_company,
            int dosage,String dosage_unity,String form,String emballage,String brand) {
        this.id_company = id_company;
        this.item_id = item_id;
        this.item_external_id = item_external_id;
        this.codebar = codebar;
        this.itemDesc = itemDesc;
        this.subcategory_id = subcategory_id;
        this.busin_category_id = busin_category_id;
        this.status = status;
        this.langue = langue;
        this.user_name = user_name;
        this.time = time;
        this.niki_code = niki_code;
        this.packet = packet;
        this.hauteur = hauteur;
        this.longeur = longeur;
        this.largeur = largeur;
        this.poids = poids;
        this.fabricant = fabricant;
        this.tax_rate = tax_rate;
        this.hs_codeString = hs_codeString;
        
        this.dosage=dosage;
        this.dosage_unity=dosage_unity;
        this.form=form;
        this.emballage=emballage;
        this.brand=brand;
    }
    
    
    public String getXml() {
        return "<item_id>" + item_id + "</item_id>"
                + "<item_external_id>" + item_external_id + "</item_external_id>"
                + "<id_company>" + id_company + "</id_company>"
                + "<codebar>" + codebar + "</codebar>"
                + "<itemDesc>" + itemDesc + "</itemDesc>"
                + "<subcategory_id>" + subcategory_id + "</subcategory_id>"
                + "<busin_category_id>" + busin_category_id + "</busin_category_id>"
                + "<status>" + status + "</status>"
                + "<langue>" + langue + "</langue>"
                + "<user_name>" + user_name + "</user_name>"
                + "<time>" + time + "</time>"
                + "<niki_code>" + niki_code + "</niki_code>"
                + "<packet>" + packet + "</packet>"
                + "<hauteur>" + hauteur + "</hauteur>"
                + "<longeur>" + longeur + "</longeur>"
                + "<largeur>" + largeur + "</largeur>"
                + "<poids>" + poids + "</poids>"
                + "<fabricant>" + fabricant + "</fabricant>"
                + "<tax_rate>" + tax_rate + "</tax_rate>"
                + "<hs_codeString>" + hs_codeString + "</hs_codeString>"
                + "<itemInn>" + itemInn + "</itemInn>";

    }
    public String addNikiRequestExcel(Connection conn){
        
        try {
            PreparedStatement pst = conn.prepareStatement
                       
        ("INSERT INTO `niki`.`niki_items_temp` ("
                    
                    + "item_external_id,"
                    + "codebar,"
                    + "itemDesc,"
                    + "subcategory_id,"
                    + "busin_category_id,"
                    + "status,"
                    + "langue,"
                    + "user_name,"
                    + "packet,"
                    + "hauteur,"
                    + "longeur,"
                    + "largeur,"
                    + "poids," 
                    + "fabricant,"
                    + "tax_rate,"
                    + "hs_code,"
                    + "company_id,molecular_name,"
                    +"item_dosage,item_dosage_unity,"
                    +"item_form,item_emballage,item_brand )"
                    + " values(?,?,?,?,?,?,?,?"
                           + ",?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            
            
            pst.setString(1, item_external_id);
            pst.setString(2, codebar);
            pst.setString(3, itemDesc);
            pst.setString(4, subcategory_id);
            pst.setString(5, busin_category_id);
            pst.setString(6, "PENDING");
            pst.setString(7, langue);
            pst.setString(8, user_name);
            pst.setDouble(9, packet);
            pst.setInt(10, hauteur);
            pst.setInt(11, longeur);
            pst.setInt(12, largeur);
            pst.setDouble(13, poids);
            pst.setString(14, fabricant);
            pst.setString(15, tax_rate);
            pst.setString(16, hs_codeString);
            pst.setString(17, id_company);
            pst.setString(18, itemInn);
            
            pst.setInt(19, dosage);
            pst.setString(20, dosage_unity);
            pst.setString(21, form);
            pst.setString(22, emballage);
            pst.setString(23, brand);
            
            pst.execute(); 
                    return "WELL INSERTED";
                    } catch (SQLException ex) {
                        
                        return "NAMENETSE "+ex;
          //  Logger.getLogger(Niki_request.class.getName()).log(Level.SEVERE, null, ex);
        }
 
    }
    public String addNikiRequest(Connection conn) {
      
        try {
            PreparedStatement pst = conn.prepareStatement
                       
        ("INSERT INTO `niki`.`niki_items_temp` ("
                    
                    + "item_external_id,"
                    + "codebar,"
                    + "itemDesc,"
                    + "subcategory_id,"
                    + "busin_category_id,"
                    + "status,"
                    + "langue,"
                    + "user_name,"
                    + "packet,"
                    + "hauteur,"
                    + "longeur,"
                    + "largeur,"
                    + "poids," 
                    + "fabricant,"
                    + "tax_rate,"
                    + "hs_code,"
                    + "company_id,molecular_name )"
                    + " values(?,?,?,?,?,?,?,?"
                           + ",?,?,?,?,?,?,?,?,?,?)");
            
            
            pst.setString(1, item_external_id);
            pst.setString(2, codebar);
            pst.setString(3, itemDesc);
            pst.setString(4, subcategory_id);
            pst.setString(5, busin_category_id);
            pst.setString(6, "PENDING");
            pst.setString(7, langue);
            pst.setString(8, user_name);
            pst.setDouble(9, packet);
            pst.setInt(10, hauteur);
            pst.setInt(11, longeur);
            pst.setInt(12, largeur);
            pst.setDouble(13, poids);
            pst.setString(14, fabricant);
            pst.setString(15, tax_rate);
            pst.setString(16, hs_codeString);
            pst.setString(17, id_company);
            pst.setString(18, itemInn);
            
            pst.execute(); 
                    return "WELL INSERTED";
                    } catch (SQLException ex) {
                        
                        return "NAMENETSE "+ex;
          //  Logger.getLogger(Niki_request.class.getName()).log(Level.SEVERE, null, ex);
        }
 
    }

    public Niki_request(String xml) {

        //   System.out.println("+++++++++++++++++++++     " + xml);
        
        this.itemInn =  getTagValue("itemInn", xml);
        this.item_id = 0;//Integer.parseInt(getTagValue("item_id", xml));
        this.item_external_id = getTagValue("item_external_id", xml);
        this.codebar = getTagValue("codebar", xml);
        this.itemDesc = getTagValue("itemDesc", xml);
        this.subcategory_id = getTagValue("subcategory_id", xml);
        this.busin_category_id = getTagValue("busin_category_id", xml);
        this.status = getTagValue("status", xml);
        this.langue = getTagValue("langue", xml);
        this.user_name = getTagValue("user_name", xml);
        this.time = getTagValue("time", xml);
        this.niki_code = getTagValue("niki_code", xml);
        try {
            this.packet = Double.parseDouble(getTagValue("packet", xml));
            this.hauteur = Integer.parseInt(getTagValue("hauteur", xml));
            this.longeur = Integer.parseInt(getTagValue("longeur", xml));
            this.largeur = Integer.parseInt(getTagValue("largeur", xml));
            this.poids = Double.parseDouble(getTagValue("poids", xml));
            this.dosage = Integer.parseInt(getTagValue("dosage", xml));
        } catch (NumberFormatException n) {
            numberError = xml + " " + n;
        }
        this.fabricant = getTagValue("fabricant", xml);
        this.tax_rate = getTagValue("tax_rate", xml);
        this.hs_codeString = getTagValue("hs_codeString", xml);
        this.id_company = getTagValue("id_company", xml);
        
        this.dosage_unity=getTagValue("dosage_unity", xml);
        this.form=getTagValue("form", xml);
        this.emballage=getTagValue("emballage", xml);
        this.brand=getTagValue("brand", xml);

    }
   
    String numberError;

    public static String getTagValue(String tag, String xmlData) {
        try {
            //  System.out.println("<"+tag+"> ---- "+xmlData+" ")", xml); 
            String[] splitStart = xmlData.split("<" + tag + ">");
//    System.out.println("<"+tag+"> -- 0  -- "+splitStart[0]+" ");
//    System.out.println("<"+tag+"> 11  "+splitStart[1]+" ");
            if (splitStart.length == 0)// != null && splitStart[0] =! null)
            {
                return "";
            }
            if (splitStart.length == 1)// != null && splitStart[0] =! null)
            {
                return "";
            } else {
                String[] splitEnd = splitStart[1].split("</" + tag + ">");

                return splitEnd[0];
            }
        } catch (Throwable ex) {
            System.err.println(ex + " : ");
            return "ERROR " + ex;
        }

    }
    
    
    

}
