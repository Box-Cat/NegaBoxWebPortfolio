package actions;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.TheaterTimeListDao;
import dto.ListDistrictTheaterCount;
import dto.TheaterStarScheduleVO;

public class TheaterTimeListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		TheaterTimeListDao ttlDao = new TheaterTimeListDao();
		ArrayList<ListDistrictTheaterCount> listDistrictTheaterCount = new ArrayList<ListDistrictTheaterCount>();
		ArrayList<String> listTheater = new ArrayList<String>();
		HashMap<String, String> mapTheaterKorToEng = new HashMap<String, String>();
		ArrayList<TheaterStarScheduleVO> listTheaterStarScheduleVO = new ArrayList<TheaterStarScheduleVO>();
		String inputTheaterName = request.getParameter("theater"); // "홍대"; //"강남";
		String inputDay = request.getParameter("selectedDate"); // "22/01/06"; //239번줄의 ajax data값 바꾸기
		
		ttlDao.areaCount(listDistrictTheaterCount);
		ttlDao.listTheater(listTheater, mapTheaterKorToEng); //mapTheaterKorToEng를 만듦
		
		String inputTheaterId = mapTheaterKorToEng.get(inputTheaterName); // "HONGDAE"; // "GANGNAM";

		ttlDao.getListTheaterStarScheule(inputTheaterName, inputDay, inputTheaterId, listTheaterStarScheduleVO);
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();

		JSONObject obj = new JSONObject();
		JSONArray jArray = new JSONArray();

		for (ListDistrictTheaterCount vo : listDistrictTheaterCount) {
			JSONObject sObject = new JSONObject();// 배열 내에 들어갈 json
			sObject.put("area", vo.getArea());
			sObject.put("count", vo.getAreaCount());
			jArray.add(sObject);
		}
		obj.put("districtTheaterCount_list", jArray);

		JSONArray jArray2 = new JSONArray();

		for (String vo : listTheater) {
			jArray2.add(vo.toString()); // ? 왜 toString이 있찌?
		}
		obj.put("listTheater", jArray2);

		JSONArray jArray3 = new JSONArray();
		try {
			for (TheaterStarScheduleVO vo : listTheaterStarScheduleVO) {
				JSONObject sObject = new JSONObject();// 배열 내에 들어갈 json
				sObject.put("theaterName", vo.getTheaterName());
				sObject.put("rating", vo.getRating());
				sObject.put("movieName", vo.getMovieName());
				sObject.put("name", vo.getName());
				sObject.put("type", vo.getType());
				sObject.put("totalSeats", vo.getTotalSeats());
				sObject.put("type", vo.getType());
				sObject.put("startTime", vo.getStartTime());
				sObject.put("endTime", vo.getEndTime());
				sObject.put("remainingSeats", vo.getRemainingSeats());
				sObject.put("runningTime", vo.getRunningTime());
				jArray3.add(sObject);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		obj.put("listTheaterStarScheduleVO", jArray3);
		out.print(obj);
		
	}

}
