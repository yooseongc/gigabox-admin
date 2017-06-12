package com.gigabox.admin.admin.persistence;

import com.gigabox.admin.admin.dto.LoginDTO;
import com.gigabox.admin.admin.vo.AdminVO;

public interface AdminDAO {
	
	public AdminVO login(LoginDTO loginDTO);
	
	public int idCheck(AdminVO adminVO);
	
}
