package com.gigabox.admin.enc.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gigabox.admin.admin.vo.AdminVO;
import com.gigabox.admin.enc.persistence.EncDAO;

@Service
public class EncServiceImpl implements EncService {

	@Inject
	private EncDAO encDAO;
	
	@Override
	public int idCheck(AdminVO adminVO) {
		return encDAO.idCheck(adminVO);
	}
	
	@Override
	public int pwEncryptionCheck(AdminVO adminVO) {
		return encDAO.pwEncryptionCheck(adminVO);
	}

	@Override
	public int pwEncryptionExec(AdminVO adminVO) {
		return encDAO.pwEncryptionExec(adminVO);
	}

}
