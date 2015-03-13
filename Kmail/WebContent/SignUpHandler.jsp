<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="login" class="Kmail.Login"/>
<jsp:setProperty name="login" property="*"/>
<%
String userId=login.getUserId();
String firstName=login.getFirstName();

System.out.println("Login id on jsp==="+userId);
System.out.println("FirstName on jsp==="+firstName);
  boolean flag=login.insertRecord();
  if(flag)
  {
	  session.setAttribute("userId",userId);
	  
	  %>
	  <input type="hidden" name="userId" value="<%=request.getParameter("userId")%>"/>
      <input type="hidden" name="firstName" value="<%=request.getParameter("firstName")%>"/>
      
      
     
	<jsp:forward page="continue.jsp"/>
	
	
<%	}

  else
  {%>
	  
	 <jsp:forward page="SignUp.jsp"/>
	 
 <%}


%>