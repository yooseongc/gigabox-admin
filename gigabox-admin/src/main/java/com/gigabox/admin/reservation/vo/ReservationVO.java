package com.gigabox.admin.reservation.vo;

import java.util.Date;

public class ReservationVO {
	
	/*
	 * reservationStatus
	 * 예매 상태는 아래와 같이 분류한다.
	 * 1 좌석선택
	 * 2 예매완료
	 * 3 예매취소
	 */
	
	// 예매 기본
	private int reservationNumber;			// 예약 번호(PK)
	private Date reservationRegisterdate;	// 예약 등록일 default SYSDATE
	private int reservationStatus;			// 예매 상태 (1, 2, 3)
	private int reservationAdultnum;		// 성인 예매 수
	private int reservationYouthnum;		// 청소년 예매 수
	private int reservationChildnum;		// 아동 예매 수
	private int reservationPreferencenum;	// 우대 예매 수
	
	// 결제
	private int reservationUsingmileage;	// 결제시 사용 마일리지 default 0
	private int reservationPayamount;		// 결제 총 금액(원)
	private String reservationPaymethod;	// 결제 수단 (신용카드, 계좌이체, 현장결제)
	private Date reservationPaymentdate;	// 결제일 
	private String reservationSeat1;		// 좌석1
	private String reservationSeat2;		// 좌석2
	private String reservationSeat3;		// 좌석3
	private String reservationSeat4;		// 좌석4
	private String reservationSeat5;		// 좌석5
	private String reservationSeat6;		// 좌석6
	private String reservationCode;			// 예매 코드 TR-(영화5자리)-(영화관3자리)-(상영관2자리)-(1706280630;시작시간)
	
	// 회원
	private int userNumber;
	private String userId;
	private String userName;
	private int userMileage;
	
	// 상영 일정
	private int scheduleNumber;
	private String scheduleType;
	private Date scheduleStart;
	private Date scheduleEnd;
	
	// 영화 정보
	private int movieNumber;
	private String movieTitle;
	private String movieType;
	private String movieRating;
	private int movieScreentime;
	
	// 지점 정보
	private int branchNumber;
	private String branchName;
	
	// 상영관 정보
	private int movieroomNumber;
	private String movieroomName;
	
	@Override
	public String toString() {
		return "ReservationVO [reservationNumber=" + reservationNumber + ", reservationRegisterdate="
				+ reservationRegisterdate + ", reservationStatus=" + reservationStatus + ", reservationAdultnum="
				+ reservationAdultnum + ", reservationYouthnum=" + reservationYouthnum + ", reservationChildnum="
				+ reservationChildnum + ", reservationPreferencenum=" + reservationPreferencenum
				+ ", reservationUsingmileage=" + reservationUsingmileage + ", reservationPayamount="
				+ reservationPayamount + ", reservationPaymethod=" + reservationPaymethod + ", reservationPaymentdate="
				+ reservationPaymentdate + ", reservationSeat1=" + reservationSeat1 + ", reservationSeat2="
				+ reservationSeat2 + ", reservationSeat3=" + reservationSeat3 + ", reservationSeat4=" + reservationSeat4
				+ ", reservationSeat5=" + reservationSeat5 + ", reservationSeat6=" + reservationSeat6
				+ ", reservationCode=" + reservationCode + ", userNumber=" + userNumber + ", userId=" + userId
				+ ", userName=" + userName + ", userMileage=" + userMileage + ", scheduleNumber=" + scheduleNumber
				+ ", scheduleType=" + scheduleType + ", scheduleStart=" + scheduleStart + ", scheduleEnd=" + scheduleEnd
				+ ", movieNumber=" + movieNumber + ", movieTitle=" + movieTitle + ", movieType=" + movieType
				+ ", movieRating=" + movieRating + ", movieScreentime=" + movieScreentime + ", branchNumber="
				+ branchNumber + ", branchName=" + branchName + ", movieroomNumber=" + movieroomNumber + 
				", movieroomName=" + movieroomName +"]";
	}

	public int getReservationNumber() {
		return reservationNumber;
	}

	public void setReservationNumber(int reservationNumber) {
		this.reservationNumber = reservationNumber;
	}

	public Date getReservationRegisterdate() {
		return reservationRegisterdate;
	}

