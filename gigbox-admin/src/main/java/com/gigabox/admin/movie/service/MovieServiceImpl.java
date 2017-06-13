package com.gigabox.admin.movie.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gigabox.admin.movie.persistence.MovieDAO;
import com.gigabox.admin.movie.vo.MovieSearchCriteria;
import com.gigabox.admin.movie.vo.MovieVO;

@Service
public class MovieServiceImpl implements MovieService {

	@Inject
	private MovieDAO movieDAO;
	
	@Override
	public List<MovieVO> movieList(MovieSearchCriteria msc) {
		return movieDAO.movieList(msc);
	}

	@Override
	public int movieListCount(MovieSearchCriteria msc) {
		return movieDAO.movieListCount(msc);
	}

	@Override
	public MovieVO movieDetail(MovieVO movieVO) {
		return movieDAO.movieDetail(movieVO);
	}

	@Override
	public int movieInsert(MovieVO movieVO) {
		return movieDAO.movieInsert(movieVO);
	}

	@Override
	public int movieUpdate(MovieVO movieVO) {
		return movieDAO.movieUpdate(movieVO);
	}

	@Override
	public int movieDelete(MovieVO movieVO) {
		return movieDAO.movieDelete(movieVO);
	}

}
