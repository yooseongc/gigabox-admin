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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gigabox.admin.cinema.service.BranchService;
import com.gigabox.admin.cinema.service.MovieroomService;
import com.gigabox.admin.cinema.vo.BranchVO;
import com.gigabox.admin.cinema.vo.MovieroomVO;

@Controller
@RequestMapping("/admin/cinema")
public class MovieroomController {
	
	private static final Logger logger = LoggerFactory.getLogger(MovieroomController.class);
	
	@Inject
	private BranchService branchService;
	
	@Inject
	private MovieroomService movieroomService;
	
	
	@RequestMapping(value="/{branchNumber}/movieroom", method=RequestMethod.GET)
	public String movieroomInfoGET(@PathVariable int branchNumber, Model model) {
		logger.info("=====================================================");
		logger.info("MOVIEROOM PAGE START");
		logger.info("MOVIEROOM - BRANCH NUMBER= " + branchNumber);
		
		BranchVO branchVO = new BranchVO();
		branchVO.setBranchNumber(branchNumber);
		
		model.addAttribute("branchInfo", branchService.branchDetail(branchVO));
		model.addAttribute("movieroomList", movieroomService.movieroomList(branchNumber));
		for (MovieroomVO vo : movieroomService.movieroomList(branchNumber)) {
			logger.info(vo.toString());
		}
		
		logger.info("MOVIEROOM PAGE END");
		logger.info("=====================================================");
		return "/cinema/cinemaMovieroom";
	}
	
	// AJAX로 해당 지점의 상영관 리스트 보내기
	@ResponseBody
	@RequestMapping(value="/{branchNumber}/movieroomList", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> movieroomListRest(@PathVariable int branchNumber) {
		logger.info("=======================================================");
		logger.info("MOVIEROOM LIST REQUESTED");
		logger.info("BRANCH NUMBER= " + branchNumber);
		
		
		List<MovieroomVO> movieroomList = movieroomService.movieroomList(branchNumber);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("movieroomList", movieroomList);
		ResponseEntity<Map<String, Object>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		
		logger.info("MOVIEROOM LIST RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/movieroomInsert", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> movieroomInsertRest(MovieroomVO movieroomVO) {
		logger.info("=======================================================");
		logger.info("MOVIEROOM INSERT REQUESTED");
		logger.info("MovieroomVO= " + movieroomVO.toString());
		if (movieroomVO.getMovieroom2D() == null) {
			movieroomVO.setMovieroom2D("N");
		}
		if (movieroomVO.getMovieroom3D() == null) {
			movieroomVO.setMovieroom3D("N");
		} 
		if (movieroomVO.getMovieroom4D() == null) {
			movieroomVO.setMovieroom4D("N");  
		}
		
		int result = movieroomService.movieroomInsert(movieroomVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("INSERT SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("INSERT FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("MOVIEROOM INSERT RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
	@ResponseBody
	@RequestMapping(value="/movieroomDetail/{movieroomNumber}", method=RequestMethod.PUT)
	public ResponseEntity<MovieroomVO> movieroomDetailRest(@PathVariable("movieroomNumber") int movieroomNumber) {
		
		logger.info("=======================================================");
		logger.info("MOVIEROOM DETAIL DATA REQUESTED");
		MovieroomVO selectData = new MovieroomVO();
		selectData.setMovieroomNumber(movieroomNumber);
		MovieroomVO selectedData = movieroomService.movieroomDetail(selectData);
		logger.info("MovieroomVO= " + selectedData.toString());
		ResponseEntity<MovieroomVO> selectedMovieroomVO = new ResponseEntity<>(selectedData, HttpStatus.OK);
		
		logger.info("MOVIEROOM DETAIL DATA SENT TO JSON");
		logger.info("=======================================================");
		return selectedMovieroomVO;
	}
	
	@ResponseBody
	@RequestMapping(value="/movieroomUpdate", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> movieroomUpdateRest(MovieroomVO movieroomVO) {
		
		logger.info("=======================================================");
		logger.info("MOVIEROOM UPDATE REQUESTED");
		logger.info("MovieroomVO= " + movieroomVO.toString());
		if (movieroomVO.getMovieroom2D() == null) {
			movieroomVO.setMovieroom2D("N");
		}
		if (movieroomVO.getMovieroom3D() == null) {
			movieroomVO.setMovieroom3D("N");
		}
		if (movieroomVO.getMovieroom4D() == null) {
			movieroomVO.setMovieroom4D("N");  
		}
		int result = movieroomService.movieroomUpdate(movieroomVO);
		Map<String, String> resultMap = new HashMap<>();
		if (result == 1) {
			resultMap.put("result", "SUCCESS");
			logger.info("UPDATE SUCCESS");
		} else {
			resultMap.put("result", "FAILED");
			logger.info("UPDATE FAILED");
		}
		ResponseEntity<Map<String, String>> resultEntity = new ResponseEntity<>(resultMap, HttpStatus.OK);
		logger.info("MOVIEROOM UPDATE RESULT SENT TO JSON");
		logger.info("=======================================================");
		return resultEntity;
	}
	
}
