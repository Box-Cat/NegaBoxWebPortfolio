<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dto.*" %>
<%@ page import="actions.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.net.*" %>

<%
//로그인 관련 변수
String url = "http://localhost:9080/NegaMVC/Controller?command=fastRev";
String loginId = (String)(session.getAttribute("member_id"));
String username = (String)(session.getAttribute("name"));
Date today = (Date)(session.getAttribute("today"));
String todate = (String)(session.getAttribute("todate"));
System.out.println("loginId :" + loginId);
System.out.println("username :" + username);
%>

<%
String paramMovieCode = (String)request.getAttribute("paramMovieCode");
String paramArea = (String)request.getAttribute("paramArea");
String paramTheaterName = (String)request.getAttribute("paramTheaterName");
String paramDate = (String)request.getAttribute("paramDate");
String[] arrParamMovieCode = (String[])request.getAttribute("arrParamMovieCode");
ArrayList<QuickMovieTimeVO> listQuickMovieTime = (ArrayList<QuickMovieTimeVO>)request.getAttribute("listQuickMovieTime");
int year = (Integer)request.getAttribute("year");
int month = (Integer)request.getAttribute("month");
int date = (Integer)request.getAttribute("date");
int hour = (Integer)request.getAttribute("hour");
int minute = (Integer)request.getAttribute("minute");
String selectedDate = (String)request.getAttribute("selectedDate");
ArrayList<QuickMovieVO> listQuickMovie = (ArrayList<QuickMovieVO>)request.getAttribute("listQuickMovie");
ArrayList<String> listMoviePhoto = (ArrayList<String>)request.getAttribute("listMoviePhoto");
String[] arrArea = (String[])request.getAttribute("arrArea");
HashMap<String, Integer> hMapArea = (HashMap<String, Integer>)request.getAttribute("hMapArea");
ArrayList<String> listStr1 = (ArrayList<String>)request.getAttribute("listStr1");
ArrayList<String> listPhotoName = (ArrayList<String>)request.getAttribute("listPhotoName");
ArrayList<String> listStr3 = (ArrayList<String>)request.getAttribute("listStr3");
ArrayList<String> listStr4 = (ArrayList<String>)request.getAttribute("listStr4");

System.out.println(paramMovieCode + " / " + paramArea + " / " + paramTheaterName);
//System.out.println("size of listQuickMovieTime : " + listQuickMovieTime.size());
//System.out.println("listStr4 : " + listStr4);
%>

<%--
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

//	System.out.println("paramDate : " + paramDate);
//	System.out.println("paramTheaterName : " + paramTheaterName);
//	System.out.println("selectedDate : " + selectedDate); 
	
	ArrayList<QuickMovieVO> listQuickMovie = new ArrayList<QuickMovieVO>();
	ArrayList<String> listMoviePhoto = new ArrayList<String>();
	String[] arrArea = {"선호극장", "서울", "경기", "인천", "대전/충청/세종", "부산/대구/경상", "광주/전라", "강원"};
	HashMap<String, Integer> hMapArea = new HashMap<String, Integer>();
	
	ArrayList<String> listStr1 = new ArrayList<String>();
	ArrayList<String> listPhotoName = new ArrayList<String>();
	ArrayList<String> listStr3 = new ArrayList<String>();
	ArrayList<String> listStr4 = new ArrayList<String>();

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
--%>
<%--	
	//▽DBConnection
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String db_id = "megabox";
	String db_pw = "user1234";
	
	Connection conn = null;
	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, db_id, db_pw);
	} catch(Exception e) {   // ClassNotFoundException, SQLException
		e.printStackTrace();
	}
	//△DBConnection
	
	//▽dao1 질문. 빠른예매, 상영시간표 영화별/ 상영시간표 극장별, 좌석페이지 별로 DAO 제작
	String sql = "";
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	// 0단계 : paramMovieCode 검증 --> 수정.
	sql = "select m.movie_code mc, m.movie_photo"
			+" from movie m" 
			+" where m.movie_code in"
			+" (select distinct si.movie_code from screen_info si where si.day=?)"
			+" and m.movie_code in (";
	for(int i=0; i<=paramMovieCode.split("_").length-1; i++) {
		sql += "'#" + paramMovieCode.split("_")[i].replace("#","") + "'";
		if(i<paramMovieCode.split("_").length-1) {
			sql+= ",";
		}
	}
	sql += ")";
	System.out.println("SQL : " + sql);
	
	String theNewParamMovieCode = "";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, selectedDate);
	rs = pstmt.executeQuery();
	while(rs.next()) {
		String mc = rs.getString("mc");
		if(mc!=null) mc = mc.trim();
		//System.out.println("mc : " + mc);
		theNewParamMovieCode += mc.substring(1) + "_";
		
		String moviePhoto = rs.getString("movie_photo");
		listMoviePhoto.add(moviePhoto);
	}
	if(theNewParamMovieCode.length()>0) {
		paramMovieCode = theNewParamMovieCode.substring(0, theNewParamMovieCode.length()-1);
		arrParamMovieCode = paramMovieCode.split("_");
		for(int i=0; i<=arrParamMovieCode.length-1; i++)
			arrParamMovieCode[i] = "#" + arrParamMovieCode[i];
	} else {
		paramMovieCode = "";
	}
	rs.close();
	pstmt.close();
	
	
	//▽dao2 질문
	// 1단계: "영화가 선택되지 않은 상황이라면" --> "영화를 선택할 차례"
	// 로그아웃 상태 에서의 접속도 고려되어 있는가	loginId = null 일 경우 login is null 체크
	String sql1 ="";
	String sql1b ="";
	if(loginId == null) loginId = ""; 
	
	//비회원도 볼수 있는 화면
	sql1 =" SELECT m.movie_code mc, m.rating r, m.movie_name mn, m.movie_photo mp " + 
		  " FROM movie m " +
		  " WHERE m.movie_code " + 
		  " IN (SELECT distinct si.movie_code FROM  screen_info si WHERE si.day=?)";
	
	PreparedStatement pstmt1 = conn.prepareStatement(sql1);
	pstmt1.setString(1, selectedDate);
	ResultSet rs1 = pstmt1.executeQuery();
	while(rs1.next()) {
		String mc = rs1 .getString("mc");
		String r = rs1 .getString("r");		// rating : (ex) "15세이상관람가"
		String mn = rs1 .getString("mn");
		String mp = rs1 .getString("mp");
		String wtwmc = "";
		String wtwId = "";
		byte wantToWatch = (byte)0; 
		if(mc!=null) mc = mc.trim();
		if(r!=null) r = r.trim();
		if(mn!=null) mn = mn.trim();
		if(mp!=null) mp = mp.trim();
		
		
		//회원이 자신이 '좋아요'한 하트
		sql1b="SELECT count(*) FROM want_to_watch wtw " +
			  "WHERE member_id=? AND movie_code = ?";
		PreparedStatement pstmt1b = conn.prepareStatement(sql1b);
		pstmt1b.setString(1, loginId);
		pstmt1b.setString(2, mc);
		ResultSet rs1b = pstmt1b.executeQuery();
		if(rs1b.next()) {
			wantToWatch = (byte)(rs1b.getInt(1));
		 } 
			 
		QuickMovieVO vo = new QuickMovieVO(mc, r, mn,  wantToWatch , mp);  
		listQuickMovie.add(vo);		
		
		
	}
	for(QuickMovieVO vo : listQuickMovie) {
		System.out.println(vo);
	}
	
	pstmt.close();
	rs.close();

	//▽dao3 질문
	// 2단계: "영화가 선택된 상황이라면" --> 지역을 선택할 차례. (그런데 영화가 선택되지 않았더라도 hMapArea는 채워줘야함 여기서.)
	for(String area : arrArea) {
		if("선호극장".equals(area)) {
			sql = "select count(*) from wish_theater where member_id = '"+loginId+"'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int cnt = rs.getInt(1);
				hMapArea.put(area, cnt);      // 0 <-- 극장수.		
			}
			rs.close();
			pstmt.close();
		} else {
			//sql = "select count(theater_id), area from theater group by area";
			sql = "select count(theater_id) from theater where area = '"+area+"'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int cnt = rs.getInt(1);
				hMapArea.put(area, cnt);      // 0 <-- 극장수.		
			}
			rs.close();
			pstmt.close();
		}
	}
	
	//▽dao4 질문
