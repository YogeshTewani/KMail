package Kmail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Inbox 
{
	int total;
	int unread;
	ArrayList<Integer> messageId=new ArrayList<Integer>();
	ArrayList<String> receiver = new ArrayList<String>();
	ArrayList<String> sender = new ArrayList<String>();
	ArrayList<String> viewStatus = new ArrayList<String>();
	ArrayList<String> mailHeader = new ArrayList<String>();
	ArrayList<String> message = new ArrayList<String>();
	ArrayList<String> subject = new ArrayList<String>();
	ArrayList<String> msgDateTime = new ArrayList<String>();
	
	/*String[] receiver,sender,viewStatus,mailHeader,message,subject,msgDateTime;*/
	
	public ArrayList<Integer> getMessageId()
	{
		return messageId;
	}
		
	public ArrayList<String> getReceiver()
	{
		return receiver;
	}
	
	public ArrayList<String> getSender()
	{
		return sender;
	}
	
	public ArrayList<String> getViewStatus()
	{
		for(int i=0;i<viewStatus.size();i++)
			System.out.println(viewStatus.get(i));
		return viewStatus;
	}
	
	public ArrayList<String> getMailHeader()
	{
		return mailHeader;
	}
	
	public ArrayList<String> getMessage()
	{
		return message;
	}
	
	public ArrayList<String> getSubject()
	{
		return subject;
	}
	
	public ArrayList<String> getMsgDateTime()
	{
		return msgDateTime;
	}
	
	
	public void setData(String currentId) throws Exception
	{
		/*ArrayList<Integer> tmessageId=new ArrayList<Integer>();
		ArrayList<String> treceiver = new ArrayList<String>();
		ArrayList<String> tsender = new ArrayList<String>();
		ArrayList<String> tviewStatus = new ArrayList<String>();
		ArrayList<String> tmailHeader = new ArrayList<String>();
		ArrayList<String> tmessage = new ArrayList<String>();
		ArrayList<String> tsubject = new ArrayList<String>();
		ArrayList<String> tmsgDateTime = new ArrayList<String>();*/
		
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		
		try
		{
			int i=0;
			
			
				query="select * from inbox where receiver=?";
				pstmtSelect = conn.prepareStatement(query);
				pstmtSelect.setString(1, currentId);
				rset = pstmtSelect.executeQuery();
				while(rset.next())
				{
					messageId.add(rset.getInt(1));
					receiver.add(rset.getString(2));
					sender.add(rset.getString(3));
					viewStatus.add(rset.getString(4));
					mailHeader.add(rset.getString(5));
					i++;
				}
				
				if(messageId.size()!=0)
				{
					for(i=0;i<messageId.size();i++)
					{
						query="select * from message where MessageId=?";
						pstmtSelect = conn.prepareStatement(query);
						pstmtSelect.setInt(1, messageId.get(i));
						rset = pstmtSelect.executeQuery();
						if(rset.next())
						{
							subject.add(rset.getString(2));
							message.add(rset.getString(3));
							msgDateTime.add(rset.getString(4));
						}
						
					}
					
					/*messageId=new int[tmessageId.size()];
					for (i=0; i < messageId.length; i++)
				    {
				        messageId[i] = tmessageId.get(i).intValue();
				    }
					receiver=new String[treceiver.size()];
					receiver = treceiver.toArray(receiver);
					
					sender=new String[tsender.size()];
					sender = tsender.toArray(sender);
					
					viewStatus=new String[tviewStatus.size()];
					viewStatus = tviewStatus.toArray(viewStatus);
					
					mailHeader=new String[tmailHeader.size()];
					mailHeader = tmailHeader.toArray(mailHeader);
					
					subject=new String[tsubject.size()];
					subject = tsubject.toArray(subject);
					
					message=new String[tmessage.size()];
					message = tmessage.toArray(message);
					
					msgDateTime=new String[tmsgDateTime.size()];
					msgDateTime = tmsgDateTime.toArray(msgDateTime);*/
					
				
				}
				
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		
	}
	
	//To display the Count of Messages
	
	public String iUnreadByTotal(String userId) throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		String query1=null;
		ResultSet rset=null;
		
		
		try
		{
			query="select count(*) from inbox where receiver=?";
			pstmtSelect = conn.prepareStatement(query);
			pstmtSelect.setString(1, userId);
			rset = pstmtSelect.executeQuery();
			if(rset.next())
			{
				total = rset.getInt(1);
			}
			else
			{
				total=0;
			}
			query1="select count(*) from inbox where receiver=? and viewstatus='N'";
			pstmtSelect = conn.prepareStatement(query1);
			pstmtSelect.setString(1, userId);
			rset = pstmtSelect.executeQuery();
			if(rset.next())
			{
				unread=rset.getInt(1);
			}
			else
			{
				unread=0;
			}
			return unread +"/" + total;
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return "0/0";
		}
	}
	
	public String outboxTotal(String userId) throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		
		
		try
		{
			query="SELECT count(Distinct MessageId) from outbox where sender=?";
			pstmtSelect = conn.prepareStatement(query);
			pstmtSelect.setString(1, userId);
			rset = pstmtSelect.executeQuery();
			if(rset.next())
			{
				total = rset.getInt(1);
			}
			else
			{
				total=0;
			}
			
			return total+"";
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return "0";
		}
	}
	
	
	public String draftTotal(String userId) throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		
		
		try
		{
			query="select count(Distinct MessageId) from draft where sender=?";
			pstmtSelect = conn.prepareStatement(query);
			pstmtSelect.setString(1, userId);
			rset = pstmtSelect.executeQuery();
			if(rset.next())
			{
				total = rset.getInt(1);
			}
			else
			{
				total=0;
			}
			
			return total+"";
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return "0";
		}
	}
	
	
}
