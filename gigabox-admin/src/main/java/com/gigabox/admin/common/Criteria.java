package com.gigabox.admin.common;

public class Criteria {
	
	protected int page;
	protected int perPageNum;

	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = 10;
	}
	
	public int getPage() {
		return page;
	}
	
	// For Mapper
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	// For Mapper
	public int getPageStart() {
		return (this.page - 1) * perPageNum + 1;
	}
	
	// For Mapper
	public int getPageEnd() {
		return this.page * perPageNum;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", getPageStart()=" + getPageStart()
				+ ", getPageEnd()=" + getPageEnd() + "]";
	}
	
	
}
