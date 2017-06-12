package com.gigabox.admin.admin.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object Handler) throws Exception {
		
		logger.info("AUTH INTERCEPTOR PREHANDLER ENTERED");
		logger.info("PAGE= " + request.getRequestURI());
		
		HttpSession session = request.getSession();
		if (session.getAttribute("login") == null) {
			logger.info("NOT LOGINED");
			response.sendRedirect("/admin/login");
			return false;
		}
		
		return true;
	}
}
