package com.gigabox.admin.cinema.vo;

public class BranchVO {
	
	private int branchNumber;
	private String branchName;
	private String branchAddress;
	private String branchPicture;
	
	public int getBranchNumber() {
		return branchNumber;
	}
	public void setBranchNumber(int branchNumber) {
		this.branchNumber = branchNumber;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getBranchAddress() {
		return branchAddress;
	}
	public void setBranchAddress(String branchAddress) {
		this.branchAddress = branchAddress;
	}
	public String getBranchPicture() {
		return branchPicture;
	}
	public void setBranchPicture(String branchPicture) {
		this.branchPicture = branchPicture;
	}
	
	@Override
	public String toString() {
		return "BranchVO [branchNumber=" + branchNumber + ", branchName=" + branchName + ", branchAddress="
				+ branchAddress + ", branchPicture=" + branchPicture + "]";
	}
	
}
