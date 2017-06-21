package com.gigabox.admin.cc.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

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

import com.gigabox.admin.cc.service.FaqService;
import com.gigabox.admin.cc.vo.FaqSearchCriteria;
import com.gigabox.admin.cc.vo.FaqVO;
import com.gigabox.admin.common.PageMaker;

@Controller
@RequestMapping("/admin/cc/faq")
public class FaqController {

	@Inject
	private FaqService faqService;

	private static final Logger logger = LoggerFactory.getLogger(FaqController.class);
	
	@RequestMapping(value="/faqMain", method=RequestMethod.GET)
	public String faqListGET(@ModelAttribute("fsc") FaqSearchCriteria fsc, Model model) {
		logger.info("=======================================================");
		logger.info("FAQ MAIN PAGE LOADING...");
		logger.info("INITIAL PAGING= " + fsc.toString());
		logger.info("PAGE START= " + fsc.getPageStart());
		logger.info("PAGE END= " + fsc.getPageEnd());
		
		model.addAttribute("faqList", faqService.faqList(fsc));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(fsc);
		pageMaker.setTotalCount(faqService.faqListCount(fsc));
		model.addAttribute("pageMaker", pageMaker);
		
		logger.info("pageMaker= " + pageMaker.toString());
		
		logger.info("FAQ MAIN PAGE LOADING END");
		logger.info("=======================================================");
		
		return "/cc/faqMain";
	}
	
	@ResponseBody
	@RequestMapping(value="/faqDetail/{faqNumber}", method=RequestMethod.PUT)
	public ResponseEntity<FaqVO> faqDetailRest(@PathVariable("faqNumber") int faqNumber) {
		
		logger.info("=======================================================");
		logger.info("FAQ DETAIL DATA REQUESTED");
		FaqVO selectData = new FaqVO();
		selectData.setFaqNumber(faqNumber);
		FaqVO selectedData = faqService.faqDetail(selectData);
		logger.info("FaqVO= " + selectedData.toString());
		ResponseEntity<FaqVO> selectedUserVO = new ResponseEntity<>(selectedData, HttpStatus.OK);
		
		logger.info("FAQ DETAIL DATA SENT TO JSON");
		logger.info("=======================================================");
		return selectedUserVO;
	}
	
	@ResponseBody
	@RequestMapping(value="/faqInsert", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> faqInsertRest(FaqVO faqVO) {
		logger.info("=======================================================");
		logger.info("FAQ INSERT REQUESTED");
		logger.info("FaqVO= " + faqVO.toString());
		int result = faqService.faqInsert(faqVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("INSERT SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("INSERT FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("FAQ INSERT RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/faqUpdate", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> faqUpdateRest(FaqVO faqVO) {
		
		logger.info("=======================================================");
		logger.info("FAQ UPDATE REQUESTED");
		logger.info("FaqVO= " + faqVO.toString());
		int result = faqService.faqUpdate(faqVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("UPDATE SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("UPDATE FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("FAQ UPDATE RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/faqDelete", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> faqDeleteRest(FaqVO faqVO) {
		
		logger.info("=======================================================");
		logger.info("FAQ DELETE REQUESTED");
		logger.info("FaqVO= " + faqVO.toString());
		int result = faqService.faqDelete(faqVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("DELETE SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("DELETE FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("FAQ DELETE RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
}
