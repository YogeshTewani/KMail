<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>

<jsp:useBean id="checkId" class="Kmail.Login"/>
<jsp:setProperty name="checkId" property="*"/>

<%
String enteredId=request.getParameter("userId");
String flag="";
if(enteredId.length()<5)
{
	//response.setContentType("text/xml");
    //response.setHeader("Cache-Control", "no-cache");
    response.getWriter().print("<font color='#FF0000'>UserId should be atleast 5 characters long</font>:false");
	//String str="<font color='#FF0000'>UserId should be atleast 5 characters long</font>";
	//out.println(str);
//String str="<font color='#FF0000'>UserId should be atleast 5 characters long</font>"+":"+"false";

}
else
{
	  flag=checkId.CheckUserAvailability(enteredId);
	  
	System.out.println(flag);
	if(flag.equals("Id Available"))
	{
		//response.setContentType("text/xml");
      	//response.setHeader("Cache-Control", "no-cache");
      	response.getWriter().print("<font color='#00FF00'>UserID Available</font>:true");
		//String str="<font color='#00FF00'>UserID Available</font>"+":"+"true";
		
	}
	else
	{
		//response.setContentType("text/xml");
      	//response.setHeader("Cache-Control", "no-cache");
      	response.getWriter().print("<font color='#FF0000'>User Id not available</font>:false");
		//String str="<font color='#FF0000'>User Id not available</font>	"+":"+"false";
	
	}
}
%>
	
	 
