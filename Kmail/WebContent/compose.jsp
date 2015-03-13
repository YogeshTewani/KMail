<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="java.util.*" %>

<jsp:useBean id="ComposeMail" class="Kmail.ComposeMail"/>
<jsp:setProperty name="ComposeMail" property="*"/>

<jsp:useBean id="replyForward" class="Kmail.ShowMessage"/>

<jsp:setProperty name="replyForward" property="messageId" value="${param.msgId}"/>

<jsp:useBean id="inbox" class="Kmail.Inbox" />

<% 
String page1=request.getParameter("page1");
String msgId=request.getParameter("msgId");
System.out.println(page1);
if(page1!=null && page1!="")
{
	if(page1.equals("Rinbox"))
	{
		replyForward.replyEdit();
	}
	if(page1.equals("Finbox"))
	{
		replyForward.forwardEdit();
	}
	if(page1.equals("outbox"))
	{
		replyForward.outForward();
	}
	if(page1.equals("draft"))
	{
		replyForward.draftCompose();
	}
}


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
<title>Compose-<%=session.getAttribute("userId")%>@kmail.com</title>

<link type="text/css" rel="stylesheet" href="css/style.css"/>
<script type="text/javascript">
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
		
		Array.prototype.forEach.call(document.querySelectorAll("#availableEmailIds :checked"), function(el) { el.selected = false });
		/*
		var elements = document.getElementById(id).options;

   	   for(var i = 0; i < elements.length; i++)
	   {
       		if(elements[i].selected)
        		elements[i].selected = false;
       }
	   
	   var checkedElements = document.querySelectorAll("#availableEmailIds :checked");

​for(var i = 0, length = checkedElements.length; i < length; i++) {
    checkedElements[i].selected = false;
}​
		*/
	
	
		document.getElementById("sTo").focus();
	}
	

function saveToDraft() 
{
	document.Compose_form.action="DraftHandler.jsp";
	document.Compose_form.submit();
} 

