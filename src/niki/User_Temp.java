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

/**
 *
 * @author vakaniwabo
 */
public class User_Temp {
    
    private String username, email, password, fname, lname, sex,  phone,status="PENDING",language;
    
    private String msgUser, msgFn, msgLn, msgPswd, msgEm, msgPhone, error;
    private boolean valid = true;
    private String userMsg, insertMsg;
    
    //connection instance
    Connection conn = ConnectionClass.getConnection();
    
    
    public User_Temp() {
    }

    public User_Temp(String username, String email, String password, String fname, String lname, String sex, String phone) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.fname = fname;
        this.lname = lname;
        this.sex = sex;
        this.phone = phone;
 
    }
    
    

    /*
    Getters and Setters
    */

  
    
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
        return userMsg;
    }

    public void setUserMsg(String UserMsg) {
        this.userMsg = UserMsg;
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
    public boolean insertUserTemp() {

        try {
 
            PreparedStatement pst = conn.prepareStatement("insert into users_temp values(?,?,?,?,?,?,?,?,?)");

            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setString(4, fname);
            pst.setString(5, lname);
            pst.setString(6, sex);
            pst.setString(7, phone);
            pst.setString(8, status);
            pst.setString(9, language);
 

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
    //============================================================================to be reviewed and corrected

    public boolean updateUserTemp() {

        try {
            PreparedStatement pst = conn.prepareStatement("update users_temp set email_address=?, password=?, first_name=?, last_name=?, gender=?,  phone=?,language=? where user_name=?");
            
            pst.setString(9, username);
            pst.setString(1, email);
            pst.setString(2, password);
            pst.setString(3, fname);
            pst.setString(4, lname);
            pst.setString(5, sex);
            pst.setString(6, phone);


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
    
   


    public boolean deleteUserTemp() {

        try {

            PreparedStatement pst = conn.prepareStatement("delete from users_temp where user_name=?");

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
    

    public boolean checkUserTemp() {
        try {

            String query = "select passWord,user_name from users_temp where user_name='" + username + "'";
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery(query);
            if (rs.next()) {

                String userNameFromDb = rs.getString("user_name");
                String userPasswordFromDb = rs.getString("passWord");
                if (userNameFromDb.equals(username) && userPasswordFromDb.equals(password)) {
                    valid = true;
                    userMsg = "access is  granted";
                    return true;
                } else {
                    valid = false;
                    userMsg = "Invalid Username or Password ";
                    return false;
                }
            } else {
                return false;
            }
        } catch (Exception e) {
            return false;

        }

    }
    
    

    //----------------LoginMethods--------------
    public List<User> retrieveUserTemp() {

        List<User> AllUser = new ArrayList<User>();
        try {
            
            String query = "select user_name,passWord from users_temp where user_name='" + username + "'";
            Statement stm = conn.createStatement();
            ResultSet rs = stm.executeQuery(query);
            while (rs.next()) {
                User q = new User();
                q.setUsername(rs.getString("user_name"));

                q.setPassword(rs.getString("passWord"));

                AllUser.add(q);

            }
        } catch (Exception e) {
        }
        return AllUser;
    }
    
    /*
    this function changes a pending user status to "rejected" whenever the user is rejected
    returns true when it rejects successfully, and false otherwise
    */
    
    public boolean rejectUser() {

        try {
            PreparedStatement pst = conn.prepareStatement("update users_temp set status = ?  where user_name=?");

  
            pst.setString(2, username);
            pst.setString(1, "rejected");

            pst.execute();
            conn.close(); 
            insertMsg="Successfully rejected";
            return true;
            
            
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not rejected";
            return false;

        }
    }
    
    /*
    this function changes a pending user status to "transformed" whenever the user is validated successfully
    returns true when it transforms successfully, and false otherwise
    */
    public boolean transformUser() {

        try {
            PreparedStatement pst = conn.prepareStatement("update users_temp set status = ?  where user_name=?");

  
            pst.setString(2, username);
            pst.setString(1, "transformed");

            pst.execute();
            conn.close(); 
            insertMsg="Successfully transformed";
            return true;
            
            
        } catch (Exception e) {
            setError(e.getMessage());
            insertMsg="Not transformed";
            return false;

        }
    }
    
}
