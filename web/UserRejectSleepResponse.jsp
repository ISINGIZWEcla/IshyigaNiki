<%-- 
    Document   : UserRejectSleepResponse
    Created on : Jun 21, 2016, 11:59:01 AM
    Author     : vakaniwabo
--%>

<%@page import="niki.User" %>
<jsp:useBean id="usr" scope="request" class="niki.User">
    <jsp:setProperty name="usr" property="*" />
</jsp:useBean>

<jsp:useBean id="usr_tmp" scope="request" class="niki.User_Temp">
    <jsp:setProperty name="usr_tmp" property="*" />
</jsp:useBean>

<%
    String action = request.getParameter("action");

    if(action.equals("rejectTemp"))
    {
        // the action to be performed is reject user
    
        String user = request.getParameter("userRejectSleep");

		//setting the username of the user to reject
        usr_tmp.setUsername(user);
   
        if (usr_tmp.isValid()) {
            //the data is valid

            //call the method to reject the user
            usr_tmp.rejectUser();

        } else {
            //the data is not valid
            usr_tmp.setInsertMsg("Invalid data");

        }
    
    }
    else if(action.equals("sleepFinal")){
        // the action to be performed is putting the user in sleep mode
        String user = request.getParameter("userRejectSleep");

		//setting the username of the user to sleep or make live
        usr.setUsername(user);
   
        if (usr.isValid()) { //TODO: why checking if the user is valid
            //the data is valid
			
            //call the method to sleep or make live the user
            usr.sleepUser();


        } else {
            //the data is not valid
            usr.setInsertMsg("Invalid data");
        }
        
    }
    else{
        usr.setInsertMsg("action not supported!!"); 
    }
%>
<jsp:forward page="FinalUsers.jsp"/>