package dto;

public class QuickMovieTimeVO {
	private String startHM; // = "15:10";
	private String endHM; // = "17:48";
	private String movieName; // = "스파이더맨:노 웨이 홈";
	private String type; // = "2D(자막)";
	private String theaterName; // = "강남";
	private String showroomName; // = "6관[백신패스관]";
	private int curr; // = 36;      // 현재예매좌석수
	private int total; // = 103;   // 총좌석수
	
	public QuickMovieTimeVO() { }
	public QuickMovieTimeVO(String startHM, String endHM, String movieName, String type, String theaterName,
			String showroomName, int curr, int total) {
		this.startHM = startHM;
		this.endHM = endHM;
		this.movieName = movieName;
		this.type = type;
		this.theaterName = theaterName;
		this.showroomName = showroomName;
		this.curr = curr;
		this.total = total;
	}
	
	public String getStartHM() {
		return startHM;
	}
	public void setStartHM(String startHM) {
		this.startHM = startHM;
	}
	public String getEndHM() {
		return endHM;
	}
	public void setEndHM(String endHM) {
		this.endHM = endHM;
	}
	public String getMovieName() {
		return movieName;
	}
	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTheaterName() {
		return theaterName;
	}
	public void setTheaterName(String theaterName) {
		this.theaterName = theaterName;
	}
	public String getShowroomName() {
		return showroomName;
	}
	public void setShowroomName(String showroomName) {
		this.showroomName = showroomName;
	}
	public int getCurr() {
		return curr;
	}
	public void setCurr(int curr) {
		this.curr = curr;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	@Override
	public String toString() {
		return "VO객체 [" + startHM + "," + endHM + "," + movieName + ","
				+ type + "," + theaterName + "," + showroomName + "," + curr
				+ "," + total + "]";
	}
	
	
}
