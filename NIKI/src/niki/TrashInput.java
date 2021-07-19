package niki;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Timestamp;

/*
 * this class models the inputs from excel sheets
 */

public class TrashInput {

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
	private Timestamp time;
	private Object usernameExc;
	private Object username;
	private String filename;
	private String status;
	private boolean valid=true;
	private String niki_code;
    private String insertMsg,selectMsg,updateMsg,error;
		
	//connection instance
    Connection conn = ConnectionClass.getConnection();

	
	/*
	 * constructors
	 */

	public TrashInput() {
		// TODO Auto-generated constructor stub
	}	
	
	public TrashInput(String externalId, String itemDesc, String codebar, String username) {
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
	

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}
	
	public Object getUsernameExc() {
		return usernameExc;
	}

	public void setUsernameExc(Object usernameExc) {
		this.usernameExc = usernameExc;
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
	 * function that helps TO put rejected data (from an excel sheet) INTO a trash table
	 * returns true if it is successful and false otherwise
	 */


	public boolean insertTrashInput(){
		try 
        {

            PreparedStatement pst = conn.prepareStatement("insert into Trash_from_excel values(?,?,?,?,?,?,?,?,now(),?,?,?,?,?)");
           

            pst.setString(1, fromExcelId);
            pst.setString(2, externalId);
            pst.setString(3, itemDesc);
            pst.setString(4, codebar);
            pst.setObject(5, company);
            pst.setString(6, external_info_1);
            pst.setString(7, external_info_2);
            pst.setTimestamp(8, time);
            pst.setObject(9, usernameExc);
            pst.setObject(10, username);
            pst.setString(11, filename);
            pst.setString(12, niki_code); 
            pst.setString(13, status);
            
            
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
	
	 /*
     * this function get niki_code of a rejected item and add it to that item in Trash
     * returns true if it is successful and false otherwise
     */
    public boolean addItemNiki_code() {

        try {
            PreparedStatement pst = conn.prepareStatement("update Trash_from_excel set t_niki_code = ?  where t_fromExceld=?");

  
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


	public boolean deleteTrashInput(){
		try 
        {

            PreparedStatement pst = conn.prepareStatement("delete from Trash_from_excel where t_fromExceld = ? ");
 
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
	
		
	
	

}
