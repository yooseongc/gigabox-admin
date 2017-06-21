package com.gigabox.admin.cc.vo;

public class FaqVO {
	
	private int faqNumber; //공지번호
	private int adminNumber;//관리자번호
	private String faqTitle; //제목
	private String faqContent; //내용
	private String faqType; //질문 유형

	public int getFaqNumber() {
		return faqNumber;
	}

	public void setFaqNumber(int faqNumber) {
		this.faqNumber = faqNumber;
	}

	public int getAdminNumber() {
		return adminNumber;
	}

	public void setAdminNumber(int adminNumber) {
		this.adminNumber = adminNumber;
	}

	public String getFaqTitle() {
		return faqTitle;
	}

	public void setFaqTitle(String faqTitle) {
		this.faqTitle = faqTitle;
	}

	public String getFaqContent() {
		return faqContent;
	}

	public void setFaqContent(String faqContent) {
		this.faqContent = faqContent;
	}

	public String getFaqType() {
		return faqType;
	}

	public void setFaqType(String faqType) {
		this.faqType = faqType;
	}

	@Override
	public String toString() {
		return "FaqVO [faqNumber=" + faqNumber + ", adminNumber=" + adminNumber + ", faqTitle=" + faqTitle
				+ ", faqContent=" + faqContent + ", faqType=" + faqType + "]";
	}

}
