package Kmail;

import java.util.*;
import java.io.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.ServletContext;

import com.oreilly.servlet.multipart.*;

import com.oreilly.servlet.multipart.MultipartParser;
import org.apache.commons.io.FileUtils;

public class ComposeMail {
	
	String sTo,sCc, sBcc,subject,message;
	File sFile;
	ServletContext sc;
	
	ArrayList<String> listFileName = new ArrayList<String>();
	ArrayList<String> validUser = new ArrayList<String>();
	ArrayList<String> invalidUser = new ArrayList<String>();
	ArrayList<String> validHeader = new ArrayList<String>();
	ArrayList<String> invalidHeader = new ArrayList<String>();
	ArrayList<FilePart> isFilePart = new ArrayList<FilePart>();
	ArrayList<String> FileName=new ArrayList<String>();
	
	boolean isValid=false;
	boolean isInvalid=false;
	boolean isFile=false;
	
	//Get and Set Data
	
	public void setSTo(String sTo) 
	{
		this.sTo = sTo;
	}

	public String getSTo() 
	{
		return sTo;
	}
	
	public void setSCc(String sCc) 
	{
		this.sCc = sCc;
	}

	public String getSCc() 
	{
		return sCc;
	}
	
	public void setSBcc(String sBcc) 
	{
		this.sBcc = sBcc;
	}

	public String getSBcc() 
	{
		return sBcc;
	}
	
	public void setFile(File sFile) 
	{
		this.sFile = sFile;
	}

	public File getSFile() 
	{
		return sFile;
	}
	
	public void setSubject(String subject) 
	{
		this.subject = subject;
	}
	
	public String getSubject() 
	{
		return subject;
	}
	
	public void setMessage(String message) 
	{
		this.message = message;
	}
	
	public String getmessage() 
	{
		return message;
	}
	
	public void setServletContext(ServletContext sc)
	{
		this.sc=sc;
	}
	
	public ServletContext getServletContext()
	{
		return sc;
	}
	
	public void setData(HttpServletRequest request,String userId,String sendSave) throws Exception
	{
		
		Connection conn=null;
		conn=DBConnection.getConnection();
		conn.setAutoCommit(false);

		String messageId="",page1="",path="";
		
		Part part;
		MultipartParser mp=new MultipartParser(request, 1000*1024); //2mb
		while((part=mp.readNextPart())!= null)
		{
			if(part.isParam())
			{
				ParamPart part1=(ParamPart)part;
				String name=part1.getName();
				
				if(name.equals("msgId"))
				{
					messageId=part1.getStringValue();
					System.out.println(messageId);
				}
				
				if(name.equals("page1"))
				{
					page1=part1.getStringValue();
					System.out.println(page1);
				}
				
				if(name.equals("sTo"))
				{
					setSTo(part1.getStringValue());
					System.out.println(sTo);
				}
				if(name.equals("sCc"))
				{
					setSCc(part1.getStringValue());
					System.out.println(sCc);
				}
				if(name.equals("sBcc"))
				{
					setSBcc(part1.getStringValue());
					System.out.println(sBcc);
				}
				if(name.equals("subject"))
				{
					setSubject(part1.getStringValue());
				}
				if(name.equals("message"))
				{
					setMessage(part1.getStringValue());
				}
			}
			
			if(part.isFile())
			{
				System.out.println("Entered part.isFile()");
				FilePart part2=(FilePart)part;
				System.out.println(">>>>>>>>>>>>>"+part2);
				
				if(part2!=null && !(part2.equals("")))
				{
					System.out.println(">>>>>>>>>>>>>"+part2);
					int msgId=getMaxMsgID(conn)+1;
					String fileName=part2.getFileName();
					
					if(fileName!=null && !(fileName.equals("")))
					{
						//fileName+="_msgId="+msgId;
						System.out.println("Adding to array");
						isFilePart.add(part2);
						FileName.add(fileName);
						System.out.println("Added");
						sc=request.getSession().getServletContext();
						//String path=sc.getRealPath("/")+"attachments\\"+msgId+"\\"+fileName;
						path=sc.getRealPath("/")+"attachments\\";
						System.out.println("Got real path"+path);
						System.out.println(path);
						new File(path+msgId).mkdir();
						String mPath=path+msgId+"\\"+fileName;
						File f1=new File(mPath);
						System.out.println("creating file");
						long size=part2.writeTo(f1);
						System.out.println("File wrote"+size);
						isFile=true;
					}
				}
			}

		}
		
		if(sendSave.equals("send"))
		{
			sc=request.getSession().getServletContext();
			//String path=sc.getRealPath("/")+"attachments\\"+msgId+"\\"+fileName;
			path=sc.getRealPath("/")+"attachments\\";
			if((messageId!="" && messageId!=null) && page1.equals("draft"))
			{
				deleteDraft(conn,userId, messageId,path);
				sendMessage(conn,userId,path);
			}
			else
			{
				sendMessage(conn,userId,path);
			}
		}
		
		if(sendSave.equals("save"))
		{
			sc=request.getSession().getServletContext();
			//String path=sc.getRealPath("/")+"attachments\\"+msgId+"\\"+fileName;
			path=sc.getRealPath("/")+"attachments\\";
			if((messageId!="" && messageId!=null) && page1.equals("draft"))
			{
				deleteDraft(conn,userId, messageId,path);
				saveDraft(conn,userId,path);
			}
			else
			{
				saveDraft(conn,userId,path);
			}
		}
		
		if(sendSave.equals("discard"))
		{
			sc=request.getSession().getServletContext();
			//String path=sc.getRealPath("/")+"attachments\\"+msgId+"\\"+fileName;
			path=sc.getRealPath("/")+"attachments\\";
			deleteDraft(conn, userId, messageId,path);
		}
		
	}
	
