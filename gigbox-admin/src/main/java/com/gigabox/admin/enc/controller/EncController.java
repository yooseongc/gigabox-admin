package com.gigabox.admin.enc.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gigabox.admin.admin.vo.AdminVO;
import com.gigabox.admin.enc.service.EncService;
import com.gigabox.admin.enc.utils.BCrypt;
import com.gigabox.admin.enc.utils.SHA256;

@Controller("/admin/enc")
public class EncController {
	
	private static final Logger logger = LoggerFactory.getLogger(EncController.class);
	
	@Inject
	private EncService encService;
	
	@RequestMapping(value="/admin/enc/encForm", method=RequestMethod.GET)
	public String encFormGET() {
		logger.info("ENCFORM PAGE LOADING...");
		return "/enc/encForm";
	}
	
	@Transactional
	@RequestMapping(value="/admin/enc/encForm", method=RequestMethod.POST)
	public String encFormPOST(Model model, AdminVO adminVO) {
		logger.info("ENCFORM PAGE PROCESSING...");
		logger.info("SUBMITTED DATA: " + adminVO.toString());
		
		int idCheckResult = encService.idCheck(adminVO);
		logger.info("ID CHECK RESULT= " + idCheckResult);
		
		if (idCheckResult == 0) {
			// 해당 아이디가 없는 경우
			logger.info("ID CHECK : " + adminVO.getAdminId() + " DOES NOT EXIST!");
			model.addAttribute("idCheckResult", idCheckResult);
			model.addAttribute("adminId", adminVO.getAdminId());
		} else {
			// 해당 아이디가 존재하는 경우
			logger.info("ID CHECK : " + adminVO.getAdminId() + " EXISTS!");
			
			int pwEncryptionCheckResult = encService.pwEncryptionCheck(adminVO);
			logger.info("PW ENCRYPTION CHECK RESULT= " + pwEncryptionCheckResult);
			
			int pwEncryptionResult = 0;
			
			if (pwEncryptionCheckResult == 1) {
				// 암호화 적용
				String orgPass = adminVO.getAdminPw();
				
				String shaPass = "";
				try {
					SHA256 sha = SHA256.getInsatnce();
					shaPass = sha.getSha256(orgPass.getBytes());
					String bcPass = BCrypt.hashpw(shaPass, BCrypt.gensalt());
					adminVO.setAdminPw(bcPass);
					pwEncryptionResult = encService.pwEncryptionExec(adminVO);
					
					logger.info("PW ENCRYPTION RESULT= " + pwEncryptionResult);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			} else {
				// 이미 암호화가 된 경우
				// pwEncryptionResult = 0 이 된다.
				logger.info("PW ENCRYPTION CHECK : " + adminVO.getAdminId() + " ALREADY ENCRYPTIZED!");
			}
			model.addAttribute("idCheckResult", idCheckResult);
			model.addAttribute("adminId", adminVO.getAdminId());
			model.addAttribute("encCheckResult", pwEncryptionCheckResult);
			model.addAttribute("encResult", pwEncryptionResult);
			
		}
		
		logger.info("ENCFORM PROCESS FINISHED -- GO TO encResult.jsp");
		return "/enc/encResult";
	}
	
}
