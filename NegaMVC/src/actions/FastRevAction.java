package actions;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.FastRevDao;
import dto.QuickMovieTimeVO;
import dto.QuickMovieVO;

public class FastRevAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<String> listMoviePhoto = new ArrayList<String>();
		ArrayList<QuickMovieVO> listQuickMovie = new ArrayList<QuickMovieVO>();
		HashMap<String, Integer> hMapArea = new HashMap<String, Integer>();
		
		String paramMovieCode = "";     // 파라미터 movie_code = "유체이탈자_스파이더맨:노웨이홈" (예를 들어)    
		String paramArea = "";   		// 파라미터 area = "서울"  (예를 들어)
		String paramTheaterName = "";   // 파라미터 theater_name = "강남" (예를 들어)
		String paramDate = "";			// 파라미터 day = "25" (예를 들어) --> ___월 25일 날짜를 선택한 것.    ---> 변경: "20220101" 형식으로 변경(12/28)
		
		String[] arrParamMovieCode = null;	// ex. [#유체이탈자, #스파이더맨:노웨이홈] 
		ArrayList<QuickMovieTimeVO> listQuickMovieTime = new ArrayList<QuickMovieTimeVO>();

		if(request.getParameter("movie_code")==null) {		// 1단계.
			// 처음 단계 = 영화 선택 단계. ---> 그대로.
		} 
		if(request.getParameter("movie_code")!=null){		// 2단계.
			paramMovieCode = "#" + request.getParameter("movie_code");
			arrParamMovieCode = request.getParameter("movie_code").split("_");
			//System.out.println("paramMovieCode : " + paramMovieCode);
			for(int i=0; i<=arrParamMovieCode.length-1; i++)
				arrParamMovieCode[i] = "#" + arrParamMovieCode[i];   
		} 
		if(request.getParameter("area")!=null) {			// 3단계.
			paramArea = request.getParameter("area");
		}
		if(request.getParameter("theater_name")!=null) {
			paramTheaterName = request.getParameter("theater_name");
		}
		
		Calendar cal = Calendar.getInstance();
		int year, month, date, hour, minute;
		year = cal.get(Calendar.YEAR);
		month =	cal.get(Calendar.MONTH)+1;
		date = cal.get(Calendar.DATE);
		hour = cal.get(Calendar.HOUR_OF_DAY);
		minute = cal.get(Calendar.MINUTE);


		
	 /*	String selectedDate = "21/12/" + (paramDate!=null ? paramDate : date); */ 
		String selectedDate = "";
	 
	  	if(request.getParameter("date")!=null) {
			paramDate = request.getParameter("date");
		} else {
			paramDate = year + "" + (month<10 ? "0"+month : month) + "" + (date<10 ? "0"+date : date);	//오늘날짜			// 20220101 (=paramDate)
		}
		selectedDate = paramDate.substring(2,4) + "/" + paramDate.substring(4,6) + "/" + paramDate.substring(6);   // .substring(2);   // 20220101이 아니라 220101 --> 22/01/01 (=selectedDate)

//			System.out.println("paramDate : " + paramDate);
//			System.out.println("paramTheaterName : " + paramTheaterName);
//			System.out.println("selectedDate : " + selectedDate); 
		
		ArrayList<String> listStr1 = new ArrayList<String>();
		ArrayList<String> listPhotoName = new ArrayList<String>();
		ArrayList<String> listStr3 = new ArrayList<String>();
		ArrayList<String> listStr4 = new ArrayList<String>();
		
		//로그인 아이디 받기
		HttpSession session = request.getSession();
		String loginId = (String)session.getAttribute("member_id");
		String name = (String)(session.getAttribute("name"));
		
		// DAO 호출, with test code.
		FastRevDao frDao = new FastRevDao();
		paramMovieCode = frDao.showMovieHeart(paramMovieCode, selectedDate, arrParamMovieCode, listMoviePhoto);  //("#특송", "22/01/22");
		frDao.showMovieHeartNoId(selectedDate, loginId, listQuickMovie);  //("22/01/22", "PJH");
		frDao.countTheater(loginId, FastRevDao.arrArea, hMapArea);   //("PJH", FastRevDao.arrArea);
		listQuickMovieTime = frDao.selectTheater(selectedDate,paramTheaterName, arrParamMovieCode); //("22/01/22","신촌", FastRevDao.arrParamMovieCode);
		listStr1 = frDao.makeListStr1(listQuickMovie, arrParamMovieCode);	
		listPhotoName = frDao.makeListStr2(listMoviePhoto);
		listStr3 = frDao.makeListStr3(loginId, paramArea, paramTheaterName, hMapArea);  // ("PJH", "서울", "신촌");
		listStr4 = frDao.makeListStr4(listQuickMovieTime);

		request.setAttribute("paramMovieCode", paramMovieCode);
		request.setAttribute("paramArea",paramArea);
		request.setAttribute("paramTheaterName",paramTheaterName);
		request.setAttribute("paramDate",paramDate);
		request.setAttribute("arrParamMovieCode",arrParamMovieCode);
		request.setAttribute("listQuickMovieTime",listQuickMovieTime);
		request.setAttribute("year",year);
		request.setAttribute("month",month);
		request.setAttribute("date",date);
		request.setAttribute("hour",hour);
		request.setAttribute("minute",minute);
		request.setAttribute("selectedDate",selectedDate);
		request.setAttribute("listQuickMovie",listQuickMovie);
		request.setAttribute("listMoviePhoto",listMoviePhoto);
		request.setAttribute("arrArea",FastRevDao.arrArea);	
		request.setAttribute("hMapArea",hMapArea);
		request.setAttribute("listStr1",listStr1);	
		request.setAttribute("listPhotoName",listPhotoName);
		request.setAttribute("listStr3",listStr3);
		request.setAttribute("listStr4",listStr4);

		//System.out.println(request.getRequestURL()+"?"+request.getQueryString());    // http://localhost:9080/NegaMVC/Controller?command=fastRev
		request.getRequestDispatcher("fast_rev_before_map.jsp").forward(request, response);
	}

}
