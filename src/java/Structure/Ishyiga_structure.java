/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Structure;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author Administrator
 */
public class Ishyiga_structure {

    
    
        public static String testWeb(String url, String valuetosend) throws Exception {

        URL siteUrl = new URL(url);
        HttpURLConnection connection = (HttpURLConnection) siteUrl.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "SDJUNSHDSD");
        connection.setRequestProperty("user", "ishyiga");
        connection.setRequestProperty("password", "empire");
        connection.setDoOutput(true);
        connection.setDoInput(true);

        try (DataOutputStream out = new DataOutputStream(connection.getOutputStream())) {
            valuetosend = valuetosend.replaceAll("&", "_");
            byte[] data = valuetosend.getBytes("UTF-8");
            out.write(data);
            out.flush();
        }

        String line2;
        try (BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
            String responsesrver = in.readLine();
            String line;
            line2 = "";
            while ((line = in.readLine()) != null) {
                line2 += "   " + (line);
            }
        }

        String response = line2;

        return response;
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
            try {
//                // TODO code application logic here
//                Niki_request nikii= new Niki_request(
//                  "0", "BN323", "123232323", "PARACETAMOL 500ML", "PSE", "DEPOT", 
//                        "NOT VALIDATED", "KINYARWANDA", "KIMENYI", 
//                        "", "", 0, 0, 344, 0, 0, "GSK", "A", "23234343", "SUN");
//                String res =  testWeb("http://localhost:8080/NIKI/NikiCodeRequest.jsp?", nikii.getXml());
//                
//                Niki_request nikiii= new Niki_request(res);
//                System.out.println("niki 1 "+nikiii);
//                
//                 Niki_request nikii2= new Niki_request(
//                  "0", "9992", "123232323", "PARACETAMOL 250ML", "PSE", "DEPOT", 
//                        "NOT VALIDATED", "KINYARWANDA", "KIMENYI", 
//                        "", "", 1000, 0, 344, 0, 0, "GSK", "A", "23234343", "SUN");
//                String res2 =  testWeb("http://localhost:8080/NIKI/NikiCodeRequest.jsp?", nikii2.getXml());
//               // System.out.println("res2 "+res2);
//                Niki_request nikiii2= new Niki_request(res2);
//                System.out.println("niki2 "+nikiii2);
                String var = JOptionPane.showInputDialog("bus_cat_id", "BOUTIQUE");
                String send= "<bus_cat_id>"+var+"</bus_cat_id>";
                  String res2 =  testWeb("http://localhost:8080/NIKI/PromotionRequest.jsp?", send);
                System.out.println("res2 "+res2);
                Promotions promo =new Promotions (res2);
                System.out.println("promo  "+promo);
                JOptionPane.showMessageDialog(null, promo);
                 
                
                
            } catch (Exception ex) {
                Logger.getLogger(Ishyiga_structure.class.getName()).log(Level.SEVERE, null, ex);
            }
        
    }
    
}
