<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<jsp:useBean id="profile" class="Kmail.Profile" />
<jsp:setProperty name="profile" property="*"/>

<%
	if(session.getAttribute("userId") == null || session.getAttribute("userId").equals("")) 
	{ 
   		response.sendRedirect("index.jsp"); 
	}
	else
	{
		profile.getUserInfo((String)session.getAttribute("userId")); 	
		
	}
%>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="JavaScript" type="text/JavaScript" src="js/checkbox.js"></script>
<script language="JavaScript" type="text/JavaScript" src="js/validation.js"></script>

<script language="JavaScript" type="text/JavaScript">

function validate()
{
	if(login())
		return true;
	else
		return false;
}

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

function login()
{
	var frm=document.info;
	
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
	
	frm.qualification.value = Trim(frm.qualification.value);
	if(frm.qualification.value == "")
	{
		alert("Select a Qualification");
		frm.qualification.focus();
		return false;
	}
	
	frm.occupation.value = Trim(frm.occupation.value);
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
	
	
	if(document.getElementById("notAvailable").innerHTML!='')
	{
		alert("UserId is not Valid");
		frm.userId.focus();
		return false;
	}
	
	return true;
}

</script>

<title>Profile-<%=session.getAttribute("userId")%></title>
<link type="text/css" rel="stylesheet" href="css/style.css"/>

</head>


