package com.gigabox.admin.cinema.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.gigabox.admin.cinema.service.BranchService;
import com.gigabox.admin.cinema.vo.BranchSearchCriteria;
import com.gigabox.admin.cinema.vo.BranchVO;
import com.gigabox.admin.common.PageMaker;

@Controller
@RequestMapping("/admin/cinema")
public class BranchController {

	private static final Logger logger = LoggerFactory.getLogger(BranchController.class);
	
	@Inject
	private BranchService branchService;
	
	@RequestMapping(value="/cinemaMain", method=RequestMethod.GET)
	public String noticeListGET(@ModelAttribute("bsc") BranchSearchCriteria bsc, Model model) {
		logger.info("=======================================================");
		logger.info("CINEMA MAIN PAGE LOADING...");
		logger.info("INITIAL PAGING= " + bsc.toString());
		logger.info("PAGE START= " + bsc.getPageStart());
		logger.info("PAGE END= " + bsc.getPageEnd());
		
		model.addAttribute("branchList", branchService.branchList(bsc));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(bsc);
		pageMaker.setTotalCount(branchService.branchListCount(bsc));
		model.addAttribute("pageMaker", pageMaker);
		
		logger.info("pageMaker= " + pageMaker.toString());
		
		logger.info("CINEMA MAIN PAGE LOADING END");
		logger.info("=======================================================");
		
		return "/cinema/cinemaMain";
	}
	
	@ResponseBody
	@RequestMapping(value="/branchDetail/{branchNumber}", method=RequestMethod.PUT)
	public ResponseEntity<BranchVO> branchDetailRest(@PathVariable("branchNumber") int branchNumber) {
		
		logger.info("=======================================================");
		logger.info("NOTICE DETAIL DATA REQUESTED");
		BranchVO selectData = new BranchVO();
		selectData.setBranchNumber(branchNumber);
		BranchVO selectedData = branchService.branchDetail(selectData);
		logger.info("BranchVO= " + selectedData.toString());
		ResponseEntity<BranchVO> selectedBranchVO = new ResponseEntity<>(selectedData, HttpStatus.OK);
		
		logger.info("NOTICE DETAIL DATA SENT TO JSON");
		logger.info("=======================================================");
		return selectedBranchVO;
	}
	
	@ResponseBody
	@RequestMapping(value="/branchInsert", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> branchInsertRest(BranchVO branchVO) {
		logger.info("=======================================================");
		logger.info("BRANCH INSERT REQUESTED");
		logger.info("BranchVO= " + branchVO.toString());
		int result = branchService.branchInsert(branchVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("INSERT SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("INSERT FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("BRANCH INSERT RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/branchUpdate", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> branchUpdateRest(BranchVO branchVO) {
		
		logger.info("=======================================================");
		logger.info("BRANCH UPDATE REQUESTED");
		logger.info("BranchVO= " + branchVO.toString());
		int result = branchService.branchUpdate(branchVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("UPDATE SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("UPDATE FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("BRANCH UPDATE RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/branchnameList", method=RequestMethod.PUT)
	public ResponseEntity<List<BranchVO>> noticeBranchnameList() {
		logger.info("=======================================================");
		logger.info("BRANCHNAME LIST DATA REQUESTED");
		List<BranchVO> selectedList = branchService.branchListAll();
		logger.info("BRANCHNAME LIST= " + selectedList.toString());
		ResponseEntity<List<BranchVO>> selectedVOList = new ResponseEntity<>(selectedList, HttpStatus.OK);
		
		logger.info("BRANCHNAME DATA SENT TO JSON");
		logger.info("=======================================================");
		return selectedVOList;
	}
	
}
