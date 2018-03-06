/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package niki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author vakaniwabo
 */
public class Tax_Rate {
    private String taxLabel;
    private String taxValue;
    private String status="LIVE";
    private String insertMsg,selectMsg,updateMsg,error;
    private boolean valid=true;
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();

    public Tax_Rate() {
    }

    public Tax_Rate(String taxLabel, String taxValue) {
        this.taxLabel = taxLabel;
        this.taxValue = taxValue;
    }
    
    /*
    getters and setters
    */

    public String getTaxLabel() {
        return taxLabel;
    }

    public void setTaxLabel(String taxLabel) {
        this.taxLabel = taxLabel;
    }

    public String getTaxValue() {
        return taxValue;
    }

    public void setTaxValue(String taxValue) {
        this.taxValue = taxValue;
    }

    public String getInsertMsg() {
        return insertMsg;
    }

    public void setInsertMsg(String insertMsg) {
        this.insertMsg = insertMsg;
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
    
    /*
    end of getters and setters
    */
    
    public boolean insertTaxRate()
    {
        
        try 
        {

            PreparedStatement pst = conn.prepareStatement("insert into niki_tax_rates values(?,?,?)");
            PreparedStatement pst2 = conn.prepareStatement("select taxValue from niki_tax_rates where taxValue = '"+taxValue +"'");

            
            ResultSet rs = pst2.executeQuery();
            
            if(rs.next())
            {
                insertMsg="that tax value already exists";
                
                return false;
            }
            else
            {
                pst.setString(1, taxLabel); 
                pst.setString(2, taxValue);
                pst.setString(3, status);
                
                pst.execute();
                conn.close(); 
                insertMsg="Successfully inserted";
                return true;
            }
        } catch (Exception e) {
            insertMsg="Not Inserted";
            setError(e.getMessage());
            return false;
        }
        
    }
    
    
    /*
     * this methods changes the status of a selected taxrate from live to sleep
     * returns true if it does it successfully and false otherwise
     */
    public boolean sleepTaxrate() {
    	String statusFrmDb="";
        try {
        	PreparedStatement ps = conn.prepareStatement("select status from niki_tax_rates where taxLabel=?");
 
        	ps.setString(1, taxLabel);
        	
        	ResultSet rs = ps.executeQuery();
        	
        	while(rs.next()){
            	statusFrmDb = rs.getString("status");
        	}
        	
        	
        	
            PreparedStatement pst = conn.prepareStatement("update niki_tax_rates set status = ?  where taxLabel = ?");

  
            pst.setString(2, taxLabel ); 
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
     * this method allow to update a taxrate
     * returns true if it updates successfully and false otherwise
     */
    public boolean updateTaxrate() {

        try {
            PreparedStatement pst = conn.prepareStatement("update niki_tax_rates set taxValue=? where taxLabel=? ");


            /*
             * checking if no other taxrate has the same value as the  updated ones
             */
            PreparedStatement pst2 = conn.prepareStatement("select taxValue from niki_tax_rates where taxValue = ?  and taxLabel!=? ");

 
            /*
             * setting the preparedstatement parameters
             */
                                    
            pst2.setString(1, taxValue);
            pst2.setString(2, taxLabel);

            
            /*
            resultsets of the select statements
            */
            ResultSet rs = pst2.executeQuery();
            
                        
            if(rs.next())
            {
            	//there is another item with the same description in the final items
            	String taxLbl = rs.getString(1);

                insertMsg="that subcategory already exists as: "+taxLbl;
                
                return false;
            }
           
            else
            {

                pst.setString(1, taxValue);
                pst.setString(2, taxLabel);   
                
                
                                
                pst.execute(); //updating the taxrate
                                
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
    
    
}
