/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package niki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author vakaniwabo
 */
public class Category {
    private String category_id;
    private String category_descr;
    private String status="LIVE";
    private String insertMsg,selectMsg,updateMsg,error;
    private boolean valid=true;
    
    private String category_parent;
    private String category_french;
    private String category_kinya; 
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();

    public Category() {
    }

    public Category(String category_id, String category_descr) {
        this.category_id = category_id;
        this.category_descr = category_descr;
    }

    
    /*
    getters and setters
    */
    
    public String getCategory_id() {
        return category_id;
    }

    public void setCategory_id(String category_id) {
        this.category_id = category_id;
    }

    public String getCategory_descr() {
        return category_descr;
    }

    public void setCategory_descr(String category_descr) {
        this.category_descr = category_descr;
    }
     public void setCategory_parent(String category_parent) {
        this.category_parent = category_parent;
    }
      public void setCategory_french(String category_french) {
        this.category_french = category_french;
    }
       public void setCategory_kinya(String category_kinya) {
        this.category_kinya = category_kinya;
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
    
    
    public boolean insertCategory(String user)
    {
        
        try 
        {

           String insert = "insert into niki_categories "
                   + "(`category_id`,`category_descr`,`status`,`parent_category`,"
                   + "`french_catagory_name`,`kinya_catagory_name`,`global_id`)"
                   + " values(?,?,?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(insert);
            PreparedStatement pst2 = conn.prepareStatement("select category_descr from niki_categories where category_descr = '"+category_descr +"'");
   
            ResultSet rs = pst2.executeQuery();
            
            if(rs.next())
            {
                insertMsg="that category name already exists";
                
                return false;
            }
            else
            {
                pst.setString(1, category_id); 
                pst.setString(2, category_descr);
                pst.setString(3, status);
                pst.setString(4, category_parent); 
                pst.setString(5, category_french);
                pst.setString(6, category_kinya);
                pst.setString(7, user);
                pst.executeUpdate();
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
    public boolean sleepCategory() {
    	String statusFrmDb="";
        try {
        	PreparedStatement ps = conn.prepareStatement("select status from niki_categories where category_id=?");
 
        	ps.setString(1, category_id);
        	
        	ResultSet rs = ps.executeQuery();
        	
        	while(rs.next()){
            	statusFrmDb = rs.getString("status");
        	}
        	
        	
        	
            PreparedStatement pst = conn.prepareStatement("update niki_categories set status = ?  where category_id=?");

  
            pst.setString(2, category_id);
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
    
  
     public String updateCategory2() {

          String sql="update niki_categories "
                    + " set category_descr='"+category_descr+"' ,"
                        + " parent_category='"+category_parent+"',"
                        + " french_catagory_name='"+category_french+"',"
                    +   "kinya_catagory_name='"+category_kinya+"' where "
                        + " category_id='"+category_id+"' ";
          
      //    out.print("sql  "+sql);
        
        try {
            
            Statement state = conn.createStatement(); 
                state.execute(sql);
                conn.close(); 
                insertMsg="Successfully updated hey 2 "+sql;
                return sql;
            
            
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not Inserted";
            return null;

        }
    }
    
    
}
