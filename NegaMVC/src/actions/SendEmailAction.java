package actions;

import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import dao.EmailDao;

public class SendEmailAction implements Action{ //post

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			EmailDao eDao = new EmailDao();
		
			int a = 0;
			double dValue = Math.random();
		    int iValue = (int)(dValue * 1000000);
		    String sValue = Integer.toString(iValue);
			response.setContentType("application/json; charset=UTF-8");
		    PrintWriter out = response.getWriter();
		    JSONObject obj = new JSONObject();
		    String host     = "smtp.google.com";
		    final String user   = "pjh211pjh@gmail.com";
		    final String password  = "wxecrvtbyn!";
		    
		    String to = request.getParameter("email4");
		    // Get the session object
		    Properties props = new Properties();
		    props.put("mail.smtp.host", host);
		    props.put("mail.smtp.auth", "true");

		    Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
		    	protected PasswordAuthentication getPasswordAuthentication() {
		    		return new PasswordAuthentication(user, password);
		    	}
		  });
		    
		  // Compose the message
		  try {
		   MimeMessage message = new MimeMessage(session);
		   message.setFrom(new InternetAddress(user));
		   message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

		   // Subject
		   message.setSubject("메가박스, 인증번호");
		   
		   // Text
		   message.setText(sValue);

		   // send the message
		   Transport.send(message);
		   System.out.println("message sent successfully... 스펨함을 확인하세요");
		   a = 1;
		   
		  } catch (MessagingException e) {
		   e.printStackTrace();
		   a = 0;
		  }
		  obj.put("result", a);
		  out.print(obj);
		  
		  
		  eDao.deleteUsedEmailNumber(to);
		  eDao.insertEmailNumber(to, sValue);
	}

}