System.out.println("minute :" + minute);
	// 3단계 : "영화&지역이 선택되었다면" --> 상영관을 선택할 차례!
	// 문제 원인 의심
	if(request.getParameter("theater_name")!=null) {
		//이 sql문은 강남/신촌/홍대 를 구분하지 못하고 있음.
		sql = "select m.running_time, m.movie_name, m.movie_code, si.time, si.type, ts.name, ts.total_seats, si.day"
			+ " FROM movie m, screen_info si,  theater_showroom ts"
			+ " WHERE "
			+ " m.movie_code = si.movie_code and si.theater_showroom = ts.theater_showroom_code"
			+ " and si.day = ? "
			+ " and ts.name in (select name from theater_showroom where theater_id=(select distinct theater_id from theater where theater_name=?))"
			+ " and m.movie_code in (?,?,?)"
			+ ( ( (year+ "" + (month<10 ? "0"+month : month) + "" + (date<10 ? "0"+date : date)).equals(paramDate) ) ? " and si.time >= ?" : "") 
			+ " order by si.time";
			
		// ? : '21/12/24'
		// ? : '강남'
		// ? : '#스파이더맨:노웨이홈'
				
		pstmt = conn.prepareStatement(sql);
		
		//String findDay = (year%100) + "/" + month + "/" + (paramDate==null ? date : paramDate);     // --------> "21/12/24"(=selectedDate)
		String findDay = selectedDate;   						//paramDate;    // 20220101
		String findTheaterName = paramTheaterName;  // "강남";
		//String findMovieCode = paramMovieCode;   // "#스파이더맨:노웨이홈";
		String[] arrFindMovieCode = arrParamMovieCode;   // arrParamMovieCode : { "#스파이더맨:노웨이홈", "#연애빠진로맨스", "#매트릭스:리저렉션" }
		if(arrFindMovieCode != null) {
			for(int i=0; i<=arrFindMovieCode.length-1; i++)
				arrFindMovieCode[i] = arrFindMovieCode[i];  // 
		}
if(arrFindMovieCode!=null) {
	System.out.print("arrFindMovieCode[] : ");
	for(String mc : arrFindMovieCode) {
		System.out.print(mc + ", ");
	}
	System.out.println();
}
		pstmt.setString(1, findDay);
		pstmt.setString(2, findTheaterName);
		pstmt.setString(3, (arrFindMovieCode!=null ? arrFindMovieCode[0] : ""));
		pstmt.setString(4, (arrFindMovieCode!=null && arrFindMovieCode.length>=2) ? arrFindMovieCode[1] : "");
		pstmt.setString(5, (arrFindMovieCode!=null && arrFindMovieCode.length>=3) ? arrFindMovieCode[2] : "");
		if( (year+ "" + (month<10 ? "0"+month : month) + "" + (date<10 ? "0"+date : date)).equals(paramDate) ) {
			pstmt.setString(6, (hour<10 ? "0"+hour+":"+minute : hour+":"+minute));     
			System.out.println("hour : minute :" + hour+":"+minute);			
		}
		rs = pstmt.executeQuery();
		while(rs.next()) {
			
			int running_time = rs.getInt("running_time");
			String movie_name = rs.getString("movie_name");
			String movie_code = rs.getString("movie_code");
			String time = rs.getString("time");   // "10:00"
			
			// 상영종료시간의 계산 ---------------------------------- 
			int timeH = Integer.parseInt(time.split(":")[0]);
			int timeM = Integer.parseInt(time.split(":")[1]);	
			timeM += running_time+10;
			timeH += timeM/60;
			timeM = timeM%60;
			// -----------------------------------------------
			String endTime = (timeH < 10 ? "0" : "") + timeH + ":" + (timeM < 10 ? "0" : "") + timeM;
			String type = rs.getString("type");
			String name = rs.getString("name");		// 2관[백신패스관]
			int total_seats = rs.getInt("total_seats");
			String day = rs.getString("day");
			// 현재예약좌석수의 계산 ---------------------------------
			String sql2 = "select count(*) from reservation"
				   + " where screen_info_code in ("
				   + "	select movie_info_code from screen_info"
				   + "	where theater_showroom in (select theater_showroom_code from theater_showroom where name = ?)"
				   + "	and time = ? and day=?"
				   + " )";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, name);
			pstmt2.setString(2, time);
			pstmt2.setString(3, findDay);   // "21/12/24"
			ResultSet rs2 = pstmt2.executeQuery();
			int cntCurr = 0;    // 현재예약좌석수.
			if(rs2.next()) {
				cntCurr = rs2.getInt(1);
			}
			
						// -----------------------------------------------
			listQuickMovieTime.add(new QuickMovieTimeVO(time, endTime, movie_name, type, paramTheaterName, name, cntCurr, total_seats)); //작업중
			pstmt2.close();
			rs2.close();
		}
		
		pstmt.close();
		rs.close();
	
 		for(QuickMovieTimeVO vo : listQuickMovieTime) {
			System.out.println("listQuickMovieTime :" + vo);
			//DB
		}
		
		
	}
	
/* 	if(!paramMovieCode.equals("") && !paramArea.equals("")) {
		
	}
 */
	// 그냥 출력해보는 것. OKAY!
/*  	for(int i=0; i<=arrArea.length-1; i++) {
		String key = arrArea[i];
		Integer value = hMapArea.get(key);
		System.out.println(key + " : " + value);
	} 
 */
	
/*  	for(QuickMovieVO vo : listQuickMovie) {
		System.out.println(vo);
	} */




<%//▽dao5 질문
//중간에 삽입할 변수들
String str1 = "";
String str2 = "";
String str3 = "";
String str4 = "";
%>
<!-- 중간에 삽입할 구문들 -->
<%

for(QuickMovieVO vo : listQuickMovie) {
	String ratingAge = "";
	String wantToWatch = "";   // " on"
	String btnSelected = "";   // 선택되었으면 " on"으로.
	if(vo.getRating()!=null) {
		switch(vo.getRating()) {
		case "15세이상관람가":  
			ratingAge = " age-15";
			break;
		case "12세이상관람가":
			ratingAge = " age-12";
			break;
		case "전체관람가":
			ratingAge = " age-all";
			break;
		case "청소년관람불가":
			ratingAge = " age-19";
			break;
		}
	}
	if(vo.getWantToWatch()==1)
		wantToWatch = " on";
														//System.out.println(Arrays.toString(arrParamMovieCode));
														//System.out.println(arrParamMovieCode == null);			
	if(arrParamMovieCode != null) {
		for(String movieCode : arrParamMovieCode) {
			if(movieCode.equals(vo.getMovieCode()))
				btnSelected = " on";
		}
	}
/* 삭제가능	if(paramMovieCode.equals(vo.getMovieCode())) 
	삭제가능	btnSelected = " on"; */

	str1 = "<li movie_code='" + vo.getMovieCode() + "'>"
				+"	<button type='button' class='btn " + btnSelected + "'>"
				+"		<span class='movie-grade small" + ratingAge + "'>" + vo.getRating() + "</span>"
				+"		<i class='iconset ico-heart-small" + wantToWatch + "'>보고싶어	설정안함</i>"
				+"		<span class='txt'>" + vo.getMovieName() + "</span>"
				+"	</button>"
				+"</li>";
	listStr1.add(str1);		
}
%>

<%
	for(int i=0; i<=2; i++) {
		str2 = "";
		if(i<=listMoviePhoto.size()-1) {
			String photoName = listMoviePhoto.get(i);
			str2 += 	"<div class='bg'>" +
					"	<div class='wrap'>" +
					"		<div class='img'><img src='./movie_photo/"+photoName+"'></div>" +
					"	</div>" +
					"</div>";
		} else {
			str2 += 	"<div class='bg'>" +
					"</div>";
		}
	listPhotoName.add(str2);	
	} 
