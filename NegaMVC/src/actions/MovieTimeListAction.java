package actions;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.MovieTimeListDao;
import dto.MovieStarScheduleVO;

public class MovieTimeListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		MovieTimeListDao mtlDao = new MovieTimeListDao();
		ArrayList<String> listMovieName = new ArrayList<String>();
		ArrayList<String> listRating = new ArrayList<String>();
		ArrayList<String> listMoviePhoto = new ArrayList<String>();
		ArrayList<MovieStarScheduleVO> listMovieStarSchedule = new ArrayList<MovieStarScheduleVO>();
		String movieNameSelected = request.getParameter("movieNameSelected"); //request.getParameter로 받기*/	
		String movieCodeSelected = "#"+ movieNameSelected.replaceAll(" ","");
		String daySelected = request.getParameter("daySelected"); //22/01/06. 한자리 숫자에 0을 붙여줄 것
		String areaSelected = request.getParameter("areaSelected");  // 서울
		
		mtlDao.getMovieList(listMovieName, listRating, listMoviePhoto);
		mtlDao.getListMovieStarScheule(movieCodeSelected,daySelected,areaSelected,listMovieStarSchedule);
		
		JSONObject obj = new JSONObject();
		JSONArray jArray = new JSONArray();//배열이 필요할때
		try {
			for(MovieStarScheduleVO vo : listMovieStarSchedule) {
				JSONObject sObject = new JSONObject();//배열 내에 들어갈 json
				sObject.put("theaterName", vo.getTheaterName());
				sObject.put("name", vo.getName());
				sObject.put("startTime", vo.getStartTime());
				sObject.put("endTime", vo.getEndTime());
				sObject.put("type", vo.getType());
				sObject.put("runningTime", vo.getRunningTime());
				sObject.put("totalSeats", vo.getTotalSeats());
				sObject.put("remainingSeats", vo.getRemainingSeats());
				sObject.put("theaterShowroom", vo.getTheaterShowroom());
				jArray.add(sObject);
			}
		} catch(Exception e) { e.printStackTrace(); }
		
		obj.put("movie_schedule_list", jArray);
		//String text = "some text";

		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();

//		JSONObject obj = new JSONObject();
		JSONArray jArray2 = new JSONArray();//배열이 필요할때
		for(String movie : listMovieName) {
			jArray2.add(movie);
		}
		obj.put("movie_list", jArray2);
		
		JSONArray jArray3 = new JSONArray();//배열이 필요할때
		for(String rating : listRating) {
			jArray3.add(rating);
		}
		obj.put("rating_list", jArray3);
		
		JSONArray jArray4 = new JSONArray();
		for(String moviePhoto : listMoviePhoto) {
			jArray4.add(moviePhoto);
		}
		obj.put("photo_list", jArray4);
		
//		obj.put("key1", 1234);
//		obj.put("key2", "abc");
//		obj.put("key3", "하안글");
		out.print(obj);
	}

}
