package com.gigabox.admin.admin.persistence;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.admin.dto.LoginDTO;
import com.gigabox.admin.admin.vo.AdminVO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "com.gigabox.admin.mapper.AdminMapper";
	
	@Override
	public AdminVO login(LoginDTO loginDTO) {
		return sqlSession.selectOne(namespace + ".login", loginDTO);
	}

	@Override
	public int idCheck(AdminVO adminVO) {
		return sqlSession.selectOne(namespace + ".idCheck", adminVO);
	}

	@Override
	public void autoLogin(String adminId, String sessionId, Date next) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("adminId", adminId);
		paramMap.put("sessionId", sessionId);
		paramMap.put("next", next);
		
		sqlSession.update(namespace + ".autoLogin", paramMap);
	}

	@Override
	public AdminVO checkAdminWithSessionKey(String value) {
		return sqlSession.selectOne(namespace + ".checkAdminWithSessionKey", value);
	}

}
