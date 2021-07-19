<%-- 
    Document   : ItemDelete
    Created on : May 31, 2016, 6:33:40 PM
    Last Updated: Feb 24, 2018
    Author     : vakaniwabo
--%>

<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.*"%>


<%@page import="niki.Item_Temp" %>
<jsp:useBean id="it_tmp" scope="request" class="niki.Item_Temp">
    <jsp:setProperty name="it_tmp" property="*" />
</jsp:useBean>

<jsp:useBean id="it_excl" scope="request" class="niki.ExcelInput">
    <jsp:setProperty name="it_excl" property="*" />
</jsp:useBean>

<%@page import="niki.Item_Final" %>
<jsp:useBean id="itf" scope="request" class="niki.Item_Final">
    <jsp:setProperty name="itf" property="*" />
</jsp:useBean>

<!-- change request 1 -->
<jsp:useBean id="trsh_excl" scope="request" class="niki.TrashInput">
    <jsp:setProperty name="trsh_excl" property="*" />
</jsp:useBean>

<%
	Object username = session.getAttribute("userInSessionUsername");

    String action = request.getParameter("action");
	String itmDescription = request.getParameter("itemDesc");
	session.setAttribute("actionInSession", action);

    if(action.equals("rejectTemp"))
    {
        // the action to be performed is rejecting item
    
        String itmReject = request.getParameter("itemRejectSleep");

		session.setAttribute("itemReject", itmReject);
        it_tmp.setItem_id(itmReject);
   
        if (it_tmp.isValid()) {//TODO: why checking if it is valid
            //the data is valid

			//call the method to reject the item
            it_tmp.rejectItem();
            %>
            <jsp:forward page="finalItemsRejectionLinking.jsp">
            	<jsp:param name="itemRej" value="<%=itmReject %>"/>
            	<jsp:param name="itemDesc" value="<%=itmDescription %>"/>
            </jsp:forward>
            <%
            
            


        } else {
            //the data is not valid
            it_tmp.setInsertMsg("Invalid data");


        }
        
        %>
        <jsp:forward page="PendingItems.jsp"/>
        <%
    
    }
    else if(action.equals("sleepFinal")){
        // the action to be performed is sleep
        String itmDel = request.getParameter("itemRejectSleep");
       
       
        itf.setNiki_code(itmDel);
   
        if (itf.isValid()) {
            //the data is valid
			
            //call a method to sleep or make live an item
            itf.sleepItem();
            

        } else {
            //the data is not valid
            itf.setInsertMsg("Invalid data");
        }
        %>
        <jsp:forward page="FinalItems.jsp"/>
        <%
        
    }
    else if(action.equals("rejectExcel")){
    	
    	// the action to be performed is rejecting item
        
        String itmReject = request.getParameter("itemRejectSleep");
    	
        

		session.setAttribute("itemReject", itmReject);
		it_excl.setFromExcelId(itmReject);
   
        if (it_excl.isValid()) {//TODO: why checking if it is valid
            //the data is valid

			
        
         /*
         CR#1 BY VICTOIRE
            connecting to the db and getting the excel item to be rejected
            */
            
            String fromExcelId = null, externalId = null, itemDesc = null, codebar = null, external_info_1 = null, external_info_2 = null, filename = null, niki_code = null, status = null;
         	String company = null, usernameExc = null;
         	Timestamp timeExc= Timestamp.valueOf("2007-09-23 10:10:10.0");
            try{
            	Connection con = ConnectionClass.getConnection();
            	Statement ST1 = con.createStatement();
                ResultSet rs1 = ST1.executeQuery("SELECT * FROM itemsfromexcel where fromExceld='"+ itmReject + "'");
                
                while(rs1.next()){
                	fromExcelId = rs1.getString(1);
                	externalId = rs1.getString(2);
                    itemDesc = rs1.getString(3);
                    codebar = rs1.getString(4);
                    company = rs1.getString(5);
                    external_info_1 = rs1.getString(6);
                    external_info_2 = rs1.getString(7);
                    timeExc = rs1.getTimestamp(8);
                    usernameExc = rs1.getString(9);
                    filename = rs1.getString(10);
                    niki_code = rs1.getString(11); 
                    status = rs1.getString(12);
                    
                }
            	
            }catch(Exception e){
            	
            }
            trsh_excl.setFromExcelId(fromExcelId);
        	trsh_excl.setCodebar(codebar);
        	trsh_excl.setCompany(company);
        	trsh_excl.setExternal_info_1(external_info_1);
        	trsh_excl.setExternal_info_2(external_info_2);
        	trsh_excl.setExternalId(externalId);
        	trsh_excl.setItemDesc(itemDesc);
        	trsh_excl.setUsernameExc(usernameExc);
        	trsh_excl.setUsername(username);
        	trsh_excl.setFilename(filename);
        	trsh_excl.setNiki_code(niki_code);
        	trsh_excl.setStatus(status);
        	trsh_excl.setTime(timeExc);
        	
            
        	if(trsh_excl.insertTrashInput()){
            
	          	//call the method to reject the item
	            it_excl.deleteExcelInput();
	        	
	            %>
	            <jsp:forward page="finalItemsRejectionLinking.jsp"> 
	            	<jsp:param name="itemRej" value="<%=itmReject %>"/>
	            	<jsp:param name="itemDesc" value="<%=itmDescription %>"/>
	            </jsp:forward>
	            <%
        	}
        	else{
        		trsh_excl.setInsertMsg("rejection has failed, contact administrator");
        	}
        } else {
            //the data is not valid
            it_excl.setInsertMsg("Invalid data");


        }
        
      	//part of CR setting initialExcelView attribute to 'No', cause we are directing to View excel data, and it is not initial. 
     	session.setAttribute("initialExcelView", "no");
        %>
        <jsp:forward page="ViewFilesData.jsp"/>
        <%
    	
    }
    else{
        itf.setInsertMsg("action not supported!!"); 
    }

%>

