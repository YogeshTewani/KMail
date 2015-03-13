package Kmail;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

public class Profile 
{
	String userId,password;
	String firstName, lastName, qualification, occupation, city, state,
			country, address,message;
	String gender, email, phoneNo, mobileNo, securityQuestion,
			securityAnswer;
	String date,month,year;
	//Date dob;

	// Get and Set Data
	
	public void setUserId(String userId)
	{
		this.userId=userId;
	}
	
	public String getUserId()
	{
		return userId;
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
	
	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return password;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getGender() {
		return gender;
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

	public String getMonth() {
		return month;
	}
	
	public void setYear(String year) {
		this.year = year;
	}

	public String getYear() {
		return year;
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
	
	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress() {
		return address;
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
	
	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return email;
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
	
	public void getUserInfo(String currentUser)throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		
		try
		{
			query="select * from userregistration where userid=?";
			pstmtSelect = conn.prepareStatement(query);
			pstmtSelect.setString(1, currentUser);
			rset = pstmtSelect.executeQuery();
			if(rset.next())
			{
				userId=rset.getString("userId");
				firstName=rset.getString("FirstName");
				lastName=rset.getString("LastName");
				
				Date temp=rset.getDate("dob");
				
				DateFormat df = new SimpleDateFormat("dd-MM-yyyy");
				String text = df.format(temp);
				String a[]=text.split("-");
				System.out.println(a);
				date=a[0];
				month=a[1];
				year=a[2];
				//dob=text;
				gender=rset.getString("gender");
				qualification=rset.getString("qualification");
				occupation=rset.getString("occupation");
				city=rset.getString("city");
				state=rset.getString("state");
				country=rset.getString("country");
				address=rset.getString("address").trim();
				email=rset.getString("email");
				phoneNo=rset.getString("PhoneNo");
				mobileNo=rset.getString("MobileNo");
				securityQuestion=rset.getString("SecurityQuestion");
				securityAnswer=rset.getString("securityAnswer");
				password=rset.getString("password");
				
				System.out.println(getGender().equals("M"));
				System.out.println(getGender().equals("F"));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String submitUserInfo(String currentUser)throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		SimpleDateFormat dateformat=new SimpleDateFormat("dd-MM-yyyy");
		String dob=date+"-"+month+"-"+year;
		java.sql.Date date1=new java.sql.Date(dateformat.parse(dob).getTime());
		
		PreparedStatement pstmtUpdate=null;
		String query=null;
		String flag="";
		
		try
		{
			query="update userregistration SET password=?,firstName=?,lastName=?,dob=?,gender=?,qualification=?,"
					+"occupation=?,city=?,state=?,country=?,address=?,email=?,phoneNo=?,mobileNo=?,"
					+"securityQuestion=?,securityAnswer=? where userId=?";
			
			pstmtUpdate=conn.prepareStatement(query);
			pstmtUpdate.setString(1,password);
			pstmtUpdate.setString(2,firstName);
			pstmtUpdate.setString(3,lastName);
			pstmtUpdate.setDate(4,date1);
			pstmtUpdate.setString(5,gender);
			pstmtUpdate.setString(6,qualification);
			pstmtUpdate.setString(7,occupation);
			pstmtUpdate.setString(8,city);
			pstmtUpdate.setString(9,state);
			pstmtUpdate.setString(10,country);
			pstmtUpdate.setString(11,address.trim());
			pstmtUpdate.setString(12,email);
			pstmtUpdate.setString(13,phoneNo);
			pstmtUpdate.setString(14,mobileNo);
			pstmtUpdate.setString(15,securityQuestion);
			pstmtUpdate.setString(16,securityAnswer);
			pstmtUpdate.setString(17,currentUser);
			
			int i =pstmtUpdate.executeUpdate();
			
			if(i>0)
			{
				conn.commit();
				flag="Your Information is Updated";
			}
			else
			{
				flag="Something Went Wrong, Please Try Again!!";
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
			flag="Error Connecting to Database";
		}
		return flag;
	}
}
