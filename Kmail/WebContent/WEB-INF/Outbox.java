package Kmail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Outbox 
{
	ArrayList<Integer> messageId=new ArrayList<Integer>();
	ArrayList<String> receiver = new ArrayList<String>();
	ArrayList<String> sender = new ArrayList<String>();
	ArrayList<String> mailHeader = new ArrayList<String>();
	ArrayList<String> message = new ArrayList<String>();
	ArrayList<String> subject = new ArrayList<String>();
	ArrayList<String> msgDateTime = new ArrayList<String>();
	
	
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
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		
		try
		{
				query="select * from outbox where sender=?";
				pstmtSelect = conn.prepareStatement(query);
				pstmtSelect.setString(1, currentId);
				rset = pstmtSelect.executeQuery();
				while(rset.next())
				{
					if(!messageId.contains(rset.getInt(1)))
					{
						messageId.add(rset.getInt(1));
						String r="";
						query="select * from outbox where MessageId=?";
						pstmtSelect = conn.prepareStatement(query);
						pstmtSelect.setInt(1, rset.getInt(1));
						ResultSet rset1 = pstmtSelect.executeQuery();
						while(rset1.next())
						{
							if(r.equals("") || r==null)
							{
								r=rset1.getString("receiver");
								
							}
							else
							{
								r+=","+rset1.getString("receiver");
							}
							
						}
						receiver.add(r);
					}
					
					//sender.add(rset.getString(2));
					//mailHeader.add(rset.getString(5));
					
				}
				
				if(messageId.size()!=0)
				{
					for(int i=0;i<messageId.size();i++)
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
				}
				
				
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
	}
	
}
