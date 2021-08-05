/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package niki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.regex.Pattern;

import java.sql.*;

/**
 *
 * @author vakaniwabo
 */
public class Item_Final {
    
    
    private String niki_code;
    private String codebar; 
    private String category_id;
    private String taxRate, taxRateMessage; 
    private int item_temp_id;
   private String item_commercial_name; 
    private String item_form; 
   private  String item_emballage; 
   private String item_inn;  
   private String tax_vat; 
   private String tax_excise; 
   private String tax_duty;  
   private String updated_time; 
   private String item_fabricant; 
   private double item_packet; 
   private int item_longeur_mm; 
   private int item_largeur_mm; 
   private int item_hauteur_mm; 
   private double item_poids_gr; 
   private double item_dosage; 
   private String shipment_type; 
   private String item_key_words; 
   private String hs_code; 
   private String gtin_code; 
   private String bar_code; 
   private String created; 
   private String global_id; 
   private String bus_category_id;  
    private String status="LIVE";
    private String insertMsg,selectMsg,updateMsg,error;
    private boolean valid = true;
    private String forOut1,forOut2;
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();


    /*
    constructors
    */
public Item_Final(){}

    public void setItem_Final(String niki_code, String codebar, String category_id,  
            int item_temp_id, String item_commercial_name, String item_form, 
            String item_emballage, String item_inn, String tax_vat, String tax_excise, 
            String tax_duty,  String item_fabricant, 
            double item_packet, int item_longeur_mm, int item_largeur_mm, 
            int item_hauteur_mm, double item_poids_gr, double item_dosage, 
            String shipment_type, String item_key_words, String hs_code, 
            String gtin_code, String bar_code, String global_id, 
            String bus_category_id ) {
        this.niki_code = niki_code;
        this.codebar = codebar;
        this.category_id = category_id;  
        this.item_temp_id = item_temp_id;
        this.item_commercial_name = item_commercial_name;
        this.item_form = item_form;
        this.item_emballage = item_emballage;
        this.item_inn = item_inn;
        this.tax_vat = tax_vat;
        this.tax_excise = tax_excise;
        this.tax_duty = tax_duty; 
        this.item_fabricant = item_fabricant;
        this.item_packet = item_packet;
        this.item_longeur_mm = item_longeur_mm;
        this.item_largeur_mm = item_largeur_mm;
        this.item_hauteur_mm = item_hauteur_mm;
        this.item_poids_gr = item_poids_gr;
        this.item_dosage = item_dosage;
        this.shipment_type = shipment_type;
        this.item_key_words = item_key_words;
        this.hs_code = hs_code;
        this.gtin_code = gtin_code;
        this.bar_code = bar_code; 
        this.global_id = global_id;
        this.bus_category_id = bus_category_id; 
	}

    public String getNiki_code() {
        return niki_code;
    }

	public void setNiki_code(String niki_code) {
		this.niki_code = niki_code;
	}

	public String getCodebar() {
        return codebar;
    }

	public void setCodebar(String codebar) {
        this.codebar = codebar;
    }
 
 
 
    public String getTaxRate() {
        return taxRate; 
    }

    public void setTaxRate(String taxRate) {
        this.taxRate = taxRate;
        
        if(taxRate.length()== 1)
        {
            if(Pattern.matches("[A-Z]+", taxRate) ) 
            { 
                setValid(true);
                
            } 
            else 
            { 
                setValid(false);
                setTaxRateMessage("it must be an alphabet in capital");
            }
        }
        else
        {
            setTaxRateMessage("it must be one character");
        }
    }

    public String getTaxRateMessage() {
        return taxRateMessage;
    }

    public void setTaxRateMessage(String taxRateMessage) {
        this.taxRateMessage = taxRateMessage;
    }

    public String getInsertMsg() {
        return insertMsg;
    }

