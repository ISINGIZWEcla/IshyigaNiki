<%-- 
    Document   : ValidateUserResponse
    Created on : Jun 21, 2016, 1:26:38 PM
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

    String fnm = request.getParameter("fname").toUpperCase().replaceAll("'", " ");
    String lnm = request.getParameter("lname").toUpperCase().replaceAll("'", " ");
    String sex = request.getParameter("sex").toUpperCase().replaceAll("'", " ");
    String eml = request.getParameter("email").replaceAll("'", " ");
    String phn = request.getParameter("phone").replaceAll("'", " ");
    String user = request.getParameter("username").replaceAll("'", " ");
    String pswd = request.getParameter("password").replaceAll("'", " ");
    String usertp = request.getParameter("usrtyp").toUpperCase().replaceAll("'", " ");
    String language = request.getParameter("lang").replaceAll("'", " ");
    String [] privs = request.getParameterValues("prvlg");
    String privileges="";

    //  System.out.print(fnme + "   " + lev + "   " + stat + "   " + bran + "  " + "   " + dep + "   " + emai + "   " + phone + "   " + accnt + "   " + pass);

    usr.setFname(fnm);
    usr.setLname(lnm);
    usr.setSex(sex);
    usr.setEmail(eml);
    usr.setPhone(phn);
    usr.setUsername(user);
    usr.setPassword(pswd);
    usr.setUser_type(usertp);
    usr.setLanguage(language);
    
    for(String priv:privs){
    	privileges=privileges+priv.toUpperCase()+" ";
    }
    usr.setPrivileges(privileges);
    
    usr_tmp.setUsername(user);

    if (usr.isValid()) {
        if (usr.insertUser()) {
            //the user is validated successfully
            
            //this is to change the status of the user to "transformed"
            usr_tmp.transformUser();
            
            usr.setInsertMsg("Successfuly Inserted");

        } else {
            usr.setInsertMsg("Not inserted:Error:"+usr.getError());
        }

    } else {
        usr.setInsertMsg("Invalid data");
    }

%>
<jsp:forward page="UserValidationReal.jsp"/>
