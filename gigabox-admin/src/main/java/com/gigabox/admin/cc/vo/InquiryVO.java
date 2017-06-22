package com.gigabox.admin.cc.vo;

import java.util.Date;

public class InquiryVO {
	
	private int userNumber; // 회원번호
	private int inquiryNumber; // 문의번호
	private int inquiryGroupnumber; // 글 그룹번호
	private String inquiryTitle; // 제목
	private String inquiryContent; // 내용
	private Date inquiryRegisterdate; // 등록일
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

	public int getInquiryGroupnumber() {
		return inquiryGroupnumber;
	}

	public void setInquiryGroupnumber(int inquiryGroupnumber) {
		this.inquiryGroupnumber = inquiryGroupnumber;
	}

	public String getInquiryTitle() {
		return inquiryTitle;
	}

	public void setInquiryTitle(String inquiryTitle) {
		this.inquiryTitle = inquiryTitle;
	}

	public String getInquiryContent() {
		return inquiryContent;
	}

	public void setInquiryContent(String inquiryContent) {
		this.inquiryContent = inquiryContent;
	}

	public Date getInquiryRegisterdate() {
		return inquiryRegisterdate;
	}

	public void setInquiryRegisterdate(Date inquiryRegisterdate) {
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
		return "InquiryVO [userNumber=" + userNumber + ", inquiryNumber=" + inquiryNumber + ", inquiryGroupnumber="
				+ inquiryGroupnumber + ", inquiryTitle=" + inquiryTitle + ", inquiryContent=" + inquiryContent
				+ ", inquiryRegisterdate=" + inquiryRegisterdate + ", inquiryQora=" + inquiryQora + "]";
}
}
