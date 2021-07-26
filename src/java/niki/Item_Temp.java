package niki;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author vakaniwabo
 */
public class Item_Temp {
	/*
	 * attributes
	 */
	private int item_id;
	private String item_external_id;
    private String codebar;
    private String itemDescription;
    private String subcategory_id;
    private String busin_category_id;
    private String status = "PENDING";
    private String language;
    private String username;
    private String niki_code="NOT VALIDATED";
    private String insertMsg,selectMsg,updateMsg,error;
    private boolean valid = true, toberejected=false;
    private String forOut1,forOut2;
    
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();

    /*
     * constructors
     */
    public Item_Temp() {
    }

    
    public Item_Temp(int item_id, String item_external_id, String codebar, String itemDescription,
			String subcategory_id, String busin_category_id, String status, String language, String username,
			String niki_code) {
		super();
		this.item_id = item_id;
		this.item_external_id = item_external_id;
		this.codebar = codebar;
		this.itemDescription = itemDescription;
		this.subcategory_id = subcategory_id;
		this.busin_category_id = busin_category_id;
		this.status = status;
		this.language = language;
		this.username = username;
		this.niki_code = niki_code;
	}
    

    /*
    getters and setters
    */
    
    public int getItem_id() {
		return item_id;
	}

	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}

	public String getItem_external_id() {
		return item_external_id;
	}

	public void setItem_external_id(String item_external_id) {
		this.item_external_id = item_external_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}


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

    public String getItemDescription() {
        return itemDescription;
    }

    public void setItemDescription(String itemDescription) {
        this.itemDescription = itemDescription;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public boolean isToberejected() {
		return toberejected;
	}


	public void setToberejected(boolean toberejected) {
		this.toberejected = toberejected;
	}


	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
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
    
    /*
    end of getters and setters
    */
 
    
    /*
     * this functions adds an item in niki_items_temp table after doing some checking to see if the same item doesn't exist already
     * returns true if it is done successfully and false otherwise
     */
    public boolean insertItem()
    {
        
        try 
        {
        	/*String insert = "INSERT INTO books(author, title, year, remark)" +
        		    "VALUES (?, ?, ?, ?)";
        	PreparedStatement ps = conn.prepareStatement(insert);
        	
        	ps.executeUpdate();*/
        	
            PreparedStatement pst = conn.prepareStatement("insert into niki_items_temp values(?,?,?,?,?,?,?,?,?,?,?)");
            
            PreparedStatement pst2 = conn.prepareStatement("select itemDesc,status from niki_items_temp where itemDesc = ? ");
            PreparedStatement pst3 = conn.prepareStatement("select niki_code,itemDesc_ENGL from niki_items where itemDesc_ENGL = ? or itemDesc_KINYA = ? or itemDesc_FRENCH = ? or itemDesc_SWAHILI = ? ");
            PreparedStatement pst4 = conn.prepareStatement("select itemDesc,status from niki_items_temp where codebar = ? and (codebar NOT IN ('','null') AND codebar IS NOT NULL) ");
            PreparedStatement pst5 = conn.prepareStatement("select itemDesc_ENGL from niki_items where codebar = ? and (codebar NOT IN ('','null') AND codebar IS NOT NULL) ");

            /*
             * setting the preparedstatement parameters
             */
            pst2.setString(1, itemDescription);
            
            pst3.setString(1, itemDescription);
            pst3.setString(2, itemDescription);
            pst3.setString(3, itemDescription);
            pst3.setString(4, itemDescription);
            
            pst4.setString(1, codebar);
            
            pst5.setString(1, codebar);
            
            
            
            /*
            resultsets of the select statements
            */
            ResultSet rs = pst2.executeQuery();
            ResultSet rs1 = pst3.executeQuery();
            ResultSet rs2 = pst4.executeQuery();
            ResultSet rs3 = pst5.executeQuery();
            
            
            /*if(rs.next())
            {
                //there is another item with the same description in the temporary items
            	
            	String itmdesc = rs.getString(1);
            	String sta = rs.getString(2);
            	
                insertMsg="that item already exists as "+itmdesc+" ; it is in "+sta+ " items";
                
                return false;
            }*/
            /*else if(rs1.next())
            {
                //there is another item with the same description in the final items
            	String itmdesc = rs1.getString(1);

                insertMsg="that item already exists in final items list as: "+itmdesc;
                
                return false;
            }
*/          if(rs2.next())
            {
                //there is another item with the same codebar in the temporary items
            	
            	String itmdesc = rs2.getString(1);
            	String sta = rs2.getString(2);
            	
                insertMsg="that barcode belongs to an existing item named: "+itmdesc+" ; it is in "+sta+" items";
                
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
            	if(rs1.next())
                {
                    //there is another item with the same description in the final items
                    toberejected=true;
                    niki_code = rs1.getString(1);
                    status="REJECTED";
                }
            	pst.setString(1, null); 
            	pst.setString(2, item_external_id); 
                pst.setString(3, codebar); 
                pst.setString(4, itemDescription);
                pst.setString(5, subcategory_id);
                pst.setString(6, busin_category_id);
                pst.setString(7, status);
                pst.setString(8, language);
                pst.setString(9, username);
                
                String timeStamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());

                
                pst.setString(10, timeStamp); 
                pst.setString(11, niki_code); 
                
                pst.execute();
                //conn.close(); 
                insertMsg="Successfully inserted";
                
                
                
                return true;
            }
        } catch (Exception e) {
            insertMsg="Not Inserted"+e.getMessage();
            setError(e.getMessage());
            return false;
        }
        
    } 
    
    /*
     * this function changes the status of an item to "rejected"
     * returns true if it is successful and false otherwise
     */
    public boolean rejectItem() {

        try { 
    String sql =   "update niki_items_temp set status = 'REJECTED',"
            + "niki_code ='"+niki_code+"'  where item_id=" +item_id ;   
           
Statement state =conn.createStatement();  

state.execute(sql) ;

            conn.close(); 
           // insertMsg="Successfully rejected "+sql;
            
            insertMsg=itemDescription+" Successfully rejected "+niki_code;
            
            return true;
            
            
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not rejected";
            return false;

        }
    }
    
    /*
     * this function change the status of an item to "transformed"
     * returns true if it is successful and false otherwise
     */
    public boolean transformItem() {

        try {
            PreparedStatement pst = conn.prepareStatement("update niki_items_temp set status = ?  where item_id=?");

  
            pst.setInt(2, item_id);
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
            PreparedStatement pst = conn.prepareStatement("update niki_items_temp set niki_code = ?  where item_id=?");

  
            pst.setInt(2, item_id);
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
    
    
}
