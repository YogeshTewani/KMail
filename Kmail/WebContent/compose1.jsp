<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page import="java.util.*" %>
<jsp:useBean id="ComposeMail" class="Kmail.ComposeMail"/>
<jsp:setProperty name="ComposeMail" property="*"/>

<head>

	<title>Compose-<%=session.getAttribute("userId")%>@kmail.com
    </title>

	<link type="text/css" rel="stylesheet" href="css/style.css"/>
    
    <script language="javascript">
    
		function elementHideShow(elementToHideOrShow) 
    	{
        	var el = document.getElementById(elementToHideOrShow);
        	if (el.style.display == "block") 
			{
	            el.style.display = "none";
    	    }
        	else 
        	{
            	el.style.display = "block";
        	}
    	}         
 

		function addEmail(valu,id)
		{
			var txt=document.getElementById("sTo").value;
			if(txt!="")
			{
				txt=txt + ";" +valu;
			}
			else
			{
				txt=valu;
			}
			document.getElementById("sTo").value=txt;
			document.getElementById("sTo").focus();
		}
	</script>
    
</head>

<% 
	if(session.getAttribute("userId") == null || session.getAttribute("userId").equals("")) 
	{ 
   		response.sendRedirect("index.jsp"); 
   }
%>

<body>

	<form name="Compose_form" id="Compose_form">
		<table width="100%">
        <tr>
        	
            <td>
            	<img src="images/logo.jpg" height="50" width="100" />
            </td>
            
            <td colspan="4">
            	<p> 
        	  		<input name="search" type="text" id="search" width="300" size="130" />
              		<input name="search" type="button" value="Search" />
             	</p>
            </td>
            
            <td align="right">
            	<ul class="sf-menu">
                	<li>
                    	<a href="#"><%=session.getAttribute("userId")%>@kmail.com
						</a>
                    <ul>
                    	<li>
                    		<a href="#">Profile
                        	</a>
                    	</li>
                    	<li>
                    		<a href="#">Settings
                        	</a>
                    	</li>
                    	<li>
                    		<a href="logout.jsp">Log Out
                        	</a>
                    	</li>
                	</ul>
                    </li>
               </ul>
            </td>
        
        </tr>
        
        <tr>
        	<td colspan="6">
            	<marquee align="bottom"> Hello There
                </marquee>
            </td>
        </tr>
        
        <tr>
        	<th width="158">
            	<h3>Composing mail
                </h3>
            </th>
        </tr>
        
        <tr>
        	<td valign="top">
            	<table width="100%" bgcolor="#CCCCCC">
                	<tr>
                    	<td align="center">
                        	<a href="compose.jsp">Compose Mail
                            </a>
                        </td>
                    </tr>
                    
                    <tr>
                    	 <td align="center">
                        	<a href="inbox.jsp">Inbox(0/0)
                            </a>
                        </td>
                    </tr>
                    
                    <tr>
                    	<td align="center">
                        	<a href="outbox.jsp">OutBox
                            </a>
                        </td>
                    </tr>
                    
                    <tr>
                    	<td align="center">
                        	<a href="drafts.jsp">Drafts(0)
                            </a>
                        </td>
                    </tr>
                    
                    <tr>
                    	<td>
                    	</td>
                    </tr>
                    
                    <tr>
                    	<td>
                    	</td>
                    </tr>
                    
                    <tr>
                    	<td>
                        	<h4>Available Email Ids
                            </h4>
                            
                             <select name="availableEmailIds" id="availableEmailIds" size="10" style="width:157px" ondblclick="addEmail(this.value,this.id)">
                             	 <%
      								ArrayList<String> getList=ComposeMail.getUserIds();
									if(getList!=null && getList.size()>0)
      								{
										for(int i=0;i<getList.size();i++)
    	  								{
								  %>	
                                  <option value = "<%=getList.get(i)%>" id="<%=getList.get(i)%>">	
                                  		<%=getList.get(i)%>
                                  </option>
                                  <%
										}
									}
								  %>
                             </select>
                        </td>
                    </tr>
                    
                </table>
            </td>
            
            <td colspan="5" valign="top">
            	<table width="100%"  bgcolor="#CCCCCC">
                	<tr>
                    	<td width="30%">
                        	
                        </td>
                        <td width="70%">
                        	<center>
                            	<font color="#FF0000">(You can separate Email ids by ;)
                                </font>
                             </center>
                        </td>
                        
                    </tr>
                    
                    <tr>
                    	<td align="right" width="30%">
                        	To:
                        </td>
                        <td width="70%">
                             <input name="sTo" type="text" id="sTo" size="56"/>@kmail.com
                        </td>
                       
                    </tr>
                    
                    <tr>
                    	
                        <td align="center" colspan="4">
                        	
                            	<a href="javascript:elementHideShow('cc');">CC
								</a> | 
                                <a href="javascript:elementHideShow('bcc');">BCC
								</a> | 
                                <a href="javascript:elementHideShow('attachFiles');">Attach Files
								</a>
                           
                        </td>
                       
                    </tr>
                    
                    <tr id="cc" style="width:300px; display:none;">
                    	<td align="right" width="30%">
                        	CC:
                        </td>
                        <td width="70%" align="center">
                            <input name="scc" type="text" size="56" />@kmail.com
                        </td>
                       
                    </tr>
                    
                    <tr id="bcc" style="width:300px; display:none;">
                    	<td align="right" width="30%">
                        	Bcc:
                        </td>
                        
                        <td width="70%">
                            <input name="sBcc" type="text" size="56" />@kmail.com
                        </td>
                       
                    </tr>
                    
                    <tr id="attachFiles" style="width:300px; display:none;">
                    	<td align="right">
                        	<label for="file">Attach File: 
                            </label>
                        </td>
                        
                        <td width="70%">
                        	 <input type="file" name="sfile" id="file" size="56" />
                        </td>
                       
                    </tr>
                    
                    <tr>
                    	<td align="right">
                        	Subject:
                        </td>
                        
                        <td>
                        	<input name="subject" type="text" size="56" maxlength="200" />
                        </td>
                        
                        <td>
                        </td>
                    </tr>
                    
                    <tr>
                    	
                        
                        <td colspan="4" align="center">
                        	
                            	<input name="send" type="button" value="Send" />
								<input name="saveDrafts" type="button" value="Save To Drafts" />
								<input name="discard" type="button" value="Discard" />
                            
                        </td>
                        
                    </tr>
                    
                    <tr>
                    	<td colspan="4">
                        	Message
                        </td>
                    </tr>
                    
                    <tr>
                    	<td colspan="4">
                        	<center>
                            <textarea name="message" cols="120" rows="18">
							</textarea>
                            </center>
                        </td>
                    </tr>
                    
                      <tr>
                    	
                        
                        <td colspan="4" align="center">
                        	
                            	<input name="send" type="button" value="Send" />
								<input name="saveDrafts" type="button" value="Save To Drafts" />
								<input name="discard" type="button" value="Discard" />
                            
                        </td>
                        
                    </tr>
                    
                </table>
            </td>
        </tr>
        </table>

	</form>

</body>

</html>