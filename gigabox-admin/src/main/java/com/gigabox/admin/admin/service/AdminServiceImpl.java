package com.gigabox.admin.admin.service;

import java.sql.Date;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gigabox.admin.admin.dto.LoginDTO;
import com.gigabox.admin.admin.persistence.AdminDAO;
import com.gigabox.admin.admin.vo.AdminVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	private AdminDAO adminDAO;
	
	@Override
	public AdminVO login(LoginDTO loginDTO) {
		return adminDAO.login(loginDTO);
	}

	@Override
	public int idCheck(AdminVO adminVO) {
		return adminDAO.idCheck(adminVO);
	}

	@Override
	public void autoLogin(String adminId, String sessionId, Date next) {
		adminDAO.autoLogin(adminId, sessionId, next);
	}

	@Override
	public AdminVO checkAdminWithSessionKey(String value) {
		return adminDAO.checkAdminWithSessionKey(value);
	}

}
