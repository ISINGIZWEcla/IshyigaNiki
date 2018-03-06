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
public class Sub_Category {
    private String subcategory_id;
    private String subcategory_descr;
    private String status="LIVE";
    private String category_id;
    private String insertMsg,selectMsg,updateMsg,error;
    private boolean valid=true;
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();

    public Sub_Category() {
    }

    public Sub_Category(String subcategory_id, String subcategory_descr, String category_id) {
        this.subcategory_id = subcategory_id;
        this.subcategory_descr = subcategory_descr;
        this.category_id = category_id;
    }

    /*
    getters and setters
    */
    
    public String getSubcategory_id() {
        return subcategory_id;
    }

    public void setSubcategory_id(String subcategory_id) {
        this.subcategory_id = subcategory_id;
    }

    public String getSubcategory_descr() {
        return subcategory_descr;
    }

    public void setSubcategory_descr(String subcategory_descr) {
        this.subcategory_descr = subcategory_descr;
    }

    public String getCategory_id() {
        return category_id;
    }

    public void setCategory_id(String category_id) {
        this.category_id = category_id;
    }
    

    public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
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
    
    public boolean insertSubcategory()
    {
        
        try 
        {

            PreparedStatement pst = conn.prepareStatement("insert into niki_subcategories values(?,?,?,?)");
            PreparedStatement pst2 = conn.prepareStatement("select subcategory_descr from niki_subcategories where subcategory_descr = '"+subcategory_descr +"'");

            
            ResultSet rs = pst2.executeQuery();
            
            if(rs.next())
            {
                insertMsg="that category name already exists";
                
                return false;
            }
            else
            {
                pst.setString(3, category_id); 
                pst.setString(1, subcategory_id);
                pst.setString(2, subcategory_descr);
                pst.setString(4, status);
                
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
     * this methods changes the status of a selected business category from live to sleep
     * returns true if it does it successfully and false otherwise
     */
    public boolean sleepSubCategory() {
    	String statusFrmDb="";
        try {
        	PreparedStatement ps = conn.prepareStatement("select status from niki_subcategories where subcategory_id=?");
 
        	ps.setString(1, subcategory_id);
        	
        	ResultSet rs = ps.executeQuery();
        	
        	while(rs.next()){
            	statusFrmDb = rs.getString("status");
        	}
        	
        	
        	
            PreparedStatement pst = conn.prepareStatement("update niki_subcategories set status = ?  where subcategory_id=?");

  
            pst.setString(2, subcategory_id);
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
     * this method allow to update a subcategory
     * returns true if it updates successfully and false otherwise
     */
    public boolean updateSubcategory() {

        try {
            PreparedStatement pst = conn.prepareStatement("update niki_subcategories set subcategory_descr=?, category_id=? where subcategory_id=? ");


            /*
             * checking if no other subcategor has the same description as the  updated ones
             */
            PreparedStatement pst2 = conn.prepareStatement("select subcategory_descr from niki_subcategories where subcategory_descr = ?  and subcategory_id!=? ");

 
            /*
             * setting the preparedstatement parameters
             */
                                    
            pst2.setString(1, subcategory_descr);
            pst2.setString(2, subcategory_id);

            
            /*
            resultsets of the select statements
            */
            ResultSet rs = pst2.executeQuery();
            
                        
            if(rs.next())
            {
            	//there is another item with the same description in the final items
            	String subcat = rs.getString(1);

                insertMsg="that subcategory already exists as: "+subcat;
                
                return false;
            }
           
            else
            {

                pst.setString(1, subcategory_descr);
                pst.setString(2, category_id);              
                pst.setString(3, subcategory_id);
             
                                
                pst.execute(); //updating the subcategory
                                
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
