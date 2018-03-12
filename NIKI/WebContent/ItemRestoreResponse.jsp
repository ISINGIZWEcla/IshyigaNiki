<%-- 
    Document   : ItemDelete
    Created on : May 31, 2016, 6:33:40 PM
    Last Updated: Feb 19, 2018
    Author     : vakaniwabo
--%>

<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.*"%>


<jsp:useBean id="it_excl" scope="request" class="niki.ExcelInput">
    <jsp:setProperty name="it_excl" property="*" />
</jsp:useBean>


<!-- change request 1 -->
<jsp:useBean id="trsh_excl" scope="request" class="niki.TrashInput">
    <jsp:setProperty name="trsh_excl" property="*" />
</jsp:useBean>

<%
    String action = request.getParameter("action");
	String itmDescription = request.getParameter("itemDesc");
	session.setAttribute("actionInSession", action);

	
    	// the action to be performed is restoring item
        
        String itmRestore = request.getParameter("itemRestore");

    	
		session.setAttribute("itemRestore", itmRestore);
		it_excl.setFromExcelId(itmRestore);
		trsh_excl.setFromExcelId(itmRestore);
   
        if (it_excl.isValid()) {//TODO: why checking if it is valid
            //the data is valid

        
         /*
         CR BY VICTOIRE
            connecting to the db and getting the excel item to be rejected
            */
            
            String externalId = null, itemDesc = null, codebar = null, external_info_1 = null, external_info_2 = null, filename = null, niki_code = null, status = null;
         	String company = null, username = null;
            try{
            	Connection con = ConnectionClass.getConnection();
            	Statement ST1 = con.createStatement();
                ResultSet rs1 = ST1.executeQuery("SELECT * FROM Trash_from_excel where t_fromExceld='"+ itmRestore + "'");
                
                while(rs1.next()){                	
                	externalId = rs1.getString(2);
                    itemDesc = rs1.getString(3);
                    codebar = rs1.getString(4);
                    company = rs1.getString(5);
                    external_info_1 = rs1.getString(6);
                    external_info_2 = rs1.getString(7);
                    username = rs1.getString(10);
                    filename = rs1.getString(12);
                    niki_code = rs1.getString(13); 
                    status = rs1.getString(14);
                    
                }
            	
            }catch(Exception e){
            	
            }
            it_excl.setFromExcelId(itmRestore);
            it_excl.setCodebar(codebar);
            it_excl.setCompany(company);
            it_excl.setExternal_info_1(external_info_1);
            it_excl.setExternal_info_2(external_info_2);
            it_excl.setExternalId(externalId);
        	//trsh_excl.setFromExcelId(externalId);
        	it_excl.setItemDesc(itemDesc);
        	it_excl.setUsername(username);
        	it_excl.setFilename(filename);
        	it_excl.setNiki_code(niki_code);
        	it_excl.setStatus(status);
        	
        	//removing the restored item FROM TRASH table
            if(trsh_excl.deleteTrashInput()){
            	 //call the method to restore the item back to ExcelItem Table
                
            	 if(it_excl.insertExcelInput()){
            	
              	//the data is restored
                	it_excl.setInsertMsg("Successfully restored");
            	 }else{
            		 it_excl.setInsertMsg("Error in restoring, contact administrator");
            	 }
            }
            
   
        } else {
            //the data is not valid
            it_excl.setInsertMsg("Invalid data");

        }
        
        %>
        <jsp:forward page="ViewExcelTrash.jsp"/>
        <%

%>

