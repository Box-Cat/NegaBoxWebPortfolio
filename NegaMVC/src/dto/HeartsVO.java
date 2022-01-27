package dto;

public class HeartsVO {
	int heart;
	boolean heartTrueFalse;
	
	public HeartsVO(){}
	public HeartsVO(int heart, boolean heartTrueFalse) {
		this.heart = heart;
		this.heartTrueFalse = heartTrueFalse;
	}
	public int getHeart() {
		return heart;
	}
	public void setHeart(int heart) {
		this.heart = heart;
	}
	public boolean isHeartTrueFalse() {
		return heartTrueFalse;
	}
	public void setHeartTrueFalse(boolean heartTrueFalse) {
		this.heartTrueFalse = heartTrueFalse;
	}
	
	
}
