/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Structure;
 
import java.sql.Date;

/**
 *
 * @author delphine
 */
public class me {

    public int DATE_EXP, PERCENTAGE, PIN, PASSWORD;
    public String NUM_AFFILIATION, NOM_CLIENT, PRENOM_CLIENT, ASSURANCE,
            EMPLOYEUR, SECTEUR, VISA, CODE, AGE, SEXE, LIEN, BENEFICIAIRE,
            AFFILIATE_PRENOM, AFFILIATE_NOM,
            TEL, NUM_CLIENT2, MAIL, STATUS = "DESACTIVATED",
            INSURER, INSURANCE_TIN = "";
    double PERCENTAGE_PART = 0;

    public String global_ineza_id,national_id;
    public Date dob; 
    
    
    public me(String NUM_AFFILIATION, String NOM_CLIENT, String PRENOM_CLIENT, int PERCENTAGE, int DATE_EXP,
            String ASSURANCE, String EMPLOYEUR, String SECTEUR, String VISA, String CODE) {

        this.NUM_AFFILIATION = NUM_AFFILIATION;
        this.NOM_CLIENT = NOM_CLIENT;
        this.PRENOM_CLIENT = PRENOM_CLIENT;
        this.PERCENTAGE = PERCENTAGE;
        this.DATE_EXP = DATE_EXP;
        this.ASSURANCE = ASSURANCE;
        this.EMPLOYEUR = EMPLOYEUR;
        this.SECTEUR = SECTEUR;
        this.VISA = VISA;
        this.CODE = CODE;
        this.LIEN="LUI MEME";
    }

    public me(String NUM_AFFILIATION, String NOM_CLIENT, String PRENOM_CLIENT,
             int PERCENTAGE, int DATE_EXP, String ASSURANCE, String EMPLOYEUR,
            String SECTEUR, String VISA, String CODE, String AGE, String SEXE,
            String LIEN, String BENEFICIAIRE, String TEL, String STATUS, int PIN,
            String AFFILIATE_NOM, String AFFILIATE_PRENOM, int PASSWORD) {

        this.NUM_AFFILIATION = NUM_AFFILIATION;
        this.NOM_CLIENT = NOM_CLIENT;
        this.PRENOM_CLIENT = PRENOM_CLIENT;
        this.PERCENTAGE = PERCENTAGE;
        this.DATE_EXP = DATE_EXP;
        this.ASSURANCE = ASSURANCE;
        this.EMPLOYEUR = EMPLOYEUR;
        this.SECTEUR = SECTEUR;
        this.VISA = VISA;
        this.CODE = CODE;
        this.AGE = AGE;
        this.SEXE = SEXE;
        this.LIEN = LIEN;
        this.BENEFICIAIRE = BENEFICIAIRE;
        this.AFFILIATE_PRENOM = AFFILIATE_PRENOM;
        this.AFFILIATE_NOM = AFFILIATE_NOM;
        this.PIN = PIN;
        this.STATUS = STATUS;
        this.TEL = TEL;
        this.BENEFICIAIRE = BENEFICIAIRE;
        this.PASSWORD = PASSWORD;

    }

    public boolean isPhone(String phoneTest) {
        
        if (phoneTest == null) {
            System.err.println("wrong phone format for; " + NUM_AFFILIATION + "; is " + phoneTest);
            return false;
        } else if (phoneTest.length() == 12 && !phoneTest.contains("250")) {
            System.err.println("wrong phone format LENGTH NOT 12 for; " + NUM_AFFILIATION + "; " + phoneTest);
            return false;
        }
        else if ( phoneTest.contains("")) {
            return true;
        }
         
         

        try {
            double year = Double.parseDouble(phoneTest);
            if (phoneTest.length() == 12 && phoneTest.contains("250")) {
                TEL = phoneTest.replaceAll("250", "");
                return true;
            }
            if (phoneTest.length() == 9) {
                TEL = "0" + phoneTest;
                return true;
            }
            if (phoneTest.length() == 10) {
                TEL =phoneTest; return true;
            }
        } catch (NumberFormatException nb) {
            System.err.println("wrong TEL format NumberFormatException for; " + NUM_AFFILIATION + "; " + phoneTest);
            return false;
        }

        return false;
    }

