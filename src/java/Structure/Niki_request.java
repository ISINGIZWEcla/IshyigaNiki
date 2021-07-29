/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Structure;
public class Niki_request {
    
String item_id;
public String item_external_id;
public String id_company;
String codebar;
String itemDesc;
String subcategory_id;
String busin_category_id;
String status;
String langue;
String user_name;
String time;
String niki_code;
double packet;
int hauteur;
int longeur;
int largeur;
double poids;
String fabricant;
String tax_rate;
String hs_codeString ; 

    public Niki_request(String item_id, String item_external_id, String codebar,
            String itemDesc, String subcategory_id, String busin_category_id,
            String status, String langue, String user_name, String time, String niki_code,
            double packet, int hauteur, int longeur, int largeur, double poids, 
            String fabricant, String tax_rate, String hs_codeString, String id_company) {
        this.id_company = id_company;
        this.item_id = item_id;
        this.item_external_id = item_external_id;
        this.codebar = codebar;
        this.itemDesc = itemDesc;
        this.subcategory_id = subcategory_id;
        this.busin_category_id = busin_category_id;
        this.status = status;
        this.langue = langue;
        this.user_name = user_name;
        this.time = time;
        this.niki_code = niki_code;
        this.packet = packet;
        this.hauteur = hauteur;
        this.longeur = longeur;
        this.largeur = largeur;
        this.poids = poids;
        this.fabricant = fabricant;
        this.tax_rate = tax_rate;
        this.hs_codeString = hs_codeString;
    }
        
public String getXml()
{
      return  "<item_id>"+item_id+"</item_id>"+
        "<item_external_id>"+item_external_id+"</item_external_id>"+
              "<id_company>"+id_company+"</id_company>"+
        "<codebar>"+codebar+"</codebar>"+
        "<itemDesc>"+itemDesc+"</itemDesc>"+
        "<subcategory_id>"+subcategory_id+"</subcategory_id>"+
        "<busin_category_id>"+busin_category_id+"</busin_category_id>"+
        "<status>"+status+"</status>"+
        "<langue>"+langue+"</langue>"+
        "<user_name>"+user_name+"</user_name>"+
        "<time>"+time+"</time>"+
        "<niki_code>"+niki_code+"</niki_code>"+
        "<packet>"+packet+"</packet>"+
        "<hauteur>"+hauteur+"</hauteur>"+
        "<longeur>"+longeur+"</longeur>"+
        "<largeur>"+largeur+"</largeur>"+
        "<poids>"+poids+"</poids>"+
        "<fabricant>"+fabricant+"</fabricant>"+
        "<tax_rate>"+tax_rate+"</tax_rate>"+
        "<hs_codeString>"+hs_codeString+"</hs_codeString>";

}

 

 public Niki_request(String xml) {

       // System.out.println("+++++++++++++++++++++     " + xml);
      
        this.item_id = getTagValue("item_id", xml);
        this.item_external_id = getTagValue("item_external_id", xml);
        this.codebar = getTagValue("codebar", xml);
        this.itemDesc = getTagValue("itemDesc", xml);
        this.subcategory_id = getTagValue("subcategory_id", xml);
        this.busin_category_id = getTagValue("busin_category_id", xml);
        this.status = getTagValue("status", xml);
        this.langue = getTagValue("langue", xml);
        this.user_name = getTagValue("user_name", xml);
        this.time = getTagValue("time", xml);
        this.niki_code = getTagValue("niki_code", xml);
        try{
        this.packet = Double.parseDouble(getTagValue("packet", xml));
        this.hauteur = Integer.parseInt(getTagValue("hauteur", xml));
        this.longeur = Integer.parseInt(getTagValue("longeur", xml));
        this.largeur = Integer.parseInt(getTagValue("largeur", xml));
        this.poids =   Double.parseDouble(getTagValue("poids", xml));
        }
        catch (NumberFormatException n){ 
            if(xml!=null && xml.contains("LOG EXITING"))
            {numberError="NOT AUTHORISED ";}
            else {numberError=xml+" \n "+n;}
        }
        this.fabricant = getTagValue("fabricant", xml);
        this.tax_rate = getTagValue("tax_rate", xml);
        this.hs_codeString = getTagValue("hs_codeString", xml);
        this.id_company= getTagValue("id_company", xml);

 }
 String numberError="";
    public static String getTagValue(String tag, String xmlData) {
        try {
            //  System.out.println("<"+tag+"> ---- "+xmlData+" ")", xml); 
            String[] splitStart = xmlData.split("<" + tag + ">");
//    System.out.println("<"+tag+"> -- 0  -- "+splitStart[0]+" ");
//    System.out.println("<"+tag+"> 11  "+splitStart[1]+" ");
            if (splitStart.length == 0)// != null && splitStart[0] =! null)
            {
                return "";
            }
            if (splitStart.length == 1)// != null && splitStart[0] =! null)
            {
                return "";
            } else {
                String[] splitEnd = splitStart[1].split("</" + tag + ">");

                return splitEnd[0];
            }
        } catch (Throwable ex) {
            System.err.println(ex + " : ");
            return "ERROR " + ex;
        }

    }
 
@Override
public String toString()
{

return id_company+" "+item_external_id+" "+niki_code+" "+status+" "+item_id+" "+numberError;
}

}