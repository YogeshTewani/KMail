<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<jsp:useBean id="inbox" class="Kmail.Inbox" />
<jsp:useBean id="outbox" class="Kmail.Outbox"/>

<% 
String uByT="0/0";
String oT="0";
String dT="0";
	if(session.getAttribute("userId") == null || session.getAttribute("userId").equals("")) 
	{ 
   		response.sendRedirect("index.jsp"); 
    }
	else
	{
		uByT=inbox.iUnreadByTotal((String)session.getAttribute("userId"));
		oT=inbox.outboxTotal((String)session.getAttribute("userId"));
		dT=inbox.draftTotal((String)session.getAttribute("userId"));
	}

%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Outbox-<%=session.getAttribute("userId")%>@kmail.com</title>

<link type="text/css" rel="stylesheet" href="css/style.css"/>

<script language="JavaScript" type="text/JavaScript" src="js/checkbox.js"></script>


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
        	<form name="delete1">
            <input type="hidden" name="dMsgId1" id="dMsgId" value="" />
            <input type="hidden" name="type" value="outbox" />
            </form>
      </td>
    </tr>
	
    <tr>
    	<th width="120">
        	<h4>Outbox</h4>
        </th>
    	<td>
        	<a href="javascript:deleteIt()"> Delete </a>
        </td>
        <!--<td>
        	<a href="javascript:funcSelectAll();">Select All</a>
        </td>
        <td>
        	<a href="javascript:funcDeselectAll();">Deselect All</a>
        </td>_-->
        <td width="718">
        	
        </td>
  </tr>
    
	<tr>
    	<td valign="top">
        	<table width="100%" align="center" bgcolor="#00FFFF" bordercolor="#00CC00">
            	<tr><td align="center"><a href="compose.jsp">Compose Mail</a></td></tr>
            	<tr><td align="center"><a href="inbox.jsp">Inbox (<%=uByT%>) </a></td></tr>
                <tr><td align="center"><a href="outbox.jsp">Outbox (<%=oT%>)</a></td></tr>
                <tr><td align="center"><a href="drafts.jsp">Drafts (<%=dT%>)</a></td></tr>
            </table>
        </td>
   		<td colspan="4" valign="top">
        <form name="frm">
        <table width="100%" align="center" bordercolor="#0000FF" cellspacing="0">
            	<tr bgcolor="#999999">
                	<th>
                    <input type="checkbox" name="allCheck" onClick="selectallMe()">
                    </th>
                    
                    <th width="20%">
                    Sent To
                    </th>
                    
                    <th width="55%">
                    	Subject
                    </th>
                    
                    <th width="25%">
                    	Date
                    </th>
                </tr>
                
                <%
                ArrayList<String> receiver,subject,msgDateTime=new ArrayList<String>();
        		ArrayList<Integer> msgId=new ArrayList<Integer>();
        		String userId=(String)session.getAttribute("userId");
        		outbox.setData(userId);
        	    msgId=outbox.getMessageId();
        	    receiver=outbox.getReceiver();
        	    subject=outbox.getSubject();
        	    msgDateTime=outbox.getMsgDateTime();
			    
			    if(msgId.size()==0)
			    {%>
			    	<tr bgcolor="#666666">
    				<td colspan="4" align="center">
    					<font color="#FF0000" face="Georgia, Times New Roman, Times, serif">Outbox is Empty</font>
    				</td>
    				</tr>
			   <% }
			    else
			    {
			    	for(int i=msgId.size()-1;i>=0;i--)
			    	{
						
							%>
                            
			    			<tr bgcolor="#666666" class="lovelyrow">
			    				<td>
                                	<input type="checkbox" value="<%=msgId.get(i)%>" name="chkMsgId" onClick="checkSelect()"/>
                                </td>
                                
                                <td width="20%" onclick="location.href='ReadOutbox.jsp?msgId=<%=msgId.get(i)%>&sender=<%=session.getAttribute("userId")%>&subject=<%=subject.get(i)%>'">
			    					<%=receiver.get(i)%>
			    				</td>
                                
                                <td width="55%" onclick="location.href='ReadOutbox.jsp?msgId=<%=msgId.get(i)%>&sender=<%=session.getAttribute("userId")%>&subject=<%=subject.get(i)%>'">
                                	<%=subject.get(i)%>
                                </td>
                                
                                <td width="25%" onclick="location.href='ReadOutbox.jsp?msgId=<%=msgId.get(i)%>&sender=<%=session.getAttribute("userId")%>&subject=<%=subject.get(i)%>'">
                                	<center><%=msgDateTime.get(i)%></center>
                                </td>
			    			</tr>
                            
			    		<%
						}
					}
			   %>
               
               
          </table>
       </form> 	
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