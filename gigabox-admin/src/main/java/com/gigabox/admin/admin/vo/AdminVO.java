package com.gigabox.admin.admin.vo;

public class AdminVO {
	
	private int adminNumber;
	private String adminId;
	private String adminPw;
	
	public int getAdminNumber() {
		return adminNumber;
	}
	public void setAdminNumber(int adminNumber) {
		this.adminNumber = adminNumber;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPw() {
		return adminPw;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}
	
	@Override
	public String toString() {
		return "AdminVO [adminNumber=" + adminNumber + ", adminId=" + adminId + ", adminPw=" + adminPw + "]";
	}
	
}
