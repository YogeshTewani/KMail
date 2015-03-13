<%@page import="Kmail.Delete"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<jsp:useBean id="delete" class="Kmail.Delete">
<jsp:setProperty name="delete" property="*"/>

</jsp:useBean>


<% 

	if(session.getAttribute("userId") == null || session.getAttribute("userId").equals("")) 
	{ 
   		response.sendRedirect("index.jsp"); 
    }
	else
	{
		System.out.println("Deleting");
		System.out.println(request.getParameter("dMsgId1"));
		System.out.println(request.getParameter("type"));
		
		if(request.getParameter("type").equals("inbox"))
		{
			delete.deleteFromInbox(request,request.getParameter("dMsgId1"), (String)session.getAttribute("userId"));
			response.sendRedirect("inbox.jsp");
		}
		if(request.getParameter("type").equals("outbox"))
		{
			delete.deleteFromOutbox(request,request.getParameter("dMsgId1"), (String)session.getAttribute("userId"));
			response.sendRedirect("outbox.jsp");
		}
		if(request.getParameter("type").equals("draft"))
		{
			delete.deleteFromDrafts(request,request.getParameter("dMsgId1"), (String)session.getAttribute("userId"));
			response.sendRedirect("drafts.jsp");
		}
	}
%>