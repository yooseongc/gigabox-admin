package com.gigabox.admin.user.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.gigabox.admin.common.Criteria;

public class UserSearchCriteria extends Criteria {

	private String searchType;
	private String searchKeyword;
	private String startDate;
	private String endDate;
	private String searchStatus;
	
	public String makeQuery(int page) {
		UriComponents uriComponents = 
			UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", this.perPageNum)
				.queryParam("searchType", searchType)
				.queryParam("searchKeyword", encoding(searchKeyword))
				.queryParam("startDate", startDate)
				.queryParam("endDate", endDate)
				.queryParam("userStatus", encoding(searchStatus))
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
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	
	public String getSearchStatus() {
		return searchStatus;
	}
	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
	}
	
	@Override
	public String toString() {
		return "UserSearchCriteria [searchType=" + searchType + ", searchKeyword=" + searchKeyword + ", startDate="
				+ startDate + ", endDate=" + endDate + ", searchStatus=" + searchStatus + ", page=" + page + ", perPageNum="
				+ perPageNum + "]";
	}
	
}
