package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import dto.QuickMovieTimeVO;
import dto.QuickMovieVO;

public class FastRevDao {
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;

//	public static ArrayList<String> listMoviePhoto = new ArrayList<String>();
//	public static String[] arrParamMovieCode = null;	// ex. [#유체이탈자, #스파이더맨:노웨이홈] 
//	public static ArrayList<QuickMovieVO> listQuickMovie = new ArrayList<QuickMovieVO>();
//	//public static ArrayList<QuickMovieTimeVO> listQuickMovieTime = new ArrayList<QuickMovieTimeVO>();
//	public static HashMap<String, Integer> hMapArea = new HashMap<String, Integer>();
	
	//날짜 관련 -- 모든 thread가 공유하는 변수.
	public static Calendar cal = Calendar.getInstance();
	public static int year = cal.get(Calendar.YEAR);
	public static int month = cal.get(Calendar.MONTH)+1;
	public static int date = cal.get(Calendar.DATE);
	public static int hour = cal.get(Calendar.HOUR_OF_DAY);
	public static int minute = cal.get(Calendar.MINUTE);
	public static String[] arrArea = {"선호극장", "서울", "경기", "인천", "대전/충청/세종", "부산/대구/경상", "광주/전라", "강원"};
	
	//중간에 삽입하는 구문의 변수들
	//public static String str1 = "";
	//public static String str2 = "";
	//public static String str3 = "";
	//public static String str4 = "";

	
	public String showMovieHeart(String paramMovieCode, String selectedDate, String[] arrParamMovieCode, ArrayList<String> listMoviePhoto ){
		String 	sql = "select m.movie_code mc, m.movie_photo"
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
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, selectedDate); //selectedDate
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String mc = rs.getString("mc");
				if(mc!=null) mc = mc.trim();
				//System.out.println("mc : " + mc);
				theNewParamMovieCode += mc.substring(1) + "_";
				
