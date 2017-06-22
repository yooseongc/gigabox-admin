package com.gigabox.admin.cc.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gigabox.admin.cc.persistence.InquiryDAO;
import com.gigabox.admin.cc.vo.InquirySearchCriteria;
import com.gigabox.admin.cc.vo.InquiryVO;

@Service
public class InquiryServiceImpl implements InquiryService {

	@Inject
	private InquiryDAO inquiryDAO;
	
	@Override
	public List<InquiryVO> inquiryList(InquirySearchCriteria isc) {
		return inquiryDAO.inquiryList(isc);
	}

	@Override
	public int inquiryListCount(InquirySearchCriteria isc) {
		return inquiryDAO.inquiryListCount(isc);
	}

	@Override
	public InquiryVO inquiryDetailQ(InquiryVO inquiryVO) {
		return inquiryDAO.inquiryDetailQ(inquiryVO);
	}

	@Override
	public InquiryVO inquiryDetailA(InquiryVO inquiryVO) {
		return inquiryDAO.inquiryDetailA(inquiryVO);
	}

	@Override
	public int inquiryInsertA(InquiryVO inquiryVO) {
		return inquiryDAO.inquiryInsertA(inquiryVO);
	}

	@Override
	public int inquiryUpdateA(InquiryVO inquiryVO) {
		return inquiryDAO.inquiryUpdateA(inquiryVO);
	}

	@Override
	public int inquiryDeleteA(InquiryVO inquiryVO) {
		return inquiryDAO.inquiryDeleteA(inquiryVO);
	}

}
