<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="ErrorPage.jsp" %>
<% session.removeAttribute("userid");
   session.invalidate();
   response.sendRedirect("index.jsp");
%>