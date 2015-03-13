<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<jsp:useBean id="composeMail" class="Kmail.ComposeMail">
<jsp:setProperty name="composeMail" property="*"/>

</jsp:useBean>

<input type="hidden" name="userId" value=<%=session.getAttribute("userId")%>/>
<%
System.out.println("Checking");
composeMail.setData(request,(String)session.getAttribute("userId"),"discard");

response.sendRedirect("inbox.jsp");
%>