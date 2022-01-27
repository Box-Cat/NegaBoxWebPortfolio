package dto;

public class MovieStarScheduleVO {
	private String theaterName;  // 강남	"theater_name"
	private String name;     // 상영관 이름 [백신패스관] "name"
	private String startTime;  //DB:"time"     // 상영시간  "03:10"  "time"
	private String endTime;      
	private String type;     // 2D(자막)   "type"
	private int runningTime;    // 상영시간 (분)    "running_time"
	private int totalSeats;   // 총좌석수      "total_seats"
	private int remainingSeats;   // 잔여좌석수  
	private String theaterShowroom;    // GANGNAM1    "theater_showroom"

	public MovieStarScheduleVO() {
	}
	public MovieStarScheduleVO(String theaterName, String name, String startTime, String endTime, String type,
			int runningTime, int totalSeats, int remainingSeats, String theaterShowroom) {
		this.theaterName = theaterName;
		this.name = name;
		this.startTime = startTime;
		this.endTime = endTime;
		this.type = type;
		this.runningTime = runningTime;
		this.totalSeats = totalSeats;
		this.remainingSeats = remainingSeats;
		this.theaterShowroom = theaterShowroom;
	}

	public String getTheaterName() {
		return theaterName;
	}
	public void setTheaterName(String theaterName) {
		this.theaterName = theaterName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getRunningTime() {
		return runningTime;
	}
	public void setRunningTime(int runningTime) {
		this.runningTime = runningTime;
	}
	public int getTotalSeats() {
		return totalSeats;
	}
	public void setTotalSeats(int totalSeats) {
		this.totalSeats = totalSeats;
	}
	public int getRemainingSeats() {
		return remainingSeats;
	}
	public void setRemainingSeats(int remainingSeats) {
		this.remainingSeats = remainingSeats;
	}
	public String getTheaterShowroom() {
		return theaterShowroom;
	}
	public void setTheaterShowroom(String theaterShowroom) {
		this.theaterShowroom = theaterShowroom;
	}

	@Override
	public String toString() {
		return "MovieStarScheduleVO객체 [" + theaterName + ", " + name + ", " + startTime + ", " + endTime + ", " + type + ", " + runningTime + ", "
				+ totalSeats + ", " + remainingSeats + ", " + theaterShowroom + "]";
	}
	
}
