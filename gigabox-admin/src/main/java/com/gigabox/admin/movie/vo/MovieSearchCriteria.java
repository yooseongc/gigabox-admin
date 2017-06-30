package com.gigabox.admin.movie.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.gigabox.admin.common.Criteria;

public class MovieSearchCriteria extends Criteria {
	
	private String searchType;
	private String searchKeyword;
	private String genre;
	private String rating;
	private String startYear;
	private String endYear;
	private List<String> genreList;
	private List<String> ratingList;
	private String movieStatus;
	
	public void checkYear() {
		if (startYear == null || "".equals(startYear)) {
			startYear = "1700";
		}
		if (endYear == null || "".equals(endYear)) {
			endYear = "2099";
		}
		if (Integer.parseInt(startYear) > Integer.parseInt(endYear)) {
			String temp = startYear;
			startYear = endYear;
			endYear = temp;
		}
	}
	
	public String makeQuery(int page) {
		UriComponents uriComponents = 
			UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", this.perPageNum)
				.queryParam("searchType", searchType)
				.queryParam("searchKeyword", encoding(searchKeyword))
				.queryParam("genre", encoding(genre))
				.queryParam("rating", encoding(rating))
				.queryParam("startYear", startYear)
				.queryParam("endYear", endYear)
				.queryParam("movieStatus", encoding(movieStatus))
				.build();
		return uriComponents.toString();
	}
	
	private String encoding(String keyword) {
		if (keyword == null || keyword.trim().length() == 0) {
			return "";
		}
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return "";
		}
	}
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public String getStartYear() {
		return startYear;
	}
	public void setStartYear(String startYear) {
		this.startYear = startYear;
	}
	public String getEndYear() {
		return endYear;
	}
	public void setEndYear(String endYear) {
		this.endYear = endYear;
	}
	
	@Override
	public String toString() {
		return super.toString() + " MovieSearchCriteria [searchType=" + searchType + ", searchKeyword=" + searchKeyword + ", genre=" + genre
				+ ", rating=" + rating + ", startYear=" + startYear + ", endYear=" + endYear + ", movieStatus=" + movieStatus + "]";
	}

	public List<String> getGenreList() {
		return genreList;
	}

	public void setGenreList(List<String> genreList) {
		this.genreList = genreList;
	}

	public List<String> getRatingList() {
		return ratingList;
	}

	public void setRatingList(List<String> ratingList) {
		this.ratingList = ratingList;
	}

	public String getMovieStatus() {
		return movieStatus;
	}

	public void setMovieStatus(String movieStatus) {
		this.movieStatus = movieStatus;
	}
	
	
	
}
