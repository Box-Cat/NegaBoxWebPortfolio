package dto;

import java.util.Date;

public class ReserveListVO {
	private String reserveCode;
	private String memberId;
	private String movieCode;
	private Date payDate;
	private String peopleType;
	private int peopleMember;
	private String theaterId;
	private int showroomMember;
	
	public ReserveListVO() {}
	public ReserveListVO(String reserveCode, String memberId, String movieCode, Date payDate, String peopleType,
			int peopleMember, String theaterId, int showroomMember) {
		this.reserveCode = reserveCode;
		this.memberId = memberId;
		this.movieCode = movieCode;
		this.payDate = payDate;
		this.peopleType = peopleType;
		this.peopleMember = peopleMember;
		this.theaterId = theaterId;
		this.showroomMember = showroomMember;
	}
	
	public String getReserveCode() {
		return reserveCode;
	}
	public void setReserveCode(String reserveCode) {
		this.reserveCode = reserveCode;
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
	public Date getPayDate() {
		return payDate;
	}
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	public String getPeopleType() {
		return peopleType;
	}
	public void setPeopleType(String peopleType) {
		this.peopleType = peopleType;
	}
	public int getPeopleMember() {
		return peopleMember;
	}
	public void setPeopleMember(int peopleMember) {
		this.peopleMember = peopleMember;
	}
	public String getTheaterId() {
		return theaterId;
	}
	public void setTheaterId(String theaterId) {
		this.theaterId = theaterId;
	}
	public int getShowroomMember() {
		return showroomMember;
	}
	public void setShowroomMember(int showroomMember) {
		this.showroomMember = showroomMember;
	}
	
	
}
