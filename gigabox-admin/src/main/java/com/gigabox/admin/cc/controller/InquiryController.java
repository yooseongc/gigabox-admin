package com.gigabox.admin.cc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gigabox.admin.cc.service.InquiryService;
import com.gigabox.admin.cc.vo.InquirySearchCriteria;
import com.gigabox.admin.cc.vo.InquiryVO;
import com.gigabox.admin.common.PageMaker;
import com.gigabox.admin.user.service.UserService;
import com.gigabox.admin.user.vo.UserVO;

@Controller
@RequestMapping("/admin/cc/qna")
public class InquiryController {

	@Inject
	private InquiryService inquiryService;
	
	@Inject
	private UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(InquiryController.class);
	
	// 본 메소드는 QNA 중 회원의 질문만을 들고오는 메소드이다.
	@Transactional
	@RequestMapping(value="/qnaMain", method=RequestMethod.GET)
	public String inquiryListGET(@ModelAttribute("isc") InquirySearchCriteria isc, Model model) {
		logger.info("=======================================================");
		logger.info("INQUIRY MAIN PAGE LOADING...");
		logger.info("INITIAL PAGING= " + isc.toString());
		logger.info("PAGE START= " + isc.getPageStart());
		logger.info("PAGE END= " + isc.getPageEnd());
		
		List<InquiryVO> inquiryList = inquiryService.inquiryList(isc);
		//logger.info("INQUIRY LIST FIRST ITEM= " + inquiryList.get(0).toString());
		List<Map<String, Object>> inquiryMapList = new ArrayList<>();
		for (InquiryVO eachInquiry : inquiryList) {
			
			// 질문 정보
			Map<String, Object> inquiryMap = new HashMap<>();
			inquiryMap.put("inquiry", eachInquiry);
			
			// 회원 정보
			int userNumber = eachInquiry.getUserNumber();
			UserVO initInquiryUser = new UserVO();
			initInquiryUser.setUserNumber(userNumber);
			UserVO inquiryUser = userService.userDetail(initInquiryUser);
			inquiryMap.put("user", inquiryUser);
			
			// 답변 여부
			InquiryVO answerInquiry = inquiryService.inquiryDetailA(eachInquiry);
			if (answerInquiry == null) {
				// 답변이 없으면 0
				inquiryMap.put("answerExist", new Integer(0));
			} else {
				// 답변이 있으면 1
				inquiryMap.put("answerExist", new Integer(1));
			}
			
			// List에 저장
			inquiryMapList.add(inquiryMap);
		}
		model.addAttribute("inquiryList", inquiryMapList);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(isc);
		pageMaker.setTotalCount(inquiryService.inquiryListCount(isc));
		model.addAttribute("pageMaker", pageMaker);
		
		logger.info("pageMaker= " + pageMaker.toString());
		
		logger.info("INQUIRY MAIN PAGE LOADING END");
		logger.info("=======================================================");
		
		return "/cc/qnaMain";
	}
	
	@Transactional
	@ResponseBody
	@RequestMapping(value="/qnaDetailQ/{inquiryNumber}", method=RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> noticeDetailQRest(@PathVariable("inquiryNumber") int inquiryNumber) {
		
		logger.info("=======================================================");
		logger.info("INQUIRY DETAIL QUESTION DATA REQUESTED");
		InquiryVO selectData = new InquiryVO();
		selectData.setInquiryNumber(inquiryNumber);
		InquiryVO selectedData = inquiryService.inquiryDetailQ(selectData);
		
		// 작성자 정보 가져오기
		int userNumber = selectedData.getUserNumber();
		UserVO userVO = new UserVO();
		userVO.setUserNumber(userNumber);
		UserVO selectedUser = userService.userDetail(userVO);
		userVO.setUserId(selectedUser.getUserId());
		userVO.setUserName(selectedUser.getUserName());
		
		logger.info("InquiryVO= " + selectedData.toString());
		logger.info("UserVO= " + selectedUser.toString());
		
		// 맵
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("inquiry", selectedData);
		resultMap.put("user", userVO);
		ResponseEntity<Map<String, Object>> selectedInquiryEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		
		logger.info("INQUIRY DETAIL QUESTION DATA SENT TO JSON");
		logger.info("=======================================================");
		return selectedInquiryEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/qnaDetailA/{inquiryGroupnumber}", method=RequestMethod.PUT)
	public ResponseEntity<InquiryVO> noticeDetailARest(@PathVariable("inquiryGroupnumber") int inquiryGroupnumber) {
		
		logger.info("=======================================================");
		logger.info("INQUIRY DETAIL ANSWER DATA REQUESTED");
		InquiryVO selectData = new InquiryVO();
		selectData.setInquiryGroupnumber(inquiryGroupnumber);
		InquiryVO selectedData = inquiryService.inquiryDetailA(selectData);
		logger.info("InquiryVO= " + selectedData.toString());
		ResponseEntity<InquiryVO> selectedInquiryEntity = new ResponseEntity<>(selectedData, HttpStatus.OK);
		
		logger.info("INQUIRY DETAIL ANSWER DATA SENT TO JSON");
		logger.info("=======================================================");
		return selectedInquiryEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/qnaInsertA", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> inquiryInsertARest(InquiryVO inquiryVO) {
		logger.info("=======================================================");
		logger.info("INQUIRY ANSWER INSERT REQUESTED");
		logger.info("InquiryVO= " + inquiryVO.toString());
		int result = inquiryService.inquiryInsertA(inquiryVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("INSERT SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("INSERT FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("INQUIRY ANSWER INSERT RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/qnaUpdateA", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> inquiryUpdateARest(InquiryVO inquiryVO) {
		
		logger.info("=======================================================");
		logger.info("INQUIRY ANSWER UPDATE REQUESTED");
		logger.info("InquiryVO= " + inquiryVO.toString());
		int result = inquiryService.inquiryUpdateA(inquiryVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("UPDATE SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("UPDATE FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("INQUIRY ANSWER UPDATE RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/qnaDeleteA", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> inquiryDeleteARest(InquiryVO inquiryVO) {
		
		logger.info("=======================================================");
		logger.info("INQUIRY ANSWER DELETE REQUESTED");
		logger.info("InquiryVO= " + inquiryVO.toString());
		int result = inquiryService.inquiryDeleteA(inquiryVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("DELETE SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("DELETE FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("INQUIRY ANSWER DELETE RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	
}
