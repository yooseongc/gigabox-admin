package com.gigabox.admin.enc.service;

import com.gigabox.admin.admin.vo.AdminVO;

public interface EncService {
	
	public int idCheck(AdminVO adminVO);
	
	public int pwEncryptionCheck(AdminVO adminVO);
	
	public int pwEncryptionExec(AdminVO adminVO);
	
}
