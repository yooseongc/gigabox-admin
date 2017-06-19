package com.gigabox.admin.admin.controller;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gigabox.admin.admin.dto.LoginDTO;
import com.gigabox.admin.admin.service.AdminService;
import com.gigabox.admin.admin.vo.AdminVO;
import com.gigabox.admin.enc.utils.BCrypt;
import com.gigabox.admin.enc.utils.SHA256;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Inject
	private AdminService adminService;
	
	@RequestMapping(value="/auth/login", method=RequestMethod.GET)
	public String loginGET(@ModelAttribute("loginDTO") LoginDTO loginDTO) {
		logger.info("LOGIN PAGE LOADING...");
		return "/admin/login";
	}
	
	@ResponseBody
	@RequestMapping(value="/auth/login", method=RequestMethod.POST,produces = "application/json")
	public ResponseEntity<Map<String, Object>> loginPOST(LoginDTO loginDTO, HttpSession session) {
		logger.info("LOGIN PROCESSING...");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		logger.info("LOGIN... " + loginDTO.toString());
		
		// 1. 아이디 존재 체크
		AdminVO idCheckAdminVO = new AdminVO();
		idCheckAdminVO.setAdminId(loginDTO.getAdminId());
		idCheckAdminVO.setAdminPw(loginDTO.getAdminPw());
		int idCheckResult = adminService.idCheck(idCheckAdminVO);
		if (idCheckResult == 0) {
			// 해당 계정이 존재하지 않음.
			logger.info("ACCOUNT (" + loginDTO.getAdminId() + ") NOT EXISTS.");
			
			
			resultMap.put("idCheckResult", idCheckResult);
			resultMap.put("message", "ID-MISSING");
			
			return new ResponseEntity<Map<String, Object>> (resultMap, HttpStatus.OK);
			
		} else {
			// 해당 계정이 존재.
			// 2. 비밀번호 확인
			logger.info("ACCOUNT (" + loginDTO.getAdminId() + ") EXISTS.");
			logger.info("PASSWORD CHECKING PROCEED...");
			
			String orgPass = loginDTO.getAdminPw();
			try {
				
				SHA256 sha = SHA256.getInsatnce();
				String shaPass = sha.getSha256(orgPass.getBytes());
				logger.info(adminService.login(loginDTO).toString());
				String dbPass = adminService.login(loginDTO).getAdminPw();
				boolean pwCheckResult = BCrypt.checkpw(shaPass, dbPass);
				if (pwCheckResult) {
					// 비밀번호 일치
					logger.info("LOGIN SUCCESS (" + loginDTO.getAdminId() + ")");
					resultMap.put("pwCheckResult", 1);
					resultMap.put("message", "LOGIN-SUCCESS");
					
					// 자동 로그인 처리
					if (loginDTO.isUseCookie()) {
						int amount = 60 * 60 * 24 * 7; // 1주일
						Date sessionLimit = new Date(System.currentTimeMillis() + 1000 * amount);
						logger.info("AUTO LOGIN...");
						adminService.autoLogin(loginDTO.getAdminId(), session.getId(), sessionLimit);
						logger.info("AUTO LOGIN SUCCESSED");
					}
					
					return new ResponseEntity<Map<String, Object>> (resultMap, HttpStatus.OK);
				} else {
					// 비밀번호 불일치
					logger.info("LOGIN FAILED (" + loginDTO.getAdminId() + ")");
					resultMap.put("pwCheckResult", 0);
					resultMap.put("message", "PW-WRONG");
					return new ResponseEntity<Map<String, Object>> (resultMap, HttpStatus.OK);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.info("LOGIN PROCESS - ERROR");
				resultMap.put("message", "ERROR");
				return new ResponseEntity<Map<String, Object>> (resultMap, HttpStatus.OK);
			}
			
		}
		
	}
	
	@RequestMapping(value="/auth/loginSession", method=RequestMethod.POST)
	public String loginSessionCreation(LoginDTO dto, HttpSession session, Model model) {
		logger.info("LOGIN PROCESS - Create Session");
		AdminVO adminVO = new AdminVO();
		adminVO.setAdminId(dto.getAdminId());
		model.addAttribute("adminVO", adminVO);
		return "/admin/loginSession";
	}
	
	@RequestMapping(value="/auth/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		logger.info("LOGOUT PROCESS - Remove Session and Cookie");
		adminService.autoLogin(((AdminVO) session.getAttribute("login")).getAdminId(), "none", new Date(System.currentTimeMillis()));
		session.removeAttribute("login");
		return "redirect:/admin/auth/login";
	}
	
}
