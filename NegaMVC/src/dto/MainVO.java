package dto;

public class MainVO {
	private String movieCode;
	private String moviePhoto;
	private String plot;
	private int dolby;
	private int mx;
	private String movieName;
	
	public MainVO() {}
	public MainVO(String movieCode, String moviePhoto, String plot, int dolby, int mx, String movieName) {
		this.movieCode = movieCode;
		this.moviePhoto = moviePhoto;
		this.plot = plot;
		this.dolby = dolby;
		this.mx = mx;
		this.movieName = movieName;
	}
	
	
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getMovieCode() {
		return movieCode;
	}
	public void setMovieCode(String movieCode) {
		this.movieCode = movieCode;
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
		return "MainVO [movieCode=" + movieCode + ", moviePhoto=" + moviePhoto + ", plot=" + plot + ", dolby=" + dolby
				+ ", mx=" + mx + ", movieName=" + movieName + "]";
	}
	
	
}
