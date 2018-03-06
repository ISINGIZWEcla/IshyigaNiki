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
    private String itemDescriptionENGL;
    private String itemDescriptionKINYA;
    private String itemDescriptionFRENCH;
    private String itemDescriptionSWAHILI;
    private String subcategory_id;
    private String taxRate, taxRateMessage;
    private String busin_category_id;
    private String status="LIVE";
    private String insertMsg,selectMsg,updateMsg,error;
    private boolean valid = true;
    private String forOut1,forOut2;
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();


    /*
    constructors
    */

    public Item_Final() {
    }

    public Item_Final(String niki_code, String codebar, String itemDescriptionENGL, String itemDescriptionKINYA,
			String itemDescriptionFRENCH, String itemDescriptionSWAHILI, String subcategory_id, String taxRate,
			String taxRateMessage, String busin_category_id, String status) {
		super();
		this.niki_code = niki_code;
		this.codebar = codebar;
		this.itemDescriptionENGL = itemDescriptionENGL;
		this.itemDescriptionKINYA = itemDescriptionKINYA;
		this.itemDescriptionFRENCH = itemDescriptionFRENCH;
		this.itemDescriptionSWAHILI = itemDescriptionSWAHILI;
		this.subcategory_id = subcategory_id;
		this.taxRate = taxRate;
		this.taxRateMessage = taxRateMessage;
		this.busin_category_id = busin_category_id;
		this.status = status;
	}
    

    
    

    /*
    getters and setters
    */
    
    
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

    public String getItemDescriptionENGL() {
        return itemDescriptionENGL;
    }

    public void setItemDescriptionENGL(String itemDescriptionENGL) {
        this.itemDescriptionENGL = itemDescriptionENGL;
    }

    public String getItemDescriptionKINYA() {
        return itemDescriptionKINYA;
    }

    public void setItemDescriptionKINYA(String itemDescriptionKINYA) {
        this.itemDescriptionKINYA = itemDescriptionKINYA;
    }

    public String getItemDescriptionFRENCH() {
        return itemDescriptionFRENCH;
    }

    public void setItemDescriptionFRENCH(String itemDescriptionFRENCH) {
        this.itemDescriptionFRENCH = itemDescriptionFRENCH;
    }

    public String getItemDescriptionSWAHILI() {
        return itemDescriptionSWAHILI;
    }

    public void setItemDescriptionSWAHILI(String itemDescriptionSWAHILI) {
        this.itemDescriptionSWAHILI = itemDescriptionSWAHILI;
    }

    public String getSubcategory_id() {
        return subcategory_id;
    }

    public void setSubcategory_id(String subcategory_id) {
        this.subcategory_id = subcategory_id;
    }

    public String getBusin_category_id() {
        return busin_category_id;
    }

    public void setBusin_category_id(String busin_category_id) {
        this.busin_category_id = busin_category_id;
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

            PreparedStatement pst = conn.prepareStatement("insert into niki_items values(?,?,?,?,?,?,?,?,?,now())");
            
            /*
             * checking from the database for some conditions before we can insert items
             */
            PreparedStatement pst3 = conn.prepareStatement("select itemDesc_ENGL from niki_items where itemDesc_ENGL = ? or itemDesc_KINYA = ? or itemDesc_FRENCH = ? or itemDesc_SWAHILI = ? ");
            PreparedStatement pst5 = conn.prepareStatement("select itemDesc_ENGL from niki_items where codebar = ? and (codebar NOT IN ('','null') AND codebar IS NOT NULL) ");

            /*
             * setting the preparedstatement parameters
             */
            
            pst3.setString(1, itemDescriptionENGL);
            pst3.setString(2, itemDescriptionKINYA);
            pst3.setString(3, itemDescriptionFRENCH);
            pst3.setString(4, itemDescriptionSWAHILI);
            
            
            pst5.setString(1, codebar);            
            
            
            /*
            resultsets of the select statements
            */
            ResultSet rs1 = pst3.executeQuery();
            ResultSet rs3 = pst5.executeQuery();
            
            
 
            if(rs1.next())
            {
                //there is another item with the same description in the final items
            	String itmdesc = rs1.getString(1);

                insertMsg="that item already exists in final items list as: "+itmdesc;
                
                return false;
            }
            else if(rs3.next())
            {
                //there is another item with the same codebar in the final items

            	String itmdesc = rs3.getString(1);

                insertMsg="that barcode belongs to an existing item named: "+itmdesc;
                
                return false;
            }
            else
            {
            	pst.setString(1, niki_code);
                pst.setString(2, codebar);
                pst.setString(3, itemDescriptionENGL);
                pst.setString(4, itemDescriptionKINYA);
                pst.setString(5, itemDescriptionFRENCH);
                pst.setString(6, itemDescriptionSWAHILI);
                pst.setString(7, subcategory_id);
                pst.setString(8, taxRate);
                pst.setString(9, status);
                
                pst.execute();
                insertMsg="Successfully validated";
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
    	String statusFrmDb="";
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
            if(statusFrmDb.equals("LIVE")){
            	pst.setString(1, "SLEEPING");
            	insertMsg="Successfully slept";
            }
            else if(statusFrmDb.equals("SLEEPING")){
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
            PreparedStatement pst = conn.prepareStatement("update niki_items set codebar=?,itemDesc_ENGL = ?,itemDesc_FRENCH=?, itemDesc_KINYA=?, itemDesc_SWAHILI=?, subcategory_id=?, taxLabel = ?  where niki_code=? ");


            
            /*
             * checking if no other item has the same description as the  updated ones
             */
            PreparedStatement pst2 = conn.prepareStatement("select itemDesc_ENGL from niki_items where (itemDesc_ENGL = ? or itemDesc_FRENCH=? OR itemDesc_KINYA=? OR itemDesc_SWAHILI=?) and niki_code!=? ");

            PreparedStatement pst3 = conn.prepareStatement("select itemDesc_ENGL from niki_items where codebar = ? and (codebar NOT IN ('','null') AND codebar IS NOT NULL) and niki_code!=?");

            /*
             * deleting from niki_item_business_category table all business categories corresponding to the item to be updated,
             *  because new business categories will be specified
             */
            PreparedStatement pst4 = conn.prepareStatement("delete from niki_item_business_category where niki_code=?");

            
            
            
            /*
             * setting the preparedstatement parameters
             */
                                    
            pst2.setString(1, itemDescriptionENGL);
            pst2.setString(2, itemDescriptionFRENCH);
            pst2.setString(3, itemDescriptionKINYA);
            pst2.setString(4, itemDescriptionSWAHILI);
            pst2.setString(5, niki_code);
            
            pst3.setString(1, codebar);  
            pst3.setString(2, niki_code);  

            pst4.setString(1, niki_code);  

            
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
            else
            {
                pst4.execute();//delete business categories related to the item to be updated

                pst.setString(1, codebar);
                pst.setString(2, itemDescriptionENGL);
                pst.setString(3, itemDescriptionKINYA);
                pst.setString(4, itemDescriptionFRENCH);
                pst.setString(5, itemDescriptionSWAHILI);
                pst.setString(6, subcategory_id);
                pst.setString(7, taxRate);
                pst.setString(8, niki_code);
                                
                pst.execute(); //updating the item
                                
                conn.close(); 
                insertMsg="Successfully updated";
                return true;
            }
            
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not Inserted";
            return false;

        }
    }
    
    /*
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
