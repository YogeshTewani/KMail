<%@page import="javax.sound.midi.Receiver"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<jsp:useBean id="inbox" class="Kmail.Inbox">

</jsp:useBean>
<% 
String uByT="0/0";
String oT="0";
String dT="0";
String unread="0";
	if(session.getAttribute("userId") == null || session.getAttribute("userId").equals("")) 
	{ 
   		response.sendRedirect("index.jsp"); 
    }
	else
	{
		uByT=inbox.iUnreadByTotal((String)session.getAttribute("userId"));
		unread=uByT.substring(1);
		oT=inbox.outboxTotal((String)session.getAttribute("userId"));
		dT=inbox.draftTotal((String)session.getAttribute("userId"));
		
	}

%>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>Inbox-<%=session.getAttribute("userId")%>@kmail.com<%=uByT%></title>
<link type="text/css" rel="stylesheet" href="css/style.css"/>


</head>


<body bgcolor="#333333">
<table width="100%">
	<tr> 
		<td>
    		<img src="images/logo.jpg" height="50" width="100" />
    	</td>
    	<td colspan="4" valign="top">
        	<table width=100%>
            	<tr>
                	<td colspan="4">
            	 <form name="search">
             	 	<input name="query" type="text" id="query" width="300" size="75" onKeydown="Javascript: if (event.keyCode==13) searchIt();" />
              		<input name="search" type="button" value="Search" onclick="searchIt()" />
              	</form>
            </td>
                    
        			<td align="right">
        				
                        
                        
                    <ul class="sf-menu">
                        <li><a href="#"><%=session.getAttribute("userId")%>@kmail.com</a>
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
     
        			
                
               
            </table>
        </td>
         </tr>
  <tr>
    	<td colspan="5">
        	<marquee align="bottom"> Hello There</marquee>
        </td>
  </tr>
    <tr>
    	<td colspan="5">
        	
      </td>
    </tr>
	
    <tr>
    	<th width="120">
        	<h3></h3>
        </th>
    	<td width="47">
        	
        </td>
        <td width="65">
        	
        </td>
        <td width="81">
        	
        </td>
        <td width="718">
        	
        </td>
  </tr>
    
	<tr>
    	<td valign="top">
        	<table width="100%" align="center" bgcolor="#00FFFF">
            	<tr><td align="center"><a href="compose.jsp">Compose Mail</a></td></tr>
            	<tr><td align="center"><a href="inbox.jsp">Inbox (<%=uByT%>) </a></td></tr>
                <tr><td align="center"><a href="outbox.jsp">Outbox (<%=oT%>)</a></td></tr>
                <tr><td align="center"><a href="drafts.jsp">Drafts (<%=dT%>)</a></td></tr>
            </table>
        </td>
   		<td colspan="4" valign="top">
        <table width="100%" align="center" bordercolor="#0000FF">
            	
                
			    	<tr bgcolor="#666666">
    				<td colspan="3" align="center">
    					<font color="#FF0000" face="Georgia, Times New Roman, Times, serif">Your Mail Has been delivered</font>
    				</td>
    				</tr>
			  
               
          </table>
        	
      </td>
  </tr>

</table>

<table width="100%">
	<tr>
    	<td align="center">
        	Copyright &copy; 2013
        </td>
    </tr>

</table>
</body>
</html>