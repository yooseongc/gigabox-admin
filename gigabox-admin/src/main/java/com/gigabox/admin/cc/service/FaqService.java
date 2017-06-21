package com.gigabox.admin.cc.service;

import java.util.List;

import com.gigabox.admin.cc.vo.FaqSearchCriteria;
import com.gigabox.admin.cc.vo.FaqVO;

public interface FaqService {
	
	public List<FaqVO> faqList(FaqSearchCriteria fsc);
	
	public int faqListCount(FaqSearchCriteria fsc);
	
	public FaqVO faqDetail(FaqVO faqVO);
	
	public int faqInsert(FaqVO faqVO);
	
	public int faqUpdate(FaqVO faqVO);
	
	public int faqDelete(FaqVO faqVO);
	
}
