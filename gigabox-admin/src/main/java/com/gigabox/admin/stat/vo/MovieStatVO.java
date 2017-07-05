package com.gigabox.admin.stat.vo;

public class MovieStatVO {

	/*
	 * <resultMap type="movieStat" id="movieStatResultMap">
		<result property="movie" column="MOVIE" />
		<result property="count" column="COUNT" />
		<result property="time" column="TIME" />
		<result property="total" column="TOTAL" />
		<result property="average" column="AVERAGE" />
	   </resultMap>
	 * 
	 */
	
	private String movie;		// '영화제목', '전체'
	private int count;			// 수
	private String time;		// '2017-07'
	private int total;			// 합계
	private double average;		// 평균
	
	public String getMovie() {
		return movie;
	}

	public void setMovie(String movie) {
		this.movie = movie;
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

	@Override
	public String toString() {
		return "MovieStatVO [movie=" + movie + ", count=" + count + ", time=" + time + ", total=" + total + ", average="
				+ average + "]";
	}
	
}
