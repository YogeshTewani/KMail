package Kmail;


import java.sql.*;
import java.text.SimpleDateFormat;




public class Login {

	String userId, password;
	String firstName, lastName, qualification, occupation, city, state,
			country, address,message;
	String date,month,year,dob, gender, email, phoneNo, mobileNo, securityQuestion,securityAnswer;
	Date date1;
	int flag;

	// Get and Set Data

	public void setUserId(String userId) {
		this.userId = userId.toLowerCase();
	}

	public String getUserId() {
		return userId;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return password;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getDate() {
		return date;
	}
	
	public void setMonth(String month) {
		this.month = month;
	}

	public String getmonth() {
		return month;
	}
	
	public void setYear(String year) {
		this.year = year;
	}

	public String getYear() {
		return year;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getGender() {
		return gender;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	public String getQualification() {
		return qualification;
	}

	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}

	public String getOccupation() {
		return occupation;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCity() {
		return city;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getState() {
		return state;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCountry() {
		return country;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress() {
		return address;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return email;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setSecurityQuestion(String sq) {
		this.securityQuestion = sq;
	}

	public String getSecurityQuestion() {
		return securityQuestion;
	}

	public void setSecurityAnswer(String sa) {
		this.securityAnswer = sa;
	}

	public String getSecurityAnswer() {
		return securityAnswer;
	}
	
	public String getMessage()
	{
		return message;
	}
	
	public boolean checkLogin()
	{
		boolean flag = false;
		Connection conn=null;
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		conn=DBConnection.getConnection();
		
		if(conn!=null)
		{
			try
			{
				query = "select * from userregistration where userId=? and password=?";
				pstmtSelect = conn.prepareStatement(query);
				pstmtSelect.setString(1, userId);
				pstmtSelect.setString(2, password);
				rset = pstmtSelect.executeQuery();
				if(rset.next())
				{
					flag=true;
				}
				else
				{
					flag=false;
				}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
				flag=false;
			}
			
		}
		else
		{
			message="Error While Connection To Database";
			flag=false;
		}
		return flag;
		}
	
		
	
	// Registration Details
	
	
	public boolean insertRecord() throws Exception
	{
		
		Connection conn=null;
		PreparedStatement pstmtInsert=null;
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		conn=DBConnection.getConnection();
		
		SimpleDateFormat dateformat=new SimpleDateFormat("dd-MM-yyyy");
		
			dob=date+"-"+month+"-"+year;
			java.sql.Date date1=new java.sql.Date(dateformat.parse(dob).getTime());
			
			System.out.println("&&&&&&&&&&&&&&"+date1);
		
		
			
		if(conn!=null)
		{
			try
			{
			query="select * from userregistration where userid=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setString(1, userId);
			rset=pstmtSelect.executeQuery();
			if(rset.next())
			{
				this.userId=rset.getString("userid");
				System.out.println("Userid already exits");
				
				
			}
			else
			{
				String query2="insert into userregistration(userId,password,firstName,lastName,dob,gender,qualification,occupation,city,state,country,address,email,phoneNo,mobileNo,securityQuestion,securityAnswer) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				
				pstmtInsert=conn.prepareStatement(query2);
				pstmtInsert.setString(1,getUserId());
				pstmtInsert.setString(2,getPassword());
				pstmtInsert.setString(3,getFirstName());
				pstmtInsert.setString(4,getLastName());
				pstmtInsert.setDate(5,date1);
				pstmtInsert.setString(6,getGender());
				pstmtInsert.setString(7,getQualification());
				pstmtInsert.setString(8,getOccupation());
				pstmtInsert.setString(9,getCity());
				pstmtInsert.setString(10,getState());
				pstmtInsert.setString(11,getCountry());
				pstmtInsert.setString(12,getAddress());
				pstmtInsert.setString(13,getEmail());
				pstmtInsert.setString(14,getPhoneNo());
				pstmtInsert.setString(15,getMobileNo());
				pstmtInsert.setString(16,getSecurityQuestion());
				pstmtInsert.setString(17,getSecurityAnswer());
				
				System.out.println("********"+pstmtInsert);
				
				
				int i =pstmtInsert.executeUpdate();
				if(i>0){
					//message="Congratulations ! You are successfully registered. "+
				//"Please use your Login Id and password to access your account.";
					
					System.out.println("Record updated successfully");
					flag=1;
				}
				else{
					message="Error! Please Try Again";
					flag=0;
				}
				
			}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
				flag=0;
			}
			
		}
		else
		{
			message="Error While Connection To Database";
			flag=0;
		}
		if(flag==1)
		{
			return true;
		}
		else
		{
			return false;
		}
		
	}
	
	public String CheckUserAvailability(String enteredId) throws Exception
	{
		String message="";
		
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		
		try
		{
			query="Select * from userregistration where userId=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setString(1, enteredId);
			rset=pstmtSelect.executeQuery();
			
			if(rset.next())
			{
				message="Id Not Available";
			}
			else
			{
				message="Id Available";
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
			message="Id Not Available";
		}
		
		return message;
	}
	
}
