<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="login" class="Kmail.Login"/>
<jsp:setProperty name="login" property="*"/>

<% 
if(session.getAttribute("userId") != null) 
{ 
	response.sendRedirect("index.jsp"); 
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Kmail-SignUp</title>
<script language="JavaScript" type="text/JavaScript" src="js/validation.js"></script>
<script language="JavaScript" type="text/JavaScript" src="js/checkUserId.js"></script>
<script language="javascript" type="text/javascript">


function emailValidator(email1)
{
	
	/*var x=document.forms["myForm"]["email"].value;
	var atpos=x.indexOf("@");
	var dotpos=x.lastIndexOf(".");
	if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
  	{
  		alert("Not a valid e-mail address");
  		return false;
  	}*/
	
	 var emailReg = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
		return emailReg.test(email1);
}  




function validate()
{
	if(login())
		return true;
	else
		return false;
}

function login()
{
	var frm=document.form1;
	
	frm.userId.value = Trim(frm.userId.value);
	if(frm.userId.value == "")
	{
		alert("Enter a Valid User Id");
		frm.userId.focus();
		return false;
	}
	
	else if(frm.userId.value.length<5)
	{
		alert("User Id should be of atleast 5 characters");
		//alert(document.getElementById("userIdMessage").innerHTML);
		frm.userId.focus();
		return false;
	}
	
//alert(document.getElementById("userIdStatus").value.trim());
//alert(document.getElementsByName("userIdStatus"));
		if((document.getElementById("userIdStatus").value.trim())=="false")
	{
		//alert(document.getElementById("userIdStatus").value);
		alert("UserId not valid");
		
		//frm.address.value=document.getElementById("userIdStatus");
		frm.userId.focus();
		return false;
	}
	
	if(frm.password.value == "")
	{
		alert("Password Field cannot be blank");
		frm.password.focus();
		return false;
	}
	
	if(frm.password.value.length<6)
	{
		alert("Passwords should be of atleat 6 characters");
		frm.password.focus();
		return false;
	}
	
	
	if(frm.password.value != frm.password1.value)
	{
		alert("Passwords Do not match");
		frm.password.value="";
		frm.password1.value="";
		frm.password.focus();
		return false;
	}
	
	frm.firstName.value = Trim(frm.firstName.value);
	if(frm.firstName.value == "")
	{
		alert("First Name cannot be blank");
		frm.firstName.focus();
		return false;
	}
	
	frm.lastName.value = Trim(frm.lastName.value);
	if(frm.lastName.value == "")
	{
		alert("Last Name cannot be blank");
		frm.lastName.focus();
		return false;
	}
	
	if(frm.gender.value == "")
	{
		alert("Gender not selected");
		frm.gender.focus();
		return false;
	}
	
	if(frm.date.value == "")
	{
		alert("Select a Date");
		frm.date.focus();
		return false;
	}
	
	if(frm.month.value == "")
	{
		alert("Select a Month");
		frm.month.focus();
		return false;
	}
	
	if(frm.year.value == "")
	{
		alert("Select a Year");
		frm.year.focus();
		return false;
	}
	
	if(frm.qualification.value == "")
	{
		alert("Select a Qualification");
		frm.qualification.focus();
		return false;
	}
	
	if(frm.occupation.value == "")
	{
		alert("Select a Occupation");
		frm.occupation.focus();
		return false;
	}
	
	frm.phoneNo.value = Trim(frm.phoneNo.value);
	if(frm.phoneNo.value == "")
	{
		alert("PhoneNo cannot be blank");
		frm.phoneNo.focus();
		return false;
	}
	
	if(is_valid = !/^[0-9]+$/.test(frm.phoneNo.value))
	{
		alert("PhoneNo should be numeric");
		frm.phoneNo.focus();
		return false;
	}
	
	frm.mobileNo.value = Trim(frm.mobileNo.value);
	if(frm.mobileNo.value == "")
	{
		alert("MobileNo cannot be blank");
		frm.mobileNo.focus();
		return false;
	}
	
	if(is_valid = !/^[0-9]+$/.test(frm.mobileNo.value))
	{
		alert("MobileNo should be numeric");
		frm.mobileNo.focus();
		return false;
	}
	
	frm.address.value = Trim(frm.address.value);
	if(frm.address.value == "")
	{
		alert("Address field cannot be blank");
		frm.address.focus();
		return false;
	}
	
	if(frm.address.value != "" && frm.address.value.length > 200)
	{
	 	alert("You can enter address upto 200 characters only.")
		frm.address.focus();
		return false;
	 }
	
	frm.city.value = Trim(frm.city.value);
	if(frm.city.value == "")
	{
		alert("City Field cannot be blank");
		frm.city.focus();
		return false;
	}
	
	frm.state.value = Trim(frm.state.value);
	if(frm.state.value == "")
	{
		alert("State Field cannot be blank");
		frm.state.focus();
		return false;
	}
	
	frm.country.value = Trim(frm.country.value);
	if(frm.country.value == "")
	{
		alert("Country Field cannot be blank");
		frm.country.focus();
		return false;
	}
	
	frm.email.value = Trim(frm.email.value);
	if(frm.email.value == "")
	{
		alert("Email Field cannot be blank");
		frm.email.focus();
		return false;
	}
	else
	 {
	   var isEmail=emailValidator(frm.email.value);
	   
		if(!isEmail)
		{
			alert("Please enter a valid email");
	   		frm.email.focus();
	   		return false;	
		}
	 }
	
	if(frm.securityQuestion.value == "")
	{
		alert("Security Question Field cannot be blank");
		frm.securityQuestion.focus();
		return false;
	}
	
	frm.securityAnswer.value = Trim(frm.securityAnswer.value);
	if(frm.securityAnswer.value == "")
	{
		alert("Security Answer Field cannot be blank");
		frm.securityAnswer.focus();
		return false;
	}
	
	
	//if(document.getElementById("notAvailable").innerHTML!='')
	//{
		//alert("UserId is not Valid");
		//frm.userId.focus();
		//return false;
	//s}
	
	return true;
}

</script>

</head>

<body bgcolor="#333333">

<table width="100%">
	<tr> 
		<td>
    		<a href="index.jsp">
            	<img src="images/logo.jpg" height="50" width="100" />
            </a>
    	</td>
    </tr>
</table>


<form id="form1" name="form1" method="post" action="SignUpHandler.jsp" onsubmit="return validate()">
<table width="80%"  cellpadding="2" cellspacing="0" bordercolor="#CCCCCC" rules="none" align="center">
  <tr>
    <td colspan="4" align="center">Registration</td>
  </tr>
  
  <tr>
    <td>Desired Login Id*</td>
    <td>
    <input name="userId" type="text" id="userId" size="30" maxlength="20" onblur="validateUserId()" />
    </td>
    
    <td colspan="2">
    	<div id="userIdMessage"></div>
    <input type="hidden" value="" name="userIdStatus" id="userIdStatus" />
  	
    </td>
    
  </tr>
  <tr>
    <td>Password*</td>
    <td><input name="password" type="password" id="password" size="30" maxlength="20" /></td>
    <td align="left">Confirm Password* </td>
    <td><input name="password1" type="password" id="password1" size="30" maxlength="20" /></td>
  </tr>
  
  <tr>
    <td>First Name*</td>
    <td><input name="firstName" type="text" id="firstName" size="30" maxlength="50" /></td>
    <td>Last Name*</td>
    <td><input name="lastName" type="text" id="lastName" size="30" maxlength="30" /></td>
  </tr>
  <tr>
    <td>Gender*</td>
    <td>
    	<select name="gender" id="gender">
        	<option value="">--SELECT--</option>
            <option value="M">MALE</option>
            <option value="F">FEMALE</option>
        </select>
    </td>
    <td>Date Of Birth*</td>
    <td>
    		<select name="date" id="date">
        		<option value="">--DD--</option>
            	<%
					int d;	
            		for(d=1;d<=31;d++)
            		{	
				%>
            			<option value="<%=d%>"><%=d%></option>
            	<%
            		}
            	%>
        	</select>
        	
        	<select name="month" id="month">
        		<option value="">--MM--</option>
            	<%
					int m;	
            		for(m=1;m<=12;m++)
            		{	
				%>
            			<option value="<%=m%>"><%=m%></option>
            	<%
            		}
            	%>
            	</select>
            	
            	<select name="year" id="year">
        		<option value="">--YYYY--</option>
            	<%
					int y;	
            		for(y=1940;y<=2012;y++)
            		{	
				%>
            			<option value="<%=y%>"><%=y%></option>
            	<%
            		}
            	%>
        	</select></td>
  </tr>
  <tr>
    <td>Qualification*</td>
    <td>
    	      
        <select name="qualification" id="qualification">
        	 <option value="">--SELECT--</option>
      		<option value="Senior Secondary">Senior Secondry</option>
        	<option value="Graduation">Graduation</option>
	        <option value="Post Graduation">Post Graduation</option>
    	</select>
    </td>
    <td>Occupation*</td>
    <td>
    	<select name="occupation" id="occupation">
      		<option value="">--SELECT--</option>
            <option value="Business">Buisness</option>
      		<option value="Service">Service</option>
      		<option value="Other">Other</option>
    </select>
    </td>
  </tr>
  <tr>
    <td>Phone No*</td>
    <td><input name="phoneNo" type="text" id="phoneNo" maxlength="10" size="30" /></td>
    <td>Mobile No*</td>
    <td><label for="mobileNo"></label>
      <input type="text" name="mobileNo" id="mobileNo" size="30" maxlength="10" /></td>
  </tr>
  <tr>
    <td> Address*</td>
    <td colspan="3"><textarea name="address" cols="45" rows="4" id="address"></textarea> (Upto 200 Characters only)</td>
  </tr>
  <tr>
    <td>City*</td>
    <td><input name="city" type="text" id="city" size="30" maxlength="40" /></td>
    <td>State*</td>
    <td><label for="state"></label>
      <input type="text" name="state" id="state" size="30" maxlength="40"/></td>
  </tr>
  <tr>
    <td>Country*</td>
    <td><label for="country"></label>
      <input type="text" name="country" id="country" size="30" maxlength="40"/></td>
    <td>Email: </td>
    <td><input name="email" type="text" id="email" size="30" maxlength="100" /></td>
  </tr>
  
  
  <tr>
    <td>Security Question</td>
    <td>
    	<select name="securityQuestion" id="securityQuestion">
        	<option value="" selected="selected">--SELECT--</option>
            <option valu="My best friend?">My best friend?</option>
      		<option value="My first teacher?">My first teacher?</option>
      		<option value="My mother's name?">My mother's name?</option>
        </select>
      </td>
    <td>Security Answer</td>
    <td><label for="securityAnswer"></label>
      <input type="text" name="securityAnswer" id="securityAnswer"  size="30" /></td>
  </tr>
  <tr>
    <td colspan="4">* <em>means fields are compulsory</em></td>
  </tr>
  <tr>
    <td colspan="4" align="center"><input name="register" type="submit" id="register" value="Register" />
      <input name="reset" type="reset" id="reset" value="Reset" />
      <input name="close" type="button" id="close" value="Close" onclick="self.location='index.jsp'" /></td>
  </tr>
</table>
</form>
</body>
</html>