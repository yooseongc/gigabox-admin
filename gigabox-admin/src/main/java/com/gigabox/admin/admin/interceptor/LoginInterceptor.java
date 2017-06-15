package com.gigabox.admin.admin.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.gigabox.admin.admin.vo.AdminVO;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	private static final String LOGIN = "login";
	
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception {
		
		logger.info("LOGIN INTERCEPTOR PREHANDLER ENTERED");
		HttpSession session = request.getSession();
		
		if (session.getAttribute(LOGIN) != null) {
			logger.info("CLEAR LOGIN SESSION BEFORE");
			session.removeAttribute(LOGIN);
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		logger.info("LOGIN INTERCEPTOR POSTHANDLER ENTERED");
		
		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		Object adminVO = modelMap.get("adminVO");
		if (adminVO != null) {
			logger.info("NEW LOGIN SESSION CREATED, " + ((AdminVO) adminVO).toString());
			session.setAttribute(LOGIN, adminVO);
			
			if (request.getParameter("useCookie") != null) {
				logger.info("AUTO LOGIN ALLOWED - CREATE COOKIE");
				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				loginCookie.setPath("/");
				loginCookie.setMaxAge(60 * 60 * 24 * 7);	// 1주일
				response.addCookie(loginCookie);
			}
			
			// index.jsp로 돌려보냄.
			response.sendRedirect("/admin/index");
		}
	}
	
}
