package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.MovieStarScheduleVO;

public class MovieTimeListDao {

	//타원형의 영화 목록 ----> // dao.getMovieList(listMovieName, listRating, listMoviePhoto)
	public void getMovieList(ArrayList<String> listMovieName, ArrayList<String> listRating, ArrayList<String> listMoviePhoto) {
		String sql = "SELECT distinct m.movie_name, m.opening_day, m.rating, m.movie_photo" 
				+ " FROM screen_info si, movie m"
				+ " WHERE si.movie_code = m.movie_code" 
				+ " ORDER BY m.opening_day DESC";

		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String movieName = rs.getString("movie_name");
				String rating = rs.getString("rating");
				String moviePhoto = rs.getString("movie_photo"); 
				//System.out.println(movieName);
				listMovieName.add(movieName);
				listRating.add(rating);
				listMoviePhoto.add(moviePhoto);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// getRemainingSeats() : 잔여좌석수를 반환함.
	public int getRemainingSeats(String daySelected, String startTime, String theaterShowroom, String movieCodeSelected, int totalSeats) {
		String sql2 = "select count(*)" + 
				" FROM reservation r, screen_info si" + 
				" WHERE r.screen_info_code = si.movie_info_code" + 
				" and si.day = ?" +           // '22/01/06' = daySelected
				" and si.time = ?" +          // '09:10' = startTime
				" and si.theater_showroom = ?" +     // 'GANGNAM1' = theaterShowroom
				" and si.movie_code = ?";     // '#스파이더맨:노웨이홈' = movieCodeSelected
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt2;
		int remainingSeats = -1;    // 초기값일 뿐. 혹시, "-1"로 화면에 표시되면, 아래에서 무언가 잘못되었다는 뜻!
		try {
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, daySelected);
			pstmt2.setString(2, startTime);
			pstmt2.setString(3, theaterShowroom);
			pstmt2.setString(4, movieCodeSelected);
			ResultSet rs2 = pstmt2.executeQuery();
			rs2.next();
			remainingSeats = totalSeats - rs2.getInt(1);
		} catch (SQLException e) { e.printStackTrace(); }
		return remainingSeats;
	}
	// TODO : 여기서, remaingSeats에 코로나석 개수를 차감해야....
	// 좌석테이블.... String rowSeats = rs.getString(~~~) ---> String[] arr_seat = rowSeats.split(",") ---> 배열 안에 있는 요소들 중 "x"에 해당되는 개수 = "그 줄에 있는 코로나 석의 개수"
	// ,를 제거하면 배열이 된다. 이 상태에서 arr[i] ==x 식으로 해서, x에 해당하는 개수를 찾는다.  이런 식으로 한 상영관의 총 x개수를 구한다.

	public void getListMovieStarScheule(String movieCodeSelected, String daySelected, String areaSelected, ArrayList<MovieStarScheduleVO> listMovieStarSchedule) {
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT t.theater_name, ts.name, ts.total_seats, si.time, si.type, m.running_time, si.theater_showroom" + 
				" FROM screen_info si, theater t, theater_showroom ts, movie m" + 
				" WHERE si.theater_id = t.theater_id" + 
				" and ts.theater_showroom_code = si.theater_showroom" + 
				" and m.movie_code = si.movie_code" + 
				" and si.movie_code like ?" +           // '%스파이더맨%' 
				" and si.day=?" +     // '22/01/06'
				" and t.area = ?" +   // '서울'
				" order by theater_name, name, time asc";
		
		try {
			pstmt = conn.prepareStatement(sql);
			//pstmt.setString(1, "%"+movieNameSelected+"%");
			pstmt.setString(1, "%"+movieCodeSelected+"%");
			pstmt.setString(2, daySelected);
			pstmt.setString(3, areaSelected);
	//System.out.println("[sql] " + sql);
	//System.out.println("%"+movieNameSelected+"%");
	//System.out.println(daySelected);
	//System.out.println(areaSelected);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String theaterName = rs.getString("theater_name");
				String name = rs.getString("name");
				String startTime = rs.getString("time");     // 상영시간  "03:10"  "time"
				String endTime;      
				String type = rs.getString("type"); // 2D(자막)   "type"
				int runningTime = rs.getInt("running_time");    // 상영시간 (분)    "running_time"
				int totalSeats = rs.getInt("total_seats");   // 총좌석수      "total_seats"
				String theaterShowroom = rs.getString("theater_showroom");   // "GANGNAM1"
	
				int timeH = Integer.parseInt(startTime.split(":")[0]);
				int timeM = Integer.parseInt(startTime.split(":")[1]);	
				timeM += runningTime+10;  //10은 광고시간
				timeH += timeM/60;
				timeM = timeM%60;
				endTime = (timeH < 10 ? "0" : "") + timeH + ":" + (timeM < 10 ? "0" : "") + timeM;
	
				int remainingSeats = getRemainingSeats(daySelected, startTime, theaterShowroom, movieCodeSelected, totalSeats);   // 잔여좌석수 
	
				MovieStarScheduleVO vo = new MovieStarScheduleVO(theaterName,name,startTime,endTime,type,runningTime,totalSeats,remainingSeats,theaterShowroom);
				listMovieStarSchedule.add(vo);
			
				
			}
		} catch(Exception e) { e.printStackTrace(); }
	
		for(MovieStarScheduleVO vo : listMovieStarSchedule) {
			System.out.println("MovieTimeListServ - vo : " + vo);
		}
	}
}
