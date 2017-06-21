package com.gigabox.admin.cc.service;

import java.util.List;

import com.gigabox.admin.cc.vo.NoticeSearchCriteria;
import com.gigabox.admin.cc.vo.NoticeVO;

public interface NoticeService {
	
public List<NoticeVO> noticeList(NoticeSearchCriteria nsc);
	
	public int noticeListCount(NoticeSearchCriteria nsc);
	
	public NoticeVO noticeDetail(NoticeVO noticeVO);
	
	public int noticeInsert(NoticeVO noticeVO);
	
	public int noticeUpdate(NoticeVO noticeVO);
	
	public int noticeDelete(NoticeVO noticeVO);
	
}
