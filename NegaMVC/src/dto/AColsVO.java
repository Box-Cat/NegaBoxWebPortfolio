package dto;


//배열 A의 위치 정보를 담은 클래스입니다. 배열 A의 위치 정보는 좌석정보 배치에 기준이 되는 꼭 필요한 정보 입니다. THEATER_SHOWROOM 테이블에 관련 정보가 담겨져 있습니다. 
public class AColsVO {
	private int aLeft;
	private int aTop;
	public AColsVO(){}
	
	public AColsVO(int aLeft, int aTop) {
		this.aLeft = aLeft;
		this.aTop = aTop;
	}

	public int getaLeft() {
		return aLeft;
	}

	public void setaLeft(int aLeft) {
		this.aLeft = aLeft;
	}

	public int getaTop() {
		return aTop;
	}

	public void setaTop(int aTop) {
		this.aTop = aTop;
	}

	/*
	 * @Override public String toString() { return "AColsVO [aLeft=" + aLeft +
	 * ", aTop=" + aTop + "]"; }
	 */
	
}
