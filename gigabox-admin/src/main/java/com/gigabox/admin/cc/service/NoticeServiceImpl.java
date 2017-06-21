package com.gigabox.admin.cc.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gigabox.admin.cc.persistence.NoticeDAO;
import com.gigabox.admin.cc.vo.NoticeSearchCriteria;
import com.gigabox.admin.cc.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Inject
	private NoticeDAO noticeDAO;
	
	@Override
	public List<NoticeVO> noticeList(NoticeSearchCriteria nsc) {
		return noticeDAO.noticeList(nsc);
	}

	@Override
	public int noticeListCount(NoticeSearchCriteria nsc) {
		return noticeDAO.noticeListCount(nsc);
	}

	@Override
	public NoticeVO noticeDetail(NoticeVO noticeVO) {
		return noticeDAO.noticeDetail(noticeVO);
	}

	@Override
	public int noticeInsert(NoticeVO noticeVO) {
		return noticeDAO.noticeInsert(noticeVO);
	}

	@Override
	public int noticeUpdate(NoticeVO noticeVO) {
		return noticeDAO.noticeUpdate(noticeVO);
	}

	@Override
	public int noticeDelete(NoticeVO noticeVO) {
		return noticeDAO.noticeDelete(noticeVO);
	}

}