	//Send Message
	public void sendMessage(Connection conn,String userId,String path) throws Exception
	{
		
		if(sTo!=null && !sTo.isEmpty())
		{
			String To[]=sTo.split(";");
			for(int i=0;i<To.length;i++)
			{
				boolean flagTo=selectUserFromDatabase(To[i],conn);
				
				if(flagTo)
				{
					isValid=true;
					if(!(validUser.contains(To[i])))
					{
						validUser.add(To[i]);
						validHeader.add("to");
					}
				}
				else
				{
					isInvalid=true;
					if(!(invalidUser.contains(To[i])))
					{
						invalidUser.add(To[i]);
						invalidHeader.add("to");
					}
						
				}
			}
		}
			
			
		if(sCc!=null && !sCc.isEmpty())
		{
			String Acc[]=sCc.split(";"); //Array for CC
			for(int i=0;i<Acc.length;i++)
			{
				boolean flagCc=selectUserFromDatabase(Acc[i],conn);
				
				if(flagCc)
				{
					isValid=true;
					if(!(validUser.contains(Acc[i])))
					{
						validUser.add(Acc[i]);
						validHeader.add("cc");
					}
				}
				else
				{
					isInvalid=true;
					if(!(invalidUser.contains(Acc[i])))
					{
						invalidUser.add(Acc[i]);
						invalidHeader.add("cc");
					}
					
				}
			}
		}
		
		if(sBcc!=null && !sBcc.isEmpty())
		{
			String ABcc[]=sBcc.split(";"); //Array for bcc
			for(int i=0;i<ABcc.length;i++)
			{
				boolean flagCc=selectUserFromDatabase(ABcc[i],conn);
				
				if(flagCc)
				{
					isValid=true;
					if(!(validUser.contains(ABcc[i])))
					{
						validUser.add(ABcc[i]);
						validHeader.add("bcc");
					}
				}
				else
				{
					isInvalid=true;
					if(!(invalidUser.contains(ABcc[i])))
					{
						invalidUser.add(ABcc[i]);
						invalidHeader.add("bcc");
					}
					
				}
			}
		}
		
		int msgId=getMaxMsgID(conn)+1;
		
		if(isValid)
		{
			insertIntoMessage(conn,msgId);
			insertIntoInbox(validUser,conn,validHeader,msgId,userId);
			insertIntoOutbox(validUser,conn,validHeader,msgId,userId);
			

			if(isFile)
			{
				System.out.println("isfile true");
				insertIntoAttachments(conn,msgId,path);
			}
		}
		if(isInvalid)
		{
			if(isValid)
			{
				if(isFile)
				{
					File srcDir=new File(path+msgId);
					msgId+=1;
					File desDir=new File(path+msgId);
					FileUtils.copyDirectory(srcDir, desDir);
				}
				else
				{
					msgId+=1;
				}
				
			}
				
			subject+="(Invalid User Id, Message Cannot Be sent)";
			insertIntoMessage(conn,msgId);
			insertIntoDrafts(invalidUser,invalidHeader,conn,msgId,userId);
			

			if(isFile)
			{
				System.out.println("isfile true");
				insertIntoAttachments(conn,msgId,path);
				
			}
		}


	}
	
	
	//Delete Draft
	public void deleteDraft(Connection conn,String userId,String messageId,String path)
	{
		String query="";
		PreparedStatement pstmtDelete=null;
		System.out.println("Delete draft");
		System.out.println(path);
		try
		{
			query="Delete from draft where MessageId=? and sender=?";
			pstmtDelete = conn.prepareStatement(query);
			pstmtDelete.setInt(1, Integer.parseInt(messageId));
			pstmtDelete.setString(2, userId);
			
			int i=pstmtDelete.executeUpdate();
			
			if(i>0)
			{
				conn.commit();
			}
			
			boolean attach=false;
			query="Delete from attachment where MessageId=?";
			pstmtDelete = conn.prepareStatement(query);
			pstmtDelete.setInt(1, Integer.parseInt(messageId));
			int a=pstmtDelete.executeUpdate();
			
			if(a>0)
			{
				conn.commit();
				attach=true;
			}
			
			if(attach)
			{
				String var=path+messageId;
				System.out.println(var);
				File dir=new File(var);
				System.out.println(dir);
				FileUtils.deleteDirectory(dir);
				System.out.println("FileUtils");
			}
			
			query="Delete from message where MessageId=?";
			pstmtDelete = conn.prepareStatement(query);
			pstmtDelete.setInt(1, Integer.parseInt(messageId));
			
			int j=pstmtDelete.executeUpdate();
			
			if(j>0)
			{
				conn.commit();
			}
			
		}
		
		catch(Exception e)
		{
			e.printStackTrace();
		}


	}
	
