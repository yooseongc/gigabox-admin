package com.gigabox.admin.cinema.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.gigabox.admin.common.Criteria;

public class ScheduleSearchCriteria extends Criteria {

	
	/*
	 * 본 클래스는 상영일정의 검색 기능을 지원한다.
	 * 상영 일정의 경우 상영 날짜, 영화 제목, 상영관 이름 별로 검색이 가능하다.
	 * 
	 */
	
	private String searchType;		// 영화 제목(t), 상영관 이름(b)
	private String searchKeyword;
	private Date scheduleStart;		// 상영 시작 시간
	private Date scheduleEnd;		// 상영 종료 시간
	
	private int branchNumber;
	private int movieroomNumber;
	private String movieStatus; // 상영 타입
	
	public String makeQuery(int page) {
		UriComponents uriComponents = 
			UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", this.perPageNum)
				.queryParam("searchType", searchType)
				.queryParam("searchKeyword", encoding(searchKeyword))
				.queryParam("scheduleStart", scheduleStart)
				.queryParam("scheduleEnd", scheduleEnd)
				.queryParam("movieStatus", movieStatus)
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


	public Date getScheduleStart() {
		return scheduleStart;
	}


	public void setScheduleStart(Date scheduleStart) {
		this.scheduleStart = scheduleStart;
	}


	public Date getScheduleEnd() {
		return scheduleEnd;
	}


	public void setScheduleEnd(Date scheduleEnd) {
		this.scheduleEnd = scheduleEnd;
	}

	@Override
	public String toString() {
		return "ScheduleSearchCriteria [searchType=" + searchType + ", searchKeyword=" + searchKeyword
				+ ", scheduleStart=" + scheduleStart + ", scheduleEnd=" + scheduleEnd + ", getPage()=" + getPage()
				+ ", getPerPageNum()=" + getPerPageNum() + ", getPageStart()=" + getPageStart() + ", getPageEnd()="
				+ getPageEnd() + "]";
	}

	public int getBranchNumber() {
		return branchNumber;
	}

	public void setBranchNumber(int branchNumber) {
		this.branchNumber = branchNumber;
	}

	public int getMovieroomNumber() {
		return movieroomNumber;
	}

	public void setMovieroomNumber(int movieroomNumber) {
		this.movieroomNumber = movieroomNumber;
	}

	public String getMovieStatus() {
		return movieStatus;
	}

	public void setMovieStatus(String movieStatus) {
		this.movieStatus = movieStatus;
	}
	
}
