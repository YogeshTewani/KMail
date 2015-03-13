package Kmail;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;



public class Delete 
{
	ServletContext sc;
	public void setServletContext(ServletContext sc)
	{
		this.sc=sc;
	}
	
	public ServletContext getServletContext()
	{
		return sc;
	}
	
	
	//If Request from Inbox to Delete
	public void deleteFromInbox(HttpServletRequest request,String msgId,String receiver)throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtDelete=null;
		PreparedStatement pstmtSelect=null;
		String query=null;
		boolean inbox=false,outbox=false;
		ResultSet rsetI=null;
		ResultSet rsetO=null;
		String aMsgId[]=msgId.split(";");
		try
		{
			for(int i=0;i<aMsgId.length;i++)
			{
				query="Delete from inbox where MessageId=? and receiver=?";
				pstmtDelete = conn.prepareStatement(query);
				pstmtDelete.setInt(1, Integer.parseInt(aMsgId[i]));
				pstmtDelete.setString(2, receiver);
				int exec = pstmtDelete.executeUpdate();
				if(exec>0)
				{
					conn.commit();
					query="Select * from inbox where MessageId=?";
					pstmtSelect = conn.prepareStatement(query);
					pstmtSelect.setInt(1, Integer.parseInt(aMsgId[i]));
					rsetI=pstmtSelect.executeQuery();
					if(!(rsetI.next()))
					{
						inbox=true;
					}
					
					query="Delete from outbox where MessageId=? and sender=?";
					pstmtSelect = conn.prepareStatement(query);
					pstmtSelect.setInt(1, Integer.parseInt(aMsgId[i]));
					pstmtSelect.setString(2, receiver);
					int j=pstmtSelect.executeUpdate();
					if(j>0)
					{
						conn.commit();
					}
					
					query="Select * from outbox where MessageId=?";
					pstmtSelect = conn.prepareStatement(query);
					pstmtSelect.setInt(1, Integer.parseInt(aMsgId[i]));
					rsetO=pstmtSelect.executeQuery();
					if(!(rsetO.next()))
					{
						outbox=true;
					}
				}
				//String check=checkExistance(Integer.parseInt(aMsgId[i]));
				
				if(inbox && outbox)
				{
					query="Delete from attachment where MessageId=?";
					pstmtSelect = conn.prepareStatement(query);
					pstmtSelect.setInt(1, Integer.parseInt(aMsgId[i]));
					int j=pstmtSelect.executeUpdate();
					if(j>0)
					{
						conn.commit();
					}
					
					query="Delete from message where MessageId=?";
					pstmtSelect = conn.prepareStatement(query);
					pstmtSelect.setInt(1, Integer.parseInt(aMsgId[i]));
					int m=pstmtSelect.executeUpdate();
					if(m>0)
					{
						conn.commit();
					}
					sc=request.getSession().getServletContext();
					//String path=sc.getRealPath("/")+"attachments\\"+msgId+"\\"+fileName;
					String path=sc.getRealPath("/")+"attachments\\";
					String var=path+aMsgId[i];
					//System.out.println(var);
					File dir=new File(var);
					//System.out.println(dir);
					FileUtils.deleteDirectory(dir);
				}
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	
	//If Request from Outbox to Delete
	public void deleteFromOutbox(HttpServletRequest request,String msgId,String sender)throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtDelete=null;
		PreparedStatement pstmtSelect=null;
		String query=null;
		boolean inbox=false,outbox=false;
		ResultSet rsetO=null,rsetI=null;
		String aMsgId[]=msgId.split(";");
		try
		{
			for(int i=0;i<aMsgId.length;i++)
			{
				query="Delete from outbox where MessageId=? and sender=?";
				pstmtDelete = conn.prepareStatement(query);
				pstmtDelete.setInt(1, Integer.parseInt(aMsgId[i]));
				pstmtDelete.setString(2, sender);
				int exec = pstmtDelete.executeUpdate();
				if(exec>0)
				{
					conn.commit();
					
					query="Select * from outbox where MessageId=?";
					pstmtSelect = conn.prepareStatement(query);
					pstmtSelect.setInt(1, Integer.parseInt(aMsgId[i]));
					rsetO=pstmtSelect.executeQuery();
					if(!(rsetO.next()))
					{
						outbox=true;
					}
					
					query="Delete from inbox where MessageId=? and sender=? and receiver=?";
					pstmtSelect = conn.prepareStatement(query);
					pstmtSelect.setInt(1, Integer.parseInt(aMsgId[i]));
					pstmtSelect.setString(2, sender);
					pstmtSelect.setString(3, sender);
					int j=pstmtSelect.executeUpdate();
					if(j>0)
					{
						conn.commit();
					}
					
					query="Select * from inbox where MessageId=?";
					pstmtSelect = conn.prepareStatement(query);
					pstmtSelect.setInt(1, Integer.parseInt(aMsgId[i]));
					rsetO=pstmtSelect.executeQuery();
					if(!(rsetO.next()))
					{
						inbox=true;
					}
					
				}
				//String check=checkExistance(Integer.parseInt(aMsgId[i]));
				
				if(outbox && inbox)
				{
					query="Delete from attachment where MessageId=?";
					pstmtSelect = conn.prepareStatement(query);
					pstmtSelect.setInt(1, Integer.parseInt(aMsgId[i]));
					int j=pstmtSelect.executeUpdate();
					if(j>0)
					{
						conn.commit();
					}
					
					query="Delete from message where MessageId=?";
					pstmtSelect = conn.prepareStatement(query);
					pstmtSelect.setInt(1, Integer.parseInt(aMsgId[i]));
					int m=pstmtSelect.executeUpdate();
					if(m>0)
					{
						conn.commit();
					}
					sc=request.getSession().getServletContext();
					//String path=sc.getRealPath("/")+"attachments\\"+msgId+"\\"+fileName;
					String path=sc.getRealPath("/")+"attachments\\";
					String var=path+aMsgId[i];
					//System.out.println(var);
					File dir=new File(var);
					//System.out.println(dir);
					FileUtils.deleteDirectory(dir);
				}
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	//If Request from Draft to Delete
	public void deleteFromDrafts(HttpServletRequest request,String msgId,String sender)throws Exception
	{
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmtDelete=null;
		String query=null;
		String aMsgId[]=msgId.split(";");
		try
		{
			for(int i=0;i<aMsgId.length;i++)
			{
				query="Delete from draft where MessageId=? and sender=?";
				pstmtDelete = conn.prepareStatement(query);
				pstmtDelete.setInt(1, Integer.parseInt(aMsgId[i]));
				pstmtDelete.setString(2, sender);
				int exec = pstmtDelete.executeUpdate();
				if(exec>0)
					conn.commit();
				
				boolean attach=false;
				query="Delete from attachment where MessageId=?";
				pstmtDelete = conn.prepareStatement(query);
				pstmtDelete.setInt(1, Integer.parseInt(aMsgId[i]));
				int a=pstmtDelete.executeUpdate();
				
				if(a>0)
				{
					conn.commit();
					attach=true;
				}
				
				if(attach)
				{
					sc=request.getSession().getServletContext();
					//String path=sc.getRealPath("/")+"attachments\\"+msgId+"\\"+fileName;
					String path=sc.getRealPath("/")+"attachments\\";
					String var=path+aMsgId[i];
					System.out.println(var);
					File dir=new File(var);
					System.out.println(dir);
					FileUtils.deleteDirectory(dir);
					System.out.println("FileUtils");
				}
				
				query="Delete from message where MessageId=?";
				pstmtDelete = conn.prepareStatement(query);
				pstmtDelete.setInt(1, Integer.parseInt(aMsgId[i]));
				
				int j=pstmtDelete.executeUpdate();
				
				if(j>0)
				{
					conn.commit();
				}
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
}
