<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<jsp:useBean id="login" class="Kmail.Login"/>
<jsp:setProperty name="login" property="*"/>

<input type="hidden" name="userId" value="login.getUserId()"/>
<input type="hidden" name="firstName" value="login.getFirstName()"/>

<%
if(session.getAttribute("userId") != null) 
{ 
		response.sendRedirect("inbox.jsp"); 
}
else
{
  System.out.println("ID IS"+login.getUserId());
  boolean flag=login.checkLogin();
  String userId=login.getUserId();
  if(flag)
  {
	  
      session.setAttribute("userId",userId);
	  response.sendRedirect("inbox.jsp"); // redirect to homepage if login is success
      
   
	//<jsp:forward page="inbox.jsp"/>
	
	
	}

  else
  {
	  session.removeAttribute("userId");
	  response.sendRedirect("index.jsp?valid=invalid"); // redirect to index page if login fails.
	  //<jsp:forward page="index.jsp"/>
	  
  }

}
%>