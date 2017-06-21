package com.gigabox.admin.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gigabox.admin.common.PageMaker;
import com.gigabox.admin.user.service.UserService;
import com.gigabox.admin.user.vo.UserSearchCriteria;
import com.gigabox.admin.user.vo.UserVO;

@Controller
@RequestMapping("/admin/user")
public class UserController {

	@Inject
	private UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping(value="/userMain", method=RequestMethod.GET)
	public String userListGET(@ModelAttribute("usc") UserSearchCriteria usc, Model model) {
		
		logger.info("=======================================================");
		logger.info("USER MAIN PAGE LOADING...");
		logger.info("INITIAL PAGING= " + usc.toString());
		logger.info("PAGE START= " + usc.getPageStart());
		logger.info("PAGE END= " + usc.getPageEnd());
		logger.info("DATESTART= " + usc.getStartDate());
		logger.info("DATEEND= " + usc.getEndDate());
		
		model.addAttribute("userList", userService.userList(usc));
		logger.info(userService.userList(usc).toString());
		
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(usc);
		pageMaker.setTotalCount(userService.userListCount(usc));
		model.addAttribute("pageMaker", pageMaker);
		
		logger.info("pageMaker= " + pageMaker.toString());
		
		logger.info("USER MAIN PAGE LOADING END");
		logger.info("=======================================================");
		
		return "/user/userMain";
	}
	
	@ResponseBody
	@RequestMapping(value="/userDetail/{userNumber}", method=RequestMethod.PUT)
	public ResponseEntity<UserVO> userDetailRest(@PathVariable("userNumber") int userNumber) {
		
		logger.info("=======================================================");
		logger.info("USER DETAIL DATA REQUESTED");
		UserVO selectData = new UserVO();
		selectData.setUserNumber(userNumber);
		UserVO selectedData = userService.userDetail(selectData);
		logger.info("UserVO= " + selectedData.toString());
		ResponseEntity<UserVO> selectedUserVO = new ResponseEntity<>(selectedData, HttpStatus.OK);
		
		logger.info("USER DETAIL DATA SENT TO JSON");
		logger.info("=======================================================");
		return selectedUserVO;
	}
	
	@ResponseBody
	@RequestMapping(value="/userUpdate", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> userUpdate(HttpServletResponse response, UserVO userVO) throws IOException {
		logger.info("=======================================================");
		logger.info("USER UPDATE PROCESSING...");
		
		logger.info("userVO= " + userVO.toString());
		Map<String, String> resultMap = new HashMap<String, String>();
		int result = userService.userUpdate(userVO);
		if (result == 0) {
			logger.info("USER UPDATE FAILED");
			logger.info("=======================================================");
			
			resultMap.put("result", "회원 수정에 실패하였습니다.");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.BAD_REQUEST);
		}
		resultMap.put("result", "회원 수정에 성공하였습니다.");
		logger.info("USER UPDATE SUCCESSED");
		logger.info("=======================================================");
		return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.CREATED);
	}
	
}
