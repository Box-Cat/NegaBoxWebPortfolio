package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import dto.ListDistrictTheaterCount;
import dto.MovieStarScheduleVO;
import dto.TheaterStarScheduleVO;

public class TheaterTimeListDao {
	
	public void areaCount (ArrayList<ListDistrictTheaterCount> listDistrictTheaterCount){
	
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs =null;
	
	String sql  = " SELECT distinct AREA, count(*) "  
			+ " FROM theater "  
			+ " WHERE not AREA is Null "
			+ " group by AREA"
			+ " ORDER by ( CASE AREA "
			+ " WHEN '서울' THEN 1 "
			+ " WHEN '경기' THEN 2 "
			+ " WHEN '인천' THEN 3 "
			+ " WHEN '대전/충청/세종' THEN 4 "
			+ " WHEN '부산/대구/경상' THEN 5 "
			+ " WHEN '광주/전라' THEN 6 "
			+ " WHEN '강원' THEN 7 "
			+ " ELSE 8 END ) ";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String area = rs.getString("AREA");
				int areaCount = rs.getInt("COUNT(*)");
				ListDistrictTheaterCount vo = new ListDistrictTheaterCount(area, areaCount);
				listDistrictTheaterCount.add(vo);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}


	public HashMap<String, String> listTheater (ArrayList<String> listTheater, HashMap<String, String> mapTheaterKorToEng){
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		String sql2 = "SELECT THEATER_NAME, theater_id "
			    + " FROM THEATER "
			    + " WHERE area=? " //서울
			    + " ORDER BY "
			    + " (CASE WHEN THEATER_NAME = 'ARTNINE' "
			    + " THEN 1 else 0 END),THEATER_NAME asc ";
		try {
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			String inputArea = "서울"; //받아오도록 변경해야 함. 작업중 getParameter snedPost 
			pstmt2.setString(1, inputArea);
			ResultSet rs2 = pstmt2.executeQuery();
			while(rs2.next()) {
				String theaterName = rs2.getString("theater_name");
				String theaterId = rs2.getString("theater_id");
				/*String vo = new String(theaterName);*/
				listTheater.add(theaterName);
				//System.out.println(listTheater.toString());
				mapTheaterKorToEng.put(theaterName, theaterId);
			}
			rs2.close();
			pstmt2.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mapTheaterKorToEng;
	}

	
	public int getRemainingSeats(String inputTheaterId, String inputDay, String movieCode, String theaterShowroom, String startTime, int totalSeats) {
		// 극장별 상영시간표의 예약 좌석수
		String sql4 = "select count(*)" + " FROM reservation r, screen_info si"
				+ " WHERE r.screen_info_code = si.movie_info_code" + " and si.theater_id = ?" + // 강남
				" and si.day = ?" + // 22/01/06
				" and si.movie_code = ?" + // #스파이더맨:노웨이홈
				" and si.theater_showroom = ?" + // GANGNAM1
				" and si.time =  ?"; // '09:10'
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt4;
		int remainingSeats = -1; 
		try {
			pstmt4 = conn.prepareStatement(sql4);
			pstmt4.setString(1, inputTheaterId);
			pstmt4.setString(2, inputDay);
			pstmt4.setString(3, movieCode);
			pstmt4.setString(4, theaterShowroom); // 상영관
			pstmt4.setString(5, startTime);
			ResultSet rs4 = pstmt4.executeQuery();
			rs4.next();
			remainingSeats = totalSeats - rs4.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("return하기 직전의 remainingSeats :" + remainingSeats);
		return remainingSeats;
	}
	
	public void getListTheaterStarScheule(String inputTheaterName, String inputDay, String inputTheaterId ,ArrayList<TheaterStarScheduleVO> listTheaterStarScheduleVO ){
	
		//String inputTheaterId = mapTheaterKorToEng.get(inputTheaterName);	 
		
		String sql3 = " SELECT t.theater_name,  m.rating, m.movie_name, ts.name, ts.total_seats, si.type, si.time, m.running_time "
				+ " FROM screen_info si, theater t, theater_showroom ts, movie m"
				+ " WHERE si.theater_id = t.theater_id " + " and ts.theater_showroom_code = si.theater_showroom "
				+ " and m.movie_code = si.movie_code " + " and t.theater_name = ? " + // "강남"
				" and si.day= ? " + // "22/01/06"
				" ORDER BY m.movie_name, ts.name, si.time";
		Connection conn = DBConnection.getConnection();

		try {
			PreparedStatement pstmt3 = conn.prepareStatement(sql3);
			pstmt3.setString(1, inputTheaterName);
			pstmt3.setString(2, inputDay);
			ResultSet rs3 = pstmt3.executeQuery();
			while (rs3.next()) {
				String theaterName = rs3.getString("theater_name"); // 강남 "theater_name"
				String rating = rs3.getString("rating"); // 전체이용가, 12세, 15세, 19세
				String movieName = rs3.getString("movie_name");
				String name = rs3.getString("name"); // 신촌 1관 컴포트
				int totalSeats = rs3.getInt("total_seats"); // 총좌석수
				String type = rs3.getString("type"); // 2D(자막)
				String startTime = rs3.getString("time"); // DB:"time" // 상영시간 "03:10" "time"
				int runningTime = rs3.getInt("running_time");
				int remainingSeats = -1;
				String endTime;

				int timeH = Integer.parseInt(startTime.split(":")[0]);
				int timeM = Integer.parseInt(startTime.split(":")[1]);
				timeM += runningTime + 10; // 10은 광고시간
				timeH += timeM / 60;
				timeM = timeM % 60;
				endTime = (timeH < 10 ? "0" : "") + timeH + ":" + (timeM < 10 ? "0" : "") + timeM;

				// movieName ---> movieCode
				String movieCode = "#" + movieName.replace(" ", "");

				// 상영관 name "신촌 1관 컴포트" ---> theater_showroom "GANGNAM1"
				String sql3b = "SELECT theater_showroom_code FROM theater_showroom WHERE name=?";
				PreparedStatement pstmt3b = conn.prepareStatement(sql3b);
				pstmt3b.setString(1, name);
				ResultSet rs3b = pstmt3b.executeQuery();
				String theaterShowroom = "";
				if (rs3b.next()) {
					theaterShowroom = rs3b.getString(1);
				}
				rs3b.close();
				pstmt3b.close();
				
				//listTheater(listTheater,mapTheaterKorToEng).get(inputTheaterName)
				remainingSeats = getRemainingSeats(inputTheaterId, inputDay, movieCode, theaterShowroom, startTime, totalSeats); 

				TheaterStarScheduleVO vo = new TheaterStarScheduleVO(theaterName, rating, movieName, name, totalSeats,type, startTime, endTime, remainingSeats, runningTime);
				listTheaterStarScheduleVO.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		for(TheaterStarScheduleVO vo : listTheaterStarScheduleVO) {
			System.out.println("TheaterStarScheduleVO - vo : " + vo);
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	

}