%>	
<%//삽입 str3
//스크롤바 위치 지정을 위해 넣는 배열
String[] cities = new String [] {"favorite","seoul","gyeonggi","incheon ","daejeon","pusan","gwangju","gangwon"};
for(int i=0; i<=arrArea.length-1; i++) {
	str3 = 	"<li>"
					+"	<button type='button' class='"
					+(arrArea[i].equals(paramArea) ? "on" : "")
					+"'>"
					+"		<span>"+arrArea[i]+"("+hMapArea.get(arrArea[i])+")</span>"
					+"	</button>"
					+"	<div class='depth"+(arrArea[i].equals(paramArea) ? " on" : "")+"'>"
					+"		<div  id='"+cities[i]+"'  class='detail-list scrollbar'>";
	//질문. 테이블을 2개 이상할 때, 어느 DAO에 넣어야 하나요?. while안에 있는 str은 어떻게 하나요?				
		if(paramArea.equals("선호극장")) {
		str3 += 		"<ul>";
		String sql2 = "select theater_name tn from theater"
				+ " where theater_name in (select theater_id from wish_theater where member_id = ?)";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setString(1, loginId);
		ResultSet rs2 = pstmt2.executeQuery();
		while(rs2.next()) {
			String tn = rs2.getString(1);
			str3 += "	<li><button id='btn' type='button' class='"
					+ (paramTheaterName.equals(tn) ? "on" : "")
					+ "'>"+tn+"</button></li>";
		}
		rs2.close();
		pstmt2.close();
		str3 += 		"</ul>";
	} 
		
	if(arrArea[i].equals(paramArea)) {
		str3 += 		"<ul>";
		String sql2 = "select theater_name from theater where area = ? and theater_name >'Z'"
				+ " union"
	 			+ " select theater_name tn from theater where area = ? and theater_name <='Z' order by theater_name";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setString(1, arrArea[i]);
		pstmt2.setString(2, arrArea[i]);
		ResultSet rs2 = pstmt2.executeQuery();
		while(rs2.next()) {
			String tn = rs2.getString(1);
			str3 += "	<li><button id='btn' type='button' class='"
					+ (paramTheaterName.equals(tn) ? "on" : "")
					+ "'>"+tn+"</button></li>";
		}
		rs2.close();
		pstmt2.close();
		str3 += 		"</ul>";
	}
	str3 +=			"		</div>"
					+"	</div>"
					+"</li>";
					
	listStr3.add(str3);
}
%>
<%//삽입 str4
for(QuickMovieTimeVO vo : listQuickMovieTime) {
		str4 = "<li>"
				+ "<button type='button' class='btn'>"
				//+ "<div class='legend'>"
				//+ "	<i class='iconset ico-sun' title='조조'>조조</i>"
				//+ "</div>"
				+ "<span class='time'>"
				+ "	<strong title='상영 시작'>"+vo.getStartHM()+"</strong>"
				+ "	<em title='상영 종료'>~"+vo.getEndHM()+"</em>"
				+ "</span>"
				+ "<span class='title'>"
				+ "	<strong title='"+vo.getMovieName()+"'>"+vo.getMovieName()+"</strong>"
				+ "	<em>"+vo.getType()+"</em>"
				+ "</span>"
				+ "<div class='info'>"
				+ "	<span class='theater' title='극장'>"+vo.getTheaterName()+"<br>"+vo.getShowroomName()+"</span>"
				+ "	<span class='seat'>"
				+ "		<strong class='now' title='잔여 좌석'>"+(vo.getTotal()-vo.getCurr())+"</strong>"
				+ "		<span>/</span>"
				+ "		<em class='all' title='전체 좌석'>"+vo.getTotal()+"</em>"
				+ "	</span>"
				+ "</div>"
				+ "</button>"
				+ "</li>";
				
				listStr4.add(str4);
}
%>
--%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="./image/megabox_logo.ico">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css" rel="stylesheet">
<link href='css/header_footer.css?a' rel='stylesheet' type='text/css'>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MEET PLAY SHARE, 내가박스</title>
<script src="js/jquery-3.6.0.min.js"></script>
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js" integrity="sha256-xH4q8N0pEzrZMaRmd7gQVcTZiFei+HfRTBPJ1OGXC0k=" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="./css/fast-rev.css?aa type="text/css" />
		<link rel="stylesheet" href="./css/jquery.mCustomScrollbar.css" type="text/css" />
		<script type="text/javascript" src="./js/jquery.mCustomScrollbar.js"></script>
<script>
$(function(){
	$('#exitButton').on("click",function(){
		$(this).parents(".background").toggleClass('on');
	});
	
	$('#loginBox').on("click",function(){
		$(".background").toggleClass('on');
	});
	
	$('#movelogin').on("click",function(){
		$(".layer-mynega").removeClass("on");
		$(".background").addClass('on');
		$(".mymegabox").removeClass('on');
	});
	
	$('.mymegabox').click(function(){
		$(this).toggleClass("on");
		$(".layer-mynega").toggleClass("on");
	});
	
	$('#sitemap').click(function(){
		$(this).toggleClass("on");
		$('.layer-sitemap').toggleClass("on");
	});
	
	$('.gnb-txt-movie, .gnb-depth2').mouseenter(function(){
		$('#gnb').addClass("on");
		$(this).parent('li').addClass("on");
	});
	
	$('.gnb-txt-movie, .gnb-depth2').mouseleave(function(){
		$('#gnb').removeClass("on");
		$(this).parent('li').removeClass("on");
	});

	$('.gnb-txt-reserve, .gnb-depth2').mouseenter(function(){
		$('#gnb').addClass("on");
		$(this).parent('li').addClass("on");
	});
	
	$('.gnb-txt-reserve, .gnb-depth2').mouseleave(function(){
		$('#gnb').removeClass("on");
		$(this).parent('li').removeClass("on");
	});
	
	$('.gnb-txt-theater, .gnb-depth2').mouseenter(function(){
		$('#gnb').addClass("on");
		$(this).parent('li').addClass("on");
	});
	
	$('.gnb-txt-theater, .gnb-depth2').mouseleave(function(){
		$('#gnb').removeClass("on");
		$(this).parent('li').removeClass("on");
	});
	
	$('.gnb-txt-event, .gnb-depth2').mouseenter(function(){
		$('#gnb').addClass("on");
		$(this).parent('li').addClass("on");
	});
	
	$('.gnb-txt-event, .gnb-depth2').mouseleave(function(){
		$('#gnb').removeClass("on");
		$(this).parent('li').removeClass("on");
	});
	
	$('.gnb-txt-benefit, .gnb-depth2').mouseover(function(){
		$('#gnb').addClass("on");
		$(this).parent('li').addClass("on");
	});
	
	$('.gnb-txt-benefit, .gnb-depth2').mouseout(function(){
		$('#gnb').removeClass("on");
		$(this).parent('li').removeClass("on");
	});
	/*  ======================================= ============= =*/
});

