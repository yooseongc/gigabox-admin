package com.gigabox.admin.cinema.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.gigabox.admin.common.Criteria;

public class BranchSearchCriteria extends Criteria {
	
	private String branchLocation;	// 지역명 (e.g. 서울)
	private String branchLocationName;  // 실제 이름 (e.g. 서울 수유점)
	
	public String getBranchLocation() {
		return branchLocation;
	}

	public void setBranchLocation(String branchLocation) {
		this.branchLocation = branchLocation;
	}

	public String getBranchLocationName() {
		return branchLocationName;
	}

	public void setBranchLocationName(String branchLocationName) {
		this.branchLocationName = branchLocationName;
	}

	@Override
	public String toString() {
		return "BranchSearchCriteria [branchLocation=" + branchLocation + ", branchLocationName=" + branchLocationName + ", getPage()="
				+ getPage() + ", getPerPageNum()=" + getPerPageNum() + ", getPageStart()=" + getPageStart()
				+ ", getPageEnd()=" + getPageEnd() + ", toString()=" + super.toString() + "]";
	}

	public String makeQuery(int page) {
		UriComponents uriComponents = 
			UriComponentsBuilder.newInstance()
				.queryParam("page", page)
				.queryParam("perPageNum", this.perPageNum)
				.queryParam("branchLocation", encoding(branchLocation))
				.queryParam("branchLocationName", encoding(branchLocationName))
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
	
	
	
}
