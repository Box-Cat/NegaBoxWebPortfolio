package dto;

public class TheaterStarScheduleVO {
	private String theaterName;  // 강남	"theater_name"
	private String rating;     // 전체이용가, 12세, 15세, 19세
	private String movieName;  
	private String name;       // 신촌 1관 컴포트
	private int totalSeats;     // 총좌석수
	private String type;    // 2D(자막)
	private String startTime;  //DB:"time"     // 상영시간  "03:10"  "time"
	private String endTime;
	private int remainingSeats;
	private int runningTime;
	
	public TheaterStarScheduleVO(String theaterName, String rating, String movieName, String name, int totalSeats,
			String type, String startTime, String endTime, int remainingSeats, int runningTime) {
		this.theaterName = theaterName;
		this.rating = rating;
		this.movieName = movieName;
		this.name = name;
		this.totalSeats = totalSeats;
		this.type = type;
		this.startTime = startTime;
		this.endTime = endTime;
		this.remainingSeats = remainingSeats;
		this.runningTime = runningTime;
	}

	public String getTheaterName() {
		return theaterName;
	}

	public void setTheaterName(String theaterName) {
		this.theaterName = theaterName;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getTotalSeats() {
		return totalSeats;
	}

	public void setTotalSeats(int totalSeats) {
		this.totalSeats = totalSeats;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public int getRemainingSeats() {
		return remainingSeats;
	}

	public void setRemainingSeats(int remainingSeats) {
		this.remainingSeats = remainingSeats;
	}

	public int getRunningTime() {
		return runningTime;
	}

	public void setRunningTime(int runningTime) {
		this.runningTime = runningTime;
	}

	@Override
	public String toString() {
		return "TheaterStarScheduleVO [" + theaterName + ", =" + rating + ", " + movieName
				+ ", " + name + ", " + totalSeats + ", " + type + ", " + startTime
				+ ", " + endTime + ", " + remainingSeats + ", " + runningTime + "]";
	}
	
	
	
	
}
