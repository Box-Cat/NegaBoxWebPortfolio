package dto;

public class ExitDoorVO {
	private String direction;
	private String x_left; 
	private String y_top;
	
	ExitDoorVO(){}
	public ExitDoorVO(String direction, String x_left, String y_top) {
		this.direction = direction;
		this.x_left = x_left;
		this.y_top = y_top;
	}
	
	public String getDirection() {
		return direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
	public String getX_left() {
		return x_left;
	}
	public void setX_left(String x_left) {
		this.x_left = x_left;
	}
	public String getY_top() {
		return y_top;
	}
	public void setY_top(String y_top) {
		this.y_top = y_top;
	}

	@Override
	public String toString() {
		return "ExitDoorVO [direction=" + direction + ", x_left=" + x_left + ", y_top=" + y_top + "]";
	}
	
	
}
