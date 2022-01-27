package dto;

import java.sql.Date;

public class MemberVO {
	private String memberId;
	private String pw;
	private String name;
	private String email;
	private String phone;
	private Date birthDay;
	private String address;
	private String memberPhoto;
	private String adminStrator;
	
	public MemberVO() {}
	public MemberVO(String memberId, String pw, String name, String email, String phone, Date birthDay, String address,
			String memberPhoto, String adminStrator) {
		this.memberId = memberId;
		this.pw = pw;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.birthDay = birthDay;
		this.address = address;
		this.memberPhoto = memberPhoto;
		this.adminStrator = adminStrator;
	}

	
	public String getMemberId() {
		return memberId;
	}


	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	public String getPw() {
		return pw;
	}


	public void setPw(String pw) {
		this.pw = pw;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public Date getBirthDay() {
		return birthDay;
	}


	public void setBirthDay(Date birthDay) {
		this.birthDay = birthDay;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getMemberPhoto() {
		return memberPhoto;
	}


	public void setMemberPhoto(String memberPhoto) {
		this.memberPhoto = memberPhoto;
	}


	public String getAdminStrator() {
		return adminStrator;
	}


	public void setAdminStrator(String adminStrator) {
		this.adminStrator = adminStrator;
	}

}
