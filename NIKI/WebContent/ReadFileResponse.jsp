
 
 
<%
    Object checkUserPrivileges = session.getAttribute("userInSessionPrivileges");
    Object checkfName = session.getAttribute("userInSessionfName");
    Object checkType = session.getAttribute("userInSessionType");
    if (checkUserPrivileges == null) {
%>
<jsp:forward page="Login.jsp"/>


<%    
} else if (!checkUserPrivileges.toString().contains("EXCELINPUT")) {
    session.setAttribute("errorLogin","you don't have the right to input excel sheet");

%>
<jsp:forward page="Login.jsp"/>


<%    } else {
	String userLanguage = session.getAttribute("userInSessionLanguage").toString();

%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="niki.ConnectionClass"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>

<%@page import="niki.ExcelInput"%>
<jsp:useBean id="excInpt" scope="request" class="niki.ExcelInput">
    <jsp:setProperty name="excInpt" property="*"/>
</jsp:useBean>

<%
String user=session.getAttribute("userInSessionfName").toString(); 


%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Choose Company</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  

		<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"> 
 		 
        <script src="assets/js/jquery-1.12.3.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        
        <script src="assets/js/bootstrap.min.js" type="text/javascript"></script>
        
 

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
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="index.html">Home</a></li>
        <li><a href="import&export.jsp">import&export</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<li><i class="glyphicon glyphicon-user" style="color: white;font-size: 2em;"> <%=user%></i></li>
        <li><a href="Logout.jsp" class="btn btn-info btn-lg" style="color: white;">
          <span class="glyphicon glyphicon-log-out"></span> Log out
        </a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">
  <div class="row content">
    <div class="col-sm-2 sidenav">
      
    </div>
    <div class="col-sm-8 text-left" >
		<div class="page-header">
			<h1 style="text-align: center; text-shadow: maroon;">Reading Excel File</h1>
		</div>         
            
		<%
	String filepath = request.getAttribute("message").toString();
  	//String filepath = request.getParameter("file");
	Object username = session.getAttribute("userInSessionUsername");
//    	String companyName = request.getAttribute("company").toString();
	String companyName = session.getAttribute("compagnie").toString();


	out.println(" filepath: "+filepath+"<br>");
	out.println(" companyName: "+companyName+"<br>");
	out.println("......loading"+"<br><br>");
	
	String [] filename = filepath.split("[\\\\]");
	int n=filename.length;
	
    
	try {
		
		
		FileInputStream file = new FileInputStream(new File(filepath));

		//Get the workbook instance for XLS file 
		XSSFWorkbook workbook = new XSSFWorkbook(file);

		//Get first sheet from the workbook
		XSSFSheet sheet = workbook.getSheetAt(0);
		
		//Iterate through each rows from first sheet
		Iterator<Row> rowIterator = sheet.iterator();
		
		
		int i=0;
		int insertedRow=0;
		while(rowIterator.hasNext()) {
			
			Row row = rowIterator.next();
			i++;
			String data="";
			//array to store data for the whole row
			String [] dataForRow=new String[5];
			int j=0;
			
			//For each row, iterate through each column
			Iterator<Cell> cellIterator = row.cellIterator();
			while(cellIterator.hasNext() && j<5) {
				//I make sure to only go through 5 colums only
				Cell cell = cellIterator.next();
				
				/* if(cell == null){
					//a cell is null
					data="-";
				}
				else{ */
					
					switch(cell.getCellType()) {
						case Cell.CELL_TYPE_BOOLEAN:
							///System.out.print(cell.getBooleanCellValue() + "\t\t");
							data=cell.getBooleanCellValue()+"";
	
							break;
						case Cell.CELL_TYPE_NUMERIC:
							//System.out.print(cell.getNumericCellValue() + "\t\t");
							data=cell.getNumericCellValue()+"";
							break;
						case Cell.CELL_TYPE_STRING:
							//System.out.print(cell.getStringCellValue() + "\t\t");
							data=cell.getStringCellValue()+"";
							break;
						case Cell.CELL_TYPE_BLANK:
							///System.out.print(cell.getStringCellValue() + "\t\t");
							data="";
							break;
					}//end switch
				
				dataForRow[j]=data;
				j++;
				
				
			}//end while (which iterate in colums)
			/*
			data to be stored in the database
			*/
			//System.out.println("hereeeeeeeeeeeeeeee: "+String.valueOf(dataForRow[0]));
			String externalId="";
			if(dataForRow[0] != null){
				
			//	out.println("String.valueOf(dataForRow[1])  " +String.valueOf(dataForRow[1]));
		    externalId=dataForRow[0].replaceAll("'", " ");
			//out.println(i+" $$$$    iiiiii externalId  " +externalId);
			String itemDesc = String.valueOf(dataForRow[1]).replaceAll("'", " "); 
			//out.println(" $$$$ itemDesc " +itemDesc);
			String barcode = String.valueOf(dataForRow[2]).replaceAll("'", " ");
			//out.println("$$$$  barcode  " +barcode);
			String externalInfo1 = String.valueOf(dataForRow[3]).replaceAll("'", " ");
			//out.println("$$$$ externalInfo1  " +externalInfo1);
			String externalInfo2 = String.valueOf(dataForRow[4]).replaceAll("'", " "); 
			//out.println("SexternalInfo2 " +externalInfo2);
			
			/*
			setting the attributes
			*/
			
			excInpt.setExternalId(externalId);
			excInpt.setItemDesc(itemDesc);
			excInpt.setCodebar(barcode);
			excInpt.setCompany(companyName);
			excInpt.setExternal_info_1(externalInfo1);
			excInpt.setExternal_info_2(externalInfo2);
			excInpt.setUsername(username);
			//excInpt.setFilename(filename[n-1]);
			excInpt.setFilename("medical.xls");
				
			}
			else{
				out.println("wamenetse");
			}
			/*
			calling the method to insert in the database
			*/
			boolean ndimo=!excInpt.isRowDuplicate(externalId, companyName);
			
			if(ndimo && excInpt.insertExcelInput()){
				insertedRow++;
			}
			else{
				//out.println(excInpt.getInsertMsg()+"<br>");
				//out.println(excInpt.getError()+"<br>");
				
			}			
						
		}//end while (which iterate in rows)
		
		String res=excInpt.insertExcelLogs( username.toString(), filepath,companyName, i, insertedRow);
		out.println(" res: "+res+"<br>");
		out.println(" filepath: "+filepath+"<br>");
		out.println(i+" received   ||  inserted: "+insertedRow+"<br><br>");
		out.println(" Excel loading is done! ");
			
		file.close();//closing the file
		
	} catch (FileNotFoundException e) {
		e.printStackTrace();
		//return mydata;
	} catch (IOException e) {
		e.printStackTrace();
		//return mydata;
	}
	
		
%>
       	
        
    </div>
    <div class="col-sm-2 sidenav" >
      
    </div>
  </div>
</div>


<footer class="container-fluid text-center">
  <p><strong> Copyright &#169; 2016 Algorithm,Inc.</strong></p>
</footer>


</body>
</html>
<% 
}
%>
 