<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Kmail-Secure</title>
<style type="text/css">
#form1 table tr td {
	font-size: medium;
}
</style>
</head>

<% 
if(session.getAttribute("userId")!=null) 
{ 
		response.sendRedirect("inbox.jsp"); 
}
%>

<body onLoad="javascript:document.form1.userId.focus()">
<form id="form1" name="form1" method="post" action="LoginHandler.jsp">
  <table width="619" border="0" align="center">
    <tr>
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="2"><center>
      <img src="images/logo.jpg" width="auto" height="90"/>
</center></td>
    </tr>
    
    <tr>
          <td colspan="4"><table width="40%"  border="1" align="center" bordercolor="#CCCCCC" bgcolor="#CCCCCC">
            <tr align="center" bgcolor="#999999">
              <td colspan="2">Sign In</td>
                </tr>
            <tr bgcolor="#E1E1E1">
              <td colspan="2">&nbsp;</td>
                </tr>
            <tr bgcolor="#E1E1E1">
              <td width="35%">Login Id: </td>
                <td width="65%"><input name="userId" type="text" id="userId"></td>
              </tr>
            <tr bgcolor="#E1E1E1">
              <td >Password:</td>
                <td><input name="password" type="password" id="password"></td>
              </tr>
            <% if(request.getParameter("valid") != null && request.getParameter("valid").equals("invalid")) 
	{  %>
            	<tr bgcolor="#E1E1E1">
              <td colspan="2" align="center"><font color="#FF0000">Invalid Login Id or Password.</td>
                </tr>
            <% }  %>
            <tr bgcolor="#E1E1E1">
              <td colspan="2" align="center"><input name="login" type="submit" id="login" value="Login">
                <input name="close" type="button" id="close" value="Close" onClick="self.location='index.jsp'">  
                <input type="reset" name="Reset" id="button" value="Reset" />
                
                              </td>
                </tr>
	<tr>
    	<td colspan="2">
        	<center><a href="SignUp.jsp" >New User Register Here</a></center>
        </td>
    </tr>      
      
  </table>
</form>
</body>
</html>