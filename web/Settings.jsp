<%-- 
    Document   : Settings
    Created on : Jul 21, 2021, 7:34:16 AM
    Author     : Administrator
--%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>NIKI</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css">
	<script src="assets/js/jquery.min.js"></script>
<!--   <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;}
    }
  </style>
</head>
 <meta charset="UTF-8"> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
    
    	<div style="background-color: orange; border-style: solid;width:100%;">
	        <div style="text-align: center; border:medium; "><h1>Welcome To NIKI</h1> </div>         
        </div>
        <div style="background: #CCCCCC; position:absolute;width:100%;height:100%">
	        <div style=" margin-left:25%; margin-top:5%;">  
	        
		        <div style="float: left;margin-right:20px">
		        	<form action="Category.jsp">
		        		<input type="submit" style="font-weight:bold;width: 15em; height: 12em;color: black;font-size: 100; background-color:  powderblue;" value="CATEGORIES"/>
		        	</form> 
		        </div>
		        <div style="float: left;margin-right:20px">
		        	<form action="Emballage.jsp">
		        		<input type="submit" style="font-weight:bold; background: pink; width: 15em; height: 12em;color: black;" value="EMBALLAGE"/>
		        	</form> 
		        </div>
		        <div style="margin-right:20px;margin-bottom:20px;">
                            <a href="../build/web/settings.jsp"></a>
		        	<form action="Form.jsp">
		        		<input type="submit" style="font-weight:bold; width: 15em; height: 12em;color: black ; background: red;" value="FORM"/>
		        	</form> 
		        </div>
		        <div style="float: left;margin-right:20px">
		        	<form action="taxPage.jsp">
		        		<input type="submit" style="font-weight:bold; width: 15em; height: 12em;color: black; background-color: orange;" value="TAXES"/>
		        	</form> 
		        </div>
		        <div style="float: left;margin-right:20px">
		        	<form action="taxPage.jsp">
		        		<input type="submit" style="font-weight:bold; width: 15em; height: 12em;color: black; background-color:  lightgreen; " value="AUTHORITIES"/>
		        	</form> 
		        </div>
		        <div style="margin-right:20px;margin-bottom:20px;">
		        	<form action="Business_Category.jsp">
		        		<input type="submit" style="font-weight:bold; width: 15em; height: 12em;color: black;background-color: yellow; " value="BUSINESSES"/>
		        	</form> 
		        </div>
                    <div style="margin-right:20px;margin-bottom:20px;">
		        	<form action="Niki_Report.jsp">
                                    <input type="submit" style="font-weight:bold; width: 15em; height: 12em;color: black;" class="bg-info" value="REPORT"/>
		        	</form> 
		        </div>
                    <a href="../build/web/Settings.jsp"></a>
                     
	        </div>

<!--         <div><a href="testDesign.jsp">Design</a></div> -->
        <!-- <div><a href="PopUpButtonDemo.jsp">Pop up demo</a></div>
        <div><a href="testModal.jsp">Test Modal</a></div> -->
    
		</div>
		<div style="background-color: orange; border-style: solid;width:100%;">
	        <div style="text-align: center; border:medium; "><h1>Welcome To NIKI items codification</h1> </div>         
        </div>
		

</html>


