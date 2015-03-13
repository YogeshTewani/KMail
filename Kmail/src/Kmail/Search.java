package Kmail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Search
{
  ArrayList<Integer> messageId = new ArrayList<Integer>();
  ArrayList<String> receiver = new ArrayList<String>();
  ArrayList<String> sender = new ArrayList<String>();
  ArrayList<String> viewStatus = new ArrayList<String>();
  ArrayList<String> mailHeader = new ArrayList<String>();
  ArrayList<String> message = new ArrayList<String>();
  ArrayList<String> subject = new ArrayList<String>();
  ArrayList<String> msgDateTime = new ArrayList<String>();

  public ArrayList<Integer> getMessageId()
  {
    return this.messageId;
  }

  public ArrayList<String> getReceiver()
  {
    return this.receiver;
  }

  public ArrayList<String> getSender()
  {
    return this.sender;
  }

  public ArrayList<String> getViewStatus()
  {
    for (int i = 0; i < this.viewStatus.size(); i++)
      System.out.println((String)this.viewStatus.get(i));
    return this.viewStatus;
  }

  public ArrayList<String> getMailHeader()
  {
    return this.mailHeader;
  }

  public ArrayList<String> getMessage()
  {
    return this.message;
  }

  public ArrayList<String> getSubject()
  {
    return this.subject;
  }

  public ArrayList<String> getMsgDateTime()
  {
    return this.msgDateTime;
  }

  public String searchInbox(String searchQuery, String currentId)
    throws Exception
  {
    Connection conn = null;
    conn = DBConnection.getConnection();
    conn.setAutoCommit(false);

    PreparedStatement pstmtSelect = null;
    String query = null;
    ResultSet rset = null;
    String m = "";

    ArrayList<Integer> tempMsgId = new ArrayList<Integer>();
    try
    {
      query = "select * from inbox where receiver=?";
      pstmtSelect = conn.prepareStatement(query);
      pstmtSelect.setString(1, currentId);
      rset = pstmtSelect.executeQuery();
      while (rset.next())
      {
        tempMsgId.add(Integer.valueOf(rset.getInt(1)));

        if ((rset.getString("sender").contains(searchQuery)) || (searchQuery.contains(rset.getString("sender"))))
        {
          if (!this.messageId.contains(Integer.valueOf(rset.getInt(1))))
          {
            this.messageId.add(Integer.valueOf(rset.getInt(1)));
          }
        }

        if ((!rset.getString("receiver").contains(searchQuery)) && (!searchQuery.contains(rset.getString("receiver"))))
          continue;
        if (this.messageId.contains(Integer.valueOf(rset.getInt(1))))
          continue;
        this.messageId.add(Integer.valueOf(rset.getInt(1)));
      }

      if (tempMsgId.size() != 0)
      {
        for (int i = 0; i < tempMsgId.size(); i++)
        {
          query = "select * from message where MessageId=?";
          pstmtSelect = conn.prepareStatement(query);
          pstmtSelect.setInt(1, ((Integer)tempMsgId.get(i)).intValue());
          rset = pstmtSelect.executeQuery();

          while (rset.next())
          {
            if ((rset.getString("message").contains(searchQuery)) || (searchQuery.contains(rset.getString("message"))))
            {
              if (!this.messageId.contains(Integer.valueOf(rset.getInt(1))))
              {
                this.messageId.add(Integer.valueOf(rset.getInt(1)));
              }
            }

            if ((!rset.getString("subject").contains(searchQuery)) && (!searchQuery.contains(rset.getString("subject"))))
              continue;
            if (this.messageId.contains(Integer.valueOf(rset.getInt(1))))
              continue;
            this.messageId.add(Integer.valueOf(rset.getInt(1)));
          }

        }

      }

      if (this.messageId.size() == 0)
      {
        m = "No records Found";
      }
      else
      {
        m = "Records Found";

        for (int i = 0; i < this.messageId.size(); i++)
        {
          query = "select * from inbox where receiver=? and MessageId=?";
          pstmtSelect = conn.prepareStatement(query);
          pstmtSelect.setString(1, currentId);
          pstmtSelect.setInt(2, ((Integer)this.messageId.get(i)).intValue());
          rset = pstmtSelect.executeQuery();

          while (rset.next())
          {
            this.sender.add(rset.getString(3));
            this.viewStatus.add(rset.getString(4));
          }

          query = "select * from message where MessageId=?";
          pstmtSelect = conn.prepareStatement(query);
          pstmtSelect.setInt(1, ((Integer)this.messageId.get(i)).intValue());
          rset = pstmtSelect.executeQuery();

          while (rset.next())
          {
            this.subject.add(rset.getString(2));

            this.msgDateTime.add(rset.getString(4));
          }
        }
      }
    }
    catch (Exception e) {
      e.printStackTrace();
    }

    return m;
  }

  public String searchOutbox(String searchQuery, String currentId)
    throws Exception
  {
    Connection conn = null;
    conn = DBConnection.getConnection();
    conn.setAutoCommit(false);

    PreparedStatement pstmtSelect = null;
    String query = null;
    ResultSet rset = null;
    String m = "";

    ArrayList<Integer> tempMsgId = new ArrayList<Integer>();
    ArrayList<Integer> tempMsgId1 = new ArrayList<Integer>();
    try
    {
      query = "select * from outbox where sender=?";
      pstmtSelect = conn.prepareStatement(query);
      pstmtSelect.setString(1, currentId);
      rset = pstmtSelect.executeQuery();
      while (rset.next())
      {
        tempMsgId.add(Integer.valueOf(rset.getInt(1)));

        if ((rset.getString("sender").contains(searchQuery)) || (searchQuery.contains(rset.getString("sender"))))
        {
          if (!tempMsgId1.contains(Integer.valueOf(rset.getInt(1))))
          {
            tempMsgId1.add(Integer.valueOf(rset.getInt(1)));
          }
        }

        if ((!rset.getString("receiver").contains(searchQuery)) && (!searchQuery.contains(rset.getString("receiver"))))
          continue;
        if (tempMsgId1.contains(Integer.valueOf(rset.getInt(1))))
          continue;
        tempMsgId1.add(Integer.valueOf(rset.getInt(1)));
      }

      if (tempMsgId.size() != 0)
      {
        for (int i = 0; i < tempMsgId.size(); i++)
        {
          query = "select * from message where MessageId=?";
          pstmtSelect = conn.prepareStatement(query);
          pstmtSelect.setInt(1, ((Integer)tempMsgId.get(i)).intValue());
          rset = pstmtSelect.executeQuery();

          while (rset.next())
          {
            if ((rset.getString("message").contains(searchQuery)) || (searchQuery.contains(rset.getString("message"))))
            {
              if (!tempMsgId1.contains(Integer.valueOf(rset.getInt(1))))
              {
                tempMsgId1.add(Integer.valueOf(rset.getInt(1)));
              }
            }

            if ((!rset.getString("subject").contains(searchQuery)) && (!searchQuery.contains(rset.getString("subject"))))
              continue;
            if (tempMsgId1.contains(Integer.valueOf(rset.getInt(1))))
              continue;
            tempMsgId1.add(Integer.valueOf(rset.getInt(1)));
          }

        }

      }

      if (tempMsgId1.size() == 0)
      {
        m = "No records Found";
      }
      else
      {
        m = "Records Found";

        for (int i = 0; i < tempMsgId1.size(); i++)
        {
          query = "select * from outbox where sender=? and MessageId=?";
          pstmtSelect = conn.prepareStatement(query);
          pstmtSelect.setString(1, currentId);
          pstmtSelect.setInt(2, ((Integer)tempMsgId1.get(i)).intValue());
          rset = pstmtSelect.executeQuery();

          while (rset.next())
          {
            if (this.messageId.contains(Integer.valueOf(rset.getInt(1))))
              continue;
            this.messageId.add(Integer.valueOf(rset.getInt(1)));
            String r = "";
            query = "select * from outbox where MessageId=?";
            pstmtSelect = conn.prepareStatement(query);
            pstmtSelect.setInt(1, rset.getInt(1));
            ResultSet rset1 = pstmtSelect.executeQuery();
            while (rset1.next())
            {
              if ((r.equals("")) || (r == null))
              {
                r = rset1.getString("receiver");
              }
              else
              {
                r = r + "," + rset1.getString("receiver");
              }
            }

            this.receiver.add(r);
          }

        }

        for (int i = 0; i < this.messageId.size(); i++)
        {
          query = "select * from message where MessageId=?";
          pstmtSelect = conn.prepareStatement(query);
          pstmtSelect.setInt(1, ((Integer)this.messageId.get(i)).intValue());
          rset = pstmtSelect.executeQuery();

          while (rset.next())
          {
            this.subject.add(rset.getString(2));

            this.msgDateTime.add(rset.getString(4));
          }
        }
      }
    }
    catch (Exception e) {
      e.printStackTrace();
    }

    return m;
  }

  public String searchDrafts(String searchQuery, String currentId)
    throws Exception
  {
    Connection conn = null;
    conn = DBConnection.getConnection();
    conn.setAutoCommit(false);

    PreparedStatement pstmtSelect = null;
    String query = null;
    ResultSet rset = null;
    String m = "";

    ArrayList<Integer> tempMsgId = new ArrayList<Integer>();
    ArrayList<Integer> tempMsgId1 = new ArrayList<Integer>();
    try
    {
      query = "select * from draft where receiver=?";
      pstmtSelect = conn.prepareStatement(query);
      pstmtSelect.setString(1, currentId);
      rset = pstmtSelect.executeQuery();
      while (rset.next())
      {
        tempMsgId.add(Integer.valueOf(rset.getInt(1)));

        if ((rset.getString("sender").contains(searchQuery)) || (searchQuery.contains(rset.getString("sender"))))
        {
          if (!tempMsgId1.contains(Integer.valueOf(rset.getInt(1))))
          {
            tempMsgId1.add(Integer.valueOf(rset.getInt(1)));
          }
        }

        if ((!rset.getString("receiver").contains(searchQuery)) && (!searchQuery.contains(rset.getString("receiver"))))
          continue;
        if (tempMsgId1.contains(Integer.valueOf(rset.getInt(1))))
          continue;
        tempMsgId1.add(Integer.valueOf(rset.getInt(1)));
      }

      if (tempMsgId.size() != 0)
      {
        for (int i = 0; i < tempMsgId.size(); i++)
        {
          query = "select * from message where MessageId=?";
          pstmtSelect = conn.prepareStatement(query);
          pstmtSelect.setInt(1, ((Integer)tempMsgId.get(i)).intValue());
          rset = pstmtSelect.executeQuery();

          while (rset.next())
          {
            if ((rset.getString("message").contains(searchQuery)) || (searchQuery.contains(rset.getString("message"))))
            {
              if (!tempMsgId1.contains(Integer.valueOf(rset.getInt(1))))
              {
                tempMsgId1.add(Integer.valueOf(rset.getInt(1)));
              }
            }

            if ((!rset.getString("subject").contains(searchQuery)) && (!searchQuery.contains(rset.getString("subject"))))
              continue;
            if (tempMsgId1.contains(Integer.valueOf(rset.getInt(1))))
              continue;
            tempMsgId1.add(Integer.valueOf(rset.getInt(1)));
          }

        }

      }

      if (tempMsgId1.size() == 0)
      {
        m = "No records Found";
      }
      else
      {
        m = "Records Found";

        for (int i = 0; i < tempMsgId1.size(); i++)
        {
          query = "select * from draft where sender=? and MessageId=?";
          pstmtSelect = conn.prepareStatement(query);
          pstmtSelect.setString(1, currentId);
          pstmtSelect.setInt(2, ((Integer)tempMsgId1.get(i)).intValue());
          rset = pstmtSelect.executeQuery();

          while (rset.next())
          {
            if (this.messageId.contains(Integer.valueOf(rset.getInt(1))))
              continue;
            this.messageId.add(Integer.valueOf(rset.getInt(1)));
            String r = "";
            query = "select * from draft where MessageId=?";
            pstmtSelect = conn.prepareStatement(query);
            pstmtSelect.setInt(1, rset.getInt(1));
            ResultSet rset1 = pstmtSelect.executeQuery();
            while (rset1.next())
            {
              if ((r.equals("")) || (r == null))
              {
                r = rset1.getString("receiver");
              }
              else
              {
                r = r + "," + rset1.getString("receiver");
              }
            }

            this.receiver.add(r);
          }

        }

        for (int i = 0; i < this.messageId.size(); i++)
        {
          query = "select * from message where MessageId=?";
          pstmtSelect = conn.prepareStatement(query);
          pstmtSelect.setInt(1, ((Integer)this.messageId.get(i)).intValue());
          rset = pstmtSelect.executeQuery();

          while (rset.next())
          {
            this.subject.add(rset.getString(2));

            this.msgDateTime.add(rset.getString(4));
          }
        }
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }

    return m;
  }
}