package com.gigabox.admin.cinema.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.cinema.vo.MovieroomVO;

@Repository
public class MovieroomDAOImpl implements MovieroomDAO {

	@Inject
	private SqlSession sqlSession;
	
	private final static String namespace = "com.gigabox.admin.mapper.MovieroomMapper";
	
	@Override
	public List<MovieroomVO> movieroomList(int branchNumber) {
		return sqlSession.selectList(namespace + ".movieroomList", branchNumber);
	}

	@Override
	public MovieroomVO movieroomDetail(MovieroomVO movieroomVO) {
		return sqlSession.selectOne(namespace + ".movieroomDetail", movieroomVO);
	}

	@Override
	public int movieroomInsert(MovieroomVO movieroomVO) {
		return sqlSession.insert(namespace + ".movieroomInsert", movieroomVO);
	}

	@Override
	public int movieroomUpdate(MovieroomVO movieroomVO) {
		return sqlSession.update(namespace + ".movieroomUpdate", movieroomVO);
	}

}