    public void setInsertMsg(String insertMsg) {
        this.insertMsg = insertMsg;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public String getForOut1() {
        return forOut1;
    }

    public void setForOut1(String forOut1) {
        this.forOut1 = forOut1;
    }

    public String getForOut2() {
        return forOut2;
    }

    public void setForOut2(String forOut2) {
        this.forOut2 = forOut2;
    }

    public String getSelectMsg() {
        return selectMsg;
    }

    public void setSelectMsg(String selectMsg) {
        this.selectMsg = selectMsg;
    }

    public String getUpdateMsg() {
        return updateMsg;
    }

    public void setUpdateMsg(String updateMsg) {
        this.updateMsg = updateMsg;
    }

    public Connection getConn() {
        return conn;
    }

    public void setConn(Connection conn) {
        this.conn = conn;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
   
    /*
    end of getters and setters
    */
    
    
    /*
     * this methods adds an item to final items table
     * returns true if it is successful and false otherwise
     */
    public boolean insertItem()
    {
        
        try 
        { 
            
            
String sqlInsert = 
"INSERT INTO `niki`.`niki_items` "
        + " (`niki_code`," +
"`item_commercial_name`," +
"`item_form`," +
"`item_emballage`," +
"`item_inn`," +
"`category_id`," +
"`tax_vat`," +
"`tax_excise`," +
"`tax_duty`," +
"`status`," +
"`item_temp_id`," +
"`item_fabricant`," +
"`item_packet`," +
"`item_longeur_mm`," +
"`item_largeur_mm`," +
"`item_hauteur_mm`," +
"`item_poids_gr`," +
"`item_dosage`," +
"`shipment_type`," +
"`item_key_words`," +
"`hs_code`," +
"`gtin_code`," +
"`bar_code`," + 
"`global_id`)"
                    + " values (?,?,?,?"
        + ",?,?,?,?"
        + ",?,?,?,?"
        + ",?,?,?,?"
        + ",?,?,?,?"
        + ",?,?,?,?)";
            
            
             
            
            PreparedStatement pst3 = conn.prepareStatement("select item_commercial_name from niki_items where item_commercial_name = ? ");
            PreparedStatement pst5 = conn.prepareStatement("select item_commercial_name from niki_items where bar_code = ? and (bar_code NOT IN ('','null') AND bar_code IS NOT NULL) ");
 
            pst3.setString(1, item_commercial_name);  
            pst5.setString(1, codebar);     
            ResultSet rs1 = pst3.executeQuery();
            ResultSet rs3 = pst5.executeQuery(); 
 
            if(rs1.next())
            {
                //there is another item with the same description in the final items
            	String itmdesc = rs1.getString(1); 
                insertMsg="that item already exists in final items list as: "+itmdesc;
                 conn.close(); 
                return false;
            }
            else if(rs3.next())
            { 
            	String itmdesc = rs3.getString(1); 
                insertMsg="that barcode belongs to an existing item named: "+itmdesc; 
                 conn.close(); 
                return false;
            }
            else
            {
                PreparedStatement pst = conn.prepareStatement(sqlInsert);
            	pst.setString(1, niki_code);
                pst.setString(2, item_commercial_name);
                pst.setString(3, item_form);
                pst.setString(4, item_emballage);
                pst.setString(5, item_inn);
                pst.setString(6, category_id);
                pst.setString(7, tax_vat);
                pst.setString(8, tax_excise);
                pst.setString(9, tax_duty);  
                pst.setString(10, status);
   
                pst.setInt(11, item_temp_id);
                pst.setString(12, item_fabricant);
                pst.setDouble(13, item_packet);
                pst.setInt(14, item_longeur_mm);
                pst.setInt(15, item_largeur_mm);
                pst.setInt(16, item_hauteur_mm);
                pst.setDouble(17, item_poids_gr);
                pst.setDouble(18, item_dosage);
                pst.setString(19, shipment_type);
                pst.setString(20, item_key_words);
                pst.setString(21, hs_code);
                pst.setString(22, gtin_code);
                pst.setString(23, bar_code);
                pst.setString(24, global_id); 
                
                pst.execute();
                insertMsg= " Successfully validated";
                conn.close(); 
                return true;
            }
        } catch (Exception e) {
            insertMsg="Not validated";
            setError(e.getMessage());
            
            return false;
        }
        
    }
    
    
    /*
     * this methods changes the status of a selected item from live to sleep
     * returns true if it does it successfully and false otherwise
     */
    public boolean sleepItem() {
    	String statusFrmDb;
        try {
        	PreparedStatement ps = conn.prepareStatement("select status from niki_items where niki_code=?");
 
        	ps.setString(1, niki_code);
        	
        	ResultSet rs = ps.executeQuery();
        	
        	while(rs.next()){
            	statusFrmDb = rs.getString("status");
        	}
        	
        	
        	
            PreparedStatement pst = conn.prepareStatement("update niki_items set status = ?  where niki_code=?");

  
            pst.setString(2, niki_code);
            pst.setString(1, "SLEEPING");
            if(status.equals("LIVE")){
            	pst.setString(1, "SLEEPING");
            	insertMsg="Successfully slept";
            }
            else if(status.equals("SLEEPING")){
            	pst.setString(1, "LIVE");
            	insertMsg="Successfully made LIVE";
            }

            pst.execute();
            conn.close(); 
            
            return true;
                        
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not slept";
            return false;
        }
        
    }
    

    /*
     * this method allow to update an item
     * returns true if it updates successfully and false otherwise
     */
    public boolean updateItem() {

        try {
            PreparedStatement pst = conn.prepareStatement("update niki_items set bar_code=?,itemDesc_ENGL = ?,itemDesc_FRENCH=?, itemDesc_KINYA=?, itemDesc_SWAHILI=?, subcategory_id=?, taxLabel = ?  where niki_code=? ");


            
            /*
             * checking if no other item has the same description as the  updated ones
             */
            PreparedStatement pst2 = conn.prepareStatement("select itemDesc_ENGL from niki_items where (itemDesc_ENGL = ? or itemDesc_FRENCH=? OR itemDesc_KINYA=? OR itemDesc_SWAHILI=?) and niki_code!=? ");

            PreparedStatement pst3 = conn.prepareStatement("select itemDesc_ENGL from niki_items where bar_code = ? and (bar_code NOT IN ('','null') AND bar_code IS NOT NULL) and niki_code!=?");

            /*
             * deleting from niki_item_business_category table all business categories corresponding to the item to be updated,
             *  because new business categories will be specified
             */
           
            /*
             * setting the preparedstatement parameters
             */
              
            pst3.setString(1, codebar);  
            pst3.setString(2, niki_code);  
 
            
            /*
            resultsets of the select statements
            */
            ResultSet rs = pst2.executeQuery();

            ResultSet rs2 = pst3.executeQuery();
            
                        
            if(rs.next())
            {
            	//there is another item with the same description in the final items
            	String itmdesc = rs.getString(1);

                insertMsg="that item already exists in final items list as: "+itmdesc;
                
                return false;
            }
            else if(rs2.next())
            {
                //there is another item with the same codebar in the final items

            	String itmdesc = rs2.getString(1);

                insertMsg="that barcode belongs to an existing item named: "+itmdesc;
                
                return false;
            } 
            
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not Inserted";
            return false;

        }
        return false;
    }
    
    
    /*
     * (CR)Change Request  March 2018
     * This function counts the number of items that are in the final Items table that have the 
     * Parameter: subcategory_abbreviation
     */
    
    public int countItemsInSubcategory(String subCategoryAbbrev){
    	try{
    		
    		PreparedStatement pst1 = conn.prepareStatement("select count(niki_code) from niki_items where niki_code like '"+subCategoryAbbrev+"%' ");
    		
    		ResultSet rs = pst1.executeQuery();
    		int numberOfItemsInSubcategory = 0;
    		if(rs.next()){
    			numberOfItemsInSubcategory = rs.getInt(1);
    		}
    		
    		return numberOfItemsInSubcategory;
    	}catch (Exception e) {
    		setError(e.getMessage());
    		return 0;
		}
    	
    }
    
    
    /*
     ***************TODO: TO REMOVE THIS FUNCTION NO LONGER USED, CR MARCH 2018**********
     * this function helps to get the items niki_code
     * it returns an auto-incremented number to add on the items niki_code
     */
    public int insertCode()
    {
    	int key=0;
        try 
        {

            PreparedStatement pst = conn.prepareStatement("insert into niki_codes values(?)", Statement.RETURN_GENERATED_KEYS);
            
           // Statement statement = conn.createStatement();
           // statement.executeUpdate("insert into niki_codes values(?)", Statement.RETURN_GENERATED_KEYS);
            
            pst.setString(1, null);
            pst.execute();
            
            ResultSet rs = pst.getGeneratedKeys();

            if (rs != null && rs.next()) {
               key = rs.getInt(1);
            } 
           
            //Successfully inserted and the auto-incremented value returned
            return key;
            
        } catch (Exception e) {
            //Not Inserted
            setError(e.getMessage());
            return 1111;
        }
        
    }
    
}
