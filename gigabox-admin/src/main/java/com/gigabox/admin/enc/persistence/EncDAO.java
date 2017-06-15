package com.gigabox.admin.enc.persistence;

import com.gigabox.admin.admin.vo.AdminVO;

public interface EncDAO {
	
	public int idCheck(AdminVO adminVO);
	
	public int pwEncryptionCheck(AdminVO adminVO);
	
	public int pwEncryptionExec(AdminVO adminVO);
	
}
