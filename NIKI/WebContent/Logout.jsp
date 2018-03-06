<%-- 
    Document   : Logout
    Created on : Jun 21, 2016, 7:48:26 PM
    Author     : vakaniwabo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
           if(!session.getAttribute("userInSessionfName").equals("null")){
                session.removeAttribute("userInSessionfName");
           //session.removeAttribute("password"); 
                session.invalidate();  
                response.sendRedirect("index.html");
        %> 
        <h1>Logout was done successfully.</h1> 
        <% 
           }else{
               %>
               <h1>Logout failed.</h1>
               <%
           }  
        %>
    </body>
</html>

