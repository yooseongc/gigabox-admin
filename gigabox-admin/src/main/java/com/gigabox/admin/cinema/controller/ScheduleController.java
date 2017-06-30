package com.gigabox.admin.cinema.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.gigabox.admin.cinema.service.MovieroomService;
import com.gigabox.admin.cinema.service.ScheduleService;
import com.gigabox.admin.cinema.vo.BranchVO;
import com.gigabox.admin.cinema.vo.MovieroomVO;
import com.gigabox.admin.cinema.vo.ScheduleSearchCriteria;
import com.gigabox.admin.cinema.vo.ScheduleVO;
import com.gigabox.admin.common.PageMaker;
import com.gigabox.admin.movie.service.MovieService;

@Controller
@RequestMapping("/admin/cinema")
public class ScheduleController {
	
	private static final Logger logger = LoggerFactory.getLogger(ScheduleController.class);
	
	@Inject
	private BranchService branchService;
	
	@Inject
	private MovieroomService movieroomService;
	
	@Inject
	private ScheduleService scheduleService;
	
	
	@RequestMapping(value="/branch/{branchNumber}/schedule", method=RequestMethod.GET)
	public String scheduleInfoByBranch(@PathVariable int branchNumber, Model model, 
			@ModelAttribute ScheduleSearchCriteria ssc, 
			String scheduleStartStr, String scheduleEndStr) throws ParseException {
		logger.info("=====================================================");
		logger.info("SCHEDULE PAGE START");
		logger.info("SCHEDULE - BRANCH NUMBER= " + branchNumber);
		ssc.setBranchNumber(branchNumber);
		
		logger.info("SCHEDULE STR= " + scheduleStartStr + ", " + scheduleEndStr);
		
		// Str -> DATE
		if (scheduleStartStr != null && scheduleEndStr != null 
				&& !"".equals(scheduleStartStr) && !"".equals(scheduleEndStr)) {
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date scheduleStart = transFormat.parse(scheduleStartStr);
			Date scheduleEnd = transFormat.parse(scheduleEndStr);
			ssc.setScheduleStart(scheduleStart);
			ssc.setScheduleEnd(scheduleEnd);
		}
		
		logger.info("ScheduleSearchCriteria= " + ssc.toString());
		
		BranchVO branchVO = new BranchVO();
		branchVO.setBranchNumber(branchNumber);
		
		model.addAttribute("branchInfo", branchService.branchDetail(branchVO));
		model.addAttribute("scheduleList", scheduleService.scheduleList(ssc));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(ssc);
		pageMaker.setTotalCount(scheduleService.scheduleListCount(ssc));
		logger.info("LIST COUNT= " + scheduleService.scheduleListCount(ssc));
		model.addAttribute("pageMaker", pageMaker);
		
		logger.info("pageMaker= " + pageMaker.toString());
		
		for (ScheduleVO vo : scheduleService.scheduleList(ssc)) {
			logger.info(vo.toString());
		}
		
		logger.info("SCHEDULE PAGE END");
		logger.info("=====================================================");
		return "/cinema/cinemaSchedule";
	}
	
	@ResponseBody
	@RequestMapping(value="/movieroom/{movieroomNumber}/schedule", method=RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> scheduleInfoByMovieroom(@PathVariable int movieroomNumber, 
			ScheduleSearchCriteria ssc) {
		logger.info("=====================================================");
		logger.info("SCHEDULE PAGE START");
		logger.info("SCHEDULE - MOVIEROOM NUMBER= " + movieroomNumber);
		ssc.setMovieroomNumber(movieroomNumber);
		ssc.setPerPageNum(200);
		ssc.setMovieStatus("상영중"); 	// 상영중인 영화만 보여준다.
		logger.info("ScheduleSearchCriteria= " + ssc.toString());
		
		MovieroomVO movieroomVO = new MovieroomVO();
		movieroomVO.setMovieroomNumber(movieroomNumber);
		
		MovieroomVO movieroomInfo = movieroomService.movieroomDetail(movieroomVO);
		List<ScheduleVO> scheduleList = scheduleService.scheduleList(ssc);
		for (ScheduleVO vo : scheduleList) {
			logger.info(vo.toString());
		}
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("movieroomInfo", movieroomInfo);
		resultMap.put("scheduleList", scheduleList);
		
		ResponseEntity<Map<String, Object>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("SCHEDULE LIST RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/scheduleInsert", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> scheduleInsertRest(@ModelAttribute ScheduleVO scheduleVO, 
			String scheduleStartStr, String scheduleEndStr) throws ParseException {
		logger.info("=======================================================");
		logger.info("SCHEDULE INSERT REQUESTED"); 
		logger.info("ScheduleVO= " + scheduleVO.toString());
		
		// Str -> DATE
		if (scheduleStartStr != null && scheduleEndStr != null) {
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Date scheduleStart = transFormat.parse(scheduleStartStr);
			Date scheduleEnd = transFormat.parse(scheduleEndStr);
			scheduleVO.setScheduleStart(scheduleStart);
			scheduleVO.setScheduleEnd(scheduleEnd);
		}
		
		int result = scheduleService.scheduleInsert(scheduleVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("INSERT SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("INSERT FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("SCHEDULE INSERT RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	/*@ResponseBody
	@RequestMapping(value="/scheduleDetail/{scheduleNumber}", method=RequestMethod.PUT)
	public ResponseEntity<ScheduleVO> scheduleDetailRest(@PathVariable("scheduleNumber") int scheduleNumber) {
		
		logger.info("=======================================================");
		logger.info("SCHEDULE DETAIL DATA REQUESTED");
		ScheduleVO selectData = new ScheduleVO();
		selectData.setScheduleNumber(scheduleNumber);
		ScheduleVO selectedData = scheduleService.scheduleDetail(selectData);
		logger.info("ScheduleVO= " + selectedData.toString());
		ResponseEntity<ScheduleVO> selectedScheduleVO = new ResponseEntity<>(selectedData, HttpStatus.OK);
		
		logger.info("SCHEDULE DETAIL DATA SENT TO JSON");
		logger.info("=======================================================");
		return selectedScheduleVO;
	}
	
	@ResponseBody
	@RequestMapping(value="/scheduleUpdate", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> scheduleUpdateRest(ScheduleVO scheduleVO) {
		
		logger.info("=======================================================");
		logger.info("SCHEDULE UPDATE REQUESTED");
		logger.info("ScheduleVO= " + scheduleVO.toString());
		if (scheduleVO.getSchedule2D() == null) {
			scheduleVO.setSchedule2D("N");
		} else if (scheduleVO.getSchedule3D() == null) {
			scheduleVO.setSchedule3D("N");
		} else if (scheduleVO.getSchedule4D() == null) {
			scheduleVO.setSchedule4D("N");  
		}
		int result = scheduleService.scheduleUpdate(scheduleVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("UPDATE SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("UPDATE FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("SCHEDULE UPDATE RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}*/
	
}
