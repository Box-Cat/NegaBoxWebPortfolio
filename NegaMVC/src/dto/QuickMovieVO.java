package dto;

public class QuickMovieVO {
	private String movieCode;
	private String rating;    // "15세이상관람가", "12세이상관람가", "전체관람가", "청소년관람불가"
	private String movieName;
	private byte wantToWatch;   // 1 or 0
	private String moviePhoto;
	
	public QuickMovieVO() { }
	public QuickMovieVO(String movieCode, String rating, String movieName, byte wantToWatch, String moviePhoto) {
		this.movieCode = movieCode; //
		this.rating = rating;
		this.movieName = movieName;
		this.wantToWatch = wantToWatch;
		this.moviePhoto = moviePhoto;
	}
	
	public String getMovieCode() {
		return movieCode;
	}
	public void setMovieCode(String movieCode) {
		this.movieCode = movieCode;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public byte getWantToWatch() {
		return wantToWatch;
	}
	public void setWantToWatch(byte wantToWatch) {
		this.wantToWatch = wantToWatch;
	}
	public String getMoviePhoto() {
		return moviePhoto;
	}
	public void setMoviePhoto(String moviePhoto) {
		this.moviePhoto = moviePhoto;
	}
	@Override
	public String toString() {
		return "QuickMovieVO객체 [movieCode=" + movieCode + ", rating=" + rating + ", movieName=" + movieName
				+ ", wantToWatch=" + wantToWatch + ", moviePhoto=" + moviePhoto + "]";
	}
	
	
}
