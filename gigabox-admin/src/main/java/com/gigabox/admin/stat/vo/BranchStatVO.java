package com.gigabox.admin.stat.vo;

public class BranchStatVO {

	/*
	 * <resultMap type="branchStat" id="branchStatResultMap">
		<result property="branch" column="BRANCH" />
		<result property="status" column="STATUS" />
		<result property="count" column="COUNT" />
		<result property="time" column="TIME" />
		<result property="total" column="TOTAL" />
		<result property="average" column="AVERAGE" />
	   </resultMap>
	 * 
	 */
	
	private String branch;		// '서울 강남점', '전체'
	private String status;		// '예매완료(2)', '예매취소(3)'
	private int count;			// 수
	private String time;		// '2017-07'
	private int total;			// 합계
	private double average;		// 평균
	
	@Override
	public String toString() {
		return "BranchStatVO [branch=" + branch + ", status=" + status + ", count=" + count + ", time=" + time
				+ ", total=" + total + ", average=" + average + "]";
	}
	
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public double getAverage() {
		return average;
	}
	public void setAverage(double average) {
		this.average = average;
	}
	
	
}
