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
public class Emballage {
    
      String niki_emballage_id;
      String niki_emballage_name;
      String niki_emballage_info;
      String global_id; 
      public String insertMsg,selectMsg,updateMsg,error; 

      
         Connection conn = ConnectionClass.getConnection();
      
    public void  setEmballage(String niki_emballage_id, String niki_emballage_name, String niki_emballage_info, String global_id) {
        this.niki_emballage_id = niki_emballage_id;
        this.niki_emballage_name = niki_emballage_name;
        this.niki_emballage_info = niki_emballage_info;
        this.global_id = global_id;
    }
     
       public boolean insertPack()
    { 
        try 
        { 
           String insert = "insert into niki_emballage "
                   + "(`niki_emballage_id`,`niki_emballage_name`,`niki_emballage_info`"
                   + ",`global_id`)"
                   + " values(?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(insert);
            PreparedStatement pst2 = conn.prepareStatement("select niki_emballage_id from niki_emballage where niki_emballage_id = '"+niki_emballage_id +"'");
   
            ResultSet rs = pst2.executeQuery();
            
            if(rs.next())
            {
                insertMsg="that category name already exists";
                
                return false;
            }
            else
            {
                pst.setString(1, niki_emballage_id); 
                pst.setString(2, niki_emballage_name);
                pst.setString(3, niki_emballage_info);
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
