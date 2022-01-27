package dto;

public class ApiVO {
	private String audiCnt; //일자별 관객수 
	private String audiAcc; //누적 관객수
	private String movieNm; //영화 이름
	
	public ApiVO() {}
	public ApiVO(String audiCnt, String audiAcc, String movieNm) {
		this.audiCnt = audiCnt;
		this.audiAcc = audiAcc;
		this.movieNm = movieNm;
	}
	public String getAudiCnt() {
		return audiCnt;
	}
	public void setAudiCnt(String audiCnt) {
		this.audiCnt = audiCnt;
	}
	public String getAudiAcc() {
		return audiAcc;
	}
	public void setAudiAcc(String audiAcc) {
		this.audiAcc = audiAcc;
	}
	public String getMovieNm() {
		return movieNm;
	}
	public void setMovieNm(String movieNm) {
		this.movieNm = movieNm;
	}
	@Override
	public String toString() {
		return "ApiVO [audiCnt(오늘관람자)=" + audiCnt + ", audiAcc(누적관람자)=" + audiAcc + ", movieNm(영화명)=" + movieNm + "]";
	}
	
}
