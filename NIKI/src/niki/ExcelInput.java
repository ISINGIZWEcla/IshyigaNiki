package niki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

/*
 * this class models the inputs from excel sheets
 */
public class ExcelInput {
	/*
	 * attributes
	 */
	private String fromExcelId;
	private String externalId;
	private String itemDesc;
	private String codebar;
	private String company;
	private String external_info_1;
	private String external_info_2;
	private Object username;
	private String filename;
	private String status = "PENDING";
	private boolean valid=true;
	private String niki_code="NOT VALIDATED";
    private String insertMsg,selectMsg,updateMsg,error;
		
	//connection instance
    Connection conn = ConnectionClass.getConnection();

	
	/*
	 * constructors
	 */

	public ExcelInput() {
		// TODO Auto-generated constructor stub
	}	
	
	public ExcelInput(String externalId, String itemDesc, String codebar, String username) {
		super();
		this.externalId = externalId;
		this.itemDesc = itemDesc;
		this.codebar = codebar;
		this.username = username;
	}



	/*
	 * getters and setters
	 */
	
	
	
	public String getExternalId() {
		return externalId;
	}

	public String getFromExcelId() {
		return fromExcelId;
	}

	public void setFromExcelId(String fromExcelId) {
		this.fromExcelId = fromExcelId;
	}

	public void setExternalId(String externalId) {
		this.externalId = externalId;
	}

	public String getItemDesc() {
		return itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public String getCodebar() {
		return codebar;
	}

	public void setCodebar(String codebar) {
		this.codebar = codebar;
	}

	public Object getUsername() {
		return username;
	}

	public void setUsername(Object username) {
		this.username = username;
	}
	
	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getInsertMsg() {
		return insertMsg;
	}

	public void setInsertMsg(String insertMsg) {
		this.insertMsg = insertMsg;
	}
	
	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	public String getExternal_info_1() {
		return external_info_1;
	}

	public void setExternal_info_1(String external_info_1) {
		this.external_info_1 = external_info_1;
	}

	public String getExternal_info_2() {
		return external_info_2;
	}

	public void setExternal_info_2(String external_info_2) {
		this.external_info_2 = external_info_2;
	}

	public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}
	
	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public boolean isValid() {
		return valid;
	}

	public void setValid(boolean valid) {
		this.valid = valid;
	}

	public String getNiki_code() {
		return niki_code;
	}

	public void setNiki_code(String niki_code) {
		this.niki_code = niki_code;
	}
	
	
	
	
	/*
	 * function that helps to record data from an excel sheet to a table
	 * returns true if it is successful and false otherwise
	 */

	public boolean insertExcelInput(){
		try 
        {

            PreparedStatement pst = conn.prepareStatement("insert into itemsfromexcel values(null,?,?,?,?,?,?,now(),?,?,?,?)");
           

           
            pst.setString(1, externalId);
            pst.setString(2, itemDesc);
            pst.setString(3, codebar);
            pst.setObject(4, company);
            pst.setString(5, external_info_1);
            pst.setString(6, external_info_2);
            pst.setObject(7, username);
            pst.setString(8, filename);
            pst.setString(9, niki_code); 
            pst.setString(10, status);
            
            pst.execute();
           // conn.close(); 
            insertMsg="Successfully inserted";
            return true;
            
        } catch (Exception e) {
            insertMsg="Not Inserted";
            setError(e.getMessage());
            return false;
        }
		
	}
	

	public String insertExcelLogs(String user,String filename,String companyname,int total,int inserted){
		try 
        {

            PreparedStatement pst = conn.prepareStatement
            		("insert into niki_excel_logs values(null,?,?,?,now(),?,?)");
           
         

           
            pst.setString(1, user);
            pst.setString(2, filename);
            pst.setString(3, companyname);
            pst.setInt(4, total);
            pst.setInt(5, inserted); 
            
            pst.execute();
           // conn.close(); 
            insertMsg="Successfully inserted";
          //  return true;
            
        } catch (Exception e) {
            insertMsg="insertExcelLogs Not Inserted "+e.getMessage();
            setError(e.getMessage());
            //return false;
        }
		return insertMsg;
	}
	
	
	/*
     * this function changes the status of an item to "rejected"
     * returns true if it is successful and false otherwise
     */
    public boolean rejectItem() {

        try {
            PreparedStatement pst = conn.prepareStatement("update itemsfromexcel set status = ?  where fromExceld=?");

  
            pst.setString(2, fromExcelId);
            pst.setString(1, "REJECTED");

            pst.execute();
            conn.close(); 
            insertMsg="Successfully rejected";
            return true;
            
            
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not rejected";
            return false;

        }
    }
    
    /*
     * this function change the status of an item to "transformed"
     * returns true if it is successful; or false otherwise
     */
    public boolean transformItem() {

        try {
            PreparedStatement pst = conn.prepareStatement("update itemsfromexcel set status = ?  where fromExceld=?");

  
            pst.setString(2, fromExcelId);
            pst.setString(1, "TRANSFORMED");

            pst.execute();
           // conn.close(); 
            insertMsg="Successfully transformed";
            return true;
            
            
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not transformed";
            return false;

        }
    }
    
    /*
     * this function get niki_code of a validated item and add it to that item
     * returns true if it is successful and false otherwise
     */
    public boolean addItemNiki_code() {

        try {
            PreparedStatement pst = conn.prepareStatement("update itemsfromexcel set niki_code = ?  where fromExceld=?");

  
            pst.setString(2, fromExcelId);
            pst.setString(1, niki_code);

            pst.execute();
            //conn.close(); 
            insertMsg="niki_code successfully added";
            return true;
            
            
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not successfully added";
            return false;

        }
    }
	
	
    /*
	 * function that helps TO delete data from trash
	 * returns true if it is successful and false otherwise
	 */


	public boolean deleteExcelInput(){
		try 
        {

            PreparedStatement pst = conn.prepareStatement("delete from itemsfromexcel where fromExceld = ? ");
 
            pst.setString(1, fromExcelId);
            
            pst.execute();
           // conn.close(); 
            insertMsg="Successfully deleted";
            return true;
            
            
        } catch (Exception e) {
            insertMsg="Not Inserted";
            setError(e.getMessage());
            return false;
        }
		
	}
	
	
	public boolean isRowDuplicate(String externalId, String company){
		try {
    		
    		PreparedStatement pst = conn.prepareStatement("select externalId from itemsfromexcel where externalId=? and company=?");
    		
    		pst.setString(1, externalId);
    		pst.setString(2, company);
    		
    		ResultSet rs = pst.executeQuery();
    		
    		if(rs.next()){
    			insertMsg=externalId+" NDIMO "+company	;
    			return true;
    		}
    		else{
    			return false;
    		}
			
		} catch (Exception e) {
			setError(e.getMessage());
			return true;
		}
	}

}
