package dto;

import java.util.Date;

public class MovieVO {
	private String movieCode;
	private String movieName;
	private String openingDay;
	private int runningTime;
	private String director;
	private String rating;
	private String casting;
	private String moviePhoto;
	private String plot;
	private String allType;
	private String tag;
	private String engName;
	private String trailer;
	private String trailerSub;
	private String stealCut;
	private String genre;
	private String miniTitle;
	private int dolby;
	private int mx;
	
	public MovieVO() {}
	public MovieVO(String movieCode, String movieName, String openingDay, int runningTime, String director,
			String rating, String casting, String moviePhoto, String plot, String allType, String tag, String engName,
			String trailer, String trailerSub, String stealCut, String genre, String miniTitle, int dolby) {
		this.movieCode = movieCode;
		this.movieName = movieName;
		this.openingDay = openingDay;
		this.runningTime = runningTime;
		this.director = director;
		this.rating = rating;
		this.casting = casting;
		this.moviePhoto = moviePhoto;
		this.plot = plot;
		this.allType = allType;
		this.tag = tag;
		this.engName = engName;
		this.trailer = trailer;
		this.trailerSub = trailerSub;
		this.stealCut = stealCut;
		this.genre = genre;
		this.miniTitle = miniTitle;
		this.dolby = dolby;
		this.mx = mx;
	}

	
	public String getMovieCode() {
		return movieCode;
	}


	public void setMovieCode(String movieCode) {
		this.movieCode = movieCode;
	}


	public String getMovieName() {
		return movieName;
	}


	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}


	public String getOpeningDay() {
		return openingDay;
	}


	public void setOpeningDay(String openingDay) {
		this.openingDay = openingDay;
	}


	public int getRunningTime() {
		return runningTime;
	}


	public void setRunningTime(int runningTime) {
		this.runningTime = runningTime;
	}


	public String getDirector() {
		return director;
	}


	public void setDirector(String director) {
		this.director = director;
	}


	public String getRating() {
		return rating;
	}


	public void setRating(String rating) {
		this.rating = rating;
	}


	public String getCasting() {
		return casting;
	}


	public void setCasting(String casting) {
		this.casting = casting;
	}


	public String getMoviePhoto() {
		return moviePhoto;
	}


	public void setMoviePhoto(String moviePhoto) {
		this.moviePhoto = moviePhoto;
	}


	public String getPlot() {
		return plot;
	}


	public void setPlot(String plot) {
		this.plot = plot;
	}


	public String getAllType() {
		return allType;
	}


	public void setAllType(String allType) {
		this.allType = allType;
	}


	public String getTag() {
		return tag;
	}


	public void setTag(String tag) {
		this.tag = tag;
	}


	public String getEngName() {
		return engName;
	}


	public void setEngName(String engName) {
		this.engName = engName;
	}


	public String getTrailer() {
		return trailer;
	}


	public void setTrailer(String trailer) {
		this.trailer = trailer;
	}


	public String getTrailerSub() {
		return trailerSub;
	}


	public void setTrailerSub(String trailerSub) {
		this.trailerSub = trailerSub;
	}


	public String getStealCut() {
		return stealCut;
	}


	public void setStealCut(String stealCut) {
		this.stealCut = stealCut;
	}


	public String getGenre() {
		return genre;
	}


	public void setGenre(String genre) {
		this.genre = genre;
	}


	public String getMiniTitle() {
		return miniTitle;
	}


	public void setMiniTitle(String miniTitle) {
		this.miniTitle = miniTitle;
	}


	public int getDolby() {
		return dolby;
	}


	public void setDolby(int dolby) {
		this.dolby = dolby;
	}


	public int getMx() {
		return mx;
	}


	public void setMx(int mx) {
		this.mx = mx;
	}
	@Override
	public String toString() {
		return "MovieVO [movieCode=" + movieCode + ", movieName=" + movieName + ", openingDay=" + openingDay
				+ ", runningTime=" + runningTime + ", director=" + director + ", rating=" + rating + ", casting="
				+ casting + ", moviePhoto=" + moviePhoto + ", plot=" + plot + ", allType=" + allType + ", tag=" + tag
				+ ", engName=" + engName + ", trailer=" + trailer + ", trailerSub=" + trailerSub + ", stealCut="
				+ stealCut + ", genre=" + genre + ", miniTitle=" + miniTitle + ", dolby=" + dolby + ", mx=" + mx + "]";
	}

	
}