	public void setReservationRegisterdate(Date reservationRegisterdate) {
		this.reservationRegisterdate = reservationRegisterdate;
	}

	public int getReservationStatus() {
		return reservationStatus;
	}

	public void setReservationStatus(int reservationStatus) {
		this.reservationStatus = reservationStatus;
	}

	public int getReservationAdultnum() {
		return reservationAdultnum;
	}

	public void setReservationAdultnum(int reservationAdultnum) {
		this.reservationAdultnum = reservationAdultnum;
	}

	public int getReservationYouthnum() {
		return reservationYouthnum;
	}

	public void setReservationYouthnum(int reservationYouthnum) {
		this.reservationYouthnum = reservationYouthnum;
	}

	public int getReservationChildnum() {
		return reservationChildnum;
	}

	public void setReservationChildnum(int reservationChildnum) {
		this.reservationChildnum = reservationChildnum;
	}

	public int getReservationPreferencenum() {
		return reservationPreferencenum;
	}

	public void setReservationPreferencenum(int reservationPreferencenum) {
		this.reservationPreferencenum = reservationPreferencenum;
	}

	public int getReservationUsingmileage() {
		return reservationUsingmileage;
	}

	public void setReservationUsingmileage(int reservationUsingmileage) {
		this.reservationUsingmileage = reservationUsingmileage;
	}

	public int getReservationPayamount() {
		return reservationPayamount;
	}

	public void setReservationPayamount(int reservationPayamount) {
		this.reservationPayamount = reservationPayamount;
	}

	public String getReservationPaymethod() {
		return reservationPaymethod;
	}

	public void setReservationPaymethod(String reservationPaymethod) {
		this.reservationPaymethod = reservationPaymethod;
	}

	public Date getReservationPaymentdate() {
		return reservationPaymentdate;
	}

	public void setReservationPaymentdate(Date reservationPaymentdate) {
		this.reservationPaymentdate = reservationPaymentdate;
	}

	public String getReservationSeat1() {
		return reservationSeat1;
	}

	public void setReservationSeat1(String reservationSeat1) {
		this.reservationSeat1 = reservationSeat1;
	}

	public String getReservationSeat2() {
		return reservationSeat2;
	}

	public void setReservationSeat2(String reservationSeat2) {
		this.reservationSeat2 = reservationSeat2;
	}

	public String getReservationSeat3() {
		return reservationSeat3;
	}

	public void setReservationSeat3(String reservationSeat3) {
		this.reservationSeat3 = reservationSeat3;
	}

	public String getReservationSeat4() {
		return reservationSeat4;
	}

	public void setReservationSeat4(String reservationSeat4) {
		this.reservationSeat4 = reservationSeat4;
	}

	public String getReservationSeat5() {
		return reservationSeat5;
	}

	public void setReservationSeat5(String reservationSeat5) {
		this.reservationSeat5 = reservationSeat5;
	}

	public String getReservationSeat6() {
		return reservationSeat6;
	}

	public void setReservationSeat6(String reservationSeat6) {
		this.reservationSeat6 = reservationSeat6;
	}

	public String getReservationCode() {
		return reservationCode;
	}

	public void setReservationCode(String reservationCode) {
		this.reservationCode = reservationCode;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getUserMileage() {
		return userMileage;
	}

	public void setUserMileage(int userMileage) {
		this.userMileage = userMileage;
	}

	public int getScheduleNumber() {
		return scheduleNumber;
	}

	public void setScheduleNumber(int scheduleNumber) {
		this.scheduleNumber = scheduleNumber;
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

	public int getMovieNumber() {
		return movieNumber;
	}

	public void setMovieNumber(int movieNumber) {
		this.movieNumber = movieNumber;
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

	public String getMovieRating() {
		return movieRating;
	}

	public void setMovieRating(String movieRating) {
		this.movieRating = movieRating;
	}

	public int getMovieScreentime() {
		return movieScreentime;
	}

	public void setMovieScreentime(int movieScreentime) {
		this.movieScreentime = movieScreentime;
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

	public int getMovieroomNumber() {
		return movieroomNumber;
	}

	public void setMovieroomNumber(int movieroomNumber) {
		this.movieroomNumber = movieroomNumber;
	}

	public String getMovieroomName() {
		return movieroomName;
	}

	public void setMovieroomName(String movieroomName) {
		this.movieroomName = movieroomName;
	}

	
}
