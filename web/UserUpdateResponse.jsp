<%-- 
    Document   : UserUpdateResponse
    Created on : Jun 21, 2016, 7:06:09 PM
    Author     : vakaniwabo
--%>

<jsp:useBean id="usr" scope="request" class="niki.User">
    <jsp:setProperty name="usr" property="*" />
</jsp:useBean>

<%

    String fnm = request.getParameter("fname").toUpperCase().replaceAll("'", " ");
    String lnm = request.getParameter("lname").toUpperCase().replaceAll("'", " ");
    String sex = request.getParameter("sex").toUpperCase().replaceAll("'", " ");
    String eml = request.getParameter("email").replaceAll("'", " ");
    String phn = request.getParameter("phone").replaceAll("'", " ");
    String user = request.getParameter("username").replaceAll("'", " ");
    
	session.setAttribute("userToEdit", user);

    String pswd = request.getParameter("password").replaceAll("'", " ").replaceAll("'", " ");
    String language = request.getParameter("lang").replaceAll("'", " ");
    String usertp = request.getParameter("usrtyp").toUpperCase().replaceAll("'", " ");
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
    

    if (usr.isValid()) {
        if (usr.updateUser()) {
            //the user is updated successfully
                        
            usr.setInsertMsg("Successfuly updated");

        } else {
            usr.setInsertMsg("Not updated:Error:"+usr.getError());
        }

    } else {
        usr.setInsertMsg("Invalid data");
    }

%>
<jsp:forward page="UserUpdate.jsp"/> 
