<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<jsp:useBean id="inbox" class="Kmail.Inbox" />
<jsp:useBean id="searchI" class="Kmail.Search"/>
<jsp:useBean id="searchO" class="Kmail.Search"/>
<jsp:useBean id="searchD" class="Kmail.Search"/>

<% 
String uByT="0/0";
String oT="0";
String dT="0";
String IM="No records Found";
String OM="No records Found";
String DM="No records Found";
	if(session.getAttribute("userId") == null || session.getAttribute("userId").equals("")) 
	{ 
   		response.sendRedirect("index.jsp"); 
    }
	else
	{
		uByT=inbox.iUnreadByTotal((String)session.getAttribute("userId"));
		oT=inbox.outboxTotal((String)session.getAttribute("userId"));
		dT=inbox.draftTotal((String)session.getAttribute("userId"));
		if(request.getParameter("query")==null || request.getParameter("query")=="")
		{
			DM="No records Found";
			DM="No records Found";
			DM="No records Found";
		}
		else
		{
			IM=searchI.searchInbox(request.getParameter("query"), (String)session.getAttribute("userId"));
				OM=searchO.searchOutbox(request.getParameter("query"), (String)session.getAttribute("userId"));
				DM=searchD.searchDrafts(request.getParameter("query"), (String)session.getAttribute("userId"));
		}
	
		
	}

