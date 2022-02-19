/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package niki;
 
   
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import static niki.Niki_request.getTagValue;

/**
 *
 * @author admin
 */
public class NecSaveReadImg {
  
public static String pathImageNec="E:\\NEC\\";  

 public static String getFichier(String xml)
{
    
    String folder = getTagValue("FOLDER", xml);
    String file   = getTagValue("CATEGORY", xml);
    String niki_Code   = getTagValue("NIKI_CODE", xml);
    String filename = pathImageNec+folder+"\\"+file+"\\"+niki_Code;
   
        String res = "ERROR NO IMAGE FOUND IN "+filename; 
        File productFile = new File(filename);
        try (BufferedReader entree = new BufferedReader(new FileReader(productFile))) {
            try {
                res="";
               String ligne = entree.readLine();
                         while (ligne != null) { 
                res +=ligne;
                ligne = entree.readLine();
            }
            } catch (IOException e) {
                System.out.println(e);
                return "ERROR "+e;
            }
           
   
        } catch (FileNotFoundException ex) {
     return res;
    } catch (IOException ex) {
        return "ERROR "+ex;
    }
        return res;
    }
    
 //Connection con,
 public static String writeImage2(String xml) 
 {
    String folder = getTagValue("FOLDER", xml);
    String file   = getTagValue("CATEGORY", xml);
    String niki_Code   = getTagValue("NIKI_CODE", xml); 
    String data   = getTagValue("IMAGE", xml); 
     
    String filename = pathImageNec+folder+"\\"+file+"\\"+niki_Code;
   
        try { 
            
            File f = new File(filename);
            try (PrintWriter sorti = new PrintWriter(new FileWriter(f))) {
                sorti.println(data); 
            } 
            return "<response>SUCCESS</response>";
        } catch (IOException ex) { 
            return "<response>FAIL"+ex+filename+"</response>";  
        }
    }  
 
 
 public static String ngerayo(String xml) 
 {
    String folder = getTagValue("FOLDER", xml);
    String file   = getTagValue("CATEGORY", xml);
    String niki_Code   = getTagValue("NIKI_CODE", xml); 
    //String data   = getTagValue("IMAGE", xml); 
     
    return pathImageNec+folder+"\\"+file+"\\"+niki_Code;
    
    }  
 
 public static String muraho() 
 { 
    return "MURAHO";
    
    } 
 
public static void insertImageTrack(Connection con, String global_account, 
        String transaction_type,String transaction_time,
            String niki_code, int quantity , String bacth_serial,
            String node_produce_id,String node_produce_doc,
            String node_consume_id,String dot_id,
            double different_compared,double image_size, 
            double quality_of_image) 
    {           
      try {
String insertSql = "INSERT INTO `track_trace_line`"
        + " (`global_account`, `transaction_type`,`transaction_time`, "
        + "`niki_code`,`quantity`,"
        + "`bacth_serial`,`node_produce_id`"
        + "`node_produce_doc`,`node_consume_id`,"
        + "`dot_id`,`different_compared,`image_size`,`quality_of_image`"
        + ") "
        + "values(?,?,?,?,?,"
        + "?,?,?,?,?,?,?,? )" ; 
//sqll +=insertSql;
  PreparedStatement ps = con.prepareStatement(insertSql); 
         
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
             sqll +=" irinjiye track and trace ";
            ps.close();   
        } catch (SQLException e) {
         System.err.println(" SQLException track and trace "+e); 
         sqll +=" SQLException track and trace "+e;
         
        } 
    }
    static public String sqll="";
    
}