    public boolean isGender() {
        if (SEXE == null) {
            System.err.println("wrong gender format for; " + NUM_AFFILIATION + "; is " + SEXE);
            return false;
        } else if (SEXE.equals("M")) {
            SEXE = "MALE";
            return true;
        } else if (SEXE.equals("F")) {
            SEXE = "FEMALE";
            return true;
        } else if (SEXE.equals("MALE")) {
            return true;
        } else if (SEXE.equals("FEMALE")) {
            return true;
        }

        return false;
    }

    public boolean isDOB() {
        if (AGE == null) {
            System.err.println("wrong dob format for; " + NUM_AFFILIATION + "; is " + AGE);
            return false;
        } else if (AGE.length() != 10) {
            System.err.println("wrong dob format LENGTH NOT 10 for; " + NUM_AFFILIATION + "; " + AGE.length());
            return false;
        } else if (!AGE.contains("-")) {
            System.err.println("wrong dob format missing - for; " + NUM_AFFILIATION + "; " + AGE);
            return false;
        } else {
            String sp[] = AGE.split("-");

            if (sp.length != 3) {
                System.err.println("wrong dob format number - for; " + NUM_AFFILIATION + "; " + sp.length);
                return false;
             }

            try {
               // System.out.println("isi.me.isDOB() "+AGE);
                int year = Integer.parseInt(sp[2]);
                int umunsi = Integer.parseInt(sp[0]);
                int ukwezi = Integer.parseInt(sp[1]);
                
                if(sp[2].length()!=4)
                     {
                    System.err.println("wrong dob value of year for; " + NUM_AFFILIATION + "; "+AGE + "; "  + umunsi);
                    return false;
                }
                int year2 = Integer.parseInt(sp[2].substring(2, 4));
                
                if (year > 2022 || year < 1900) {
                    System.err.println("wrong dob value of year for; " + NUM_AFFILIATION + "; " +AGE + "; " + year);
                    return false;
                } else if (ukwezi < 0 || ukwezi > 13) {
                    System.err.println("wrong dob value of month for; " + NUM_AFFILIATION + "; "+AGE + "; "  + ukwezi);
                    return false;
                } else if (umunsi < 0 || umunsi > 32) {
                    System.err.println("wrong dob value of umunsi for; " + NUM_AFFILIATION + "; "+AGE + "; "  + umunsi);
                    return false;
                }
            dob = new Date(year-1900, ukwezi-1, umunsi+1); 
            global_ineza_id = KABIRI(NOM_CLIENT).toUpperCase().substring(0, 2)+
                              KABIRI(PRENOM_CLIENT).toUpperCase().substring(0, 2)+
                              uzuzazero(year2)+""+uzuzazero(ukwezi)+""+uzuzazero(umunsi)+"";
                System.out.println("DOB GLOBSL: " + dob);
            } catch (NumberFormatException nb) {
                System.err.println("wrong dob format NumberFormatException for; " + NUM_AFFILIATION + "; " + AGE);
                return false;
            }

        }
        return true;
    }

    
    public static String uzuzazero(int uje)
    {
    if(uje<10)
    {return "0"+uje;}
    else {return ""+uje;}
    }
    
    public static String KABIRI(String uje)
    {
        
    if(uje==null)
    {return "__";}
    uje = uje.replaceAll(" ", "");
     
        switch (uje.length()) {
            case 0:
                return "__";
            case 1:
                return "_"+uje;
            case 2:
                return ""+uje;
            default:
                return ""+uje;
        }
    }
    
    @Override
    public String toString() {
      
        return "" + NOM_CLIENT + "   " + PRENOM_CLIENT + "   |  " + BENEFICIAIRE + "   |  " + NUM_AFFILIATION + " | " + ASSURANCE+ " | " +DATE_EXP + " | "
        + TEL + "  | " + EMPLOYEUR + "   |  " + AGE + "   |  " + SEXE + " | " + PERCENTAGE;
    }
    
    public boolean check()
    { 
        
        
  
      
        isPhone(TEL);isPhone(SECTEUR); cleanNumAff();
         
        
    return isDOB() && isGender() ;
    }
    
   void cleanNumAff()
   {
   
   NUM_AFFILIATION=NUM_AFFILIATION.replaceAll("\\.", "");
   
   if(LIEN== null || 
    !(LIEN.equals("LUI MEME") || LIEN.equals("ENFANT") || LIEN.equals("COINJOINT")))
     
   {LIEN="OTHER";}
   
   }
 
    
}

