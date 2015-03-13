<%@page import="javax.sound.midi.Receiver"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">


<jsp:useBean id="showMessage" class="Kmail.Inbox">
</jsp:useBean>

<jsp:useBean id="showMessage1" class="Kmail.ShowMessage">
</jsp:useBean>
<% 
String uByT="0/0";
String oT="0";
String dT="0";
String unread="0";
String message="",msgDateTime="",fileName="",toHeader="",ccHeader="",bccHeader="";
	if(session.getAttribute("userId") == null || session.getAttribute("userId").equals("")) 
	{ 
   		response.sendRedirect("index.jsp"); 
    }
	else
	{
		showMessage1.changeViewStatus(Integer.parseInt(request.getParameter("msgId")),(String)session.getAttribute("userId"));
		msgDateTime=showMessage1.getMsgDateTime();
		message=showMessage1.getMessage();
		fileName=showMessage1.getFileName();
		toHeader=showMessage1.getToHeader();
		ccHeader=showMessage1.getCcHeader();
		bccHeader=showMessage1.getBccHeader();
		uByT=showMessage.iUnreadByTotal((String)session.getAttribute("userId"));
		unread=uByT.substring(1);
		oT=showMessage.outboxTotal((String)session.getAttribute("userId"));
		dT=showMessage.draftTotal((String)session.getAttribute("userId"));
		
	}

%>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<title><%=request.getParameter("subject").toString() %>-<%=session.getAttribute("userId")%>@kmail.com</title>
<link type="text/css" rel="stylesheet" href="css/style.css"/>
<script type="text/javascript">

function replyForward(replyOrForward) 
    {
        if(replyOrforward=='r')
		{
			var e1=document.getElementsByName("subject");
			var e2=document.getElementsByName("message");
			var e3=document.getElementsByName("from");
			showMessage1.jksj();
		}
		
    }  

</script>

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
    	<td width="120">
        <br/>
        </td>
        
    	<td>
        	<a href="javascript:replyForward('r');">Reply</a>
        </td>
        <td>
            <a href="#">Forward</a>
        </td>
        <td>
        </td>
        
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
       	<table width="100%" align="center" bgcolor="#FFFFFF" bordercolor="#0000FF">
        			<tr>
        				<td colspan="4" height="10px" bgcolor="#FFFFFF">
        					<%=request.getParameter("subject").toString() %>
                            
        					<hr />
        				</td>
        			</tr>
        			 <%
        				if(request.getParameter("page").toString().equals("i"))
        				{
        			%>	
        					<tr>
        						<td width="10%">
        							From
        						</td>
        				
        						<td width="55%">
                    				<%=request.getParameter("sender").toString()%>@kmail.com
                    			</td>
                    
                    			<td width="35%" align="right">
                    				<%=msgDateTime%>
                    			</td>
        					</tr>
                    
         			<%	
        
        				}
        				else
						{
					%>
        					<tr>       
                				 				
        						<td colspan="2">
                    				<%=request.getParameter("sender").toString()%>@kmail.com
                                   
                    			</td>
                    			<td colspan="1" align="right">
                                	 <%=msgDateTime%>
                                </td>
        					</tr>		
        			<%        
						}
        			%>	
                    
                    <tr>
                    	<td width="10%">
                        	
                        </td>
                    </tr>
                    
                    <tr>
                    	<td width="10%">
                        </td>
                    </tr>
                    
                    <tr>
                		<td width="10%">
                    		To
                    	</td>
                    	<td width="55%">
                    		<%=toHeader%>
                    	</td>
                	</tr>
                    
                    <%
						if(ccHeader!="" && ccHeader!=null)
                		{
					%>
                			<tr>
                				<td width="10%">
                    				CC
                    			</td>
                    			<td width="55%">
                    				<%=ccHeader %>
                    			</td>
                			</tr>
               		<%
						}
                	%>
                    
                    <%
						if(bccHeader!="" && bccHeader!=null)
                		{
					%>
                			<tr>
                				<td width="10%">
                    				BCC
                    			</td>
                    			<td width="55%">
                    <%		if(request.getParameter("page").toString().equals("i"))
							{						
								String check=session.getAttribute("userId").toString()+"@kmail.com";
                    			if(bccHeader.contains(check))
                    			{
                    			
                    %>
									<%=session.getAttribute("userId").toString()+"@kmail.com" %>
                    <%
                    			}
                    		}
                		}
						else
						{
					%>
							<%=bccHeader%>
                    <%
						}
					%>
                    
        						</td>
                      		</tr>
                            
                            <tr>
                				<td colspan="4" bgcolor="#FFFFFF">
                    				<hr/>
									<%=message%>
                    				<%
										if(fileName!=null && fileName!="")
										{
									%>
	                    					<hr/>
												<a href="attachments/<%=fileName%>" target="_blank">
												<%=fileName%>
                                                </a>
									<%
										}
										
									%>
					
                    			</td>
                			</tr>
        					
        					<tr>
                            	<td>
                                	<a href="#">Reply</a>
                                </td>
                                <td>
                                	<a href="#">Forward</a>
                                </td>
                                      
						        <td width="718">
        	
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