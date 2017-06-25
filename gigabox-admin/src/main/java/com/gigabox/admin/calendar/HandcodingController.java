package com.gigabox.admin.calendar;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.api.services.calendar.Calendar;
import com.google.api.services.calendar.model.CalendarList;
import com.google.api.services.calendar.model.CalendarListEntry;

@Controller
public class HandcodingController {
	
	private Logger logger = LoggerFactory.getLogger(HandcodingController.class);
	
	// 캘린더리스트
	@RequestMapping(value="/coding", method=RequestMethod.GET)
	public String coding(Model model) {
		logger.info("calendarList");
		try {
			Calendar service = GoogleCalendarService.getCalendarService();
			CalendarList calendarList = service.calendarList().list().setPageToken(null).execute();
			List<CalendarListEntry> items = calendarList.getItems();
			model.addAttribute("items", items);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "coding";
	}
	
	// 캘린더 생성 처리
	@RequestMapping(value="/calendarAdd", method=RequestMethod.POST)
	public String calendarAdd(CalendarDTO calDto) {
		logger.info("calendarAdd "+calDto.toString());
		
		try {
			Calendar service = GoogleCalendarService.getCalendarService();
			com.google.api.services.calendar.model.Calendar calendar = new com.google.api.services.calendar.model.Calendar();
			calendar.setSummary(calDto.getSummary());
			calendar.setTimeZone("Asia/Seoul");
			service.calendars().insert(calendar).execute();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/coding";
	}
	
	// 캘린더 삭제 처리
	@RequestMapping(value="/calendarRemove", method=RequestMethod.POST)
	public String calendarRemove(HttpServletRequest req) {
		logger.info("calendarRemove");
		
		String[] chkVal = req.getParameterValues("chkVal");
		try {
			Calendar service = GoogleCalendarService.getCalendarService();
			for (String calendarId : chkVal) {
				service.calendars().delete(calendarId).execute();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/coding";
	}	
	
	// 캘린더 수정 처리
	@RequestMapping(value="/calendarModify", method=RequestMethod.POST)
	public String calendarModify(CalendarDTO calDto) {
		logger.info("calendarModify "+calDto.toString());
		
		try {
			Calendar service = GoogleCalendarService.getCalendarService();
			com.google.api.services.calendar.model.Calendar calendar = service.calendars().get(calDto.getCalendarId()).execute();
			calendar.setSummary(calDto.getSummary());
		    service.calendars().update(calendar.getId(), calendar).execute();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:/coding";
	}	
	
	// 캘린더 이동처리
	@RequestMapping(value="/schdule", method=RequestMethod.GET)
	public String schdule(Model model, String calendarId, String title) {
		logger.info("schdule");
		model.addAttribute("calendarId", calendarId);
		model.addAttribute("title", title);
		return "schdule";
	}	
	
}
