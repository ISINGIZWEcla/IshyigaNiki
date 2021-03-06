package niki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Promotions_list {

	public Promotions_list() {
		// TODO Auto-generated constructor stub
	}
	
int promo_code,niki_promotions_qte,niki_promotions_discount;
String niki_code,type;
double niki_promotions_amount,purchase_price;
 
    public String insertMsg,selectMsg,updateMsg,error;
    private boolean valid=true; 
    //connection instance
    Connection conn = ConnectionClass.getConnection();

    public  void setPromotions_list(int promo_code, int niki_promotions_qte,
            int niki_promotions_discount, String niki_code, String type, 
            double niki_promotions_amount) {
        this.promo_code = promo_code;
        this.niki_promotions_qte = niki_promotions_qte;
        this.niki_promotions_discount = niki_promotions_discount;
        this.niki_code = niki_code;
        this.type = type;
        this.niki_promotions_amount = niki_promotions_amount;
//        this.purchase_price=purchase_price;
    } 
      public  void setPromotions_list2(int promo_code, int niki_promotions_qte,
            int niki_promotions_discount, String niki_code, 
            double niki_promotions_amount,double purchase_price) {
        this.promo_code = promo_code;
        this.niki_promotions_qte = niki_promotions_qte;
        this.niki_promotions_discount = niki_promotions_discount;
        this.niki_code = niki_code;
        this.niki_promotions_amount = niki_promotions_amount;
        this.purchase_price=purchase_price;
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
                + "<niki_code>" + niki_code + "</niki_code>"
                + "<type>" + type + "</type>"
                + "<niki_promotions_qte>" + niki_promotions_qte + "</niki_promotions_qte>"
                + "<niki_promotions_amount>" + niki_promotions_amount + "</niki_promotions_amount>"
                + "<niki_promotions_discount>" + niki_promotions_discount + "</niki_promotions_discount>" ;
    }
    
    public boolean updatePromoList(){
        try {
            PreparedStatement pst = conn.prepareStatement("update niki_promotions_list set niki_promotions_amount = ?,niki_promotions_purchase=?,niki_promotions_qte=?,niki_promotions_discount=?  where promo_code=? and niki_code=?");
            pst.setDouble(1, niki_promotions_amount);
            pst.setDouble(2, purchase_price);
            pst.setDouble(3,niki_promotions_qte);
            pst.setDouble(4, niki_promotions_discount);
            pst.setInt(5, promo_code);
            pst.setString(6, niki_code);
            	insertMsg="Successfully Updated";

            pst.execute();
            conn.close(); 
            
            return true;
                        
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not Updated";
            return false;
        }   
    }
    public boolean insertPromoList()
    {
        
        try 
        {

String sql="INSERT INTO `niki`.`niki_promotions_list`" +
"(`promo_code`," +
"`niki_code`," +
"`type`," +
"`niki_promotions_qte`," +
"`niki_promotions_amount`," +
"`niki_promotions_discount`,`niki_promotions_purchase`)"
        + ""
        + "values(?,?,?,?,?,?,?)";
 PreparedStatement pst = conn.prepareStatement (sql);
 
 PreparedStatement pst2 = conn.prepareStatement
        ("select * from niki_promotions_list "
                + "where promo_code = "+promo_code +" and"
                        + " niki_code='"+niki_code +"'  and "
                        + " type ='"+type +"' ");

            
            ResultSet rs = pst2.executeQuery();
            
            if(rs.next())
            {
                insertMsg=promo_code+" "+niki_code+"  " +type+ " that promotion combination name already exists";
                
                return false;
            }
            else
            { 
                pst.setInt(1, promo_code); 
                pst.setString(2, niki_code);
                pst.setString(3, type);
                pst.setInt(4, niki_promotions_qte); 
                pst.setDouble(5, niki_promotions_amount);
                pst.setInt(6, niki_promotions_discount);
                pst.setDouble(7, purchase_price);
                
                pst.execute();
                conn.close(); 
                insertMsg="Successfully inserted";
                return true;
            }
        } catch (Exception e) {
            insertMsg="Not Inserted "+e.getMessage();
            setError(e.getMessage());
            return false;
        }
        
    }
       public boolean removeItem() {

        try {

            PreparedStatement pst = conn.prepareStatement("delete from niki_promotions_list where promo_code=? and niki_code=?");

            pst.setInt(1, promo_code);
            pst.setString(2, niki_code);


            pst.execute();
            conn.close();
            // insertMsg="Successfully insert";
            return true;
        } catch (Exception e) {
            //InsertMsg="Not Inserted u repeat username";
            return false;

        }
    }  

}
