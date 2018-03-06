/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package niki;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class User {

    private String username, email, password, fname, lname, sex,  phone, user_type, privileges,status="LIVE",language;
    
    private String msgUser, msgFn, msgLn, msgPswd, msgEm, msgPhone, error;
    private boolean valid = true;
    private String UserMsg, insertMsg;
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();
    
    
    public User() {
    }

    public User(String username, String email, String password, String fname, String lname, String sex, String phone, String user_type, String privileges) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.fname = fname;
        this.lname = lname;
        this.sex = sex;
        this.phone = phone;
        this.user_type = user_type;
        this.privileges = privileges;
    }
    
    

    /*
    Getters and Setters
    */

    public String getUser_type() {
        return user_type;
    }

    public void setUser_type(String user_type) {
        this.user_type = user_type;
    }

    public String getPrivileges() {
        return privileges;
    }

    public void setPrivileges(String privileges) {
        this.privileges = privileges;
    }
     
    
    public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public Connection getConn() {
		return conn;
	}

	public void setConn(Connection conn) {
		this.conn = conn;
	}

	public String getEmail() {
        return email;
    }

    public String getInsertMsg() {
        return insertMsg;
    }


    public void setInsertMsg(String InsertMsg) {
        this.insertMsg = InsertMsg;
    }

    public void setEmail(String email) {
        this.email = email;


        if (email.endsWith(".com") || (email.endsWith(".fr") || (email.endsWith(".rw")))) {
            msgEm = "";

        } else {
            valid = false;
            msgEm = "should end by .com or .fr or .rw";
            // msgEm = "Invalid email try correctly";
            
        }
        

    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
    
    

    public String getFname() {
        return fname;

    }

    public void setFname(String fname) {
        this.fname = fname;
        int fn = fname.length();
        if (fn < 4) {
            valid = false;
            msgFn = "Should be at least 4 characters";

        }

    }

   

    public String getMsgPhone() {
        return msgPhone;
    }

    public void setMsgPhone(String msgPhone) {
        this.msgPhone = msgPhone;
    }

    public void setLname(String lname) {
        this.lname = lname;
        int ln = lname.length();
        if (ln < 4) {
            valid = false;
            msgLn = "Should be at least 4 characters";

        }

    }

    public String getLname() {
        return lname;
    }

    public String getUserMsg() {
        return UserMsg;
    }

    public void setUserMsg(String UserMsg) {
        this.UserMsg = UserMsg;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public String getMsgEm() {
        return msgEm;
    }

    public void setMsgEm(String msgEm) {
        this.msgEm = msgEm;
    }

    public String getMsgFn() {
        return msgFn;
    }

    public void setMsgFn(String msgFn) {
        this.msgFn = msgFn;
    }

    public String getMsgLn() {
        return msgLn;
    }

    public void setMsgLn(String msgLn) {
        this.msgLn = msgLn;
    }

    public String getMsgPswd() {
        return msgPswd;
    }

    public void setMsgPswd(String msgPswd) {
        this.msgPswd = msgPswd;
    }

    public String getMsgUser() {
        return msgUser;
    }

    public void setMsgUser(String msgUser) {
        this.msgUser = msgUser;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;

//        int p = password.length();
//        if (p <= 5) {
//
//            valid = false;
//            msgPswd = "should be at least 6 characters ";
//        }
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;

        int uname = username.length();
        if (uname < 4) {
            valid = false;
            msgUser = "Should be at least 4 characters";

        }
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;

        try {
        	//verifying if it contains only digits
            Long.parseLong(phone);
            
            if(phone.startsWith("07")){
            	msgPhone="";
            
	            int phnLen =phone.length();
	            
	            if(phnLen!=10){
	                //mobile phone numbers in Rwanda contain   10digits
	               valid=false; 
	               msgPhone="should be ten digits";
	            }
	            else{
	                msgPhone="";
	            }
            }
            else{
            	valid=false;
            	msgPhone="phone number should start with 07";
            }
          
        } catch (Exception e) {
            msgPhone = "enter digits";
            valid=false;
        }
    }
    
    /*
    end of getters and setters
    */

   
//username, email, password, fname, lname, sex,  phone, user_type, privileges
    public boolean insertUser() {

        try {
 
            PreparedStatement pst = conn.prepareStatement("insert into users values(?,?,?,?,?,?,?,?,?,?,?)");

            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setString(4, fname);
            pst.setString(5, lname);
            pst.setString(6, sex);
            pst.setString(7, phone);
            pst.setString(8, user_type);
            pst.setString(9, privileges);
            pst.setString(10, status);
            pst.setString(11, language);

            pst.execute();
            conn.close();
            insertMsg="Successfully insert";
            return true;
        } catch (Exception e) {
            insertMsg="Not Inserted" + e.getMessage();
            setError(e.getMessage());
            return false;

        }
    }
    //============================================================================

    public boolean updateUser() {

        try {
            PreparedStatement pst = conn.prepareStatement("update users set email_address=?, password=?, first_name=?, last_name=?, gender=?,  phone=?, user_type=?, privileges=?, language=? where user_name=?");
            
            pst.setString(10, username);
            pst.setString(1, email);
            pst.setString(2, password);
            pst.setString(3, fname);
            pst.setString(4, lname);
            pst.setString(5, sex);
            pst.setString(6, phone);
            pst.setString(7, user_type);
            pst.setString(8, privileges);
            pst.setString(9, language);

            pst.execute();
            conn.close();
            insertMsg="Successfully updated";
            return true;
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not updated u repeat username";
            return false;

        }
    }
    
    
    public boolean addUserPrivilege() {

        try {
            String privlgs="";//variable to hold the privileges returned from the db
            
            /*
            I will first get the privileges the users already has, then after add the new one to those
            */
            String query = "select privileges from users where user_name='" + username + "'";
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery(query);
            
            if (rs.next()) {

                privlgs = rs.getString("privileges");

            }
           
            
            PreparedStatement pst = conn.prepareStatement("update users set privileges=? where user_name='" + username + "'");
            
            
            pst.setString(1, privlgs+" "+privileges);

            pst.execute();
            conn.close();
            insertMsg="Successfully added";
            return true;
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not added "+ e.getMessage();
            return false;

        }
    }


    public boolean deleteUser() {

        try {

            PreparedStatement pst = conn.prepareStatement("delete from users where user_name=?");

            pst.setString(1, username);


            pst.execute();
            conn.close();
            // insertMsg="Successfully insert";
            return true;
        } catch (Exception e) {
            //InsertMsg="Not Inserted u repeat username";
            return false;

        }
    }
    
    public boolean checkUserPrivileges() {
        try {

            String query = "select privileges from users where user_name='" + username + "'";
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery(query);
            if (rs.next()) {

                String privlgs = rs.getString("privileges");
                
                String query2 = "select privileges from users where user_name='" + username + "'";
                Statement stm2 = conn.createStatement();
                ResultSet rs2 = stm2.executeQuery(query);
                if (rs.next()) {
                
                return true;
                }
                return true;
                
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;

        }

    }

    public boolean checkUser() {
        try {

            String query = "select passWord,user_name from users where user_name='" + username + "'";
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery(query);
            if (rs.next()) {

                String userNameFromDb = rs.getString("user_name");
                String userPasswordFromDb = rs.getString("passWord");
                if (userNameFromDb.equals(username) && userPasswordFromDb.equals(password)) {
                    valid = true;
                    UserMsg = "access is  granted";
                    return true;
                } else {
                    valid = false;
                    UserMsg = "Invalid Username or Password ";
                    return false;
                }
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;

        }

    }
    
    
    /*
    this functions sleeps a user by changing his/her status to sleeping
    it retuns true when that is done successfully, and false otherwise
    */
    public boolean sleepUser() {

    	String statusFrmDb="";
        try {
        	PreparedStatement ps = conn.prepareStatement("select status from users where user_name=?");
 
        	ps.setString(1, username);
        	
        	ResultSet rs = ps.executeQuery();
        	
        	while(rs.next()){
            	statusFrmDb = rs.getString("status");
        	}
        	
        	
        	
            PreparedStatement pst = conn.prepareStatement("update users set status = ?  where user_name=?");

  
            pst.setString(2, username);
            pst.setString(1, "SLEEPING");
            if(statusFrmDb.equals("LIVE")){
            	pst.setString(1, "SLEEPING");
            	insertMsg="Successfully slept";
            }
            else if(statusFrmDb.equals("SLEEPING")){
            	pst.setString(1, "LIVE");
            	insertMsg="Successfully made LIVE";
            }

            pst.execute();
            conn.close(); 
            
            return true;
                        
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not slept";
            return false;
        }
    }

    
}