package com.gigabox.admin.movie.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gigabox.admin.common.PageMaker;
import com.gigabox.admin.movie.service.MovieService;
import com.gigabox.admin.movie.vo.MovieSearchCriteria;

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
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(msc);
		pageMaker.setTotalCount(movieService.movieListCount(msc));
		model.addAttribute("pageMaker", pageMaker);
		
		logger.info("pageMaker= " + pageMaker.toString());
		
		logger.info("MOVIE MAIN PAGE LOADING END");
		logger.info("=======================================================");
		
		return "/movie/movieMain";
	}
	
}
