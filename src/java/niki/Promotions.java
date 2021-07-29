package niki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import static niki.Niki_request.getTagValue;

public class Promotions {
public final static DateFormat DATEFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");

	public Promotions() {
		// TODO Auto-generated constructor stub
	}
	public static String geToday()
        {
        
        return DATEFORMAT.format((new Date()).getTime());
        }

    public String promo_name,start,end,niki_company_id,bus_cat_id ;
    double maximum_budget;
    public int promo_code,maximum_qty;
    String global_id,status="LIVE";
    private String insertMsg,selectMsg,updateMsg,error;
    private boolean valid=true; 
    //connection instance
    Connection conn = ConnectionClass.getConnection();

    
    public Promotions(String xml) {  
        this.bus_cat_id = getTagValue("bus_cat_id", xml); 
    }
    
    public void setPromotions(String promo_name, String start, String end, String niki_company_id,
            String bus_cat_id,String global_id, double maximum_budget, int promo_code, int maximum_qty) {
        this.global_id = global_id;
        this.promo_name = promo_name;
        this.start = start;
        this.end = end;
        this.niki_company_id = niki_company_id;
        this.bus_cat_id = bus_cat_id;
        this.maximum_budget = maximum_budget;
        this.promo_code = promo_code;
        this.maximum_qty = maximum_qty;
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
    
      public String getXml()
    {
    
    return     "<promo_code>" + promo_code + "</promo_code>"
                + "<start>" + start + "</start>"
                + "<end>" + end + "</end>"
                + "<global_id>" + global_id + "</global_id>"
                + "<niki_company_id>" + niki_company_id + "</niki_company_id>"
                + "<bus_cat_id>" + bus_cat_id + "</bus_cat_id>"
                + "<maximum_budget>" + maximum_budget + "</maximum_budget>"
                + "<maximum_qty>" + maximum_qty + "</maximum_qty>";
    }  
    
    
    public String insertPromotion()
    {
        
        try 
        {
String sql="INSERT INTO `niki`.`niki_promotions`" +
"(`promo_name`," +
"`start`," +
"`end`," +
"`global_id`," +
"`niki_company_id`," +
"`bus_cat_id`," +
"`maximum_budget`," +
"`maximum_qty`,"
        + "`status`)" 
        + ""
        + "values(?,?,?,?,?,?,?,?,?)";
 PreparedStatement pst = conn.prepareStatement (sql);
 
 PreparedStatement pst2 = conn.prepareStatement
        ("select promo_name from niki_promotions where promo_name = '"+promo_name +"'");

            
            ResultSet rs = pst2.executeQuery();
            
            if(rs.next())
            {
                insertMsg="that promotion name already exists";
                
                return insertMsg;
            }
            else
            {  
                pst.setString(1, promo_name); 
                pst.setString(2, start);
                pst.setString(3, end);
                pst.setString(4, global_id); 
                pst.setString(5, niki_company_id);
                pst.setString(6, bus_cat_id);
                pst.setDouble(7, maximum_budget);
                pst.setInt(8, maximum_qty);
                pst.setString(9, status);
                
                
                pst.execute();
                conn.close(); 
                insertMsg="Successfully inserted";
                return insertMsg;
            }
        } catch (Exception e) {
            insertMsg=e.getMessage()+" Not Inserted";
            setError(e.getMessage());
            return insertMsg;
        }
        
    }
    
    
    /*
     * this methods changes the status of a selected business category from live to sleep
     * returns true if it does it successfully and false otherwise
     */
    public boolean sleepBusinessCategory() {
    	String statusFrmDb="";
        try {
        	PreparedStatement ps = conn.prepareStatement
        ("select status from niki_promotions where promo_name=?");
 
        	ps.setString(1, promo_name);
        	
        	ResultSet rs = ps.executeQuery();
        	
        	while(rs.next()){
            	statusFrmDb = rs.getString("status");
        	}
        	
        	
        	
            PreparedStatement pst = conn.prepareStatement(
                    "update niki_promotions set status = ?  where promo_name=?");

  
            pst.setString(2, promo_name);
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
    
    

}
