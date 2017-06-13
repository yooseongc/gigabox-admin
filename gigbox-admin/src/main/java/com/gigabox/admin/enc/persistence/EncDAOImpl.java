package com.gigabox.admin.enc.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.admin.vo.AdminVO;

@Repository
public class EncDAOImpl implements EncDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = 
			"com.gigabox.admin.mapper.AdminMapper";
	
	@Override
	public int idCheck(AdminVO adminVO) {
		return sqlSession.selectOne(namespace + ".idCheck", adminVO);
	}
	
	@Override
	public int pwEncryptionCheck(AdminVO adminVO) {
		return sqlSession.selectOne(namespace + ".pwEncryptionCheck", adminVO);
	}

	@Override
	public int pwEncryptionExec(AdminVO adminVO) {
		return sqlSession.update(namespace + ".pwEncryptionExec", adminVO);
	}

}