</script>
<script type="text/javascript">
		
	
			function sendPost(url, params){ 
				var form = document.createElement('form');
				form.setAttribute('method','post');
				form.setAttribute('action',url);
				document.charset = "utf-8";
				for(var key in params){
					var hiddenField = document.createElement('input');
					hiddenField.setAttribute('type','hidden');
					hiddenField.setAttribute('name', key);
					hiddenField.setAttribute('value',params[key]);
					form.appendChild(hiddenField);
			
				}
				document.body.appendChild(form);
				form.submit();
			}

			// jQuery Scroll Plugin 적용
			function fn_scroll_plugin() {
				$(".scrollbar").mCustomScrollbar({
					theme: "light-3", // 테마 적용
					mouseWheelPixels: 300, // 마우스휠 속도
					scrollInertia: 400 // 부드러운 스크롤 효과 적용
				});
			}

			function setup_left_bottom_posters() {
				num_of_selected = $(".all-list ul li button.btn.on").length;
				//alert(num_of_selected);
				if(num_of_selected==0) {
					$(".view-area > .choice-all").addClass('on');
					$(".view-area > .choice-list").removeClass('on');
				} else {
					$(".view-area > .choice-all").removeClass('on');
					
					
					$(".view-area > .choice-list").addClass('on');
				}
			}

			$(function () {
			 	fn_scroll_plugin();
				setup_left_bottom_posters();    // 좌측 영화선택 하단의 포스터(3개) 셋팅.

				$("div#movieList ul > li").click(function() {		// 영화선택
						var movie_code = $(this).attr("movie_code");
					
					var status_on = ($(this).find("button").attr('class').indexOf('on')==-1 ? false : true);
					//alert('status_on이 이거였음 = ' + status_on);
					if(status_on == true) {  // 해당 영화가 이미 선택되어 있는 상태였다면 ---> 선택 해제!	
						new_movie_code = '<%=paramMovieCode%>'.replace(movie_code.replace('#',''),'');
						new_movie_code = new_movie_code.replace('__','_');     // a_b_c ---> a__c ---> a_c
						if(new_movie_code.startsWith('_'))
							new_movie_code = new_movie_code.substring(1);		// _b_c ---> b_c
						if(new_movie_code.endsWith('_')) 
							new_movie_code = new_movie_code.substring(0, new_movie_code.length-1);   // a_b_ --> a_b
						if(new_movie_code.replace('#','')!='') {
// request.getRequestURL().toString() 을
// request.getContextPath()+"/Controller?"+request.getQueryString() 로 변경함. (X)
// url 로 변경함.
							location.href = '<%=url%>&movie_code=' + new_movie_code.replace('#','') + "&date=<%=paramDate%>";
						} else {
							location.href = '<%=url%>&date=<%=paramDate%>';
						}	
						//$(this).find("button").attr('class', 'btn');   // 선택 해제! ('on'을 제거.)
					} else if(<%=(arrParamMovieCode!=null ? arrParamMovieCode.length : 0)%> < 3) {   // 아직 3개까지 선택을 안 한 상태였다면. 
						if(movie_code!=null) {
							if(<%=(arrParamMovieCode!=null ? arrParamMovieCode.length : 0)%>==0) {
								location.href = '<%=url%>&movie_code=' + movie_code.replace('#','') + "&date=<%=paramDate%>";
							} else {
								location.href = '<%=url%>&movie_code=<%=paramMovieCode.replace("#","")%>_' + movie_code.replace('#','') + "&date=<%=paramDate%>";
							}
						}	
					} else {		// 이미 3개를 선택한 상황이었다면.
						// 무시. (더 이상 선택할 수 없음.)
					}
				});
				
				
				$("ul#theater-list > li > button").click(function() {							// 지역선택 (NOT 극장선택)
					var area = $(this).find("span").text();
					area = area.substring(0, area.indexOf("("));
				<%
					if(paramMovieCode != null && "".equals(paramMovieCode)==false) {
				%>
						location.href = '<%=url%>&movie_code=<%=paramMovieCode%>&area='+area+'&date=<%=paramDate%>';
				<%
					} else {
				%>
						location.href = '<%=url%>&area='+area;        // 이걸 허용해야 할까??
				<% } %>
					
				});
					
				$("ul#theater-list >li div.detail-list ul > li > button").click(function() {		// 극장선택
					var theater_name = $(this).text();
					//alert(theater_name);
					<%
						if(paramMovieCode != null && "".equals(paramMovieCode)==false) {
					%>
							location.href = '<%=url%>&movie_code=<%=paramMovieCode%>&area=<%=paramArea%>&theater_name='+theater_name+'&date=<%=paramDate%>';
					<%
						} else {
					%>
							location.href = '<%=url%>&area=<%=paramArea%>&theater_name='+theater_name;        // 이걸 허용해야 할까??
					<% } %>
				});
				
				$(".time-schedule .date-area button").click(function() {						// 날짜선택
					class_val = $(this).attr('class');
					if(class_val != 'disabled') {
						year_val = $(this).attr("year");
						month_val = $(this).attr("month");
						if(month_val.length<2) month_val = "0" + month_val;
						date_val = $(this).find("em").text();
						if(date_val.length<2) date_val = "0" + date_val;
						
						location.href = '<%=url%>&movie_code=<%=paramMovieCode.replace("#","")%>&area=<%=paramArea%>&theater_name=<%=paramTheaterName%>&date='+(year_val+month_val+date_val);
					}
 				});

				//팝업창 종료 버튼
				//확인버튼
				$(".button.purple.confirm").on("click", function () {
					$(".alertStyle").removeClass("on");
					$(".alert-popup").removeClass("on");
				});
				//X버튼
				$(".btn-layer-close").on("click", function () {
					$(".alertStyle").removeClass("on");
					$(".alert-popup").removeClass("on");
				});  

				// time schedule을 출력했는지? 출력했다면 기본표시이미지를 가려줘야.
				//if(<%=listQuickMovieTime.size()%>>0) {
				//	$(".no-result.on").attr('class', 'no-result');
				//}
				if('<%=paramMovieCode%>'!='' && '<%=paramArea%>'!='' && '<%=paramTheaterName%>'!='') {
					$(".no-result.on").attr('class', 'no-result');
				}
/* 				var playScheduleList_ul = $("#playScheduleList ul").html();
				alert("playScheduleList_ul.length : " + playScheduleList_ul.length);
				if(playScheduleList_ul.length > 0) {
					//alert("길이 : " + playScheduleList_ul.length);
				}
 */				
 				/*좌석 선택 페이지로 정보를 넘기는 함수 pjh*/
				$("#result ul li").click(function() {							// 영화상영시간 선택.
					var loginId = '<%=loginId%>';
					var movie_name = '';   // 선택한 영화
					var fullDate = '';	  // 선택한 날짜 --------> YYYYMMDD
									
					var theater_name = '';   // 선택한 극장 (ex. 강남)
					var theater_showroom_name = '';    // 선택한 상영관 (ex. 1관)
					var start_time_HM = '';   // 시작시간
					var end_time_HM = '';     // 끝시간
					var rating = '';    // 선택한 영화의 등급
					var show_type = '';    // 선택한 영화의 상영 타입
					var selectedDate = '<%=selectedDate%>';
					
					start_time_HM = $(this).find(".time").find("strong").text();
					end_time_HM = $(this).find(".time").find("em").text().substring(1);
					movie_name = $(this).find(".title").find("strong").text();
					show_type = $(this).find(".title").find("em").text();					
					theater_name = $(this).find(".info").find(".theater").html().split("<br>")[0];
					theater_showroom_name = $(this).find(".info").find(".theater").html().split("<br>")[1];

					rating = "";
					$("#movieList ul li button.on").each(function(index, item) {
						movie_name_here = $.trim($(this).find("span.txt").text());
						if(movie_name_here == movie_name) {
							idx = $(this).find("span").eq(0).attr('class').indexOf('age-');
							rating = $.trim($(this).find("span").eq(0).attr('class').substring(idx));
						}
					});
					// (X) rating = $("#movieList ul li button.on").find(".movie-grade").attr('class').split(" ")[$("#movieList ul li button.on").find(".movie-grade").attr('class').split(" ").length-1];

					year = $(".year-area .year").text().substring(0,4);	
					month = $(".year-area .year").text().substring(5,7);
					date = $(".date-area").find("button.on").find("em").text();
					day = $(".date-area").find("button.on").find("strong").text();
					fullDate = year +"."+ (month<10 ? "0"+month : month) +"."+ ((date<10)? "0" + date : date) +"("+ day +")";
				    /* fullDate = $(".year-area .year").text().substring(0,4) +"."+ $(".year-area .year").text().substring(5,7) +"."+ $(".date-area").find("button.on").find("em").text() +"("+$(".date-area").find("button.on").find("strong").text()+")"; */ 
				    
					sendPost("Controller?command=quickSeatsRev", {
						"start_time_HM" : start_time_HM,
						"end_time_HM" : end_time_HM,
						"movie_name" : movie_name,
						"show_type" : show_type,
						"theater_name" : theater_name,
						"theater_showroom_name" : theater_showroom_name,
						"rating" : rating,
						"selectedDate" : selectedDate,
						"fullDate" : fullDate
					});
					
				});
 
			});


		</script>
