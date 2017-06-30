package com.gigabox.admin.cinema.vo;

import java.util.Date;

public class ScheduleVO {
	
	// 기본 필드
	private int scheduleNumber; 	// 상영 일정 번호
	private int movieNumber;		// 영화 번호 (FK)
	private int movieroomNumber;	// 상영관 번호 (FK)
	private String scheduleType;	// 상영 타입  ex) 2D 자막
	private Date scheduleStart;		// 상영 시작 시간 : 0년 0월 0일 0시 0분
	private Date scheduleEnd;		// 상영 종료 시간
	
	// 영화 관련 필드
	private String movieTitle;
	private String movieType;
	private String movieReleasedate;
	private String movieStatus;
	private int movieScreentime;
	
	// 영화관, 상영관 관련
	private String movieroomName;
	private String movieroom2D;
	private String movieroom3D;
	private String movieroom4D;
	private int branchNumber;
	private String branchName;
	
	public int getScheduleNumber() {
		return scheduleNumber;
	}
	public void setScheduleNumber(int scheduleNumber) {
		this.scheduleNumber = scheduleNumber;
	}
	public int getMovieNumber() {
		return movieNumber;
	}
	public void setMovieNumber(int movieNumber) {
		this.movieNumber = movieNumber;
	}
	public int getMovieroomNumber() {
		return movieroomNumber;
	}
	public void setMovieroomNumber(int movieroomNumber) {
		this.movieroomNumber = movieroomNumber;
	}
	public String getScheduleType() {
		return scheduleType;
	}
	public void setScheduleType(String scheduleType) {
		this.scheduleType = scheduleType;
	}
	public Date getScheduleStart() {
		return scheduleStart;
	}
	public void setScheduleStart(Date scheduleStart) {
		this.scheduleStart = scheduleStart;
	}
	public Date getScheduleEnd() {
		return scheduleEnd;
	}
	public void setScheduleEnd(Date scheduleEnd) {
		this.scheduleEnd = scheduleEnd;
	}
	public String getMovieTitle() {
		return movieTitle;
	}
	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}
	public String getMovieType() {
		return movieType;
	}
	public void setMovieType(String movieType) {
		this.movieType = movieType;
	}
	public String getMovieReleasedate() {
		return movieReleasedate;
	}
	public void setMovieReleasedate(String movieReleasedate) {
		this.movieReleasedate = movieReleasedate;
	}
	public int getMovieScreentime() {
		return movieScreentime;
	}
	public void setMovieScreentime(int movieScreentime) {
		this.movieScreentime = movieScreentime;
	}
	public String getMovieroomName() {
		return movieroomName;
	}
	public void setMovieroomName(String movieroomName) {
		this.movieroomName = movieroomName;
	}
	public String getMovieroom2D() {
		return movieroom2D;
	}
	public void setMovieroom2D(String movieroom2d) {
		movieroom2D = movieroom2d;
	}
	public String getMovieroom3D() {
		return movieroom3D;
	}
	public void setMovieroom3D(String movieroom3d) {
		movieroom3D = movieroom3d;
	}
	public String getMovieroom4D() {
		return movieroom4D;
	}
	public void setMovieroom4D(String movieroom4d) {
		movieroom4D = movieroom4d;
	}
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
	
	@Override
	public String toString() {
		return "ScheduleVO [scheduleNumber=" + scheduleNumber + ", movieNumber=" + movieNumber + ", movieroomNumber="
				+ movieroomNumber + ", scheduleType=" + scheduleType + ", scheduleStart=" + scheduleStart
				+ ", scheduleEnd=" + scheduleEnd + ", movieTitle=" + movieTitle + ", movieType=" + movieType
				+ ", movieReleasedate=" + movieReleasedate + ", movieScreentime=" + movieScreentime + ", movieroomName="
				+ movieroomName + ", movieroom2D=" + movieroom2D + ", movieroom3D=" + movieroom3D + ", movieroom4D="
				+ movieroom4D + ", branchNumber=" + branchNumber + ", branchName=" + branchName + "]";
	}
	public String getMovieStatus() {
		return movieStatus;
	}
	public void setMovieStatus(String movieStatus) {
		this.movieStatus = movieStatus;
	}
	
}