%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Search(<%=request.getParameter("query")%>)-<%=session.getAttribute("userId")%>@kmail.com</title>

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
             	 	<input name="query" type="text" id="query" width="300" size="75" onKeydown="Javascript: if (event.keyCode==13) searchIt();" value="<%=request.getParameter("query")%>" />
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
        	<h4>Search</h4>
        </th>
    	<td>
        	Displaying Results for - <%=request.getParameter("query")%>
        </td>
        <!--<td>
        	<a href="javascript:funcSelectAll();">Select All</a>
        </td>
        <td>
        	<a href="javascript:funcDeselectAll();">Deselect All</a>
        </td>_-->
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
        
        <%
        	if((IM.equals("No records Found")) && (OM.equals("No records Found")) && (DM.equals("No records Found")))
        	{
        %>
        		<center>NO RESULTS FOUND</center>
        <%	
            }
        	else
			{
        %>
        		<form name="frm">
        <%
				if(IM.equals("Records Found"))
				{
					 ArrayList<String> sender,subject,msgDateTime,viewStatus=new ArrayList<String>();
        			ArrayList<Integer> msgId=new ArrayList<Integer>();
					msgId=searchI.getMessageId();
        	    	sender=searchI.getSender();
        	    	//viewStatus=new String[inbox.getViewStatus().size()];
        			viewStatus = searchI.getViewStatus();
        	    	subject=searchI.getSubject();
        	    	msgDateTime=searchI.getMsgDateTime();
				
		%>
					
        			<table width="100%" align="center" bordercolor="#0000FF" cellspacing="0">
						<tr bgcolor="#6633FF">
                			<td colspan="4" align="center">
                    			Results Found in Inbox
                    		</td>
                
                		</tr>
                
               			<tr bgcolor="#999999">
                			<th>
                    			<input type="checkbox" name="allCheck" onClick="selectallMe()">
                    		</th>
                    		<th width="20%">
                    			Sender
                    		</th>
                    		<th width="55%">
                    			Subject
                    		</th>
                    		<th width="25%">
                    			Date
                    		</th>
                		</tr>
        <%
				for(int i=msgId.size()-1;i>=0;i--)
			    {
					if(viewStatus.get(i).equals("N"))
					{
		%> 
                		<tr bgcolor="#FFFFFF" class="lovelyrow">
                        	<td>
                                <input type="checkbox" value="<%=msgId.get(i)%>" name="chkMsgId" onClick="checkSelect()"/>
                            </td>
                            
                            <td width="20%" onclick="location.href='ReadInbox.jsp?msgId=<%=msgId.get(i)%>&sender=<%=sender.get(i)%>&subject=<%=subject.get(i)%>'">
			    					<b><%=sender.get(i)%></b>
			    			</td>
                            
                            <td width="55%" onclick="location.href='ReadInbox.jsp?msgId=<%=msgId.get(i)%>&sender=<%=sender.get(i)%>&subject=<%=subject.get(i)%>'">
                                	
									<b><%=subject.get(i)%></b>
                                    
                            </td>
                            
                            <td width="25%" onclick="location.href='ReadInbox.jsp?msgId=<%=msgId.get(i)%>&sender=<%=sender.get(i)%>&subject=<%=subject.get(i)%>'">
                                	<b><%=msgDateTime.get(i)%></b>
                            </td>
                        </tr>
        <%
					}
					else
					{
		%>
        				<tr bgcolor="#666666" class="lovelyrow">
			    				<td>
                                	<input type="checkbox" value="<%=msgId.get(i)%>" name="chkMsgId" onClick="checkSelect()"/>
                                </td>
                                
                                <td width="20%" onclick="location.href='ReadInbox.jsp?msgId=<%=msgId.get(i)%>&sender=<%=sender.get(i)%>&subject=<%=subject.get(i)%>'">
			    					<%=sender.get(i)%>
			    				</td>
                                
                                <td width="55%" onclick="location.href='ReadInbox.jsp?msgId=<%=msgId.get(i)%>&sender=<%=sender.get(i)%>&subject=<%=subject.get(i)%>'">
                                	
									<%=subject.get(i)%>
                                    
                                </td>
                                
                                <td width="25%" onclick="location.href='ReadInbox.jsp?msgId=<%=msgId.get(i)%>&sender=<%=sender.get(i)%>&subject=<%=subject.get(i)%>'">
                                	<%=msgDateTime.get(i)%>
                                </td>
			    			</tr>
        <%
					}
				}
		%>        
                        
               		</table>
          
          			<hr/>
		<%
				}
        		if(OM.equals("Records Found"))
        		{
        			System.out.println("DM");
                ArrayList<String> Oreceiver,Osubject,OmsgDateTime=new ArrayList<String>();
        		ArrayList<Integer> OmsgId=new ArrayList<Integer>();
        		
        	    OmsgId=searchO.getMessageId();
        	    Oreceiver=searchO.getReceiver();
        	    Osubject=searchO.getSubject();
        	    OmsgDateTime=searchO.getMsgDateTime();
        %>
        			<table width="100%" align="center" bordercolor="#0000FF" cellspacing="0">
          
           			<tr bgcolor="#6633FF">
                		<td colspan="4" align="center">
                    		Results Found in Outbox
                    	</td>
                	</tr>
                
               		<tr bgcolor="#999999">
                		<th>
                    	<input type="checkbox" name="allCheck" onClick="selectallMe()" />
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
                    	for(int i=OmsgId.size()-1;i>=0;i--)
			    		{
						
		  %>
                            
			    			<tr bgcolor="#666666" class="lovelyrow">
			    				<td>
                                	<input type="checkbox" value="<%=OmsgId.get(i)%>" name="chkMsgId" onClick="checkSelect()"/>
                                </td>
                                
                                <td width="20%" onclick="location.href='ReadOutbox.jsp?msgId=<%=OmsgId.get(i)%>&sender=<%=session.getAttribute("userId")%>&subject=<%=Osubject.get(i)%>'">
			    					<%=Oreceiver.get(i)%>
			    				</td>
                                
                                <td width="55%" onclick="location.href='ReadOutbox.jsp?msgId=<%=OmsgId.get(i)%>&sender=<%=session.getAttribute("userId")%>&subject=<%=Osubject.get(i)%>'">
                                	<%=Osubject.get(i)%>
                                </td>
                                
                                <td width="25%" onclick="location.href='ReadOutbox.jsp?msgId=<%=OmsgId.get(i)%>&sender=<%=session.getAttribute("userId")%>&subject=<%=Osubject.get(i)%>'">
                                	<center><%=OmsgDateTime.get(i)%></center>
                                </td>
			    			
                    </tr>
                    
        <%
						}
		%>
				   
          			</table>
          			<hr/>
        
        <%
        		}
        		
        		if(DM.equals("Records Found"))
        		{
					System.out.println("DM");
                ArrayList<String> Dreceiver,Dsubject,DmsgDateTime=new ArrayList<String>();
        		ArrayList<Integer> DmsgId=new ArrayList<Integer>();
        		
        	    DmsgId=searchD.getMessageId();
        	    Dreceiver=searchD.getReceiver();
        	    Dsubject=searchD.getSubject();
        	    DmsgDateTime=searchD.getMsgDateTime();
        %>
        			<!--Drafts-->
        			<table width="100%" align="center" bordercolor="#0000FF" cellspacing="0">
          
          				<tr bgcolor="#6633FF">
                			<td colspan="4" align="center">
                    			Results Found in Drafts
                    		</td>
                		</tr>
                
                		<tr bgcolor="#999999">
                			<th>
                    			<input type="checkbox" name="allCheck" onClick="selectallMe()" />
                    		</th>
                    
                    		<th width="20%">
                    			Receiver
                    		</th>
                    		<th width="55%">
                    			Subject
                    		</th>
                    		<th width="25%">
                    			Date
                    		</th>
                		</tr>
                        
                       
        <%
						for(int i=DmsgId.size()-1;i>=0;i--)
			    		{
		%>
        					<tr bgcolor="#666666" class="lovelyrow">
			    				<td>
                                	<input type="checkbox" value="<%=DmsgId.get(i)%>" name="chkMsgId" onClick="checkSelect()"/>
                                </td>
                                
                                <td width="20%" onclick="location.href='ReadDraft.jsp?msgId=<%=DmsgId.get(i)%>&sender=<%=session.getAttribute("userId")%>&subject=<%=Dsubject.get(i)%>'">
			    					<%=Dreceiver.get(i)%>
			    				</td>
                                
                                <td width="55%" onclick="location.href='ReadDraft.jsp?msgId=<%=DmsgId.get(i)%>&sender=<%=session.getAttribute("userId")%>&subject=<%=Dsubject.get(i)%>'">
                                	<%=Dsubject.get(i)%>
                                </td>
                                
                                <td width="25%" onclick="location.href='ReadDraft.jsp?msgId=<%=DmsgId.get(i)%>&sender=<%=session.getAttribute("userId")%>&subject=<%=Dsubject.get(i)%>'">
                                	<center><%=DmsgDateTime.get(i)%></center>
                                </td>
			    			</tr>	
        <%
						}
					
        		}
        
		%>
				
                           
		<%		
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