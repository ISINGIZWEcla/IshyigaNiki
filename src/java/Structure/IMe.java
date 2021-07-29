 

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Structure;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.LinkedList;

/**
 *
 * @author kimai
 */
public class IMe {
 
 public static boolean insertMeAss(Connection con, me moi,String global_id) {
     
      
String insertSql = " INSERT INTO `i.m.e`.`affiliate_global_ineza_assurance`"
+"(`global_ineza_id`,`num_affiliation`,`assurance`,`percentage`,`date_exp`,`employeur`," 
+"`lien`,`global_ineza_id_principal`,`status`,`global_id`)" 
        + "values(?,?,?,?,?,?,?,?,?,?) " ;
 try  
{
          try (PreparedStatement ps = con.prepareStatement(insertSql)) {
              me moii  = retrieveAss(con, moi);
              
              if(moii!=null){//System.out.println("isi.i_m_e.save() insertMeAss \n "+moi); 
              return false;}
              
              
              ps.setString(1,moi.global_ineza_id);
              ps.setString(2,moi.NUM_AFFILIATION);
              ps.setString(3,moi.ASSURANCE);
              ps.setInt(4,moi.PERCENTAGE);
              ps.setInt(5,moi.DATE_EXP);
              ps.setString(6,moi.EMPLOYEUR);
              ps.setString(7,moi.LIEN);
              ps.setString(8,moi.BENEFICIAIRE);
              ps.setString(9,moi.STATUS);
              ps.setString(10,global_id);
              
              ps.executeUpdate();
          }  
            return true;
 

        } catch (SQLException e) {
            System.err.println(" SQLException insertMeAss "+e); 
        }
        return false;
    } 

