<%-- 
    Document   : User_sign_upResponse
    Created on : Jun 21, 2016, 11:04:53 AM
    Author     : vakaniwabo
--%>

<%@page import="niki.User_Temp" %>
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
    String language = request.getParameter("lang").replaceAll("'", " ");
    String company = request.getParameter("company").replaceAll("'", " ");
    

    //  System.out.print(fnme + "   " + lev + "   " + stat + "   " + bran + "  " + "   " + dep + "   " + emai + "   " + phone + "   " + accnt + "   " + pass);

    usr_tmp.setFname(fnm);
    usr_tmp.setLname(lnm);
    usr_tmp.setSex(sex);
    usr_tmp.setEmail(eml);
    usr_tmp.setPhone(phn);
    usr_tmp.setUsername(user);
    usr_tmp.setPassword(pswd);
    usr_tmp.setLanguage(language);
    usr_tmp.setCompany(company);


    if (usr_tmp.isValid()) {
        if (usr_tmp.insertUserFinal()) {
            usr_tmp.setInsertMsg("Successfuly Inserted");

        } else {
            usr_tmp.setInsertMsg("Not inserted:ErrorDD:"+usr_tmp.getError());
        }

    } else {
        usr_tmp.setInsertMsg("Invalid data Now");
    }

%>
<jsp:forward page="createAccount.jsp"/>

