package com.gigabox.admin.cc.controller;

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

import com.gigabox.admin.cc.service.NoticeService;
import com.gigabox.admin.cc.vo.NoticeSearchCriteria;
import com.gigabox.admin.cc.vo.NoticeVO;
import com.gigabox.admin.common.PageMaker;

@Controller
@RequestMapping("/admin/cc/notice")
public class NoticeController {

	@Inject
	private NoticeService noticeService;
	
	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);
	
	@RequestMapping(value="/noticeMain", method=RequestMethod.GET)
	public String noticeListGET(@ModelAttribute("nsc") NoticeSearchCriteria nsc, Model model) {
		logger.info("=======================================================");
		logger.info("NOTICE MAIN PAGE LOADING...");
		logger.info("INITIAL PAGING= " + nsc.toString());
		logger.info("PAGE START= " + nsc.getPageStart());
		logger.info("PAGE END= " + nsc.getPageEnd());
		
		model.addAttribute("noticeList", noticeService.noticeList(nsc));
		logger.info(noticeService.noticeList(nsc).toString());
		
		
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
	
	
	
}
