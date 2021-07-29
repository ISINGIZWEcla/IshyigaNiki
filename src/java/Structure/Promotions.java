package Structure;

import java.util.LinkedList;
import static niki.Niki_request.getTagValue;

public class Promotions {
 
    public String promo_name,start,end,niki_company_id,bus_cat_id ;
    double maximum_budget;
    public int promo_code,maximum_qty;
    String global_id ;
    LinkedList <Promotions_list> laListe= new LinkedList<>();
    
    public Promotions(String xml) {  
        this.promo_name = getTagValue("promo_name", xml); 
        this.start = getTagValue("start", xml); 
        this.end = getTagValue("end", xml); 
        this.niki_company_id = getTagValue("niki_company_id", xml); 
        this.bus_cat_id = getTagValue("bus_cat_id", xml);
        this.maximum_budget =Double.parseDouble(getTagValue("maximum_budget", xml)); 
        this.promo_code = Integer.parseInt(getTagValue("promo_code", xml)); 
        this.maximum_qty = Integer.parseInt(getTagValue("maximum_qty", xml));
        this.global_id = getTagValue("global_id", xml);
        
        
        String spXml []=xml.split("</LINE>");
        
        for(String xmLine:spXml)
        {
            if(xmLine.contains("niki_promotions_amount"))
            {laListe.add(new Promotions_list(xmLine));}
            else
            {System.err.println("Struc xmLine "+xmLine);}
        }
         
    } 
    
    @Override
    public String toString()
    {
    
    return "I AM PROMOTION "+promo_name+" by "+niki_company_id+" "
            + " \n given to "+bus_cat_id+" HAVING ITEMS COUNTS "+laListe.size();
    }
    
      public String getXml()
    {
    
    return     "<promo_code>" + promo_code + "</promo_code>"
                + "<start>" + start + "</start>"
                + "<end>" + end + "</end>"
                + "<global_id>" + global_id + "</global_id>"
                + "<niki_company_id>" + niki_company_id + "</niki_company_id>"
                + "<bus_cat_id>" + bus_cat_id + "</bus_cat_id>"
                + "<maximum_budget>" + maximum_budget + "</maximum_budget>"
                + "<maximum_qty>" + maximum_qty + "</maximum_qty>";
    }  
    
 
   
    
    
class Promotions_list {


int promo_code,niki_promotions_qte,niki_promotions_discount;
String niki_code,type;
double niki_promotions_amount;

	public Promotions_list(String xml) { 
        this.type = getTagValue("type", xml); 
        this.niki_code = getTagValue("niki_code", xml);
        this.niki_promotions_amount =Double.parseDouble(getTagValue("niki_promotions_amount", xml)); 
        this.promo_code = Integer.parseInt(getTagValue("promo_code", xml)); 
        this.niki_promotions_qte = Integer.parseInt(getTagValue("niki_promotions_qte", xml));
        this.niki_promotions_discount = Integer.parseInt(getTagValue("niki_promotions_discount", xml));
         
	}
	


}
 }
  