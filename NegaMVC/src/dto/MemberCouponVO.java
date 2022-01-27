package dto;

import java.sql.Date;

public class MemberCouponVO {
	private String memberId;
	private String couponCode;
	private String couponName;
	private Date startDate;
	private Date endDate;
	private String state;

	public MemberCouponVO() {}
	public MemberCouponVO(String memberId, String couponCode, String couponName, Date startDate, Date endDate,
			String state) {
		this.memberId = memberId;
		this.couponCode = couponCode;
		this.couponName = couponName;
		this.startDate = startDate;
		this.endDate = endDate;
		this.state = state;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getCouponCode() {
		return couponCode;
	}

	public void setCouponCode(String couponCode) {
		this.couponCode = couponCode;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	
}
