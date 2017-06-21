package com.gigabox.admin.user.vo;

import java.sql.Date;

public class UserVO {

	private int userNumber;
	private String userId;
	private String userPw;
	private String userName;
	private String userGender;
	private String userBirthday;
	private String userEmail;
	private String userTel;
	private String userAddr;
	private Date userReg;
	private String userAgree;
	private int userMileage;
	private String userJoinAuth;
	private String userStatus;
	
	@Override
	public String toString() {
		return "UserVO [userNumber=" + userNumber + ", userId=" + userId + ", userPw=" + userPw + ", userName="
				+ userName + ", userGender=" + userGender + ", userBirthday=" + userBirthday + ", userEmail="
				+ userEmail + ", userTel=" + userTel + ", userAddr=" + userAddr + ", userReg=" + userReg
				+ ", userAgree=" + userAgree + ", userMileage=" + userMileage + ", userJoinAuth=" + userJoinAuth
				+ ", userStatus=" + userStatus + "]";
	}
	
	public int getUserNumber() {
		return userNumber;
	}
	public void setUserNumber(int userNumber) {
		this.userNumber = userNumber;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserBirthday() {
		return userBirthday;
	}
	public void setUserBirthday(String userBirthday) {
		this.userBirthday = userBirthday;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public String getUserAddr() {
		return userAddr;
	}
	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}
	public Date getUserReg() {
		return userReg;
	}
	public void setUserReg(Date userReg) {
		this.userReg = userReg;
	}
	public String getUserAgree() {
		return userAgree;
	}
	public void setUserAgree(String userAgree) {
		this.userAgree = userAgree;
	}
	public int getUserMileage() {
		return userMileage;
	}
	public void setUserMileage(int userMileage) {
		this.userMileage = userMileage;
	}
	public String getUserJoinAuth() {
		return userJoinAuth;
	}
	public void setUserJoinAuth(String userJoinAuth) {
		this.userJoinAuth = userJoinAuth;
	}
	public String getUserStatus() {
		return userStatus;
	}
	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}
	
}