function discard()
{
	var e1 = document.getElementById("msgId").value;
	var e2 = document.getElementById("page1").value;
	alert(e1+e2);
	if(e1!='null')
	{
	alert("this is e1!=null");
	alert(e1);
		if(e2!=null && e2=='draft')
		{
			alert("this is Draft");
			alert(e2);
			document.Compose_form.action="DiscardHandler.jsp";
			document.Compose_form.submit();
		}
		else
		{
			window.location="inbox.jsp";
		}
	}
	else
	{
		window.location="inbox.jsp";
	}
	

	/*if(e1!=null)
	{
		if(e2=="draft")
		{
			
		}
	}*/
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
                    </td>
                </tr>              
          </table>
        </td>
  	</tr>
    <tr>
    	<td colspan="5">
        	<marquee align="bottom"> Hello There</marquee>
        </td>
  </tr>
<form name="Compose_form" id="Compose_form" action="ComposeMailHandler.jsp" method="post" enctype="multipart/form-data">
  <tr>
     <td colspan="5">
        	 <input type="hidden" name="msgId" id="msgId" value="<%=msgId%>"  />
             <input type="hidden" name="page1" id="page1" value="<%=page1%>"  />
      </td>
  </tr>
	
   <tr>
    	<th width="120">
        	<h4>Composing Mail</h4>
        </th>
    	
  </tr>
    
	<tr>
    	<td valign="top">
        	<table width="100%" bgcolor="#00FFFF" bordercolor="#00CC00">
            	<tr><td align="center"><a href="compose.jsp">Compose Mail</a></td></tr>
            	<tr><td align="center"><a href="inbox.jsp">Inbox (<%=uByT%>) </a></td></tr>
                <tr><td align="center"><a href="outbox.jsp">Outbox (<%=oT%>)</a></td></tr>
                <tr><td align="center"><a href="drafts.jsp">Drafts (<%=dT%>)</a></td></tr>
                
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
                <h5>Available Email Ids</h5>
      <select name="availableEmailIds" id="availableEmailIds" size="10" style="width:120px" ondblclick="addEmail(this.value,this.id)">
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
   		<td colspan="4" valign="top">
        
        <table width="100%"  bgcolor="#CCCCCC" align="center" bordercolor="#0000FF">
        	<tr>
            	<td>
                	<center><font color="#FF0000">(You can separate Email ids by ;)</font></center>
                </td>
            </tr>
            
          <tr style="width:100%; display:block;" align="center">
            	
            	<td>
                	To: 
                	  <input name="sTo" type="text" id="sTo" value="<%=replyForward.getToHeader() %>" size="50" /> @kmail.com               	
                </td>
                
          </tr>
            
            <tr>
            	<td colspan="4" align="center">
                	<a href="javascript:elementHideShow('cc');">CC</a> | <a href="javascript:elementHideShow('bcc');">BCC</a> | <a href="javascript:elementHideShow('attachFiles');">Attach Files</a>              	
                </td>
            </tr>
             <%
			 	if(replyForward.getCcHeader()!="")
				{
			 %>
             
             <tr id="cc" style="width:100%; display:block;" align="center">
            <td>
                CC: <input name="sCc" type="text" size="50" value="<%=replyForward.getCcHeader() %>" /> @kmail.com</td>
        </tr>      
         <%
				}
				else
				{
		 %>
         	<tr id="cc" style="width:100%; display:none;" align="center">
            <td>
                CC: <input name="sCc" type="text" size="50" value="<%=replyForward.getCcHeader() %>" /> @kmail.com</td>
        </tr>      
		<%
				}
        %>
        
        
         <%
			 	if(replyForward.getBccHeader()!="")
				{
		 %>
         <tr id="bcc" style="width:100%; display:block;" align="center">
            <td>
                <center>Bcc: <input name="sBcc" type="text" size="50" value="<%=replyForward.getBccHeader() %>" /> @kmail.com</center></td>
        </tr> 
        
        <%
				}
				else
				{
		%>
                 <tr id="bcc" style="width:100%; display:none;" align="center">
            <td>
                <center>Bcc: <input name="sBcc" type="text" size="50" value="<%=replyForward.getBccHeader() %>" /> @kmail.com</center></td>
        </tr> 
        <%
				}
		%>
         
         <tr id="attachFiles" style="width:100%; display:none;" align="center">
            <td>
                <center>
                  <label for="file">Attach File: </label>
                 
                 <input type="file" name="sfile" id="file" size="42" />
              </center></td>
        </tr> 
            
          <tr>
            	<td colspan="4">
               	  <center>Subject  <input name="subject" type="text" size="56" value="<%=replyForward.getSubject()%>" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               	  </center>               	
                </td>
          </tr>
            
            <tr>
            <td bgcolor="#CCCCCC" colspan="3">
    	<center><input name="send" type="submit" value="Send" />
        <input name="saveDrafts" type="button" value="Save To Drafts" onclick="location.href='javascript:saveToDraft()'" />
        <input name="discard" type="button" value="Discard" onclick="location.href='javascript:discard()'"></input>
        </center>
   </td>
            
            </tr>
            
            <tr>
            
            <td colspan="4" bgcolor="#CCCCCC">
  		Message
             <center>  
               <textarea name="message" cols="130" rows="18" wrap="hard"><%=replyForward.getMessage()%></textarea>
                 </center>             	
    		</td>
            </tr>
            <tr>
            <td bgcolor="#CCCCCC" colspan="3">
    	<center><input name="send" type="submit" value="Send" />
        <input name="saveDrafts" type="button" value="Save To Drafts" onclick="location.href='javascript:saveToDraft()'" />
        <input name="discard" type="button" value="Discard" onclick="location.href='javascript:discard()'" />
      </center>
   </td>
            </tr>
            
        </table>
        	
  </form>
</table>

</body>
</html>