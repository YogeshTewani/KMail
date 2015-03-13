<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="editProfile" class="Kmail.Profile"/>
<jsp:setProperty name="editProfile" property="*"/>

<%
String  flag="";
if(session.getAttribute("userId") == null || session.getAttribute("userId").equals("")) 
{ 
	response.sendRedirect("index.jsp"); 
}
else
{
	flag=editProfile.submitUserInfo((String)session.getAttribute("userId"));
	System.out.println(flag);
}
	
%>
	  <input type="hidden" name="userId" value="<%=request.getParameter("userId")%>"/>
      <input type="hidden" name="firstName" value="<%=request.getParameter("firstName")%>"/>
      
      <input type="hidden" name="flag" value="<%=flag %>" />
     
    
	<jsp:forward page="Profile.jsp">
	<jsp:param value="<%=flag %>" name="flag"/>
	</jsp:forward>
	
	