	//Save Message
	public void saveDraft(Connection conn,String userId,String path) throws Exception
	{
		
		if(sTo!=null && !sTo.isEmpty())
		{
			String To[]=sTo.split(";");
			for(int i=0;i<To.length;i++)
			{
					isValid=true;
					if(!(validUser.contains(To[i])))
					{
						validUser.add(To[i]);
						validHeader.add("to");
					}
				
			}
		}
			
			
		if(sCc!=null && !sCc.isEmpty())
		{
			String Acc[]=sCc.split(";"); //Array for CC
			for(int i=0;i<Acc.length;i++)
			{
					if(!(validUser.contains(Acc[i])))
					{
						validUser.add(Acc[i]);
						validHeader.add("cc");
					}
				
			}
		}
		
		if(sBcc!=null && !sBcc.isEmpty())
		{
			String ABcc[]=sBcc.split(";"); //Array for bcc
			for(int i=0;i<ABcc.length;i++)
			{
					isValid=true;
					if(!(validUser.contains(ABcc[i])))
					{
						validUser.add(ABcc[i]);
						validHeader.add("bcc");
					}
				}
		}
		
		
		
		
		if(!isValid)
		{
			validUser.add("");
			validHeader.add("");
			isValid=true;
		}
		System.out.println(validUser.get(0)+"<>>"+validHeader.get(0));
		System.out.println("Save");
		int msgId=getMaxMsgID(conn)+1;
		
		if(isValid)
		{
			System.out.println("isValid");
			insertIntoMessage(conn,msgId);
			insertIntoDrafts(validUser,validHeader,conn,msgId,userId);
		}
		
		if(isFile)
		{
			System.out.println("isfile true");
			insertIntoAttachments(conn,msgId,path);
		}

	}
	
	
	
	//To check Existence of users
	private boolean selectUserFromDatabase(String userId,Connection conn)
	{
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		
		try
		{
			query="select * from userregistration where userid=?";
			pstmtSelect = conn.prepareStatement(query);
			pstmtSelect.setString(1, userId);
			rset = pstmtSelect.executeQuery();
			if(rset.next())
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
			return false;
		}
	}

