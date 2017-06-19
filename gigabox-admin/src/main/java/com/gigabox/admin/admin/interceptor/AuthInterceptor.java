package com.gigabox.admin.admin.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.gigabox.admin.admin.service.AdminService;
import com.gigabox.admin.admin.vo.AdminVO;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Inject
	private AdminService adminService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object Handler) throws Exception {
		
		logger.info("AUTH INTERCEPTOR PREHANDLER ENTERED");
		logger.info("PAGE= " + request.getRequestURI());
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("login") == null) {
			logger.info("NOT LOGINED");
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if (loginCookie != null) {
				logger.info("LOGIN COOKIE EXISTS...");
				AdminVO adminVO = adminService.checkAdminWithSessionKey(loginCookie.getValue());
				
				if (adminVO != null) {
					logger.info("LOGIN INFO WAS FOUND BY LOGIN COOKIE= " + adminVO.toString());
					session.setAttribute("login", adminVO);
					return true;
				} else {
					logger.info("LOGIN COOKIE FOUND BUT IT DIFFERS FROM SAVED SESSION KEY");
					logger.info("REDIRECT TO /admin/auth/login");
					response.sendRedirect("/admin/auth/login");
					return false;
				}
				
			} else {
				logger.info("LOGIN COOKIE NOT FOUND...");
				response.sendRedirect("/admin/auth/login");
				return false;
			}
		}
		
		logger.info("SESSION EXISTS");
		return true;
	}
}
