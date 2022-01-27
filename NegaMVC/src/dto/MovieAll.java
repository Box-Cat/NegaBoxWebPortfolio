package dto;

import java.util.Date;

public class MovieAll {
	private String movieCode;			
	private String movieName;
	private Date openingDay;
	private String rating;
	private String moviePhoto;
	private String plot;
	private int dolby;
	private int mx;
	
	public MovieAll() {};
	public MovieAll(String movieCode, String movieName, Date openingDay, String rating, String moviePhoto,
			String plot, int dolby, int mx) {
		this.movieCode = movieCode;
		this.movieName = movieName;
		this.openingDay = openingDay;
		this.rating = rating;
		this.moviePhoto = moviePhoto;
		this.plot = plot;
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
	public Date getOpeningDay() {
		return openingDay;
	}
	public void setOpeningDay(Date openingDay) {
		this.openingDay = openingDay;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
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
		return "MovieAll [movieCode=" + movieCode + ", movieName=" + movieName + ", openingDay=" + openingDay
				+ ", rating=" + rating + ", moviePhoto=" + moviePhoto + ", plot=" + plot + ", dolby=" + dolby + ", mx="
				+ mx + "]";
	}
	
}