				String moviePhoto = rs.getString("movie_photo");
				System.out.println("movie_code :" + mc); 
				System.out.println("theNewParamMovieCode :" + theNewParamMovieCode);
				listMoviePhoto.add(moviePhoto); // 이 녀석도 만들어야함.
			}
			if(theNewParamMovieCode.length()>0) {
				paramMovieCode = theNewParamMovieCode.substring(0, theNewParamMovieCode.length()-1);
				arrParamMovieCode = paramMovieCode.split("_"); 
				for(int i=0; i<=arrParamMovieCode.length-1; i++)
					arrParamMovieCode[i] = "#" + arrParamMovieCode[i]; // 이 녀석도 만들어야함.
			} else {
				paramMovieCode = "";
				//동시에 3개를 리턴해야할까??
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
//		return arrParamMovieCode;
		return paramMovieCode;
		
	}
	
	//각 회원의 하트여부를 리턴하는 메서드
	public byte myHeart(String loginId, String movieCode, String rating, String movieName, String moviePhoto) {
		String sql1b="SELECT count(*) FROM want_to_watch wtw " +
				  "WHERE member_id=? AND movie_code = ?";
		PreparedStatement pstmt1b;
		byte wantToWatch = 0;
		try {
			pstmt1b = conn.prepareStatement(sql1b);
			pstmt1b.setString(1, loginId);
			pstmt1b.setString(2, movieCode);
			ResultSet rs1b = pstmt1b.executeQuery();
			if(rs1b.next()) {
				wantToWatch = (byte)(rs1b.getInt(1));
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		return wantToWatch;
	}

	// 비회원도 볼 수 있는 영화/하트 목록 출력	
	public void showMovieHeartNoId(String selectedDate, String loginId, ArrayList<QuickMovieVO> listQuickMovie){
			String sql1 =" SELECT m.movie_code mc, m.rating r, m.movie_name mn, m.movie_photo mp " + 
					  " FROM movie m " +
					  " WHERE m.movie_code " + 
					  " IN (SELECT distinct si.movie_code FROM  screen_info si WHERE si.day=?)";
			
			PreparedStatement pstmt1;
			try {
				pstmt1 = conn.prepareStatement(sql1);
				pstmt1.setString(1, selectedDate);
				ResultSet rs1 = pstmt1.executeQuery();
				while(rs1.next()) {
					String mc = rs1 .getString("mc");
					String r = rs1 .getString("r");		// rating : (ex) "15세이상관람가"
					String mn = rs1 .getString("mn");
					String mp = rs1 .getString("mp");
					String wtwmc = "";
					String wtwId = "";
					if(mc!=null) mc = mc.trim();
					if(r!=null) r = r.trim();
					if(mn!=null) mn = mn.trim();
					if(mp!=null) mp = mp.trim();
					
					//wantToWatch는 myHeart()로 채움
					byte wantToWatch = myHeart(loginId, mc, r, mn, mp); 
					QuickMovieVO vo = new QuickMovieVO(mc, r, mn,  wantToWatch , mp);  
					listQuickMovie.add(vo); //필드값에 채우니까, 굳이 리턴할 필요가 없다.		 
				}

				pstmt1.close();
				rs1.close();
				for(QuickMovieVO vo : listQuickMovie) {
					System.out.println(vo);
				}
				
			}catch (Exception e) {
				e.printStackTrace();
			}
	}
	
	public void countTheater(String loginId, String[] arrArea, HashMap<String, Integer> hMapArea){
		for(String area : arrArea) {
			if("선호극장".equals(area)) {
				String sql = "select count(*) from wish_theater where member_id = '"+loginId+"'";
				try {
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						int cnt = rs.getInt(1);
						hMapArea.put(area, cnt);      // 0 <-- 극장수.	
						System.out.println(hMapArea);
					}
					rs.close();
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else {
				//sql = "select count(theater_id), area from theater group by area";
				String sql = "select count(theater_id) from theater where area = '"+area+"'";
				try {
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						int cnt = rs.getInt(1);
						hMapArea.put(area, cnt);      // 0 <-- 극장수.	
						System.out.println(hMapArea);
					}
					rs.close();
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
		}
	}
	
	//selectTheater()의 내부메서드
	public int countCurrSeats(String name, String time, String findDay){
		String sql2 = "select count(*) from reservation"
				   + " where screen_info_code in ("
				   + "	select movie_info_code from screen_info"
				   + "	where theater_showroom in (select theater_showroom_code from theater_showroom where name = ?)"
				   + "	and time = ? and day=?"
				   + " )";
			PreparedStatement pstmt2;
			int cntCurr = 0;    // 현재예약좌석수.
			try {
				pstmt2 = conn.prepareStatement(sql2);
				pstmt2.setString(1, name);
				pstmt2.setString(2, time);
				pstmt2.setString(3, findDay);   // "21/12/24"
				ResultSet rs2 = pstmt2.executeQuery();
				if(rs2.next()) {
					cntCurr = rs2.getInt(1);
				}
				System.out.println("cntCurr(현재 좌석) :" + cntCurr);
				pstmt2.close();
				rs2.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return cntCurr;
	}
	
	//(request.getParameter("theater_name")는 변수에 담지 선언가능?, 메서드로 쓸때는 다른 변수에 담아서 사용??
	public ArrayList<QuickMovieTimeVO> selectTheater(String selectedDate, String paramTheaterName,String[] arrParamMovieCode ) {
		// selectedDate : "22/01/20"
		// paramTheaterName : "강남"  
		// arrParamMovieCode : {"#특송"}
		// paramDate : "20220120" 
		String paramDate = "20"+selectedDate.split("/")[0] + selectedDate.split("/")[1] + selectedDate.split("/")[2];
		System.out.println("selectTheater : paramDate = " + paramDate);
		ArrayList<QuickMovieTimeVO> listQuickMovieTime = new ArrayList<QuickMovieTimeVO>();
		
		/*
		 * Calendar cal = Calendar.getInstance(); int year, month, date, hour, minute;
		 * year = cal.get(Calendar.YEAR); month = cal.get(Calendar.MONTH)+1; date =
		 * cal.get(Calendar.DATE); hour = cal.get(Calendar.HOUR_OF_DAY); minute =
		 * cal.get(Calendar.MINUTE);
		 */
		
		//질문
		//이 sql문은 강남/신촌/홍대 를 구분하지 못하고 있음.
		String sql = "select m.running_time, m.movie_name, m.movie_code, si.time, si.type, ts.name, ts.total_seats, si.day"
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
				
		try {
			pstmt = conn.prepareStatement(sql);
			//String findDay = (year%100) + "/" + month + "/" + (paramDate==null ? date : paramDate);     // --------> "21/12/24"(=selectedDate)
			String findDay = selectedDate;   						//paramDate;    // 20220101
			String findTheaterName = paramTheaterName;  // "강남";
			//String findMovieCode = paramMovieCode;   // "#스파이더맨:노웨이홈";
			String[] arrFindMovieCode = arrParamMovieCode;   // arrParamMovieCode : { "#스파이더맨:노웨이홈", "#연애빠진로맨스", "#매트릭스:리저렉션" }
			if(arrFindMovieCode!=null) {
				for(int i=0; i<=arrFindMovieCode.length-1; i++)
					arrFindMovieCode[i] = arrFindMovieCode[i];  // 
				System.out.print("arrFindMovieCode[] : ");
				for(String mc : arrFindMovieCode) {
					System.out.print(mc + ", ");
				}
				System.out.println();
			} /*
				 * else { System.out.println("arrParamMovieCode는 비었습니다."); }
				 */
			//if(arrFindMovieCode!=null) {
			//	System.out.print("arrFindMovieCode[] : ");
			//	for(String mc : arrFindMovieCode) {
			//		System.out.print(mc + ", ");
			//	}
			//	System.out.println();
			//}
		
			pstmt.setString(1, findDay);
			pstmt.setString(2, findTheaterName);
			pstmt.setString(3, (arrFindMovieCode!=null ? arrFindMovieCode[0] : ""));
			pstmt.setString(4, (arrFindMovieCode!=null && arrFindMovieCode.length>=2) ? arrFindMovieCode[1] : "");
			pstmt.setString(5, (arrFindMovieCode!=null && arrFindMovieCode.length>=3) ? arrFindMovieCode[2] : "");
			if( (year+ "" + (month<10 ? "0"+month : month) + "" + (date<10 ? "0"+date : date)).equals(paramDate) ) {
				pstmt.setString(6, (hour<10 ? "0"+hour+":"+minute : hour+":"+minute));     
				//System.out.println("hour : minute :" + hour+":"+minute);			
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
				int cntCurr = countCurrSeats(name, time, findDay); 
							// -----------------------------------------------
				listQuickMovieTime.add(new QuickMovieTimeVO(time, endTime, movie_name, type, paramTheaterName, name, cntCurr, total_seats)); //작업중
			}
			pstmt.close();
			rs.close();
	 		for(QuickMovieTimeVO vo : listQuickMovieTime) {
				System.out.println("listQuickMovieTime :" + vo);
				//DB
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listQuickMovieTime;
	}
	
	
	
	
	
	//▽중간에 삽입하는 구문의 메서드들
	public ArrayList<String> makeListStr1(ArrayList<QuickMovieVO> listQuickMovie, String[] arrParamMovieCode) {
		String str1 = "";
		ArrayList<String> listStr1 = new ArrayList<String>();

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
		return listStr1;
	}
	
	public ArrayList<String> makeListStr2(ArrayList<String> listMoviePhoto) {
		ArrayList<String> listPhotoName = new ArrayList<String>();
		for(int i=0; i<=2; i++) {
			String str2 = "";
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
		return listPhotoName;
	}
	
	public ArrayList<String> makeListStr3(String loginId, String paramArea, String paramTheaterName, HashMap<String, Integer> hMapArea) {
		ArrayList<String> listStr3 = new ArrayList<String>();
		String[] cities = new String [] {"favorite","seoul","gyeonggi","incheon ","daejeon","pusan","gwangju","gangwon"};
		for(int i=0; i<=arrArea.length-1; i++) {
			String str3 = 	"<li>"
							+"	<button type='button' class='"
							+(arrArea[i].equals(paramArea) ? "on" : "")
							+"'>"
							+"		<span>"+arrArea[i]+"("+hMapArea.get(arrArea[i])+")</span>"
							+"	</button>"
							+"	<div class='depth"+(arrArea[i].equals(paramArea) ? " on" : "")+"'>"
							+"		<div  id='"+cities[i]+"'  class='detail-list scrollbar'>";
			
			try {
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
			} catch(Exception e) { e.printStackTrace(); }
			str3 +=			"		</div>"
							+"	</div>"
							+"</li>";
							
			listStr3.add(str3);
		}
		return listStr3;
	}
	
	public ArrayList<String> makeListStr4(ArrayList<QuickMovieTimeVO> listQuickMovieTime) {
		ArrayList<String> listStr4 = new ArrayList<String>();
		
		for(QuickMovieTimeVO vo : listQuickMovieTime) {
			String str4 = "<li>"
					+ "			<button type='button' class='btn'>"
					//+ "<div class='legend'>"
					//+ "	<i class='iconset ico-sun' title='조조'>조조</i>"
					//+ "</div>"
					+ "				<span class='time'>"
					+ "					<strong title='상영 시작'>"+vo.getStartHM()+"</strong>"
					+ "					<em title='상영 종료'>~"+vo.getEndHM()+"</em>"
					+ "				</span>"
					+ "				<span class='title'>"
					+ "					<strong title='"+vo.getMovieName()+"'>"+vo.getMovieName()+"</strong>"
					+ "					<em>"+vo.getType()+"</em>"
					+ "				</span>"
					+ "				<div class='info'>"
					+ "					<span class='theater' title='극장'>"+vo.getTheaterName()+"<br>"+vo.getShowroomName()+"</span>"
					+ "					<span class='seat'>"
					+ "						<strong class='now' title='잔여 좌석'>"+(vo.getTotal()-vo.getCurr())+"</strong>"
					+ "						<span>/</span>"
					+ "					<em class='all' title='전체 좌석'>"+vo.getTotal()+"</em>"
					+ "					</span>"
					+ "				</div>"
					+ "			</button>"
					+ "	</li>";
			listStr4.add(str4);
		}
		return listStr4;
	}
}