    public static int insertMe(Connection con, LinkedList<me> mois,String global_id) {
      int izinjiye =0;
      try {
String insertSql = "INSERT INTO `i.m.e`.`affiliate_global_ineza` (`global_ineza_id`, `first_name`,`last_name`, `gender`,`dob`,"
        + "`national_id`,`email`,`phone`,`status`,`patient_file_visible`,`global_id`) "
        + "values(?,?,?,?,?,?,?,?,?,?,?) " ;
   

            PreparedStatement ps = con.prepareStatement(insertSql); 
            
            for(me moi:mois)
            { 
            int ndimo = retrieve(con, moi);
            // JOptionPane.showMessageDialog(null, "WAIT "+ndimo);
            if(ndimo==-1){//System.out.println("isi.i_m_e.save() ndimo \n "+moi);
            insertMeAss(con,moi,global_id); continue;}
            else
            {ndimo++; moi.global_ineza_id += me.uzuzazero(ndimo);}
            
            ps.setString(1,moi.global_ineza_id);
            ps.setString(2,moi.NOM_CLIENT);
            ps.setString(3,moi.PRENOM_CLIENT);
            ps.setString(4,moi.SEXE);
            ps.setDate(5,moi.dob);
            ps.setString(6,moi.national_id);
            ps.setString(7,moi.MAIL);
            ps.setString(8,moi.TEL);
            ps.setString(9,"ACTIF");
            ps.setString(10,"NO"); 
            ps.setString(11,global_id);  
            try {
             ps.executeUpdate();
             insertMeAss(con,moi,global_id);
             izinjiye++; } catch (SQLException e) {
                System.err.println(moi+" error inserting  "+e);
               //  JOptionPane.showMessageDialog(null, "wait ");
        }
             
            }  
            ps.close();   
        } catch (SQLException e) {
         System.err.println(" SQLException insertMe "+e); 
        }
        return izinjiye;
    }
 
 
    public static me retrieveAss(Connection con, me entering) {
       
        try {

            
    String selectSql ="SELECT `affiliate_global_ineza_assurance`.`global_ineza_id`,"
    + "`affiliate_global_ineza_assurance`.`num_affiliation`,"
    + "`affiliate_global_ineza_assurance`.`assurance`,"
    + "`affiliate_global_ineza_assurance`.`percentage`,"
    + "`affiliate_global_ineza_assurance`.`date_exp`,"
    + "`affiliate_global_ineza_assurance`.`employeur`,"
    + "`affiliate_global_ineza_assurance`.`lien`,"
    + "`affiliate_global_ineza_assurance`.`global_ineza_id_principal`,"
    + "`affiliate_global_ineza_assurance`.`status`,"
    + "`affiliate_global_ineza_assurance`.`created_time`,"
    + "`affiliate_global_ineza_assurance`.`global_id`"
    + "FROM `i.m.e`.`affiliate_global_ineza_assurance`   "    
    + " WHERE `affiliate_global_ineza_assurance`.`num_affiliation`  = '"+entering.NUM_AFFILIATION+"'"
            + " and `affiliate_global_ineza_assurance`.`assurance`  = '"+entering.ASSURANCE+"' " ;
  
            PreparedStatement ps = con.prepareStatement(selectSql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) { 
              return new me(rs.getString(2), entering.NOM_CLIENT, entering.PRENOM_CLIENT, rs.getInt(4),
                                rs.getInt(5), rs.getString(3), rs.getString(6), entering.SECTEUR, entering.VISA,  
                               entering.CODE, entering.AGE, entering.SEXE,
                                 rs.getString(7), rs.getString(8), entering.TEL, rs.getString(9),
                      1010, "", "",0);
            }

            ps.close(); 
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    

     
 public static int insertMe(Connection con, me moi,String global_id) {
      int izinjiye =0;
      try {
String insertSql = "INSERT INTO `i.m.e`.`affiliate_global_ineza` (`global_ineza_id`, `first_name`,`last_name`, `gender`,`dob`,"
        + "`national_id`,`email`,`phone`,`status`,`patient_file_visible`,`global_id`) "
        + "values(?,?,?,?,?,?,?,?,?,?,?) " ;
   

            PreparedStatement ps = con.prepareStatement(insertSql); 
            
           // for(me moi:mois)
            { 
            int ndimo = retrieve(con, moi);
            // JOptionPane.showMessageDialog(null, "WAIT "+ndimo);
            if(ndimo==-1){//System.out.println("isi.i_m_e.save() ndimo \n "+moi);
            insertMeAss(con,moi,global_id);}
            else
            {ndimo++; moi.global_ineza_id += me.uzuzazero(ndimo);
            
            ps.setString(1,moi.global_ineza_id);
            ps.setString(2,moi.NOM_CLIENT);
            ps.setString(3,moi.PRENOM_CLIENT);
            ps.setString(4,moi.SEXE);
            ps.setDate(5,moi.dob);
            ps.setString(6,moi.national_id);
            ps.setString(7,moi.MAIL);
            ps.setString(8,moi.TEL);
            ps.setString(9,"ACTIF");
            ps.setString(10,"NO"); 
            ps.setString(11,global_id);  
            System.out.println("moi.dob: " + moi.dob);
            try {
             ps.executeUpdate();
             insertMeAss(con,moi,global_id);
             izinjiye++; } catch (SQLException e) {
                System.err.println(moi+" error inserting  "+e);
               //  JOptionPane.showMessageDialog(null, "wait ");
        } 
            }  
            ps.close(); 
            }
        } catch (SQLException e) {
         System.err.println(" SQLException insertMe "+e); 
        }
        return izinjiye;
    }
 
 
 
    public static int retrieve(Connection con, me entering) {
        int size=0;
        try {

    String selectSql ="SELECT  `affiliate_global_ineza`.`first_name`, "
            + " `affiliate_global_ineza`.`last_name`, `affiliate_global_ineza`.`gender`,"
            + "`affiliate_global_ineza`.`dob`,`affiliate_global_ineza`.`global_ineza_id` FROM `i.m.e`.`affiliate_global_ineza` "
            + " WHERE `affiliate_global_ineza`.`global_ineza_id`  like '%"+entering.global_ineza_id+"%'" ;
 
            //System.out.println(" "+selectSql);
            PreparedStatement ps = con.prepareStatement(selectSql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String nom = rs.getString(1); 
                String prenom =  rs.getString(2);
                String gender =  rs.getString(3);
                Date DOB =  rs.getDate(4);
                String global_ineza_id = rs.getString(5);
                
                if(nom.equals(entering.NOM_CLIENT) 
                   && prenom.equals(entering.PRENOM_CLIENT)
                   && gender.equals(entering.SEXE)
                   && DOB.equals(entering.dob))
                {entering.global_ineza_id=global_ineza_id;
                
               // System.out.println(entering+" \n "+selectSql);
               
                return -1;}
                
                size++;
            }

            ps.close(); 
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return size;
    } 
    
 
    public static void updateLocalToIme(Connection conMysql, Connection conDerby,String TABLE) {

        try {
            Statement stat = conDerby.createStatement();
            LinkedList<me> lesMe = getClient(stat, TABLE);
            
            System.out.println(" les Me " + lesMe.size());
//13600
//024084
            if (ImOnMe(stat)) {
                for (me moi : lesMe) {
                    String gii = getByPK(conMysql, moi.NOM_CLIENT, moi.PRENOM_CLIENT,
                             moi.SEXE, moi.dob);
                    if (gii != null) {
                        conDerby.createStatement().execute(" update APP.CLIENT"+TABLE+" set GLOBAL_INEZA_ID ='" + gii + "' "
                                + "where NUM_AFFILIATION='" + moi.NUM_AFFILIATION + "' ");
                    } else {
                        System.err.println(" not found " + moi);
                    }

                }
            }

        } catch (SQLException e) {
            System.err.println(" SQLException  " + e);
        }

    }
    public static void updateLocalOneToIme(Connection conMysql, Connection conDerby,String TABLE, me moi) {

        try {
            Statement stat = conDerby.createStatement();
            if (ImOnMe(stat)) {
                    String gii = getByPK(conMysql, moi.NOM_CLIENT, moi.PRENOM_CLIENT,
                             moi.SEXE, moi.dob);
                    if (gii != null) {
                        String sql = " update APP.CLIENT"+TABLE+" set GLOBAL_INEZA_ID ='" + gii + "' "
                                + "where NUM_AFFILIATION='" + moi.NUM_AFFILIATION + "'";
                        System.out.println("" + sql);
                        conDerby.createStatement().execute(sql);
                    } else {
                        System.err.println(" not found " + moi);
                    }
            }

        } catch (SQLException e) {
            System.err.println(" SQLException  " + e);
        }

    }

    public static Connection conDerby(String url) {

        try {

//            String connectionURL = "jdbc:derby://localhost:1527/AKEDAH";
            String connectionURL = url;
            Connection conn = DriverManager.getConnection(connectionURL);
            conn.setSchema("APP");
            System.out.println(conn.getSchema() + "   Connected database successfully.. cpta db ." + connectionURL);

            return conn;
        } catch (SQLException ex) {
            System.out.println("Connection Fail " + ex);
        }

        return null;
    }

    public static Connection con(String server, String dataBase) {
        String connectionURL = "jdbc:mysql://" + server + ":3306/" + dataBase;
        try {
            Class.forName("com.mysql.jdbc.Driver");
//            if(serv!=null && serv.contains("192.")) //"41.216.117.146  jRqimHtrbFIZsUtA@201
//            Connection connMysql = DriverManager.getConnection(connectionURL,
//                    "berlin", "KIPuni@123");
//            else 
////            {
          Connection  connMysql = DriverManager.getConnection(connectionURL,
                    "bushali", "jRqimHtrbFIZsUtA@2021");
////            } 
            System.out.println("robot.MySQLUKconnection.read() ndaha ");
            String version = connMysql.getMetaData().getDatabaseProductVersion();
            System.out.println(version);

            return connMysql;
        } catch (Throwable e) {
            System.err.println(e + " connection no etablie TO " + connectionURL);
        }

        return null;
    }

    public static String getByPK(Connection con,
            String first_name, String last_name, String gender, Date dob) {

        try {

            String sql = " select global_ineza_id from `i.m.e`.`affiliate_global_ineza` where "
                    + " first_name='" + first_name + "' and "
                    + " last_name='" + last_name + "' and "
                    + " gender='" + gender + "' and "
                    + " dob='" + dob + "'  ";

          System.out.println(" " + sql);

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                return rs.getString(1);
                //System.out.println("ime.IMe.getByPK() "+rs.getString(1)); 
            }

            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static int countMes(Connection con) {

        try {

            String sql = " select count(global_ineza_id) from `i.m.e`.`affiliate_global_ineza` ";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                
                return rs.getInt(1);
            }

            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static LinkedList<me> getClient(Statement mainstatement, String table) {
        ////fields.setFlag("1");
        LinkedList<me> lesMe = new LinkedList();
        //JOptionPane.showMessageDialog(null,entier,table,JOptionPane.PLAIN_MESSAGE);

        String sql = "select * from APP.CLIENT" + table + " ";

        System.out.println("isi.i_m_e.getClient() " + sql);

        int zose = 0;
        try {

            ResultSet outResult = mainstatement.executeQuery(sql);
            while (outResult.next()) {
                String NUM_AFFILIATIONa = outResult.getString(1);
                String NOM_CLIENTa = outResult.getString(2);
                String PRENOM_CLIENTa = outResult.getString(3);
                int PERCENTAGEa = outResult.getInt(4);
                int DATE_EXPa = outResult.getInt(5);
                String ASSURANCEa = outResult.getString(6);
                String EMPLOYEURa = outResult.getString(7);
                String SECTEURa = outResult.getString(8);
                String VISAa = outResult.getString(9);
                String CODE = outResult.getString(10);
                String AGE = outResult.getString(11);
                String SEXE = outResult.getString(12);
                String LINK = outResult.getString(13);
                String BENEFICIAIRE = outResult.getString(14);
                me moi = null;
                if (table.contains("RAMA")) {
                    moi = new me(NUM_AFFILIATIONa, NOM_CLIENTa, PRENOM_CLIENTa, PERCENTAGEa,
                            DATE_EXPa, ASSURANCEa, EMPLOYEURa, SECTEURa, VISAa, CODE, AGE, SEXE,
                            LINK, BENEFICIAIRE, outResult.getString("TEL"),
                            outResult.getString("STATUS"), outResult.getInt("PIN"),
                            outResult.getString("AFFILIATE_NOM"),
                            outResult.getString("AFFILIATE_PRENOM"), 0);
                } else {
                    moi = new me(NUM_AFFILIATIONa, NOM_CLIENTa, PRENOM_CLIENTa, PERCENTAGEa,
                            DATE_EXPa, ASSURANCEa, EMPLOYEURa, SECTEURa, VISAa, CODE, AGE, SEXE,
                            LINK, BENEFICIAIRE, outResult.getString("TEL"), "", 1010, "", "", 0);
                }
                zose++;
                if (moi.check()) {
                    lesMe.add(moi);
                }
            }

            //  Close the resultSet
            outResult.close();
        } catch (SQLException e) {
            System.err.println(" getCLient " + e);
        }
        System.out.println(" zose " + zose);
        return lesMe;
    }

    static String imMeVarInsert = "INSERT INTO APP.VARIABLES (NOM_VARIABLE, VALUE_VARIABLE, "
            + "FAMILLE_VARIABLE, VALUE2_VARIABLE) \n"
            + "	VALUES ('HSP_ON_I.M.E', 'YES', 'GLOBAL', 'YES')\n"
            + "";

    static String addClientGlobalIneza = "ALTER TABLE APP.CLIENT "
            + "ADD COLUMN GLOBAL_INEZA_ID VARCHAR(45) DEFAULT 'N' ";
static String addClientGlobalIneza_RAMA = "ALTER TABLE APP.CLIENT_RAMA "
            + "ADD COLUMN GLOBAL_INEZA_ID VARCHAR(45) DEFAULT 'N' ";
    public static boolean ImOnMe(Statement state) {
        try {

            ResultSet outResult = state.executeQuery("select VALUE_VARIABLE from APP.VARIABLES where"
                    + "  nom_variable='HSP_ON_I.M.E' ");

            while (outResult.next()) {

                String st = outResult.getString(1);

                if (st != null && st.equals("YES")) {
                    return true;
                }

            }

            try {
                state.execute(imMeVarInsert);
            } catch (SQLException ex) {
                System.err.println("ERROR SNOW_INTARE_SQL_UPDATE punzerSizeVarInsert " + ex);
            }

            try {
                 state.execute(addClientGlobalIneza_RAMA);
                state.execute(addClientGlobalIneza);
                
            } catch (SQLException ex) {
                System.err.println("ERROR SNOW_INTARE_SQL_UPDATE addItemNumberInvoice " + ex);
            }

        } catch (SQLException e) {
            System.out.println("  " + e);
        }
        return false;
    }
    
 
 
 
public static String getMeAssurance(Connection conn, String num_affiliation,String assurance) {
    
     
    
    String selectMeAss ="select * from `i.m.e`.`affiliate_global_ineza_assurance` " 
            + " WHERE `num_affiliation`='"+num_affiliation+"'  ";
               
    
        System.out.println("selectMeAss   " + selectMeAss);
 
        try {
Statement mainstatement = conn.createStatement();
            ResultSet outResult = mainstatement.executeQuery(selectMeAss);
            while (outResult.next()) {
                  String global_ineza_id = outResult.getString(1); 
                int percentage   = outResult.getInt("percentage");
                int date_exp  = outResult.getInt("date_exp");
                String assurance2 = outResult.getString("assurance");
                
                return  global_ineza_id;
            } 
            //  Close the resultSet
            outResult.close();
        } catch (SQLException e) {
            System.err.println(" getMe " + e);
        } 
        return null;
    }

    public static String getByINEZAID(Connection con, String global_ineza_id) {

        try {

            String sql = " select first_name,last_name,gender,dob from "
                    + "`i.m.e`.`affiliate_global_ineza` where "
                   
                    + " global_ineza_id='" + global_ineza_id + "'  ";

            System.out.println(" " + sql);

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                return rs.getString(1)+rs.getString(2)+rs.getString(3)+rs.getString(4);
                //System.out.println("ime.IMe.getByPK() "+rs.getString(1)); 
            }

            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

   
public static me getMe(Connection conn, String num_affiliation,String assurance) {
    
     
    
    String selectMeAss ="select `affiliate_global_ineza`.`global_ineza_id`,`num_affiliation`,`assurance`,`percentage`,`date_exp`,`employeur`," 
+"`lien`,`global_ineza_id_principal`,`first_name`,`last_name`, `gender`,`dob`,"
        + "`national_id`,`email`,`phone`,`affiliate_global_ineza`.`status`,`patient_file_visible`,`password` from "
            + " `i.m.e`.`affiliate_global_ineza_assurance`,`i.m.e`.`affiliate_global_ineza`"
            + ""
            + " WHERE `num_affiliation`='"+num_affiliation+"' and `assurance` ='"+assurance+"'"
            + " and `i.m.e`.`affiliate_global_ineza_assurance`.`global_ineza_id`  = "
            + "     `i.m.e`.`affiliate_global_ineza`.`global_ineza_id` ";
              
        
    
        System.out.println("selectMeAss   " + selectMeAss);
 
        try {
Statement mainstatement = conn.createStatement();
            ResultSet outResult = mainstatement.executeQuery(selectMeAss);
            while (outResult.next()) {
                
                String global_ineza_id = outResult.getString(1);
                String first_name = outResult.getString("first_name");
                String last_name = outResult.getString("last_name");
                int percentage   = outResult.getInt("percentage");
                int date_exp  = outResult.getInt("date_exp");
                String assurance2 = outResult.getString("assurance");
                String employeur = outResult.getString("employeur");
                String status = ""; //outResult.getString("status");
                String patient_file_visible = outResult.getString("patient_file_visible");
                String national_id = outResult.getString("national_id");
                String dob    = outResult.getString("dob");
                String gender = outResult.getString("gender");
                String LINK   = outResult.getString("lien");
                String global_ineza_id_principal = outResult.getString("global_ineza_id_principal");
                String phone = outResult.getString("phone");
                int password = outResult.getInt("password");
              
                me moi = new me(num_affiliation, first_name, last_name, percentage,
                            date_exp, assurance, employeur, status, patient_file_visible, 
                             national_id, dob, gender,
                            LINK, global_ineza_id_principal, phone, global_ineza_id, 1010, "", "",password );
                moi.dob= outResult.getDate("dob");
            return moi;
            } 
            //  Close the resultSet
            outResult.close();
        } catch (SQLException e) {
            System.err.println(" getMe " + e);
        } 
        return null;
    }

  

}
