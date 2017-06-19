package com.gigabox.admin.movie.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.movie.vo.MovieSearchCriteria;
import com.gigabox.admin.movie.vo.MovieVO;

@Repository
public class MovieDAOImpl implements MovieDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "com.gigabox.admin.mapper.MovieMapper";
	
	@Override
	public List<MovieVO> movieList(MovieSearchCriteria msc) {
		return sqlSession.selectList(namespace + ".movieList", msc);
	}

	@Override
	public int movieListCount(MovieSearchCriteria msc) {
		return sqlSession.selectOne(namespace + ".movieListCount", msc);
	}

	@Override
	public MovieVO movieDetail(MovieVO movieVO) {
		return sqlSession.selectOne(namespace + ".movieDetail", movieVO);
	}

	@Override
	public int movieInsert(MovieVO movieVO) {
		return sqlSession.insert(namespace + ".movieInsert", movieVO);
	}

	@Override
	public int movieUpdate(MovieVO movieVO) {
		return sqlSession.update(namespace + ".movieUpdate", movieVO);
	}

	@Override
	public int movieDelete(MovieVO movieVO) {
		return sqlSession.update(namespace + ".movieDelete", movieVO);
	}

}
