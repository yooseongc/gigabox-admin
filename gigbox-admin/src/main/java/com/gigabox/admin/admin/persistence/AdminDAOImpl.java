package com.gigabox.admin.admin.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.admin.dto.LoginDTO;
import com.gigabox.admin.admin.vo.AdminVO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "com.gigabox.mapper.AdminMapper";
	
	@Override
	public AdminVO login(LoginDTO loginDTO) {
		return sqlSession.selectOne(namespace + ".login", loginDTO);
	}

	@Override
	public int idCheck(AdminVO adminVO) {
		return sqlSession.selectOne(namespace + ".idCheck", adminVO);
	}

}
