package com.gigabox.admin;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value={"/admin/index","/admin"}, method=RequestMethod.GET)
	public String home(Model model) {
		logger.info("INDEX PAGE LOADING...");
		
		model.addAttribute("calendarId", "sce54pbfv6mhh37r7ptn8ak350@group.calendar.google.com");
		model.addAttribute("title", "gigabox");
		return "index";
	}
	
}
