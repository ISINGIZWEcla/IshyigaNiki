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
public class Company {
    private String company_id;
    private String company_descr;
    private String status="LIVE";
    private String busin_category;
    private String insertMsg,selectMsg,updateMsg,error;
    private boolean valid=true;
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();

    public Company() {
    }

    public Company(String company_id, String company_descr) {
        this.company_id = company_id;
        this.company_descr = company_descr;
    }

    
    /*
    getters and setters
    */
    


    public String getStatus() {
		return status;
	}

	public String getCompany_id() {
		return company_id;
	}

	public void setCompany_id(String company_id) {
		this.company_id = company_id;
	}

	public String getCompany_descr() {
		return company_descr;
	}

	public void setCompany_descr(String company_descr) {
		this.company_descr = company_descr;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getBusin_category() {
		return busin_category;
	}

	public void setBusin_category(String busin_category) {
		this.busin_category = busin_category;
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
    
    
    public boolean insertCompany()
    {
        
        try 
        {

        	String insert = "insert into niki_companies values(?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(insert);
            
            PreparedStatement pst2 = conn.prepareStatement("select companyName from niki_companies where companyName = '"+company_descr +"'");

            
            ResultSet rs = pst2.executeQuery();
            
            if(rs.next())
            {
                insertMsg="that company name already exists";
                
                return false;
            }
            else
            {
                pst.setString(1, company_id); 
                pst.setString(2, company_descr);
                pst.setString(3, status);
                pst.setString(4, busin_category);
                
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
     * this methods changes the status of a selected company from live to sleep
     * returns true if it does it successfully and false otherwise
     */
    public boolean sleepCompany() {
    	String statusFrmDb="";
        try {
        	PreparedStatement ps = conn.prepareStatement("select status from niki_companies where companyId=?");
 
        	ps.setString(1, company_id);
        	
        	ResultSet rs = ps.executeQuery();
        	
        	while(rs.next()){
            	statusFrmDb = rs.getString("status");
        	}
        	
        	
        	
            PreparedStatement pst = conn.prepareStatement("update niki_companies set status = ?  where companyId=?");

  
            pst.setString(2, company_id);
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
     * this method allow to update a company
     * returns true if it updates successfully and false otherwise
     */
    public boolean updateCompany() {

        try {
            PreparedStatement pst = conn.prepareStatement("update niki_companies set companyName=?, busin_category_id=? where companyId=? ");


            /*
             * checking if no other category has the same description as the  updated ones
             */
            PreparedStatement pst2 = conn.prepareStatement("select companyName from niki_companies where companyName = ?  and companyId!=? ");

 
            /*
             * setting the preparedstatement parameters
             */
                                    
            pst2.setString(1, company_descr);
            pst2.setString(2, company_id);

            
            /*
            resultsets of the select statements
            */
            ResultSet rs = pst2.executeQuery();
            
                        
            if(rs.next())
            {
            	//there is another category with the same description
            	String comp = rs.getString(1);

                insertMsg="that item company already exists as: "+comp;
                
                return false;
            }
           
            else
            {

                pst.setString(1, company_descr);
                pst.setString(3, company_id);
                pst.setString(2, busin_category);  
             
                                
                pst.execute(); //updating the category
                                
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
