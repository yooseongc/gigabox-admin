package com.gigabox.admin.cc.vo;

public class InquiryVO {
	
	private int userNumber; // 회원번호
	private int inquiryNumber; // 문의번호
	private int inquiryGroupNumber; // 글 그룹번호
	private String inquiryTitle; // 제목
	private String inquiryCotnent; // 내용
	private String inquiryRegisterdate; // 등록일
	private String inquiryQora; // 답변 여부

	public int getUserNumber() {
		return userNumber;
	}

	public void setUserNumber(int userNumber) {
		this.userNumber = userNumber;
	}

	public int getInquiryNumber() {
		return inquiryNumber;
	}

	public void setInquiryNumber(int inquiryNumber) {
		this.inquiryNumber = inquiryNumber;
	}

	public int getInquiryGroupNumber() {
		return inquiryGroupNumber;
	}

	public void setInquiryGroupNumber(int inquiryGroupNumber) {
		this.inquiryGroupNumber = inquiryGroupNumber;
	}

	public String getInquiryTitle() {
		return inquiryTitle;
	}

	public void setInquiryTitle(String inquiryTitle) {
		this.inquiryTitle = inquiryTitle;
	}

	public String getInquiryCotnent() {
		return inquiryCotnent;
	}

	public void setInquiryCotnent(String inquiryCotnent) {
		this.inquiryCotnent = inquiryCotnent;
	}

	public String getInquiryRegisterdate() {
		return inquiryRegisterdate;
	}

	public void setInquiryRegisterdate(String inquiryRegisterdate) {
		this.inquiryRegisterdate = inquiryRegisterdate;
	}

	public String getInquiryQora() {
		return inquiryQora;
	}

	public void setInquiryQora(String inquiryQora) {
		this.inquiryQora = inquiryQora;
	}

	@Override
	public String toString() {
		return "InquiryVO [userNumber=" + userNumber + ", inquiryNumber=" + inquiryNumber + ", inquiryGroupNumber="
				+ inquiryGroupNumber + ", inquiryTitle=" + inquiryTitle + ", inquiryCotnent=" + inquiryCotnent
				+ ", inquiryRegisterdate=" + inquiryRegisterdate + ", inquiryQora=" + inquiryQora + "]";
}
}
