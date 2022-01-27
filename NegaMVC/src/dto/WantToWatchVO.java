package dto;

public class WantToWatchVO {
	private String memberId;
	private String movieCode;
	private int dayAdded;
	
	public WantToWatchVO() {}
	public WantToWatchVO(String memberId, String movieCode, int dayAdded) {
		this.memberId = memberId;
		this.movieCode = movieCode;
		this.dayAdded = dayAdded;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMovieCode() {
		return movieCode;
	}
	public void setMovieCode(String movieCode) {
		this.movieCode = movieCode;
	}
	public int getDayAdded() {
		return dayAdded;
	}
	public void setDayAdded(int dayAdded) {
		this.dayAdded = dayAdded;
	}
	
	
}
