package com.gigabox.admin.cinema.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.cinema.vo.BranchSearchCriteria;
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

	@Override
	public List<BranchVO> branchList(BranchSearchCriteria bsc) {
		return sqlSession.selectList(namespace + ".branchList", bsc);
	}
	
	@Override
	public int branchListCount(BranchSearchCriteria bsc) {
		return sqlSession.selectOne(namespace + ".branchListCount", bsc);
	}

	@Override
	public BranchVO branchDetail(BranchVO branchVO) {
		return sqlSession.selectOne(namespace + ".branchDetail", branchVO);
	}

	@Override
	public int branchInsert(BranchVO branchVO) {
		return sqlSession.insert(namespace + ".branchInsert", branchVO);
	}

	@Override
	public int branchUpdate(BranchVO branchVO) {
		return sqlSession.update(namespace + ".branchUpdate", branchVO);
	}

}
