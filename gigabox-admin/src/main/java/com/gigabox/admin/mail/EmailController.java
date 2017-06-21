package com.gigabox.admin.mail;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/user")
public class EmailController {

	@Inject
	private JavaMailSender mailSender;
	
	private final static Logger logger = LoggerFactory.getLogger(EmailController.class);
	
	@ResponseBody
	@RequestMapping(value = "/email", method=RequestMethod.POST) 
	public void sendMail(String userEmailFrom, String userEmailTo, String userEmailTitle, String userEmailContent) { 

		logger.info("=======================================================");
		logger.info("EMAIL SEND START");
		
		logger.info("FROM= " + userEmailFrom);
		logger.info("TO= " + userEmailTo);
		logger.info("TITLE= " + userEmailTitle);
		logger.info("CONTENT= " + userEmailContent);
		
		try { 
			
			MimeMessage message = mailSender.createMimeMessage(); 
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8"); 
			messageHelper.setTo(userEmailTo); 
			messageHelper.setText(userEmailContent, true); 
			messageHelper.setFrom(userEmailFrom); 
			messageHelper.setSubject(userEmailTitle);	
			mailSender.send(message);
			
		} catch(Exception e){ 
			System.out.println(e); 
		} 
		
		logger.info("EMAIL SEND END");
		logger.info("=======================================================");
		
	}
	
}
