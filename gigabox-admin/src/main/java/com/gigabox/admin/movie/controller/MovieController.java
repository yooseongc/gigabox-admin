package com.gigabox.admin.movie.controller;

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
import com.gigabox.admin.movie.service.MovieService;
import com.gigabox.admin.movie.vo.MovieSearchCriteria;
import com.gigabox.admin.movie.vo.MovieVO;

@Controller
@RequestMapping("/admin/movie")
public class MovieController {

	@Inject
	private MovieService movieService;
	
	private static final Logger logger = LoggerFactory.getLogger(MovieController.class);
	
	@RequestMapping(value="/movieMain", method=RequestMethod.GET)
	public String movieListGET(@ModelAttribute("msc") MovieSearchCriteria msc, Model model) {
		
		logger.info("=======================================================");
		logger.info("MOVIE MAIN PAGE LOADING...");
		logger.info("INITIAL PAGING= " + msc.toString());
		
		model.addAttribute("movieList", movieService.movieList(msc));
		logger.info(movieService.movieList(msc).toString());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(msc);
		pageMaker.setTotalCount(movieService.movieListCount(msc));
		model.addAttribute("pageMaker", pageMaker);
		
		logger.info("pageMaker= " + pageMaker.toString());
		
		logger.info("MOVIE MAIN PAGE LOADING END");
		logger.info("=======================================================");
		
		return "/movie/movieMain";
	}
	
	@ResponseBody
	@RequestMapping(value="/movieDetail/{movieNumber}", method=RequestMethod.PUT)
	public ResponseEntity<MovieVO> movieDetailRest(@PathVariable("movieNumber") int movieNumber) {
		
		logger.info("=======================================================");
		logger.info("MOVIE DETAIL DATA REQUESTED");
		MovieVO selectData = new MovieVO();
		selectData.setMovieNumber(movieNumber);
		MovieVO selectedData = movieService.movieDetail(selectData);
		logger.info("MovieVO= " + selectedData.toString());
		ResponseEntity<MovieVO> selectedMovieVO = new ResponseEntity<>(selectedData, HttpStatus.OK);
		
		logger.info("MOVIE DETAIL DATA SENT TO JSON");
		logger.info("=======================================================");
		return selectedMovieVO;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/movieInsert", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> movieInsert(HttpServletResponse response, MovieVO movieVO) throws IOException {
		logger.info("=======================================================");
		logger.info("MOVIE INSERT PROCESSING...");
		
		logger.info("MovieVO= " + movieVO.toString());
		Map<String, String> resultMap = new HashMap<String, String>();
		int result = movieService.movieInsert(movieVO);
		if (result == 0) {
			logger.info("MOVIE INSERTION FAILED");
			logger.info("=======================================================");
			
			resultMap.put("result", "영화 추가에 실패하였습니다.");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.BAD_REQUEST);
		}
		resultMap.put("result", "영화 추가에 성공하였습니다.");
		logger.info("MOVIE INSERTION SUCCESSED");
		logger.info("=======================================================");
		return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.CREATED);
	}
	
	@ResponseBody
	@RequestMapping(value="/movieUpdate", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> movieUpdate(HttpServletResponse response, MovieVO movieVO) throws IOException {
		logger.info("=======================================================");
		logger.info("MOVIE UPDATE PROCESSING...");
		
		logger.info("MovieVO= " + movieVO.toString());
		Map<String, String> resultMap = new HashMap<String, String>();
		int result = movieService.movieUpdate(movieVO);
		if (result == 0) {
			logger.info("MOVIE UPDATE FAILED");
			logger.info("=======================================================");
			
			resultMap.put("result", "영화 수정에 실패하였습니다.");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.BAD_REQUEST);
		}
		resultMap.put("result", "영화 수정에 성공하였습니다.");
		logger.info("MOVIE UPDATE SUCCESSED");
		logger.info("=======================================================");
		return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.CREATED);
	}
	
	@ResponseBody
	@RequestMapping(value="/movieDelete", method=RequestMethod.POST)
	public ResponseEntity<Map<String, String>> movieDelete(HttpServletResponse response, MovieVO movieVO) throws IOException {
		logger.info("=======================================================");
		logger.info("MOVIE DELETE PROCESSING...");
		
		logger.info("MovieVO= " + movieVO.toString());
		Map<String, String> resultMap = new HashMap<String, String>();
		int result = movieService.movieDelete(movieVO);
		if (result == 0) {
			logger.info("MOVIE DELETE FAILED");
			logger.info("=======================================================");
			
			resultMap.put("result", "영화 삭제에 실패하였습니다.");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.BAD_REQUEST);
		}
		resultMap.put("result", "영화 삭제에 성공하였습니다.");
		logger.info("MOVIE DELETE SUCCESSED");
		logger.info("=======================================================");
		return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.CREATED);
	}
	
}
