package com.gigabox.admin.cinema.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.cinema.vo.BranchVO;

@Repository
public class BranchDAOImpl implements BranchDAO {

	@Inject
	private SqlSession sqlSession;
	
	private final static String namespace = "com.gigabox.admin.mapper.BranchMapper";
	
	@Override
	public List<BranchVO> branchListAll() {
		return sqlSession.selectList(namespace + ".branchListAll");
	}

}
