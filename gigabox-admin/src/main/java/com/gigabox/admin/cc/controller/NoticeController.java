package com.gigabox.admin.cc.controller;

import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gigabox.admin.cc.service.NoticeService;
import com.gigabox.admin.cc.vo.NoticeSearchCriteria;
import com.gigabox.admin.cc.vo.NoticeVO;
import com.gigabox.admin.cinema.persistence.BranchDAO;
import com.gigabox.admin.cinema.vo.BranchVO;
import com.gigabox.admin.common.PageMaker;

@Controller
@RequestMapping("/admin/cc/notice")
public class NoticeController {

	@Inject
	private NoticeService noticeService;
	
	@Inject
	private BranchDAO branchDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@RequestMapping(value="/noticeMain", method=RequestMethod.GET)
	public String noticeListGET(@ModelAttribute("nsc") NoticeSearchCriteria nsc, Model model) {
		logger.info("=======================================================");
		logger.info("NOTICE MAIN PAGE LOADING...");
		logger.info("INITIAL PAGING= " + nsc.toString());
		logger.info("PAGE START= " + nsc.getPageStart());
		logger.info("PAGE END= " + nsc.getPageEnd());
		
		model.addAttribute("noticeList", noticeService.noticeList(nsc));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(nsc);
		pageMaker.setTotalCount(noticeService.noticeListCount(nsc));
		model.addAttribute("pageMaker", pageMaker);
		
		logger.info("pageMaker= " + pageMaker.toString());
		
		logger.info("NOTICE MAIN PAGE LOADING END");
		logger.info("=======================================================");
		
		return "/cc/noticeMain";
	}
	
	@ResponseBody
	@RequestMapping(value="/noticeDetail/{noticeNumber}", method=RequestMethod.PUT)
	public ResponseEntity<NoticeVO> noticeDetailRest(@PathVariable("noticeNumber") int noticeNumber) {
		
		logger.info("=======================================================");
		logger.info("NOTICE DETAIL DATA REQUESTED");
		NoticeVO selectData = new NoticeVO();
		selectData.setNoticeNumber(noticeNumber);
		NoticeVO selectedData = noticeService.noticeDetail(selectData);
		logger.info("NoticeVO= " + selectedData.toString());
		ResponseEntity<NoticeVO> selectedUserVO = new ResponseEntity<>(selectedData, HttpStatus.OK);
		
		logger.info("NOTICE DETAIL DATA SENT TO JSON");
		logger.info("=======================================================");
		return selectedUserVO;
	}
	
	@ResponseBody
	@RequestMapping(value="/noticeInsert", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> noticeInsertRest(NoticeVO noticeVO) {
		logger.info("=======================================================");
		logger.info("NOTICE INSERT REQUESTED");
		logger.info("NoticeVO= " + noticeVO.toString());
		int result = noticeService.noticeInsert(noticeVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("INSERT SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("INSERT FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("NOTICE INSERT RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/noticeUpdate", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> noticeUpdateRest(NoticeVO noticeVO) {
		
		logger.info("=======================================================");
		logger.info("NOTICE UPDATE REQUESTED");
		logger.info("NoticeVO= " + noticeVO.toString());
		int result = noticeService.noticeUpdate(noticeVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("UPDATE SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("UPDATE FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("NOTICE UPDATE RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/noticeDelete", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> noticeDeleteRest(NoticeVO noticeVO) {
		
		logger.info("=======================================================");
		logger.info("NOTICE DELETE REQUESTED");
		logger.info("NoticeVO= " + noticeVO.toString());
		int result = noticeService.noticeDelete(noticeVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("DELETE SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("DELETE FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("NOTICE DELETE RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/branchnameList", method=RequestMethod.PUT)
	public ResponseEntity<List<BranchVO>> noticeBranchnameList() {
		logger.info("=======================================================");
		logger.info("NOTICE BRANCHNAME LIST DATA REQUESTED");
		List<BranchVO> selectedList = branchDAO.branchListAll();
		logger.info("BRANCHNAME LIST= " + selectedList.toString());
		ResponseEntity<List<BranchVO>> selectedVOList = new ResponseEntity<>(selectedList, HttpStatus.OK);
		
		logger.info("NOTICE BRANCHNAME DATA SENT TO JSON");
		logger.info("=======================================================");
		return selectedVOList;
	}
	
}
