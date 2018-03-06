package niki;

import java.sql.DriverManager;

import java.sql.Connection;

public class ConnectionClass {

	public ConnectionClass() {
		// TODO Auto-generated constructor stub
	}
	
	   public static Connection getConnection() {
	        Connection conn = null;
	        try {
	            Class.forName("com.mysql.jdbc.Driver");
	           // conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/niki","second_user" ,"pass"); 
	           // conn = DriverManager.getConnection("jdbc:mysql://197.243.18.234:3306/niki","root" ,"Msqabc!123"); 
	            conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/niki","root" ,"pass");
	            //conn = DriverManager.getConnection("jdbc:mysql://niki-db.clpnj9wwsnxz.us-west-2.rds.amazonaws.com:3306/ebdb","niki_vicky" ,"mysqlniki");
	            
	        } catch (Exception e) { 
	            e.printStackTrace();

	        }
	        return conn;
	    }

}
