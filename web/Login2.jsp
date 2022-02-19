

<%-- 
    Document   : Login2
    Created on : Jan 3, 2022, 1:33:01 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>NIKI LOGIN</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://ootsmaxcdn.btrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css"
        href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fontawesome.com/v4.7/icons/">
    <link rel="stylesheet" href="assets/css/login.css">
    <script src="assets/js/jquery.min.js"></script>
</head>

<body>
    <div class="login-form">
        
        	<div id="smsG" style="color: red;">

                <%
                    Object recMsg = session.getAttribute("errorLogin");
                    
                    /*
                    this prevents from just printing null when there is no error
                    */
                    if(recMsg!=null ){
                     out.print(recMsg);
                     }else{
                     out.print("");                     
                     }

                %>
            </div>
        <form method="post" action="LoginResponse.jsp">
            <p class="text-center">Welcome to NIKI, Please login to continue.</p>
            
            <div class="second-grp">
                <div class="form-group">
                    <div class="icons"><i class="fa fa-user" aria-hidden="true"></i></div>
                    <div><input type="text" class="form-control" name="username" value="${usr.username}" placeholder="Username"
                            required="required"></div>
                </div>
                <div class="form-group">
                    <div class="icons"><i class="fa fa-key" aria-hidden="true"></i></div>
                    <div><input type="password" class="form-control " name="password" value="${usr.password}" placeholder="Password"
                            required="required"></div>
                </div>
                <div class="form-group">
                    <button type="submit" class="btn btn-block " id="signIn">Sign in</button>
                </div>

        </form>
    </div>
</body>

</html>