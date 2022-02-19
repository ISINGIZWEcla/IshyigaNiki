/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package niki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import static niki.Niki_request.getTagValue;

/**
 *
 * @author Administrator
 */
public class ORT_track {
    
    
 public static String insertLimitTrack(Connection con, String xmlTrack ) 
    {  
 
      try {
 
 String transaction_type = getTagValue("transaction_type", xmlTrack);
 String global_account = getTagValue("global_account", xmlTrack);
  String transaction_time = getTagValue("transaction_time", xmlTrack);
 String node_produce_id = getTagValue("node_produce_id", xmlTrack);
 String niki_code = getTagValue("NIKI_CODE", xmlTrack);
 int quantity = 1;
 String bacth_serial = "test"; 
 String node_produce_doc= "AB232";
 String node_consume_id ="bnm0239";
 String dot_id = "B29qH0AAAAAXNSR0IArs4c6QAAAANzQkl";
 double different_compared = 0;
 double image_size = 0;
 double quality_of_image =0 ;   
 
String sql1 = "INSERT INTO `nec`.`track_trace_line` " +
"(`global_account`," +
"`transaction_type`," +
"`transaction_time`," +
"`niki_code`," +
"`quantity`," +
"`bacth_serial`," +
"`node_produce_id`," +
"`node_produce_doc`," +
"`node_consume_id`," +
"`dot_id`," +
"`different_compared`," +
"`image_size`," +
"`quality_of_image`)" +
"VALUES(?,?,?,?,"
     + "?,?,?,?,"
     + "?,?,?,?,"
     + "?,?,?,?,"
     + "?)" ;    
 
 
          try (PreparedStatement ps = con.prepareStatement(sql1)) {
              ps.setString(1,global_account);
              ps.setString(2,transaction_type);
              ps.setString(3,transaction_time);
              ps.setString(4,niki_code);
              ps.setInt(5,quantity);
              ps.setString(6,bacth_serial);
              ps.setString(7,node_produce_id);
              ps.setString(8,node_produce_doc);
              ps.setString(9,node_consume_id);
              ps.setString(10,dot_id);
              ps.setDouble(11,different_compared);
              ps.setDouble(12,image_size);
              ps.setDouble(13,quality_of_image);
              ps.execute();
              return "WELL INSERTED";
          }   
        } catch (SQLException e) {
        // System.err.println();
         return " SQLException insertORTrack "+e;
        }
      //return false;
    }
    
}
