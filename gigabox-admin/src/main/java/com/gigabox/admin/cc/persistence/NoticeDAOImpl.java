package com.gigabox.admin.cc.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.cc.vo.NoticeSearchCriteria;
import com.gigabox.admin.cc.vo.NoticeVO;

@Repository
public class NoticeDAOImpl implements NoticeDAO {

	private static final String namespace = "com.gigabox.admin.mapper.NoticeMapper";
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public List<NoticeVO> noticeList(NoticeSearchCriteria nsc) {
		return sqlSession.selectList(namespace + ".noticeList", nsc);
	}

	@Override
	public int noticeListCount(NoticeSearchCriteria nsc) {
		return sqlSession.selectOne(namespace + ".noticeListCount", nsc);
	}

	@Override
	public NoticeVO noticeDetail(NoticeVO noticeVO) {
		return sqlSession.selectOne(namespace + ".noticeDetail", noticeVO);
	}

	@Override
	public int noticeInsert(NoticeVO noticeVO) {
		return sqlSession.insert(namespace + ".noticeInsert", noticeVO);
	}

	@Override
	public int noticeUpdate(NoticeVO noticeVO) {
		return sqlSession.update(namespace + ".noticeUpdate", noticeVO);
	}

	@Override
	public int noticeDelete(NoticeVO noticeVO) {
		return sqlSession.delete(namespace + ".noticeDelete", noticeVO);
	}

}
