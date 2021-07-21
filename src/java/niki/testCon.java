package niki;
import java.sql.*;  


public class testCon {

	public static void main(String args[]){  
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/niki","root","pass");  
			//here sonoo is database name, root is username and password  
			Statement stmt=con.createStatement();
			//Trash_from_excel
			ResultSet rs=stmt.executeQuery("select * from Trash_from_excel"); 
			while(rs.next())  
			System.out.println(rs.getInt(1)+"  "+rs.getString(2));  
			con.close();  
		}catch(Exception e){ 
			System.out.println(e.getMessage());
		}  
	}
}

