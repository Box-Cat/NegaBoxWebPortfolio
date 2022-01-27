package dto;

public class ChartVO {
	int chartStory;
	int chartProduction;
	int chartOstc;
	int chartVisual;
	int chartActor;
	String chartPit1;
	String chartPit2;
	public ChartVO(){};
	public ChartVO(int chartStory, int chartProduction, int chartOstc, int chartVisual, int chartActor, String chartPit1,
			String chartPit2) {
		this.chartStory = chartStory;
		this.chartProduction = chartProduction;
		this.chartOstc = chartOstc;
		this.chartVisual = chartVisual;
		this.chartActor = chartActor;
		this.chartPit1 = chartPit1;
		this.chartPit2 = chartPit2;
	}
	public int getChartStory() {
		return chartStory;
	}
	public void setChartStory(int chartStory) {
		this.chartStory = chartStory;
	}
	public int getChartProduction() {
		return chartProduction;
	}
	public void setChartProduction(int chartProduction) {
		this.chartProduction = chartProduction;
	}
	public int getChartOstc() {
		return chartOstc;
	}
	public void setChartOstc(int chartOstc) {
		this.chartOstc = chartOstc;
	}
	public int getChartVisual() {
		return chartVisual;
	}
	public void setChartVisual(int chartVisual) {
		this.chartVisual = chartVisual;
	}
	public int getChartActor() {
		return chartActor;
	}
	public void setChartActor(int chartActor) {
		this.chartActor = chartActor;
	}
	public String getChartPit1() {
		return chartPit1;
	}
	public void setChartPit1(String chartPit1) {
		this.chartPit1 = chartPit1;
	}
	public String getChartPit2() {
		return chartPit2;
	}
	public void setChartPit2(String chartPit2) {
		this.chartPit2 = chartPit2;
	}
	@Override
	public String toString() {
		return "Chart [chartStory=" + chartStory + ", chartProduction=" + chartProduction + ", chartOstc=" + chartOstc
				+ ", chartVisual=" + chartVisual + ", chartActor=" + chartActor + ", chartPit1=" + chartPit1
				+ ", chartPit2=" + chartPit2 + "]";
	}
	 
	
	
}
