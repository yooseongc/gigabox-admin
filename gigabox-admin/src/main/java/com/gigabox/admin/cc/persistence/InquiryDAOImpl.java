package com.gigabox.admin.cc.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.cc.vo.InquirySearchCriteria;
import com.gigabox.admin.cc.vo.InquiryVO;

@Repository
public class InquiryDAOImpl implements InquiryDAO {

	@Inject
	private SqlSession sqlSession;
	
	private final static String namespace = "com.gigabox.admin.mapper.InquiryMapper";
	
	@Override
	public List<InquiryVO> inquiryList(InquirySearchCriteria isc) {
		return sqlSession.selectList(namespace + ".inquiryList", isc);
	}

	@Override
	public int inquiryListCount(InquirySearchCriteria isc) {
		return sqlSession.selectOne(namespace + ".inquiryListCount", isc);
	}

	@Override
	public InquiryVO inquiryDetailQ(InquiryVO inquiryVO) {
		return sqlSession.selectOne(namespace + ".inquiryDetailQ", inquiryVO);
	}

	@Override
	public InquiryVO inquiryDetailA(InquiryVO inquiryVO) {
		return sqlSession.selectOne(namespace + ".inquiryDetailA", inquiryVO);
	}

	@Override
	public int inquiryInsertA(InquiryVO inquiryVO) {
		return sqlSession.insert(namespace + ".inquiryInsertA", inquiryVO);
	}

	@Override
	public int inquiryUpdateA(InquiryVO inquiryVO) {
		return sqlSession.update(namespace + ".inquiryUpdateA", inquiryVO);
	}

	@Override
	public int inquiryDeleteA(InquiryVO inquiryVO) {
		return sqlSession.delete(namespace + ".inquiryDeleteA", inquiryVO);
	}

}
