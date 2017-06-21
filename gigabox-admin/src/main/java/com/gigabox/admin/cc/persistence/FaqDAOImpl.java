package com.gigabox.admin.cc.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.cc.vo.FaqSearchCriteria;
import com.gigabox.admin.cc.vo.FaqVO;

@Repository
public class FaqDAOImpl implements FaqDAO {

	private static final String namespace = "com.gigabox.admin.mapper.FaqMapper";
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public List<FaqVO> faqList(FaqSearchCriteria fsc) {
		return sqlSession.selectList(namespace + ".faqList", fsc);
	}

	@Override
	public int faqListCount(FaqSearchCriteria fsc) {
		return sqlSession.selectOne(namespace + ".faqListCount", fsc);
	}

	@Override
	public FaqVO faqDetail(FaqVO faqVO) {
		return sqlSession.selectOne(namespace + ".faqDetail", faqVO);
	}

	@Override
	public int faqInsert(FaqVO faqVO) {
		return sqlSession.insert(namespace + ".faqInsert", faqVO);
	}

	@Override
	public int faqUpdate(FaqVO faqVO) {
		return sqlSession.update(namespace + ".faqUpdate", faqVO);
	}

	@Override
	public int faqDelete(FaqVO faqVO) {
		return sqlSession.delete(namespace + ".faqDelete", faqVO);
	}

}
