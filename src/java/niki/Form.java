/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package niki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import java.sql.Statement;

/**
 *
 * @author vakaniwabo
 */
public class Form {
       String niki_form_id;
       String niki_form_name;
       String niki_form_physique ;
       public String insertMsg,selectMsg,updateMsg,error;  
       String global_id; 
    //connection instance
    Connection conn = ConnectionClass.getConnection();

    public void isForm(String niki_form_id, String niki_form_name, 
            String niki_form_physique, String global_id) {
        this.niki_form_id = niki_form_id;
        this.niki_form_name = niki_form_name;
        this.niki_form_physique = niki_form_physique;
        this.global_id = global_id;
    }
 
     
    public boolean insertForme()
    { 
        try 
        { 
           String insert = "insert into niki_form "
                   + "(`niki_form_id`,`niki_form_name`,`niki_form_physique`"
                   + ",`global_id`)"
                   + " values(?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(insert);
            PreparedStatement pst2 = conn.prepareStatement("select niki_form_id from niki_form where niki_form_id = '"+niki_form_id +"'");
   
            ResultSet rs = pst2.executeQuery();
            
            if(rs.next())
            {
                insertMsg="that category name already exists";
                
                return false;
            }
            else
            {
                pst.setString(1, niki_form_id); 
                pst.setString(2, niki_form_name);
                pst.setString(3, niki_form_physique);
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
     public boolean insertDoseUtiy()
    { 
        try 
        { 
           String insert = "insert into niki_dose_unity "
                   + "(`niki_dose_unity_id`,`niki_dose_unity_name`,`niki_dose_unity_physique`"
                   + ",`global_id`)"
                   + " values(?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(insert);
            PreparedStatement pst2 = conn.prepareStatement("select niki_dose_unity_id from niki_dose_unity where niki_dose_unity_id = '"+niki_form_id +"'");
   
            ResultSet rs = pst2.executeQuery();
            
            if(rs.next())
            {
                insertMsg="that category name already exists";
                
                return false;
            }
            else
            {
                pst.setString(1, niki_form_id); 
                pst.setString(2, niki_form_name);
                pst.setString(3, niki_form_physique);
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
