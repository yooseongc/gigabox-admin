package com.gigabox.admin.stat.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gigabox.admin.stat.service.StatService;
import com.gigabox.admin.stat.vo.BranchStatVO;
import com.gigabox.admin.stat.vo.MovieStatVO;
import com.gigabox.admin.stat.vo.UserStatVO;

@Controller
@RequestMapping("/admin/stat")
public class StatController {

	@Inject
	StatService statService;
	
	private static final Logger logger = LoggerFactory.getLogger(StatController.class);
	
	@RequestMapping(value="/userStat", method=RequestMethod.GET)
	public String userStatGET(Model model) {
		logger.info("===============================================");
		logger.info("USER STATISTICS PAGE LOADING");
		return "/stat/userStat";
	}
	@RequestMapping(value="/branchStat", method=RequestMethod.GET)
	public String branchStatGET(Model model) {
		logger.info("===============================================");
		logger.info("USER STATISTICS PAGE LOADING");
		return "/stat/branchStat";
	}
	@RequestMapping(value="/movieStat", method=RequestMethod.GET)
	public String movieStatGET(Model model) {
		logger.info("===============================================");
		logger.info("MOVIE STATISTICS PAGE LOADING");
		return "/stat/movieStat";
	}
	
	@ResponseBody
	@RequestMapping(value="/userAge", method=RequestMethod.GET)
	public ResponseEntity<List<UserStatVO>> userAgeCountStatGET(Model model) {
		logger.info("===============================================");
		
		List<UserStatVO> ageStatList = statService.getUserAgeCountStat();
		
		ResponseEntity<List<UserStatVO>> stat = new ResponseEntity<>(ageStatList, HttpStatus.OK);
		
		return stat;
	}
	
	@ResponseBody
	@RequestMapping(value="/userGender", method=RequestMethod.GET)
	public ResponseEntity<List<UserStatVO>> userGenderCountStatGET(Model model) {
		logger.info("===============================================");
		
		List<UserStatVO> ageStatList = statService.getUserGenderCountStat();
		
		ResponseEntity<List<UserStatVO>> stat = new ResponseEntity<>(ageStatList, HttpStatus.OK);
		
		return stat;
	}
	
	@ResponseBody
	@RequestMapping(value="/userRegister", method=RequestMethod.GET)
	public ResponseEntity<List<UserStatVO>> userRegisterCountStatGET(String year, String month) {
		logger.info("===============================================");
		
		List<UserStatVO> ageStatList = statService.getUserRegisterCountStat(year, month);
		
		ResponseEntity<List<UserStatVO>> stat = new ResponseEntity<>(ageStatList, HttpStatus.OK);
		
		return stat;
	}
	
	@ResponseBody
	@RequestMapping(value="/branchResv", method=RequestMethod.GET)
	public ResponseEntity<List<BranchStatVO>> branchResvStatGET(String year, String month) {
		logger.info("===============================================");
		
		List<BranchStatVO> branchResvStatList = statService.getBranchResvStatusStat(year, month);
		
		ResponseEntity<List<BranchStatVO>> stat = new ResponseEntity<>(branchResvStatList, HttpStatus.OK);
		
		return stat;
	}
	
	@ResponseBody
	@RequestMapping(value="/branchPay", method=RequestMethod.GET)
	public ResponseEntity<List<BranchStatVO>> branchPayStatGET(String year, String month) {
		logger.info("===============================================");
		
		List<BranchStatVO> branchPayStatList = statService.getBranchPaymentStat(year, month);
		
		ResponseEntity<List<BranchStatVO>> stat = new ResponseEntity<>(branchPayStatList, HttpStatus.OK);
		
		return stat;
	}
	
	@ResponseBody
	@RequestMapping(value="/movieResv", method=RequestMethod.GET)
	public ResponseEntity<List<MovieStatVO>> movieResvStatGET(String year, String month) {
		logger.info("===============================================");
		
		List<MovieStatVO> movieResvStatList = statService.getMovieResvStatusStat(year, month);
		
		ResponseEntity<List<MovieStatVO>> stat = new ResponseEntity<>(movieResvStatList, HttpStatus.OK);
		
		return stat;
	}
	
	@ResponseBody
	@RequestMapping(value="/moviePay", method=RequestMethod.GET)
	public ResponseEntity<List<MovieStatVO>> moviePayStatGET(String year, String month) {
		logger.info("===============================================");
		
		List<MovieStatVO> moviePayStatList = statService.getMoviePaymentStat(year, month);
		
		ResponseEntity<List<MovieStatVO>> stat = new ResponseEntity<>(moviePayStatList, HttpStatus.OK);
		
		return stat;
	}
	
}
