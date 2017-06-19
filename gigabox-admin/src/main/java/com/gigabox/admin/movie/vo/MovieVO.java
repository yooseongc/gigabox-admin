/**
 * 
 */
package com.gigabox.admin.movie.vo;



public class MovieVO {
	
	private int movieNumber;
	private String movieTitle;
	private String movieType;
	private String movieRating;
	private String movieReleasedate;
	private String movieDirector;
	private String movieCast;
	private int movieScreentime;
	private String movieGenre;
	private String movieStoryline;
	private String movieEngname;
	private String moviePoster;
	private String movieSteelcut;
	private String movieTrailer;
	private int movieCode;
	private String movieStatus;
	
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
	public String getMovieReleasedate() {
		return movieReleasedate;
	}
	public void setMovieReleasedate(String movieReleasedate) {
		this.movieReleasedate = movieReleasedate;
	}
	public String getMovieDirector() {
		return movieDirector;
	}
	public void setMovieDirector(String movieDirector) {
		this.movieDirector = movieDirector;
	}
	public String getMovieCast() {
		return movieCast;
	}
	public void setMovieCast(String movieCast) {
		this.movieCast = movieCast;
	}
	public int getMovieScreentime() {
		return movieScreentime;
	}
	public void setMovieScreentime(int movieScreentime) {
		this.movieScreentime = movieScreentime;
	}
	public String getMovieGenre() {
		return movieGenre;
	}
	public void setMovieGenre(String movieGenre) {
		this.movieGenre = movieGenre;
	}
	public String getMovieStoryline() {
		return movieStoryline;
	}
	public void setMovieStoryline(String movieStoryline) {
		this.movieStoryline = movieStoryline;
	}
	public String getMovieEngname() {
		return movieEngname;
	}
	public void setMovieEngname(String movieEngname) {
		this.movieEngname = movieEngname;
	}
	public String getMoviePoster() {
		return moviePoster;
	}
	public void setMoviePoster(String moviePoster) {
		this.moviePoster = moviePoster;
	}
	public String getMovieSteelcut() {
		return movieSteelcut;
	}
	public void setMovieSteelcut(String movieSteelcut) {
		this.movieSteelcut = movieSteelcut;
	}
	public String getMovieTrailer() {
		return movieTrailer;
	}
	public void setMovieTrailer(String movieTrailer) {
		this.movieTrailer = movieTrailer;
	}
	public int getMovieCode() {
		return movieCode;
	}
	public void setMovieCode(int movieCode) {
		this.movieCode = movieCode;
	}
	public String getMovieStatus() {
		return movieStatus;
	}
	public void setMovieStatus(String movieStatus) {
		this.movieStatus = movieStatus;
	}
	
	@Override
	public String toString() {
		return "MovieVO [movieNumber=" + movieNumber + ", movieTitle=" + movieTitle + ", movieType=" + movieType
				+ ", movieRating=" + movieRating + ", movieReleasedate=" + movieReleasedate + ", movieDirector="
				+ movieDirector + ", movieCast=" + movieCast + ", movieScreentime=" + movieScreentime + ", movieGenre="
				+ movieGenre + ", movieStoryline=" + movieStoryline + ", movieEngname=" + movieEngname
				+ ", moviePoster=" + moviePoster + ", movieSteelcut=" + movieSteelcut + ", movieTrailer=" + movieTrailer
				+ ", movieCode=" + movieCode + ", movieStatus=" + movieStatus + "]";
	}
	
}
