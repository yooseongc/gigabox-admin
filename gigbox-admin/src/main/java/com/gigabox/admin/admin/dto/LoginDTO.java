package com.gigabox.admin.admin.dto;

public class LoginDTO {
	
	private String adminId;
	private String adminPw;
	private boolean useCookie;
	
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
	public boolean isUseCookie() {
		return useCookie;
	}
	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}
	
	@Override
	public String toString() {
		return "LoginDTO [adminId=" + adminId + ", adminPw=" + adminPw + ", useCookie=" + useCookie + "]";
	}
	
}