	//Getting Maximum Message Id
	private int getMaxMsgID(Connection conn)
	{
		PreparedStatement pstmtSelect=null;
		String query=null;
		ResultSet rset=null;
		int max=0;
		try
		{
		
				query="select max(MessageId) maximum from message";
				pstmtSelect = conn.prepareStatement(query);
				rset = pstmtSelect.executeQuery();
				if(rset.next())
				{
					max = rset.getInt(1);
				}
			
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return max;
	}
	
	
	//Inserting into Message
	private void insertIntoMessage(Connection conn,int msgId)
	{
		PreparedStatement pstmtInsert=null;
		String query=null;
		
		java.util.Date date = new java.util.Date(); // Right now  
		java.sql.Timestamp timestamp1 = new java.sql.Timestamp(date.getTime()); 
		
		try
		{
			query="insert into message(MessageId,subject,message,msgdatetime) values(?,?,?,?)";
			pstmtInsert = conn.prepareStatement(query);
			pstmtInsert.setInt(1, msgId);
			pstmtInsert.setString(2, subject);
			pstmtInsert.setString(3, message);
			pstmtInsert.setTimestamp(4, timestamp1);
			System.out.println("Message    "+pstmtInsert);
			int i = pstmtInsert.executeUpdate();
			if(i>0)
			{
				System.out.println("Entered Successfully");
				conn.commit();
			}
			else
			{
				System.out.println("Error Occured");
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
	}
	
	//Insert into Inbox Table
		private void insertIntoInbox(ArrayList<String> vUser,Connection conn,ArrayList<String> vHeader,int msgId,String send)
		{
			PreparedStatement pstmtInsert=null;
			String query=null;
			
			try
			{
				for(int i=0;i<vUser.size() && i<vHeader.size();i++)
				{
					query="insert into inbox(MessageId,receiver,sender,viewstatus,mailheader) values(?,?,?,?,?)";
					pstmtInsert = conn.prepareStatement(query);
					pstmtInsert.setInt(1, msgId);
					pstmtInsert.setString(2, vUser.get(i));
					pstmtInsert.setString(3, send);
					pstmtInsert.setString(4, "N");
					pstmtInsert.setString(5, vHeader.get(i));
					
					System.out.println("Inbox    "+pstmtInsert);
					
					int j = pstmtInsert.executeUpdate();
					if(j>0)
					{
						System.out.println("Entered Successfully");
						conn.commit();
					}
					else
					{
						System.out.println("Error Occured");
					}
				}
				
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
		
		//Insert into Outbox Table
		private void insertIntoOutbox(ArrayList<String> vUser,Connection conn,ArrayList<String> vHeader,int msgId,String send)
		{
			PreparedStatement pstmtInsert=null;
			String query=null;
			
			try
			{
				for(int i=0;i<vUser.size() && i<vHeader.size();i++)
				{
					query="insert into outbox(MessageId,receiver,sender,status,mailheader) values(?,?,?,?,?)";
					pstmtInsert = conn.prepareStatement(query);
					pstmtInsert.setInt(1, msgId);
					pstmtInsert.setString(2, vUser.get(i));
					pstmtInsert.setString(3, send);
					pstmtInsert.setString(4, "");
					pstmtInsert.setString(5, vHeader.get(i));
					
					System.out.println("Outbox   "+pstmtInsert);
					int j = pstmtInsert.executeUpdate();
					if(j>0)
					{
						System.out.println("Entered Successfully");
						conn.commit();
					}
					else
					{
						System.out.println("Error Occured");
					}
				}
				
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
		
		
		//Insert into Drafts
		private void insertIntoDrafts(ArrayList<String> InvalidU,ArrayList<String> invalidH,Connection conn,int msgId,String send)
		{
			PreparedStatement pstmtInsert=null;
			String query=null;
			//ResultSet rset=null;
			
			try
			{
				for(int i=0;i<InvalidU.size() && i<invalidH.size();i++)
				{
					query="insert into draft(MessageId,receiver,sender,mailheader) values(?,?,?,?)";
					pstmtInsert = conn.prepareStatement(query);
					pstmtInsert.setInt(1, msgId);
					pstmtInsert.setString(2, InvalidU.get(i));
					pstmtInsert.setString(3, send);
					pstmtInsert.setString(4, invalidH.get(i));
					
					System.out.println("Drafts    "+pstmtInsert);
					int j = pstmtInsert.executeUpdate();
					if(j>0)
					{
						System.out.println("Entered Successfully");
						conn.commit();
					}
					else
					{
						System.out.println("Error Occured");
					}
				}
				
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
		
		
		//Insert into attachment Table
		private void insertIntoAttachments(Connection conn,int msgId,String path) throws Exception
		{
			PreparedStatement pstmtInsert=null;
			String query=null;
			//ResultSet rset=null;
			
			try
			{
					for(int i=0;i<FileName.size() && i<isFilePart.size();i++)
					{
						query="insert into attachment(MessageId,FileName) values(?,?)";
						pstmtInsert = conn.prepareStatement(query);
						pstmtInsert.setInt(1, msgId);
						pstmtInsert.setString(2, FileName.get(i).toString());

						
						int j = pstmtInsert.executeUpdate();
						if(j>0)
						{
							System.out.println("Attachment Success");
							conn.commit();
						}
						else
						{
							//f1.delete();
							File dir=new File(path+msgId);
							FileUtils.deleteDirectory(dir);
							System.out.println("Attachment failed");
						}
					}
				
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}


		
		
		//To get list of Users
		public ArrayList<String> getUserIds()
		{
			Connection conn=null;
			PreparedStatement pstmtSelect=null;
			String query=null;
			ResultSet rset=null;
			conn=DBConnection.getConnection();
			ArrayList<String> list= new ArrayList<String>();
			
				try
				{
					query = "select userid from userregistration";
					pstmtSelect = conn.prepareStatement(query);
					rset = pstmtSelect.executeQuery();
					while(rset.next())
					{
						list.add(rset.getString("userid"));
					}
					return list;
				}
				catch(SQLException e)
				{
					e.printStackTrace();
					return list;
				}
		
		}


}
	


