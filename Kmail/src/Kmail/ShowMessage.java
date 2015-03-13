package Kmail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.sql.ResultSet;


public class ShowMessage {

	String message="",msgDateTime="",fileName="";
	String toHeader="",ccHeader="",bccHeader="",subject="";
	String messageId="";
	
	public String getMessage()
	{
		return message;
	}
	
	public String getSubject()
	{
		return subject;
	}
	
	public String getMsgDateTime()
	{
		return msgDateTime;
	}
	
	public String getFileName()
	{
		return fileName;
	}
	
	public String getToHeader()
	{
		System.out.println(toHeader);
		return toHeader;
	}
	
	public String getCcHeader()
	{
		return ccHeader;
	}
	
	public String getBccHeader()
	{
		return bccHeader;
	}
	
	public void setMessageId(String messageId)
	{
		this.messageId=messageId;
	}
	
	public String getMessageId()
	{
		return messageId;
	}
	
	public void changeViewStatus(int msgId,String treceiver) throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		int i=0;
		
			try
			{
				query="update inbox set viewstatus=? where MessageId=? and receiver=?";
				pstmtSelect = conn.prepareStatement(query);
				pstmtSelect.setString(1, "Y");
				pstmtSelect.setInt(2, msgId);
				pstmtSelect.setString(3, treceiver);
				i = pstmtSelect.executeUpdate();
				if(i>0)
				{
					conn.commit();
				}
				
				query="select * from inbox where MessageId=?";
				pstmtSelect=conn.prepareStatement(query);
				pstmtSelect.setInt(1,msgId);
				rset=pstmtSelect.executeQuery();
				while(rset.next())
				{
					if(rset.getString("mailheader").toString().equals("to"))
					{
						if(toHeader.equals("") || toHeader==null)
						{
							toHeader=rset.getString("receiver").toString()+"@kmail.com";
						}
						else
						{
							toHeader=toHeader+","+rset.getString("receiver").toString()+"@kmail.com";
						}
					}
					else if(rset.getString("mailheader").toString().equals("cc"))
					{
						if(ccHeader=="" || ccHeader=="null")
						{
							ccHeader=rset.getString("receiver")+"@kmail.com";
						}
						else
						{
							ccHeader=ccHeader+","+rset.getString("receiver")+"@kmail.com";
						}
					}
					else if(rset.getString("mailheader").toString().equals("bcc"))
					{
						if(bccHeader=="" || bccHeader=="null")
						{
							bccHeader=rset.getString("receiver")+"@kmail.com";
						}
						else
						{
							bccHeader=bccHeader+","+rset.getString("receiver")+"@kmail.com";
						}
					}
				}
				
				query="select * from message where MessageId=?";
				pstmtSelect=conn.prepareStatement(query);
				pstmtSelect.setInt(1,msgId);
				rset=pstmtSelect.executeQuery();
				if(rset.next())
				{
					message=rset.getString("message");
					msgDateTime=rset.getString("msgDateTime");
				}
				
				query="select * from attachment where MessageId=?";
				pstmtSelect=conn.prepareStatement(query);
				pstmtSelect.setInt(1,msgId);
				rset=pstmtSelect.executeQuery();
				if(rset.next())
				{
					fileName=rset.getString("FileName");
				}
					
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		
	}
	
