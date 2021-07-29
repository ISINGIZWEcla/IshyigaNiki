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
public class Item_Business_Category {
    private String niki_code;
    private String busin_category_id;
    public String insertMsg,selectMsg,updateMsg,error;
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();

    public Item_Business_Category() {
    }

    public Item_Business_Category(String niki_code, String busin_category_id) {
        this.niki_code = niki_code;
        this.busin_category_id = busin_category_id;
    }

    
    
/*
 * getters and setters
 */
    
    public String getNiki_code() {
 		return niki_code;
 	}

 	public void setNiki_code(String niki_code) {
 		this.niki_code = niki_code;
 	}

    public String getBusin_category_id() {
        return busin_category_id;
    }

	public void setBusin_category_id(String busin_category_id) {
        this.busin_category_id = busin_category_id;
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
     
    public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}

	public boolean insertItemBusinCategory(String global_id){
        try
        {
            
        String sql="INSERT INTO `niki`.`niki_item_business_category` "
        + " (`niki_code`," +
"`busin_category_id`,`global_id`)"
                + ""
                + "values(?,?,?)";    
            
            
            
            PreparedStatement pst = conn.prepareStatement(sql);
            
                pst.setString(1, niki_code); 
                pst.setString(2, busin_category_id);
                pst.setString(3, global_id);
                pst.execute();
                
                insertMsg="item business categ successfully inserted";
                //conn.close(); 

          
            return true;
        }
        catch(Exception e){
            setError(e.getMessage());
            
            insertMsg="item categ not inserted "+e;

            return false;
        }
    }
    //TODO: is this function necessary? if yes, I have to look for the right structure
    
    public boolean updateItemBusinCategory() {
        
        try {
            PreparedStatement pst = conn.prepareStatement("update niki_item_business_category set busin_category_id = ? where busin_category_id = ? and niki_code=?");

            
        
                pst.setString(3, niki_code);
                pst.setString(1, busin_category_id);
                pst.setString(2, busin_category_id);
                
                pst.execute();
                conn.close(); 
                insertMsg="Successfully updated";
                return true;
         
        } catch (Exception e) {
            //InsertMsg="Not Inserted u repeat username";
            return false;

        }
    }
    
    
}