</head>
<body>
	<!-- header -->
	<header id="header" class="main-header no-bg">
		<div class="ci">
		<a href="index.jsp"></a>
		</div>
		<div class="util-area">
			<div class="left-link">
				<a href="#" title="VIP LOUNGE">VIP LOUNGE</a>
				<a href="#" title="맴버십">맴버십</a>
				<a href="centerhome.jsp" title="고객센터">고객센터</a>
			</div>
			<div class="right-link">
				<%
				System.out.println("메인 페이지 loginId :"+loginId);
				if(loginId == null || loginId.equals("")) { 
				%>
				<a href="#" title="로그인" id="loginBox">로그인</a>
				<%} else { %>
				<a href="logout.jsp" title="로그아웃" id="loginBox">로그아웃</a>
				<% } %> 
				<%if (loginId == null || loginId.equals("")) { %>
				<a href="Controller?command=sendEmail" title="회원가입">회원가입</a>
				<%} else { %>
				<!-- <a href="#" title="알림">알림</a> -->
				<% } %>
				<a href="Controller?command=fastRev" title="빠른예매">빠른예매</a>
			</div>
		</div>
		<div class="link-area">
			<a href="#" id="sitemap" class="menu-open-btn" title="사이트맵">사이트맵</a>
			<!-- <a href="#" id="search" class="search-btn" title="검색">검색</a>  미구현   -->
			<a href="#" class="mymegabox" title="나의내가박스">나의내가박스</a>
			<a href="movie-theater-table.jsp" class="link-ticket" title="상영시간표">상영시간표</a>
		</div>
		<nav id="gnb" class="">
			<ul class="gnb-depth1">
				<li class=""> <!-- <<<<< on으로 메뉴조정 -->
					<a href="Controller?command=allMovie" class="gnb-txt-movie" title="영화"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="Controller?command=allMovie" title="전체영화">전체영화</a></li>
							<li><a href="#" title="N스크린">N스크린</a></li>
							<li><a href="#" title="큐레이션">큐레이션</a></li>
							<li><a href="movie_post.jsp" title="무비포스트">무비포스트</a></li>
						</ul>
					</div>
				</li>
				<li class="">	<!-- <<<<< on으로 메뉴조정 -->
					<a href="Controller?command=fastRev" class="gnb-txt-reserve" title="예매"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="Controller?command=fastRev" title="빠른예매">빠른예매</a></li>
							<li><a href="movie-theater-table.jsp" title="상영시간표">상영시간표</a></li>
						</ul>
					</div>
				</li>
				<li class="">	<!-- <<<<< on으로 메뉴조정 -->
					<a href="AllTheater.jsp" class="gnb-txt-theater" title="극장"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="AllTheater.jsp" title="전체극장">전체극장</a></li>
							<li><a href="N스크린" title="특별관">특별관</a></li>
						</ul>
					</div>
				</li>
				<li class=""> 	<!-- <<<<< on으로 메뉴조정 -->
					<a href="#" class="gnb-txt-event" title="이벤트"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="#" title="진행중 이벤트">진행중 이벤트</a></li>
							<li><a href="#" title="지난 이벤트">지난 이벤트</a></li>
							<li><a href="#" title="당첨자 발표">당첨자 발표</a></li>
						</ul>
					</div>
				</li>
				<li>
					<a href="#" class="gnb-txt-store" title="스토어"></a>
				</li>
				<li class="">	<!-- <<<<< on으로 메뉴조정 -->
					<a href="#" class="gnb-txt-benefit" title="혜택"></a>
					<div class="gnb-depth2">
						<ul>
							<li><a href="#" title="내가박스 맴버십">내가박스 맴버십</a></li>
							<li><a href="#" title="제휴/할인">제휴/할인</a></li>
						</ul>
					</div>
				</li>
			</ul>
		</nav>
		<!--  on off 사이트맵  -->
		<div id='layer_sitemap' class='layer-sitemap'> <!-- on을 놓으면 켜지고, 빼면 꺼짐 display:none으로 조정함 -->
		<div class='layer_sitemap_wrap'>
			<a href="" class="link-acc" title="사이트맵 레이어 입니다.">사이트맵 레이어 입니다.</a>
			<p class="tit">SITEMAP</p>
			<div class="list position-1">
				<p class="tit-depth">영화</p>
				<ul class="list-depth">
					<li><a href="Controller?command=allMovie" title="전체영화">전체영화</a></li>
					<li><a href="/curation/specialcontent" title="큐레이션">큐레이션</a></li>
					<li><a href="javascript:void(0)" title="영화제">영화제</a></li>
					<li><a href="movie_post.jsp" title="무비포스트">무비포스트</a></li>
				</ul>
			</div>
			<div class="list position-2">
				<p class="tit-depth">예매</p>
				<ul class="list-depth">
					<li><a href="Controller?command=fastRev" title="빠른예매">빠른예매</a></li>
					<li><a href="movie-theater-table.jsp" title="상영시간표">상영시간표</a></li>
					<li><a href="javascript:void(0);" title="더 부티크 프라빗 예매">더 부티크 프라이빗 예매</a></li>
				</ul>
			</div>

			<div class="list position-3">
				<p class="tit-depth">극장</p>

				<ul class="list-depth">
					<li><a href="AllTheater.jsp" title="전체극장">전체극장</a></li>
					<li><a href="javascript:void(0);" title="특별관">특별관</a></li>
				</ul>
			</div>

			<div class="list position-4">
				<p class="tit-depth">이벤트</p>

				<ul class="list-depth">
					<li><a href="javascript:void(0)" title="진행중 이벤트">진행중 이벤트</a></li>
					<li><a href="javascript:void(0)" title="지난 이벤트">지난
							이벤트</a></li>
					<li><a href="javascript:void(0)" title="당첨자발표">당첨자발표</a></li>
				</ul>
			</div>

			<div class="list position-5">
				<p class="tit-depth">스토어</p>

				<ul class="list-depth">
					<li><a href="javascript:void(0)" title="새로운 상품">새로운 상품</a></li>
					<li><a href="javascript:void(0)" title="메가티켓">메가티켓</a></li>
					<li><a href="javascript:void(0)" title="메가찬스">메가찬스</a></li>
					<li><a href="javascript:void(0)" title="팝콘/음료/굿즈">팝콘/음료/굿즈</a></li>
					<li><a href="javascript:void(0)" title="기프트카드">기프트카드</a></li>
				</ul>
			</div>

			<div class="list position-6">
				<p class="tit-depth">나의 내가박스</p>
				<ul class="list-depth mymage">


					<li><a href="javascript:void(0);" title="나의 내가박스 홈">나의 내가박스 홈</a></li>
					<li><a href="javascript:void(0);" title="예매/구매내역">예매/구매내역</a></li>
					<li><a href="javascript:void(0);" title="영화관람권">영화관람권</a></li>
					<li><a href="javascript:void(0);" title="스토어교환권">스토어교환권</a></li>
					<li><a href="javascript:void(0);" title="할인/제휴쿠폰">할인/제휴쿠폰</a></li>

					<li><a href="javascript:void(0);" title="멤버십포인트">멤버십포인트</a></li>
					<li><a href="javascript:void(0);" title="나의 무비스토리">나의 무비스토리</a></li>
					<li><a href="javascript:void(0);" title="나의 이벤트 응모내역">나의 이벤트 응모내역</a></li>
					<li><a href="javascript:void(0);" title="나의 문의내역">나의 문의내역</a></li>
					<li><a href="javascript:void(0);" title="자주쓰는 할인 카드">자주쓰는 할인 카드</a></li>
					<li><a href="javascript:void(0);" title="회원정보">회원정보</a></li>
				</ul>
			</div>

			<div class="list position-7">
				<p class="tit-depth">혜택</p>

				<ul class="list-depth">
					<li><a href="javascript:void(0);" title="멤버십 안내">멤버십 안내</a></li>
					<li><a href="javascript:void(0);" title="VIP LOUNGE">VIP LOUNGE</a></li>
					<li><a href="javascript:void(0);" title="제휴/할인">제휴/할인</a></li>
				</ul>
			</div>

			<div class="list position-8">
				<p class="tit-depth">고객센터</p>

				<ul class="list-depth">
					<li><a href="centerhome.jsp" title="고객센터 홈">고객센터 홈</a></li>
					<li><a href="javascript:void(0);" title="자주묻는질문">자주묻는질문</a></li>
					<li><a href="javascript:void(0);" title="공지사항">공지사항</a></li>
					<li><a href="inquiry.jsp" title="1:1문의">1:1문의</a></li>
					<li><a href="javascript:void(0);" title="단체/대관문의">단체/대관문의</a></li>
					<li><a href="javascript:void(0);" title="분실물문의">분실물문의</a></li>
				</ul>
			</div>

			<div class="list position-9">
				<p class="tit-depth">회사소개</p>

				<ul class="list-depth">
					<li><a href="mymegabox.jsp" target="_blank" title="내가박스소개">내가박스소개</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="사회공헌">사회공헌</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="홍보자료">홍보자료</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="제휴/부대사업문의">제휴/부대사업문의</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="온라인제보센터">온라인제보센터</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="자료">IR자료</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="인재채용림">인재채용</a></li>
					<li><a href="javascript:void(0);" target="_blank" title="윤리경영">윤리경영</a></li>
				</ul>
			</div>


			<div class="list position-10">
				<p class="tit-depth">이용정책</p>

				<ul class="list-depth">
					<li><a href="javascript:void(0);" title="이용약관">이용약관</a></li>
					<li><a href="javascript:void(0);" title="개인정보처리방침">개인정보처리방침</a></li>
					<li><a href="javascript:void(0);" title="스크린수배정에관한기준">스크린수배정에관한기준</a></li>
				</ul>
			</div>

			<div class="ir">
				<a href="" class="layer-close" title="레이어닫기">레이어닫기</a>
			</div>


		</div>
	</div>
		<!-- layer-mynega on off -->
		<div id="header-layer-mynega" class="layer-mynega">
			<a class="ir" title="나의 내가박스 레이어 입니다."></a>
			<div class="wrap">
				<%if(loginId == null) { %>
				<!--  로그인 전  -->
				<div class="login-before">
					<p class="txt">
						로그인 하시면 나의 내가박스를 만날 수 있어요.
						<br/>
						영화를 사랑하는 당신을 위한 꼭 맞는 혜택까지 확인해 보세요!
					</p>
					<div class="mb50">
						<a href="#" id="movelogin" title="로그인" class="button" style="width:120px;">로그인</a>
					</div>
					<a href="Controller?command=sendEmail" class="link" title="혹시 아직 회원이 아니신가요?">혹시 아직 회원이 아니신가요?</a>
				</div>
				<%} else { %>
				<!--  로그인 후    -->
				<div class="login-after" >
					<div class="user-info">
						<p class="txt">안녕하세요!</p>
						<p class="info">
							<em><%=username %></em>
							<span>회원님</span>
						</p>
						<div class="last-date">
							마지막 접속일 : 
							<em><%=todate%></em>
						</div>
						<div class="btn-fixed">
							<a href="mymegabox.jsp" class="button" title="나의 내가박스">나의 내가박스</a>
						</div>
					</div>
					<div class="box">
						<div class="point">
							<p class="tit">Point</p>
							<p class="count">0</p>
							<div class="btn-fixed">
								<a href="javascript:void(0);" class="button" title="맴버십 포인트">맴버십포인트</a>
							</div>
						</div>
					</div>
					<div class="box">
						<div class="coupon">
							<p class="tit">쿠폰/관람권</p>
							<p class="count">
								<em title="쿠폰 수" class="cpon">0</em>
								<span title="관람권수" class="movie">0</span>
							
							<div class="btn-fixed">
								<a href="javascript:void(0);" class="button" title="쿠폰">쿠폰</a>
								<a href="javascript:void(0);" class="button" title="관람권">관람권</a>
							</div>
						</div>
					</div>
					<div class="box">
						<div class="reserve">
							<p class="tit">예매</p>
							<p class="txt">예매내역이 없어요!</p>
							<div class="btn-fixed">
								<a href="javascript:void(0);" class="button" title="예매내역">예매내역</a>
							</div>
						</div>
					</div>
					<div class="box">
						<div class="buy">
							<p class="tit">구매</p>
							<p class="count">
								<em>0</em>
								<span>건</span>
							</p>
						</div>
						<div class="btn-fixed">
							<a href="javascript:void(0);" class="button" title="구매내역">구매내역</a>
						</div>
					</div>
				</div>
				<% } %>
			</div>
		</div>
	</header>
	<div class="page-util">
		<div class="inner-wrap">
			<div class="location">
				<span>Home</span>
				<a href="#" title="페이지 이동">
					예매
				</a>
				<a href="#" title="페이지 이동">
					빠른예매
				</a>
			</div>
		</div>
	</div>
	<!-- ▽로그인 창 -->
	<!-- on으로 조정함 -->
	<div class="background ">
		<!-- 	<div style="height:100px;"></div>
		 --><div class="wrap1">
				<div class="wrap-login">
					<h3 class="tit fl">로그인</h3>
						<a id="exitButton" href="#" class="fr"><img src="image/btn-layer-close.png"/></a>
					<div style="clear:both;"></div>
				</div>
				<form method="post" action="Controller?command=loginCheck">
					<div class="layer-login">
						<div class="login-input-area">
							<input type="text" placeholder="아이디" id="id" name="id"/> <br/>
							<input type="password" placeholder="비밀번호" id="pw" name="pw"/> <br/>
						</div>
						<div class="chk">
							<div>
								<input id="chkbox" type="checkbox" style="font-size:14px; color:#444444;">
								아이디 저장
									<div class="ad">
										<a href=""></a>
											<span>휴대폰 간편로그인 </span>
											<span style="border:1px solid #3d7db7; font-size:14px; border: 1px solid #3d7db7; font-size: 14px; padding-left: 7px; padding-right: 7px;">광고</span>
									</div>
							</div>
	
						</div>
							<input type='submit' value='로그인' class="but">
						<div class="link">
							<a href="javascript:void(0);" style="text-decoration: none; color:#666666">ID/PW 찾기</a>
							<img src="image/I.png" style="margin: -9px; margin-left: -20px; margin-right: -25px;"/>
							<a href="Controller?command=sendEmail" style="text-decoration: none; color:#666666">회원가입</a>
							<img src="image/I.png" style="margin: -9px; margin-right: -25px; margin-left: -20px;"/>
							<a href="javascript:void(0);" style="text-decoration: none; color:#666666">비회원 예매확인</a>
						</div>
						<div class="sns-login">
							<a href="javascript:void(0);">
							<img src="image/ico-facebook.png">
							</a>
							<a href="javascript:void(0);">
							<img src="image/ico-naver.png">
							</a>
							<a href="javascript:void(0);">
							<img src="image/ico-kakao.png">
							</a>
							<a href="javascript:void(0);">
							<img src="image/ico-payco.png">
							</a>
						</div>
						<div class="col-right">
						</div>
					</div>
				</form>
				<div class="right-login">
					<div class="login-ad">
						<a href="javascript:void(0);">
							<img src="image/fecf1f96c23d2dfc4deaeba5b8c33828.jpg">
						</a>
					</div>
				</div>
			</div>
		</div>
	<!-- △로그인 창 -->
	<!--  header 종료 -->
	<!-- ▽main  -->
	<div class="inner-wrap" style="padding-top: 40px; padding-bottom: 100px">
			<!-- quick-reserve -->
			<div class="quick-reserve">
				<div class="tit-util">
					<h2 class="tit">빠른예매</h2>
				</div>

				<div class="mega-quick-reserve-inculde">
					<!-- time-schedule -->
					<div class="time-schedule quick">
						<div class="wrap">
							<!-- 이전날짜 -->
							<button type="button" title="이전 날짜 보기" class="btn-pre">
								<i class="iconset ico-cld-pre"></i> <em>이전</em>
							</button>
							<!--// 이전날짜 -->

							<div class="date-list">
								<!-- 년도, 월 표시 -->

								<script> 
									let today = new Date();
									let year = today.getFullYear(); // 년도
									let month = today.getMonth() + 1;  // 월
									let date = today.getDate();  // 날짜
									let day = today.getDay();  // 요일
									str = year + "." + month;
								</script>

								<div class="year-area">
									<script>
										document.write("<div class='year'>" + str + "</div>");
									</script>
								</div>

								<script>
									//날짜문제
									//var arr_date = [5,6,7,8,9,10,11,12,13,14,15,16,17,18];   // 일
									//var arr_day = ['오늘', '내일', '화', '수','목','금','토','일','월','화','수','목','금','토'];    // 요일
									var arr_year = new Array(14);
									var arr_month = new Array(14);
									var arr_date = new Array(14);
									var arr_day = new Array(14);        // 요일
									var arr_day2 = new Array(14);       // 요일2

									for (var i = 0; i < 14; i++) { // 일단, arr_day[] 에 0~6를 넣어놓고.  (i가 0이면 '오늘'임.) %는 몫이 아니라, 나머지를 구하는 것
										arr_day[i] = (day + i) % 7;
										arr_day2[i]  = (day + i) % 7;
									}
									for (var i = 0; i < 14; i++) {
										switch (arr_day[i]) {
											case 0: arr_day[i] = '일'; break;
											case 1: arr_day[i] = '월'; break;
											case 2: arr_day[i] = '화'; break;
											case 3: arr_day[i] = '수'; break;
											case 4: arr_day[i] = '목'; break;
											case 5: arr_day[i] = '금'; break;
											case 6: arr_day[i] = '토'; break;
										}
									}
									for (var i = 0; i < 14; i++) {
										switch (arr_day2[i]) {
											case 0: arr_day2[i] = '일'; break;
											case 1: arr_day2[i] = '월'; break;
											case 2: arr_day2[i] = '화'; break;
											case 3: arr_day2[i] = '수'; break;
											case 4: arr_day2[i] = '목'; break;
											case 5: arr_day2[i] = '금'; break;
											case 6: arr_day2[i] = '토'; break;
										}
									}

									for (var i = 0; i < 14; i++) {
										today = new Date();
										the_day = new Date(today.setDate(today.getDate() + i));
										arr_year[i] = the_day.getFullYear();
										arr_month[i] = the_day.getMonth()+1;
										arr_date[i] = the_day.getDate();
									}

								</script>

								<div class="date-area">
									<div class="wrap" style="position: relative; width: 2100px; border: none;">

										<script>
									
											for (var i = 0; i < 14; i++) {
												var str = "<button class='' year='"+arr_year[i]+"' month='"+arr_month[i]+"'>"
													+ "<em>" + arr_date[i] + "</em>" //일
													+ "<span style='display: inline-block;'>" + arr_day[i] + "</span>"//요일 
													+ "<strong class='hidden'>"+ arr_day2[i] +"</strong>" /*  =>화면 선택이 깨진다. */
													+ "</button>";
												document.write(str);
												if (arr_day[i] == "토") {
													$(".time-schedule .date-area button").eq(i).attr('class', 'sat');
												}
												else if (arr_day[i] == "일") {
													$(".time-schedule .date-area button").eq(i).attr('class', 'holi');
												}
												if (i >= 12) {
													$(".time-schedule .date-area button").eq(i).attr('class', 'disabled');
												}
												if ('<%=request.getParameter("date")%>'=='null' && i == 0) {
													$(".time-schedule .date-area button").eq(i).addClass('on');
												}
												//if(i==1)
//alert( arr_year[i]+"" + (arr_month[i]<10 ? "0"+arr_month[i] : arr_month[i])+""+(arr_date[i]<10 ? "0"+arr_date[i] : arr_date[i]) + "   vs   " + <%=request.getParameter("date")%>);
												if( '<%=request.getParameter("date")%>' == arr_year[i]+"" + (arr_month[i]<10 ? "0"+arr_month[i] : arr_month[i])+""+(arr_date[i]<10 ? "0"+arr_date[i] : arr_date[i])) {
													$(".time-schedule .date-area button").eq(i).addClass('on');
												}
												if (i == 0) {
													$(".time-schedule .date-area button span").eq(i).text('오늘');
												}
												if (i == 1) {
													$(".time-schedule .date-area button span").eq(i).text('내일');
												}
											}
							/* 			for(var i=0;i<=6;i++){
											alert(arr_day2[i]); =>월,화.수,목,금,토,일(오늘 내일 적용안함)
										} */
										</script>

									</div>
								</div>
							</div>

							<!-- 다음날짜 -->
							<button type="button" title="다음 날짜 보기" class="btn-next">
								<i class="iconset ico-cld-next"></i> <em>다음</em>
							</button>
							<!--// 다음날짜 -->

							<!-- 달력보기 -->
							<div class="bg-line">
								<input type="hidden" value="2021.12.06" />
								<button class="btn-calendar-large" title="달력보기">달력보기</button>
							</div>
							<!--// 달력보기 -->
						</div>
					</div>
					<!--// time-schedule -->

					<!-- quick-reserve-area -->
					<div class="quick-reserve-area">
						<!-- movie-choice : 영화 선택  -->
						<div class="movie-choice">
							<p class="tit">영화</p>

							<!-- list-area -->
							<div class="list-area">
								<!-- all : 전체 -->
								<div class="all-list">
									<button type="button" class="btn-tab on" id="movieAll">
										전체
									</button>
									<div class="list">
										<div class="scroll n-scroll nCustomScrollbar _mCS_1 scrollbar" id="movieList">
											<div id="mCSB_1"
												class="nCustomScrollBox mCS-light mCSB_vertical nCSB_inside"
												style="max-height: none" tabindex="0">
												<!--이 녀석을 없애니까, 스크롤이 사라짐-->
												<div id="mCSB_1_container" class="nCSB_container scroll"
													style="position: relative; top: 0; left: 0" dir="ltr">
													<ul>
