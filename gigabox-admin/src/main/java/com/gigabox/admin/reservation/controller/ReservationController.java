package com.gigabox.admin.reservation.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gigabox.admin.cinema.service.ScheduleService;
import com.gigabox.admin.reservation.service.ReservationService;

@Controller
@RequestMapping("/reservation")
public class ReservationController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReservationController.class);

	@Inject 
	private ReservationService resvService;
	
	/*@Inject
	private BranchService branchService;
	
	@Inject
	private MovieRoomService movieRoomService;
	
	@Inject 
	private UserService userService;
	
	@Inject
	private MovieService movieService;*/
	
	@Inject
	private ScheduleService scheduleService;
	
	
}
