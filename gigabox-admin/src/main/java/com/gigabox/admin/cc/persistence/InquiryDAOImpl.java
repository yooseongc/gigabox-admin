package com.gigabox.admin.cc.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

import com.gigabox.admin.cc.vo.InquirySearchCriteria;
import com.gigabox.admin.cc.vo.InquiryVO;

public class InquiryDAOImpl implements InquiryDAO {

	@Inject
	private SqlSession sqlSession;
	
	private final static String mapper = "com.gigabox.admin.mapper.InquiryMapper";
	
	@Override
	public List<InquiryVO> inquiryList(InquirySearchCriteria isc) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int inquiryListCount(InquirySearchCriteria isc) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public InquiryVO inquiryDetail(InquiryVO inquiryVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int inquiryInsert(InquiryVO inquiryVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int inquiryUpdate(InquiryVO inquiryVO) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int inquiryDelete(InquiryVO inquiryVO) {
		// TODO Auto-generated method stub
		return 0;
	}

}