<%
												for(String vo :listStr1){ //listStr1은 ArrayList이지마느 요소 하나만 vo에 담기 때문에, vo는 String이다.
%>
													 <%=vo %>	<!--삽입 str1  -->			 		
<%														
													}
%> 
													</ul>
												</div>

											</div>
										</div>
									</div>
								</div>
								<!--// all : 전체 -->
							</div>
							<!--// list-area -->
							<div class="other-list">
								<button type="button" class="btn-tab" id="movieCrtn">큐레이션</button>
								<div class="list" style="display: block;"></div>
							</div>


							<div class="view-area">
								
								<div class="choice-all on" id="choiceMovieNone">
									<strong>모든영화</strong><br/>
									<span>목록에서 영화를 선택하세요.</span>
								</div>
								<div class="choice-list " id="choiceMovieList">
									<% 
									for(String vo : listPhotoName){
									%>
											<%= vo %>
									
									<%}%>
								</div>
							</div> 
							
						</div>
						<!--// movie-choice : 영화 선택  -->

						<!-- theater-choice : 극장 선택  -->
						<div class="theater-choice">
							<div class="tit-area">
								<p class="tit">극장</p>
							</div>

							<!-- list-area -->
							<div class="list-area" id="brchTab">
								<!-- all-theater-list : 전체 -->
								<div class="all-theater-list">
									<button type="button" class="btn-tab on" style="width: 156px;">전체</button>
									<div class="list" style="height:400px";>
										<div class="scroll" id="brchList">
											<ul id="theater-list">
					
											<!--삽입 str3  -->
											<%for(String vo:listStr3){ 
											%>
												<%=vo%> 	
											<% }%>											
													
											</ul>
										</div>
									</div>
								</div>

								<div class="other-list">
									<button type="button" class="btn-tab"
										style="left: 156px; width: 156px;">특별관</button>
								</div>
							</div>
						

							<!-- <div class="view-area">  
							
								<div class="choice-all on">
									<strong>전체극장</strong><br/>
									<span>목록에서 극장을 선택하세요.</span>
								</div>

							
								<div class="choice-list "> 
									<div class="bg">
										<div class="wrap">
											<p class="txt">강남<button type="button" class="del">삭제</button></p>
										</div>
									</div>
									<div class="bg">
									</div>
									<div class="bg">
									</div>
								</div>
							</div>  -->

				

						</div>
						<!--// theater-choice : 영화관 선택  -->

						<!-- time-choice : 상영시간표 선택 -->
						<div class="time-choice">
							<div class="tit-area">
								<p class="tit">시간</p>

								<div class="right legend">
									<i class="iconset ico-sun" title="조조"></i> 조조 <i class="iconset ico-brunch" title="브런치"></i> 브런치 <i class="iconset ico-moon" title="심야"></i> 심야
								</div>
							</div>

							<!-- hour-schedule : 시간 선택  : 00~30 시-->
							<div class="hour-schedule">
								<button type="button" class="btn-prev-time">이전 시간 보기</button>

								<div class="wrap">
									<div class="view">
										<!-- class="hour on"에서 on으로 조정 -->
										<!--disabled="true"가 켜지면 버튼이 비활성화되면서, 회색이 된다. 없애면 원래대로 돌아간다.  -->
										<%
											if(hour<7)
												hour = 7;
										
											//year month date  vs  year month paramDate
											if(!(paramDate==null || ((year+ "" + (month<10 ? "0"+month : month) + "" + (date<10 ? "0"+date : date))).equals(paramDate))) {
												hour = 7;
											}
										%>										
										<button type="button" class="hour" disabled="true"
											style="opacity: 0.5"><%=(hour-4<10 ? "0" + (hour-4) : (hour-4)) %></button>
										<button type="button" class="hour" disabled="true"
											style="opacity: 0.5"><%=(hour-3<10 ? "0" + (hour-3) : (hour-3)) %></button>
										<button type="button" class="hour" disabled="true"
											style="opacity: 0.5"><%=(hour-2<10 ? "0" + (hour-2) : (hour-2)) %></button>
										<button type="button" class="hour" disabled="true"
											style="opacity: 0.5"><%=(hour-1<10 ? "0" + (hour-1) : (hour-1)) %></button>
										<button type="button" class="hour on"><%=(hour<10 ? "0" + (hour) : (hour)) %></button>
										<button type="button" class="hour"><%=(hour+1<10 ? "0" + (hour+1) : (hour+1)) %></button>
										<button type="button" class="hour"><%=(hour+2<10 ? "0" + (hour+2) : (hour+2)) %></button>
										<button type="button" class="hour"><%=(hour+3<10 ? "0" + (hour+3) : (hour+3)) %></button>
										<button type="button" class="hour"><%=(hour+4<10 ? "0" + (hour+4) : (hour+4)) %></button>
										<button type="button" class="hour"><%=(hour+5<10 ? "0" + (hour+5) : (hour+5)) %></button>
					
									</div>
								</div>

								<button type="button" class="btn-next-time">다음 시간 보기</button>
							</div>
							<!--// hour-schedule : 시간 선택  : 00~30 시-->

							<!-- movie-schedule-area : 시간표 출력 영역-->
							<div class="movie-schedule-area">
								<!-- 영화, 영화관 선택 안했을때 -->
								<!-- on의 유무로 조정. 시간표가 없을 때는 on이 켜지고, 시간표가 뜨면 on이 꺼진다. -->
								<div class="no-result on" id="playScheduleNonList">
									<i class="iconset ico-movie-time"></i>

									<p class="txt">
										영화와 극장을 선택하시면<br /> 상영시간표를 비교하여 볼 수 있습니다.
									</p>
								</div>

								<!-- 영화, 영화관 선택 했을때 result on이 되면서 켜짐 -->
								<div id='result' class="result">
									<div class="scroll scrollbar" id="playScheduleList"	style="display:block; height: 430px;">

										<ul>
											<% 
											System.out.println("Controller?command=fastRev : " + listStr4);
									for(String vo : listStr4){
									%>
											<%= vo %>
									
									<%}%>
											
											
										</ul>
									</div>

								</div>



							</div>
							<!--// movie-schedule-area : 시간표 출력 영역-->
						</div>
						<!--// time-choice : 상영시간표 선택 -->
					</div>
					<!--// quick-reserve-area -->
				</div>
			</div>


			<!-- 팝업창 뜰때의 검은 배경 -->
			<!-- class="alertStyle "에서 on으로 조정 -->
			<div class="alertStyle  "
				style="position: fixed; top: 0px; left: 0px; background: rgb(0, 0, 0); opacity: 0.7; width: 100%; height: 100%; z-index: 5005;">
			</div>

			<!-- 팝업창1 -->
			<!-- <section class="alert-popup  "에서 on으로 조정 -->
			<section class="alert-popup "
				style="position: fixed; padding-top: 45px; background: rgb(255, 255, 255); z-index: 5006; top: 386px; left: 881px; width: 600px; opacity: 1;"
				id="layerId_06890490035781209">
				<div class="wrap">
					<header class="layer-header">
						<h3 class="tit">알림</h3>
					</header>
					<div class="layer-con" style="height:340px; margin-left:22px; position:relative; bottom:28px;">
						<p class="txt-common"></p>
						<p>
							<font color="black">특별방역대책으로 방역패스 영화관 의무적용되어 <br>12 월 6 일부터 전 상영관이 백신패스관 으로 운영됩니다 <br>
								<font color="black"> (접종완료자만 입장가능 접종증빙서류 필참 )</font><br><strong>
									<font color="black"> 만 18 세 미만의 경우 접종유무에 관계없이 이용가능 </font><br> 띄어앉기 적용 / 상영관내 물 음료만
									취식가능
								</strong>
							</font><strong><br><br>[극장 이용 안내 ]<br>1.마스크 상시 착용 <br> 2.상영관 입장 전 발열 체크 <br> 3.극장 이용 전체 고객
								대상
								전자출입명부 작성<br> 입장 전 다소 시간이 소요되더라도 고객 여러분의 많은 협조 부탁드립니다 .</strong>
						</p>
						<p></p>
						<div class="btn-group" style="left:245px;">
							<strong>
								<button type="button" class="button lyclose" style="display: none;"></button>
								<button type="button" class="button purple confirm">확인</button>
							</strong>
						</div>
					</div><button type="button" class="btn-layer-close">레이어 닫기</button>
				</div>
			</section>

			<!-- 팝업창2 -->
			<!-- <section class="alert-popup  "에서 on으로 조정 -->
			<section class="alert-popup "
				style="position: fixed; padding-top: 45px; background: rgb(255, 255, 255); z-index: 5006; top: 386px; left: 881px; width: 600px; opacity: 1;"
				id="layerId_08437487240287769">
				<div class="wrap">
					<header class="layer-header">
						<h3 class="tit">알림</h3>
					</header>
					<div class="layer-con" style="height:250px; margin-left:22px; position:relative; bottom:28px;">
						<p class="txt-common"></p>
						<p>■[백신패스관] 은 접종완료자만 입장 가능합니다 (증빙서류 필참)■<br>* 접종완료기준 : 얀센 1 차 접종 그외 백신 2 차 접종 후 14 일 경과자 <br>*
							PCR
							검사 음성자 (48 시간이내), 만 18 세 이하 , 완치자 , 의학적 접종 불가자의 경우 예외적으로 허용 (단 , 관련증빙서류 지참시 )</p>
						<br><br>*안전한
						관람환경을 위한 메가박스의 조치에 적극적인 협조부탁드립니다<p></p>
						<p></p>
						<div class="btn-group" style="left:245px;">
							<button type="button" class="button lyclose" style="display: none;"></button>
							<button type="button" class="button purple confirm">확인</button>
						</div>
					</div><button type="button" class="btn-layer-close">레이어 닫기</button>
				</div>
			</section>

			<!-- 팝업창3 -->
			<!-- <section class="alert-popup  "에서 on으로 조정 -->
			<section class="alert-popup ">
				<div class="layer-header">
					<h3 class="tit">알림</h3>
				</div>
				<div class="layer-con" style="height: 138px">
					<p class="txt-common">영화상영시간이 20분 미만으로 남아있어 예매 취소는 현장에서만 가능합니다.
						예매하시겠습니까?</p>
					<div class="btn-group">
						<button type="button" class="button lyclose">취소</button>
						<button type="button" class="button purple confirm">확인</button>
					</div>
				</div>

				<button type="button" class="btn-layer-close">레이어 닫기</button>
			</section>
		</div>
	<!-- △main -->
	<!-- footer 입력 -->
	<div style="clear:both;"></div>
	<div id="footer">
		<div class="container1">
			<div id="footerbox1">
				<a href="javascript:void(0);" class="footerlink">회사소개</a>
				<a href="javascript:void(0);" class="footerlink">인재채용</a>
				<a href="javascript:void(0);" class="footerlink">사회공헌</a>
				<a href="javascript:void(0);" class="footerlink">제휴/광고/부대사업문의</a>
				<a href="javascript:void(0);" class="footerlink"><b>개인정보처리방침</b></a>
				<a href="javascript:void(0);" class="footerlink">윤리경영</a>
				<a href="AllTheater.jsp" id="footerbox"><img src="./image/ico-footer-search.png" style="margin:-4px 0" />극장찾기</a>
			</div>

			<div id="footerbox4">
				<div id="footerbox2">
					<img src="./image/logo-opacity_new2.png" style="margin:0 15px 0 0; float:left;" />
					<p class="footertext" style="margin-top:3px">
						서울특별시 마포구 월드컵로 240, 지상 2층(성산동, 월드컵주경기장) ARS 1544-0070</p>
					<p class="footertext">
						대표자명 김진선 · 개인정보보호책임자 조상연 · 사업자등록번호 211-86-59478 · 통신판매업신고번호 제 833호
					</p>
					<p class="footertext">
						COPYRIGHT © MegaboxJoongAng, Inc. All rights reserved
					</p>
				</div>

				<div id="footerbox3">
					<a href="javascript:void(0);">
						<div class="footerlink1" style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-appstore.png)">
						</div>
					</a>
					<a href="https://play.google.com/store/apps/details?id=com.megabox.mop">
						<div class="footerlink1" style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-googleplay.png)">
						</div>
					</a>
					<a href="https://www.instagram.com/megaboxon">
						<div class="footerlink1" style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-instagram.png)">
						</div>
					</a>
					<a href="https://www.facebook.com/megaboxon">
						<div class="footerlink1" style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-facebook.png)">
						</div>
					</a>
					<a href="https://twitter.com/megaboxon">
						<div class="footerlink1" style="background-image:url(https://img.megabox.co.kr/static/pc/images/common/ico/ico-twitter.png)">
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>