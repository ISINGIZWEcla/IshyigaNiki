
<%@page import="niki.Item_Temp" %>
<jsp:useBean id="it_tmp" scope="request" class="niki.Item_Temp">
    <jsp:setProperty name="it_tmp" property="*" />
</jsp:useBean>

<jsp:useBean id="it_excl" scope="request" class="niki.ExcelInput">
    <jsp:setProperty name="it_excl" property="*" />
</jsp:useBean>

<!-- ADDED BY VICTOIRE: CR#1 -->
<jsp:useBean id="trsh_excl" scope="request" class="niki.TrashInput">
    <jsp:setProperty name="trsh_excl" property="*" />
</jsp:useBean>
<!-- END OF ADDED FOR CR#1 -->

<%
String niki = request.getParameter("nikicode");
String action = session.getAttribute("actionInSession").toString();

String itmReject=request.getParameter("itemReject");

//String itmReject = session.getAttribute("itemReject").toString();
           
 
 if(action.equals("rejectTemp"))
 {
	 it_tmp.setItem_id(itmReject);
     it_tmp.setNiki_code(niki);
     it_tmp.addItemNiki_code();//calling a function to add attach a niki code to the rejected item
     it_tmp.setInsertMsg("item is rejected successfully");
 %>
 
  	<jsp:forward page="PendingItems.jsp"/>
  
  <%
 }
 if(action.equals("rejectExcel"))
 {
	 //ADDED BY VICTOIRE: CR#1
	 trsh_excl.setFromExcelId(itmReject);
	 trsh_excl.setNiki_code(niki);
	 trsh_excl.addItemNiki_code();//calling a function to add attach a niki code to the rejected item
	 //END OF ADDED FOR CR#1
	 
	 it_excl.setInsertMsg("item number "+ itmReject +" is rejected successfully and saved to Trash");
	
	 //part of CR setting initialExcelView attrubute to No, cause we are directing to View excel data, and it is not initial. 
	 session.setAttribute("initialExcelView", "no");
	  
	  %>
	  <jsp:forward page="ViewFilesData.jsp"/>
	  <%
    
 }
    
 %>