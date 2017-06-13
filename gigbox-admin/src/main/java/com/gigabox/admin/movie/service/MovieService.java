package com.gigabox.admin.movie.service;

import java.util.List;

import com.gigabox.admin.movie.vo.MovieSearchCriteria;
import com.gigabox.admin.movie.vo.MovieVO;

public interface MovieService {

	public List<MovieVO> movieList(MovieSearchCriteria cri);
	
	public int movieListCount(MovieSearchCriteria cri);
	
	public MovieVO movieDetail(MovieVO movieVO);
	
	public int movieInsert(MovieVO movieVO);
	
	public int movieUpdate(MovieVO movieVO);
	
	public int movieDelete(MovieVO movieVO);
	
}
