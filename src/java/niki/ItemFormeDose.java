/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package niki;

/**
 *
 * @author Administrator
 */
public class ItemFormeDose {
   
    String doseSmart = "";
    String formSmart = "";
    
    
    
public void setItemFormeDose(String itemDesc)
    {
    String form [] = new String [] {"ML","MG","CL","GR","KG"};    
    String sp []= itemDesc.split(" ");
    
    for(String ss:sp)
    {
    for(String fr:form)
    {
        if(ss!=null && ss.contains(fr))
        {
        String replaced = ss.replaceAll(fr, "");
        try {
        int niyo =(int) Double.parseDouble(replaced);
        
           // System.out.println(niyo+" "+fr);
        doseSmart=""+niyo;
        formSmart=fr;
        } catch (NumberFormatException n){System.err.println(ss+" ntiyariyo ");}
        
        }
    }
    
    }
    
    }
    
}
