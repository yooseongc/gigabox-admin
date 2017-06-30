package com.gigabox.admin.cinema.vo;

public class MovieroomVO {
	
	private int movieroomNumber;
	private int branchNumber;
	private String movieroom2D;
	private String movieroom3D;
	private String movieroom4D;
	private String movieroomSeatdata;
	private String movieroomName;
	
	public int getMovieroomNumber() {
		return movieroomNumber;
	}

	public void setMovieroomNumber(int movieroomNumber) {
		this.movieroomNumber = movieroomNumber;
	}

	public int getBranchNumber() {
		return branchNumber;
	}

	public void setBranchNumber(int branchNumber) {
		this.branchNumber = branchNumber;
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

	public String getMovieroomSeatdata() {
		return movieroomSeatdata;
	}

	public void setMovieroomSeatdata(String movieroomSeatdata) {
		this.movieroomSeatdata = movieroomSeatdata;
	}

	public String getMovieroomName() {
		return movieroomName;
	}

	public void setMovieroomName(String movieroomName) {
		this.movieroomName = movieroomName;
	}
	
	@Override
	public String toString() {
		return "MovieroomVO [movieroomNumber=" + movieroomNumber + ", branchNumber=" + branchNumber + ", movieroom2D="
				+ movieroom2D + ", movieroom3D=" + movieroom3D + ", movieroom4D=" + movieroom4D + ", movieroomSeatdata="
				+ movieroomSeatdata + ", movieroomName=" + movieroomName + "]";
	}
	
}