	public void displayOutbox(int msgId,String treceiver)throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		
		try
		{
			query="select * from outbox where MessageId=? and sender=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,msgId);
			pstmtSelect.setString(2, treceiver);
			rset=pstmtSelect.executeQuery();
			
			while(rset.next())
			{					
				if(rset.getString("mailheader").toString().equals("to"))
				{
					if(toHeader.equals("") || toHeader==null)
					{
						toHeader=rset.getString("receiver").toString()+"@kmail.com";
					}
					else
					{
						toHeader=toHeader+","+rset.getString("receiver").toString()+"@kmail.com";
					}
				}
				else if(rset.getString("mailheader").toString().equals("cc"))
				{
					if(ccHeader=="" || ccHeader=="null")
					{
						ccHeader=rset.getString("receiver")+"@kmail.com";
					}
					else
					{
						ccHeader=ccHeader+","+rset.getString("receiver")+"@kmail.com";
					}
				}
				else if(rset.getString("mailheader").toString().equals("bcc"))
				{
					if(bccHeader=="" || bccHeader=="null")
					{
						bccHeader=rset.getString("receiver")+"@kmail.com";
					}
					else
					{
						bccHeader=bccHeader+","+rset.getString("receiver")+"@kmail.com";
					}
				}
			}
			
			query="select * from message where MessageId=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,msgId);
			rset=pstmtSelect.executeQuery();
			if(rset.next())
			{
				message=rset.getString("message");
				msgDateTime=rset.getString("msgDateTime");
			}
			
			query="select * from attachment where MessageId=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,msgId);
			rset=pstmtSelect.executeQuery();
			if(rset.next())
			{
				fileName=rset.getString("FileName");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public void displayDraft(int msgId,String treceiver)throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		
		try
		{
			query="select * from draft where MessageId=? and sender=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,msgId);
			pstmtSelect.setString(2, treceiver);
			rset=pstmtSelect.executeQuery();
			
			while(rset.next())
			{					
				if(rset.getString("mailheader").toString().equals("to"))
				{
					if(toHeader.equals("") || toHeader==null)
					{
						toHeader=rset.getString("receiver").toString()+"@kmail.com";
					}
					else
					{
						toHeader=toHeader+","+rset.getString("receiver").toString()+"@kmail.com";
					}
				}
				else if(rset.getString("mailheader").toString().equals("cc"))
				{
					if(ccHeader=="" || ccHeader=="null")
					{
						ccHeader=rset.getString("receiver")+"@kmail.com";
					}
					else
					{
						ccHeader=ccHeader+","+rset.getString("receiver")+"@kmail.com";
					}
				}
				else if(rset.getString("mailheader").toString().equals("bcc"))
				{
					if(bccHeader=="" || bccHeader=="null")
					{
						bccHeader=rset.getString("receiver")+"@kmail.com";
					}
					else
					{
						bccHeader=bccHeader+","+rset.getString("receiver")+"@kmail.com";
					}
				}
			}
			
			query="select * from message where MessageId=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,msgId);
			rset=pstmtSelect.executeQuery();
			if(rset.next())
			{
				message=rset.getString("message");
				msgDateTime=rset.getString("msgDateTime");
			}
			
			query="select * from attachment where MessageId=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,msgId);
			rset=pstmtSelect.executeQuery();
			if(rset.next())
			{
				fileName=rset.getString("FileName");
			}
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
		
	public void replyEdit() throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		//boolean flag=false;
		
		try
		{
			query="select sender from inbox where MessageId=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,Integer.parseInt(messageId));
			rset=pstmtSelect.executeQuery();
			while(rset.next())
			{
			toHeader=rset.getString(1).toString();
			}
			
			query="select * from message where MessageId=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,Integer.parseInt(messageId));
			rset=pstmtSelect.executeQuery();
			
			while(rset.next())
			{
				subject="re:"+rset.getString("subject");
				message="\n"+rset.getString("message");
			}
			//flag=true;
			
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		//return flag;
	}
	
	public void forwardEdit() throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		//boolean flag=false;
		
		try
		{
			query="select * from message where MessageId=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,Integer.parseInt(messageId));
			rset=pstmtSelect.executeQuery();
			
			while(rset.next())
			{
				subject="Fwd:"+rset.getString("subject");
				message="\n"+rset.getString("message");
			}
			//flag=true;
			
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		//return flag;
	}
	public void outForward() throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		//boolean flag=false;
		
		try
		{
			query="select * from message where MessageId=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,Integer.parseInt(messageId));
			rset=pstmtSelect.executeQuery();
			
			while(rset.next())
			{
				subject="Fwd:"+rset.getString("subject");
				message="\n"+rset.getString("message");
			}
			//flag=true;
			
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		//return flag;
	}
	
	
	public void draftCompose() throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		//boolean flag=false;
		
		try
		{
			query="select * from draft where MessageId=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,Integer.parseInt(messageId));
			rset=pstmtSelect.executeQuery();
			
			while(rset.next())
			{					
				if(rset.getString("mailheader").toString().equals("to"))
				{
					if(toHeader.equals("") || toHeader==null)
					{
						toHeader=rset.getString("receiver").toString();
					}
					else
					{
						toHeader=toHeader+";"+rset.getString("receiver").toString();
					}
				}
				else if(rset.getString("mailheader").toString().equals("cc"))
				{
					if(ccHeader=="" || ccHeader=="null")
					{
						ccHeader=rset.getString("receiver");
					}
					else
					{
						ccHeader=ccHeader+";"+rset.getString("receiver");
					}
				}
				else if(rset.getString("mailheader").toString().equals("bcc"))
				{
					if(bccHeader=="" || bccHeader=="null")
					{
						bccHeader=rset.getString("receiver");
					}
					else
					{
						bccHeader=bccHeader+";"+rset.getString("receiver");
					}
				}
			}
			
			
			query="select * from message where MessageId=?";
			pstmtSelect=conn.prepareStatement(query);
			pstmtSelect.setInt(1,Integer.parseInt(messageId));
			rset=pstmtSelect.executeQuery();
			
			while(rset.next())
			{
				subject=rset.getString("subject");
				message=rset.getString("message");
			}
			//flag=true;
			
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		//return flag;
	}
}