<body  bgcolor="#333333">

	<table width="100%">
    	<tr>
        	<td>
    			<img src="images/logo.jpg" height="50" width="100" />
    		</td>
            
            <td colspan="4">
            	 <form name="search" method="post">
             	 	<input name="query" type="text" id="query" width="300" size="75" onKeydown="Javascript: if (event.keyCode==13) searchIt();" />
              		<input name="search" type="button" value="Search" onclick="searchIt()" />
              	</form>
            </td>
            
            <td align="right">
            	<ul class="sf-menu">
                	<li>
                    	<a href="#">
							<%=session.getAttribute("userId")%>@kmail.com
                        </a>
                        
                        <ul>
                        	<li>
                            	<a href="Profile.jsp">Profile</a>
                            </li>
                            <!--
                            <li>
                            	<a href="#">Settings</a>
                            </li>
                            -->
                            <li>
                            	<a href="logout.jsp">Log Out</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </td>
            
        </tr>
    
	</table>
    
    <br />
    <br />
    <form name="info" method="post" action="ProfileEditHandler.jsp" onsubmit="return validate()">
     <table width="100%" bgcolor="#CCCCCC">
     	
     	<tr>
        	<td align="center" colspan="4">
            	Profile info for <%=session.getAttribute("userId")%>@kmail.com<br/>
                <%
					if(request.getParameter("flag")!=null && !(request.getParameter("flag").equals("")))
					{
						if(request.getParameter("flag").equals("Your Information is Updated"))
						{
				%>
                			<font color="#00FF00"><%=request.getParameter("flag")%></font>
                <%  	
						}
						else
						{
				%>
                			<font color="#FF0000"><%=request.getParameter("flag")%></font>
                <%
						}
					}
				
				%>
                <hr/>
            </td>
        </tr>
        
        <tr>
    <td>UserId</td>
    <td colspan="3">
    <input name="userId" type="text" disabled="disabled" id="userId" value="<%=profile.getUserId()%>" size="30" maxlength="20" />
    </td>
    
    </tr>
        
        <tr>
        	 <td>
             	First Name: 
             </td>
    		 <td>
             	<input name="firstName" type="text" id="firstName" size="30" maxlength="50" value="<%=profile.getFirstName() %>" />
             </td>
    		 <td>
             	Last Name: 
             </td>
    		 <td>
             	<input name="lastName" type="text" id="lastName" size="30" maxlength="30" value="<%=profile.getLastName() %>" />
             </td>
        </tr>
        
        <tr>
        	<td>
            	Password: 
            </td>
    		<td>
            	<input name="password" type="password" id="password" size="30" maxlength="20" value="<%=profile.getPassword() %>" />
            </td>
    		<td align="left">
            	Confirm Password*: 
            </td>
    		<td>
            	<input name="password1" type="password" id="password1" size="30" maxlength="20" value="<%=profile.getPassword() %>"  />
            </td>
        </tr>
        
        <tr>
        	<td>
            	Gender: 
            </td>
    		<td>
            <%
				if(profile.getGender()!=null && profile.getGender().equals("M"))
				{	
			%>
             		<select name="gender">
                    <option value="M" selected="selected">Male</option>
                    <option value="F">Female</option>
                    </select>
              <!--  <input name="gender" type="radio" value="M" id="gender" checked="checked" />Male
      
      			<input name="gender" type="radio" value="F" id="gender" />Female-->
            <%
				}
				else if(profile.getGender()!=null )
				{
            %>
            	<select name="gender">
                    <option value="M">Male</option>
                    <option value="F" selected="selected">Female</option>
                    </select>
                
                <!-- <input name="gender" type="radio" value="M" id="gender"/>Male
      
      			<input name="gender" type="radio" value="F" id="gender" checked="checked"  />Female-->
            
            <%
				}
			%>
      
            </td>
   			<td>
    			Date Of Birth: 
    		</td>
    		<td>
            <select name="date" id="date">
        		<option value="">--DD--</option>
            	<%
					int d;
					int checkDate=0;	
					if(profile.getDate()!=null)
						checkDate=Integer.parseInt(profile.getDate());
            		for(d=1;d<=31;d++)
            		{
						if(checkDate==d)
						{
				%>
                			<option value="<%=d%>" selected="selected"><%=d%></option>
                <%	
						}
						else
						{
				%>
            			<option value="<%=d%>"><%=d%></option>
            	<%
						}
            		}
            	%>
        	</select>
        	
        	<select name="month" id="month">
        		<option value="">--MM--</option>
            	<%
					int m;	
					if(profile.getMonth()!=null)
						checkDate=Integer.parseInt(profile.getMonth());
            		for(m=1;m<=12;m++)
            		{	
						if(checkDate==m)
						{
				%>
                			<option value="<%=m%>" selected="selected"><%=m%></option>
                <%	
						}
						else
						{
				%>
            			<option value="<%=m%>"><%=m%></option>
            	<%
						}
            		}
            	%>
            	</select>
            	
            	<select name="year" id="year">
        		<option value="">--YYYY--</option>
            	<%
					int y;	
					if(profile.getYear()!=null)
						checkDate=Integer.parseInt(profile.getYear());
            		for(y=1940;y<=2012;y++)
            		{	
						if(checkDate==y)
						{
				%>
                			<option value="<%=y%>" selected="selected"><%=y%></option>
                <%	
						}
						else
						{
				%>
            			<option value="<%=y%>"><%=y%></option>
            	<%
						}
            		}
            	%>
        	</select>
      
      		</td>
        </tr>
        
        <tr>
        	<td>
            	Qualification : 
            </td>
    		<td>
            	<label for="qualification"></label>
      			<input type="text" name="qualification" id="qualification" value="<%=profile.getQualification() %>" />
      		</td>
    		<td>
            	Occupation
            </td>
    		<td>
            	<label for="occupation"></label>
		        <input type="text" name="occupation" id="occupation" value="<%=profile.getOccupation() %>" />
      		</td>
        </tr>
        
        <tr>
        	<td>
            	Phone No : 
            </td>
    		<td>
            	<input name="phoneNo" type="text" id="phoneNo" maxlength="20" value="<%=profile.getPhoneNo() %>" />
            </td>
		    <td>
            	Mobile No:
            </td>
    		<td>
            	<label for="mobileNo"></label>
      			<input type="text" name="mobileNo" id="mobileNo" value="<%=profile.getMobileNo() %>" />
           </td>
        </tr>
        
        <tr>
			<td rowspan="2">
				Address :
			</td>
			<td rowspan="2"><textarea name="address" cols="10" id="address"><%=profile.getAddress() %></textarea>
			</td>
			<td>
				City :
			</td>
			<td>
				<input name="city" type="text" id="city" size="30" maxlength="40" value="<%=profile.getCity() %>" />
			</td>
		</tr>

		<tr>
			<td>
				State:
			</td>
			<td>
				<label for="state"></label>
            	<input type="text" name="state" id="state" size="30" maxlength="40" value="<%=profile.getState()%>"/>
			</td>
		</tr>
        
        <tr>
        	<td>
            	Country:
            </td>
    		<td>
            	<label for="country"></label>
      			<input type="text" name="country" id="country" size="30" maxlength="40" value="<%=profile.getCountry()%>"/>
      		</td>
    		<td>
            	Primary Email: 
            </td>
    		<td>
            	<input name="email" type="text" id="email" size="30" maxlength="100" value="<%=profile.getEmail() %>" />
            </td>
        </tr>
        
        <tr>
        	<td>
				Security Question:
			</td>
			<td>
				<label for="securityQuestion">
				</label>
		      	<input type="text" name="securityQuestion" id="securityQuestion" value="<%=profile.getSecurityQuestion() %>" />
			</td>
			<td>
				Security Answer:
			</td>
			<td>
				<label for="securityAnswer">
				</label>
		      	<input type="text" name="securityAnswer" id="securityAnswer" value="<%=profile.getSecurityAnswer() %>" />
			</td>
        </tr>
        
        <tr>
        	<td colspan="4">
            	<br/>
            </td>
        </tr>
        
        
        <tr>
        	<td colspan="4" align="center">
            	<input name="update" type="submit" id="update" value="Update"/>
      			<input name="close" type="button" id="close" value="Close" onclick="location.href='inbox.jsp'"/>
            </td>
        </tr>
     </table>
</form>

</body>
</html>