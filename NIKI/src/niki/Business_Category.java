package niki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Business_Category {

	public Business_Category() {
		// TODO Auto-generated constructor stub
	}
	
	
	private String busin_category_id;
    private String busin_category_descr;
    private String status="LIVE";
    private String insertMsg,selectMsg,updateMsg,error;
    private boolean valid=true;
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();

 
    public Business_Category(String busin_category_id, String busin_category_descr) {
        this.busin_category_id = busin_category_id;
        this.busin_category_descr = busin_category_descr;
    }
    
    
    /*
    getters and setters
    */

    public String getBusin_category_id() {
        return busin_category_id;
    }

    public void setBusin_category_id(String busin_category_id) {
        this.busin_category_id = busin_category_id;
    }

    public String getBusin_category_descr() {
        return busin_category_descr;
    }

    public void setBusin_category_descr(String busin_category_descr) {
        this.busin_category_descr = busin_category_descr;
    }


    public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
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

    public Connection getConn() {
        return conn;
    }

    public void setConn(Connection conn) {
        this.conn = conn;
    }
    
    /*
    end of getters and setters
    */
    
    
    
    
    public boolean insertBusinCategory()
    {
        
        try 
        {

            PreparedStatement pst = conn.prepareStatement("insert into niki_business_categories values(?,?,?)");
            PreparedStatement pst2 = conn.prepareStatement("select busin_category_descr from niki_business_categories where busin_category_descr = '"+busin_category_descr +"'");

            
            ResultSet rs = pst2.executeQuery();
            
            if(rs.next())
            {
                insertMsg="that category name already exists";
                
                return false;
            }
            else
            {
                pst.setString(1, busin_category_id); 
                pst.setString(2, busin_category_descr);
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
     * this methods changes the status of a selected business category from live to sleep
     * returns true if it does it successfully and false otherwise
     */
    public boolean sleepBusinessCategory() {
    	String statusFrmDb="";
        try {
        	PreparedStatement ps = conn.prepareStatement("select status from niki_business_categories where busin_category_id=?");
 
        	ps.setString(1, busin_category_id);
        	
        	ResultSet rs = ps.executeQuery();
        	
        	while(rs.next()){
            	statusFrmDb = rs.getString("status");
        	}
        	
        	
        	
            PreparedStatement pst = conn.prepareStatement("update niki_business_categories set status = ?  where busin_category_id=?");

  
            pst.setString(2, busin_category_id);
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
    public boolean updateBusinessCategory() {

        try {
            PreparedStatement pst = conn.prepareStatement("update niki_business_categories set busin_category_descr=? where busin_category_id=? ");


            /*
             * checking if no other business category has the same description as the  updated ones
             */
            PreparedStatement pst2 = conn.prepareStatement("select busin_category_descr from niki_business_categories where busin_category_descr = ?  and busin_category_id!=? ");

 
            /*
             * setting the preparedstatement parameters
             */
                                    
            pst2.setString(1, busin_category_descr);
            pst2.setString(2, busin_category_id);

            
            /*
            resultsets of the select statements
            */
            ResultSet rs = pst2.executeQuery();
            
                        
            if(rs.next())
            {
            	//there is another item with the same description in the final items
            	String buscat = rs.getString(1);

                insertMsg="that business category already exists as: "+buscat;
                
                return false;
            }
           
            else
            {

                pst.setString(1, busin_category_descr);
                pst.setString(2, busin_category_id);                           
                                
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
