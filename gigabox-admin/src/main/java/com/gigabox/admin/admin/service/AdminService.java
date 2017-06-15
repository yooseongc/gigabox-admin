package com.gigabox.admin.admin.service;

import java.sql.Date;

import com.gigabox.admin.admin.dto.LoginDTO;
import com.gigabox.admin.admin.vo.AdminVO;

public interface AdminService {

	public AdminVO login(LoginDTO loginDTO);

	public int idCheck(AdminVO adminVO);

	public void autoLogin(String adminId, String sessionId, Date next);

	public AdminVO checkAdminWithSessionKey(String value);

}
