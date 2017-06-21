package com.gigabox.admin.cc.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.gigabox.admin.common.Criteria;

public class FaqSearchCriteria extends Criteria {
	
	private String searchType;
	private String searchKeyword;
	
	public String makeQuery(int page) {
		UriComponents uriComponents = 
			UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", this.perPageNum)
				.queryParam("searchType", searchType)
				.queryParam("searchKeyword", encoding(searchKeyword))
				.build();
		return uriComponents.toString();
	}
	
	@Override
	public String toString() {
		return "FaqSearchCriteria [searchType=" + searchType + ", searchKeyword=" + searchKeyword + ", page=" + page
				+ ", perPageNum=" + perPageNum + ", getPageStart()=" + getPageStart() + ", getPageEnd()=" + getPageEnd()
				+ "]";
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
	
}
