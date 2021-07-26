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
public class Manufacture {
    
      String fabricant_id;
      String niki_fabricant_name;
      String niki_fabricant_country;
      String global_id;
     public String insertMsg,selectMsg,updateMsg,error;
     
    
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();

    public void setManufacture(String fabricant_id, String niki_fabricant_name, 
            String niki_fabricant_country, String global_id) {
        this.fabricant_id = fabricant_id;
        this.niki_fabricant_name = niki_fabricant_name;
        this.niki_fabricant_country = niki_fabricant_country;
        this.global_id = global_id;
    } 
    
    public boolean insertFabricant()
    { 
        try 
        { 
           String insert = "insert into niki_fabricant "
                   + "(`fabricant_id`,`niki_fabricant_name`,`niki_fabricant_country`"
                   + ",`global_id`)"
                   + " values(?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(insert);
            PreparedStatement pst2 = conn.prepareStatement("select fabricant_id from niki_fabricant where fabricant_id = '"+fabricant_id +"'");
   
            ResultSet rs = pst2.executeQuery();
            
            if(rs.next())
            {
                insertMsg="that category name already exists";
                
                return false;
            }
            else
            {
                pst.setString(1, fabricant_id); 
                pst.setString(2, niki_fabricant_name);
                pst.setString(3, niki_fabricant_country);
                pst.setString(4, global_id);  
                pst.executeUpdate();
                conn.close(); 
                insertMsg="Successfully inserted";
                return true;
            }
        } catch (Exception e) {
            insertMsg="Not Inserted"; 
            return false;
        }     
}
    
}