package dto;

public class ListDistrictTheaterCount {
	private String Area;
	private int AreaCount;
	
	public ListDistrictTheaterCount() {}
	public ListDistrictTheaterCount(String area, int areaCount) {
		Area = area;
		AreaCount = areaCount;
	}
	public String getArea() {
		return Area;
	}
	public void setArea(String area) {
		Area = area;
	}
	public int getAreaCount() {
		return AreaCount;
	}
	public void setAreaCount(int areaCount) {
		AreaCount = areaCount;
	}
	
	@Override
	public String toString() {
		return "ListDistrictTheaterCount객체 [" + Area + ", " + AreaCount + "]";
	}
	
	

}
