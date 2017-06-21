package com.gigabox.admin.cc.persistence;

import java.util.List;

import com.gigabox.admin.cc.vo.InquirySearchCriteria;
import com.gigabox.admin.cc.vo.InquiryVO;

public interface InquiryDAO {

	public List<InquiryVO> inquiryList(InquirySearchCriteria isc);
	
	public int inquiryListCount(InquirySearchCriteria isc);
	
	public InquiryVO inquiryDetail(InquiryVO inquiryVO);
	
	public int inquiryInsert(InquiryVO inquiryVO);
	
	public int inquiryUpdate(InquiryVO inquiryVO);
	
	public int inquiryDelete(InquiryVO inquiryVO);
	
}
