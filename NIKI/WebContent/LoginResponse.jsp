<%-- 
    Document   : LoginResponse
    Created on : Jun 20, 2016, 3:54:30 PM
    Author     : vakaniwabo
--%>


<%@page import="niki.ConnectionClass"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.awt.RenderingHints.Key"%>
<%@page import="niki.User"%>
<%@page import="java.util.List"%>
<jsp:useBean id="usr" scope="request" class="niki.User" >
    <jsp:setProperty name="usr" property="*"  />  
</jsp:useBean>


<%
    String name = request.getParameter("username");
    String pass = request.getParameter("password");
    usr.setUsername(name);
    usr.setPassword(pass);


    Connection conn = ConnectionClass.getConnection();
    String query = "select user_type,privileges,first_name,status,language from users where user_name='" + name + "'";
    java.sql.Statement stm = conn.createStatement();
    ResultSet rs = stm.executeQuery(query);
    String userTypeFromDb = "";
    String userPrivsFromDb = "";
    String fNamefromDb = "";
    String usernameFromDb="";
    String statusFromDb="";
    String languageFromDb="";

    if (rs.next()) {

        userTypeFromDb = rs.getString("user_type");
        userPrivsFromDb=rs.getString("privileges");
        fNamefromDb=rs.getString("first_name");
        statusFromDb=rs.getString("status");
        languageFromDb=rs.getString("language");
    }

    session.setAttribute("errorLogin", "");
    
        
    /*
    check if the password matches the username
    */
    if (usr.checkUser()) {
        //the password matches the username

    	/*
        check if user's rights are still valid
        */
        if(statusFromDb!=null && !statusFromDb.equals("LIVE")){
        	//the user is in sleep mode (this is for users who are no longer supposed to use the system and they are put in sleep mode)
            session.setAttribute("errorLogin", "You no longer have right to access this page"+ "the status is: "+statusFromDb);
        
        %>
    		<jsp:forward page="Login.jsp"/>
    	<%
        }
        else{

            session.setAttribute("userInSessionfName", fNamefromDb);
            session.setAttribute("userInSessionType", userTypeFromDb);
            session.setAttribute("userInSessionPrivileges", userPrivsFromDb);
            session.setAttribute("userInSessionUsername", name);
            session.setAttribute("userInSessionLanguage", languageFromDb);
            
            session.setAttribute("formToUse", "index.html");
            String nextForm = session.getAttribute("formToUse").toString();
            response.sendRedirect(nextForm);

        }

    }
    
    else {
    	session.setAttribute("errorLogin", "Invalid Username or Password");

	%>

		<jsp:forward page="Login.jsp"/>

	<%}


%>



