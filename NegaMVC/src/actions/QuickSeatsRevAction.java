package actions;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.QuickSeatsRevDao;
import dto.AColsVO;
import dto.ExitDoorVO;
import dto.MovieEndTime;

public class QuickSeatsRevAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 아이디 받기
		HttpSession session = request.getSession();
		String loginId = (String)session.getAttribute("member_id");
		String name = (String)(session.getAttribute("name"));
		
		
		QuickSeatsRevDao qsrDao = new QuickSeatsRevDao();
		
		Calendar cal = Calendar.getInstance();
		int year, month, date, hour, minute;
		year = cal.get(Calendar.YEAR);
		month =	 cal.get(Calendar.MONTH)+1;
		date = cal.get(Calendar.DATE);
		hour = cal.get(Calendar.HOUR_OF_DAY);
		minute = cal.get(Calendar.MINUTE);
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String todate = format.format(today);
		
		ArrayList<String> listSeatArrInfo = new ArrayList<String>();
		ArrayList<ExitDoorVO> listExitDoorVO = new ArrayList<ExitDoorVO>();
		ArrayList<AColsVO> listAColsVO = new ArrayList<AColsVO>();
		AColsVO aColsVO = new AColsVO();
		ArrayList<String> moviePosterJpgs = new ArrayList<String> ();
		ArrayList<MovieEndTime> movieEndTimeList = new ArrayList<MovieEndTime>(); 
		Set<String> hsetReserved = new HashSet<String>(); 
		//String[] arrSeats = new String[listSeatArrInfo.size()];
		ArrayList<String> listPrintStr = new ArrayList<String>();
		
		
		
		//빠른 예매의 sendPost로 받는 정보
		request.setCharacterEncoding("UTF-8");
		String start_time_HM = request.getParameter("start_time_HM");
		String end_time_HM = request.getParameter("end_time_HM");
		String movie_name = request.getParameter("movie_name");
		String show_type = request.getParameter("show_type");
		String theater_name = request.getParameter("theater_name"); 
		String theater_showroom_name = request.getParameter("theater_showroom_name"); 
		String rating = request.getParameter("rating");
		String selectedDate = request.getParameter("selectedDate");    // "22/01/06" ?
		String fullDate = request.getParameter("fullDate");
		
		//메서드에 넣기 위해, 수정하는 변수들
		String tmp_theater_name = theater_name;//showroom, sql문에 넣기 위함
		String tmp_theater_showroom_name = theater_showroom_name;//showroom, sql문에 넣기 위함
		String tmpRating = rating;
		
		//theater_name의 이름을 sql에 들어가도록 변경  
		if(tmp_theater_name.equals("강남")){tmp_theater_name = "GANGNAM";}
		if(tmp_theater_name.equals("신촌")){tmp_theater_name = "SINCHON";	}
		if(tmp_theater_name.equals("홍대")){tmp_theater_name = "HONGDAE";}
		
		//theater_showroom_name의 이름을 sql에 들어가도록 변경
		if(tmp_theater_showroom_name.equals("1관") || tmp_theater_showroom_name.equals("컴포트 1관[백신패스관]") || tmp_theater_showroom_name.equals("이계훈관(7층1관)") )
			Integer.parseInt(tmp_theater_showroom_name = "1");
		if(tmp_theater_showroom_name.equals("2관[백신패스관]") || tmp_theater_showroom_name.equals("정우영관(9층2관)" ) || tmp_theater_showroom_name.equals("2관"))
			Integer.parseInt(tmp_theater_showroom_name = "2");
		if(tmp_theater_showroom_name.equals("3관[백신패스관]") || tmp_theater_showroom_name.equals("3관") || tmp_theater_showroom_name.equals("정우영관(9층3관)"))
			Integer.parseInt(tmp_theater_showroom_name = "3"); 
		String showroom = tmp_theater_name.concat(tmp_theater_showroom_name);	
		
		//tmpRating의 이름을  sql에 들어가도록 변경
		if(tmpRating.equals("age-all")){tmpRating = "all";}
		if(tmpRating.equals("age-12")){tmpRating = "12";}
		if(tmpRating.equals("age-15")){tmpRating = "15";}
		if(tmpRating.equals("age-19")){tmpRating = "19";} 
		String strHour = (hour < 10 ? "0" + hour : hour+"");
		String strMinute =  (minute < 10 ? "0" + minute : minute+"");
		String strFullHour = strHour + ":" + strMinute;
		String strYear = String.valueOf(year);
		strYear = strYear.substring(2);
		String strMonth = (month < 10 ? "0" + month : month+"");
		String strDate = (date < 10 ? "0" + date : date+"");
		String strToday = strYear +"/"+ strMonth +"/"+ strDate;
		
		listSeatArrInfo = qsrDao.showSeats(showroom, listSeatArrInfo);
		System.out.println("listSeatArrInfo : " + listSeatArrInfo);
		
		//int aLeft, int aTop 출력해서, qsrDao.printSeats()에게 넣어주어야 함
		aColsVO = qsrDao.showAIndex(showroom,aColsVO);
		listExitDoorVO = qsrDao.showExit(showroom, listExitDoorVO);
		moviePosterJpgs = qsrDao.showPoster(movie_name, moviePosterJpgs);
		movieEndTimeList = qsrDao.showStartEndTime(selectedDate, tmp_theater_name, movie_name, strToday, strFullHour, movieEndTimeList);
		hsetReserved = qsrDao.showRevSeats(selectedDate, start_time_HM, showroom, hsetReserved);
		listPrintStr = qsrDao.printSeats(listPrintStr, listSeatArrInfo, aColsVO.getaTop(), aColsVO.getaLeft(), hsetReserved); //오류
		
		
		//Attribute
		request.setAttribute("year",year);
		request.setAttribute("month",month);
		request.setAttribute("date",date);
		request.setAttribute("hour",hour);
		request.setAttribute("minute",minute);
		request.setAttribute("listExitDoorVO",listExitDoorVO);
		request.setAttribute("listPrintStr",listPrintStr);
		request.setAttribute("moviePosterJpgs",moviePosterJpgs);
		request.setAttribute("movieEndTimeList",movieEndTimeList);
		request.setAttribute("listAColsVO",listAColsVO);
		request.setAttribute("hsetReserved",hsetReserved);
		//request.setAttribute("arrSeats",arrSeats);
		request.setAttribute("movie_name",movie_name);
		request.setAttribute("start_time_HM",start_time_HM);
		request.setAttribute("end_time_HM",end_time_HM);
		request.setAttribute("show_type",show_type);
		request.setAttribute("theater_name",theater_name);
		request.setAttribute("theater_showroom_name",theater_showroom_name);
		request.setAttribute("rating",rating);
		request.setAttribute("selectedDate",selectedDate);
		request.setAttribute("fullDate",fullDate);
		request.setAttribute("tmp_theater_name",tmp_theater_name);
		request.setAttribute("tmp_theater_showroom_name",tmp_theater_showroom_name);
		request.setAttribute("tmpRating",tmpRating);
		request.setAttribute("showroom",showroom);
		
		
		
		
		
		
		
		
		
		
		request.getRequestDispatcher("quick-seat-rev.jsp").forward(request,response);
	}

}
