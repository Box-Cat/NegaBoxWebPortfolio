package dto;

import java.util.Date;

public class PurchaseListVO {
	private Date purchaseDate;
	private String goodsName;
	private int quantity;
	private String state;
	private String purchaseCode;
	private String memberId;
	private String amount;
	
	public PurchaseListVO() {}
	public PurchaseListVO(Date purchaseDate, String goodsName, int quantity, String state, String purchaseCode,
			String memberId, String amount) {
		this.purchaseDate = purchaseDate;
		this.goodsName = goodsName;
		this.quantity = quantity;
		this.state = state;
		this.purchaseCode = purchaseCode;
		this.memberId = memberId;
		this.amount = amount;
	}
	
	public Date getPurchaseDate() {
		return purchaseDate;
	}
	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
	public String getGoodsName() {
		return goodsName;
	}
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPurchaseCode() {
		return purchaseCode;
	}
	public void setPurchaseCode(String purchaseCode) {
		this.purchaseCode = purchaseCode;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	
	
}
