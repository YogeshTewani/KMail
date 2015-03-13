<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<jsp:useBean id="composeMail" class="Kmail.ComposeMail">
<jsp:setProperty name="composeMail" property="*"/>




</jsp:useBean>

<input type="hidden" name="userId" value=<%=session.getAttribute("userId")%>/>
<%

			
String userid=(String)session.getAttribute("userId");


	composeMail.setData(request, userid,"send");
	response.sendRedirect("Success.jsp");
%>