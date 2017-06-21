package com.gigabox.admin.cc.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gigabox.admin.cc.persistence.FaqDAO;
import com.gigabox.admin.cc.vo.FaqSearchCriteria;
import com.gigabox.admin.cc.vo.FaqVO;

@Service
public class FaqServiceImpl implements FaqService {

	@Inject
	private FaqDAO faqDAO;
	
	@Override
	public List<FaqVO> faqList(FaqSearchCriteria fsc) {
		return faqDAO.faqList(fsc);
	}

	@Override
	public int faqListCount(FaqSearchCriteria fsc) {
		return faqDAO.faqListCount(fsc);
	}

	@Override
	public FaqVO faqDetail(FaqVO faqVO) {
		return faqDAO.faqDetail(faqVO);
	}

	@Override
	public int faqInsert(FaqVO faqVO) {
		return faqDAO.faqInsert(faqVO);
	}

	@Override
	public int faqUpdate(FaqVO faqVO) {
		return faqDAO.faqUpdate(faqVO);
	}

	@Override
	public int faqDelete(FaqVO faqVO) {
		return faqDAO.faqDelete(faqVO);
	}

}
