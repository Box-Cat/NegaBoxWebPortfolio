package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Set;

import dto.AColsVO;
import dto.ExitDoorVO;
import dto.MovieEndTime;


//2)JSP의, 중간삽입을 위로 올리기
//3)중간삽입을 Dao의 메서드로 정리


public class QuickSeatsRevDao {
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public ArrayList<String> showSeats(String showroom, ArrayList<String> listSeatArrInfo ) {
		String sql = "select seat_cols FROM seat_arr_info WHERE showroom = ? "; 
		PreparedStatement pstmt;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,showroom);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				String seatCols = rs.getString("seat_cols");
				String vo = new String(seatCols);
				listSeatArrInfo.add(vo);	
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return listSeatArrInfo;	 
	}
	
	public AColsVO showAIndex (String showroom, AColsVO aColsVO) {
		String sql2 = "SELECT A_LEFT, A_TOP FROM theater_showroom WHERE theater_showroom_code =?"; 
		try {
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1,showroom);
			rs = pstmt.executeQuery();
			rs.next();
			int aLeft = rs.getInt("A_LEFT");
			int aTop = rs.getInt("A_TOP");
			aColsVO = new AColsVO(aLeft,aTop);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return aColsVO;	 
	}
	
	public ArrayList<ExitDoorVO> showExit(String showroom, ArrayList<ExitDoorVO> listExitDoorVO){
		String sql3 = "SELECT direction, x_left, y_top FROM exit_door WHERE showroom_code=?";
		try {
			pstmt = conn.prepareStatement(sql3);
			pstmt.setString(1,showroom);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				String direction = rs.getString("DIRECTION");
				String xLeft = rs.getString("X_LEFT");
				String yTop = rs.getString("Y_TOP");
				ExitDoorVO vo = new ExitDoorVO(direction, xLeft, yTop);
				listExitDoorVO.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listExitDoorVO;
		
	}
	
	
	public ArrayList<String> showPoster(String movie_name,ArrayList<String> moviePosterJpgs){
		String sql4 = "SELECT movie_photo FROM movie WHERE movie_name like ?";
		try {
			pstmt = conn.prepareStatement(sql4);
			pstmt.setString(1,movie_name);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				String moviePhoto = rs.getString("MOVIE_PHOTO");
				moviePosterJpgs.add(moviePhoto);
			}
			for(String check2 : moviePosterJpgs){
				System.out.println("moviePosterJpgs : "+ check2);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("showPoster()완료");
		return moviePosterJpgs;
	}
	
	public ArrayList<MovieEndTime> showStartEndTime(String selectedDate, String tmp_theater_name, String movie_name, String strToday, String strFullHour,ArrayList<MovieEndTime> movieEndTimeList ){
		String sql5 = "SELECT si.time, m.running_time "
			    +" FROM screen_info si, movie m "
				+" WHERE si.movie_code = m.movie_code "
				+" and si.day = '"+selectedDate+"' "
				+" and si.theater_id='"+tmp_theater_name+"' "
				+" and m.movie_name like '%"+movie_name+"%'"
				+ ( strToday.equals(selectedDate) ? " and si.time >= '"+strFullHour+"'" : "") 
				+" order by time asc";
		 	    
		try {
			pstmt = conn.prepareStatement(sql5);
			rs= pstmt.executeQuery();
			
			while(rs.next()){ 
				String movieTime = rs.getString("time");
				int runningTime = rs.getInt("running_time");
				int timeH = Integer.parseInt(movieTime.split(":")[0]);
				int timeM = Integer.parseInt(movieTime.split(":")[1]);	
				timeM += runningTime+10;
				timeH += timeM/60;
				timeM = timeM%60;
				String endTime = (timeH < 10 ? "0" : "") + timeH + ":" + (timeM < 10 ? "0" : "") + timeM;
				MovieEndTime vo = new MovieEndTime(movieTime, runningTime, endTime);
				movieEndTimeList.add(vo);  	
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("showStartEndTime()완료");
		return movieEndTimeList;
	}	
	
	public Set<String> showRevSeats(String selectedDate, String start_time_HM, String showroom, Set<String> hsetReserved) {
		String sql = "select r.seat from reservation r, screen_info si where r.screen_info_code = si.movie_info_code"
				+ " and si.day=?"        // '22/01/06'
				+ " and si.time=?"		 // '09:10'
				+ " and si.theater_showroom=?";  // 'GANGNAM1'
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, selectedDate);
				pstmt.setString(2, start_time_HM);
				pstmt.setString(3, showroom);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					String seat = rs.getString(1);
					hsetReserved.add(seat);
				}
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			System.out.println("showRevSeats()완료");
			return hsetReserved;
	}
	
	//중간삽입 Dao
	public ArrayList<String> printSeats (ArrayList<String> listPrintStr,  ArrayList<String> listSeatArrInfo, int aTop, int aLeft, Set<String> hsetReserved) {
		
		listPrintStr.add("<div style='position:relative;'>");
		String[] arrSeats = new String[listSeatArrInfo.size()];
		int size = 0;							
		for(String temp : listSeatArrInfo ){
			arrSeats[size++] = temp; // 오류. java.lang.ArrayIndexOutOfBoundsException: 0
		}	

		for(int i=0; i<arrSeats.length; i++) {
			
			int alphabetLeft = 107; 
			int alphabetTop = 20*i + 11; 
			listPrintStr.add("<div col=" + (char)('A'+i) + ">");
			listPrintStr.add("<button type='button' class='btn-seat-row' style='position:absolute; top:"+(aTop+20*i)+"px; left:"+(aLeft)+"px;'>"+(char)('A'+i)+"</button>");
					
			String[] arrRowSeats = arrSeats[i].split(",");
			int left = aLeft + 48; // 219;   // 20씩 증가.
			
			for(int j=0; j<=arrRowSeats.length-1; j++) {
				String strHandi = arrRowSeats[j].startsWith("h") ? "handicap" : "";
				String strCorona = arrRowSeats[j].startsWith("x") ? "corona" : "";
				if(strHandi.equals("handicap")) {
					arrRowSeats[j] = arrRowSeats[j].substring(1);
				}
				if(strCorona.equals("corona")){
					arrRowSeats[j] = " ";
				}
				String seatNumber = ((char)('A'+i)) + "" + arrRowSeats[j]; 
				if(hsetReserved.contains(seatNumber)) {
					listPrintStr.add("<button type='button' class='btn-seat reserved' style='position:absolute; left:" + (left) + "px; top:" + (aTop+20*i) + "px; '>");
					listPrintStr.add("<span class='num'></span>");
					listPrintStr.add("</button>");
		
				} else if(!arrRowSeats[j].equals("") && !arrRowSeats[j].equals("n")) { //질문. n이 뜻이지?/
					/* System.out.println("공석아님 : ." + arrRowSeats[j] + "."); */
					listPrintStr.add("<button type='button' class='btn-seat "+strHandi + " " + strCorona + "' style='position:absolute; left:" + left + "px; top:" + (aTop+20*i) + "px;'>");
					listPrintStr.add("<span class='num'>" + arrRowSeats[j] + "</span>");
					listPrintStr.add("</button>");
			
				} //여기까지, (옆으로 20px씩 이동하면서) 1줄을 설치
				left += 20;
			}
			listPrintStr.add("</div>");
		}
		System.out.println("printSeats ()완료");
		return listPrintStr;
	}
	
	//ajax Dao
	public void insertRevSeats(int[] arrPrice , String[] arrSeats2, String[] arrAges, String paramloginId, String paramScreenInfoCode) {
		for(int i=0; i<=arrSeats2.length-1; i++) {
			int paramPrice = arrPrice[i];
			try {
				String sql = "insert into reservation(seat, price, age, member_id, screen_info_code)"
							+ " values (?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, arrSeats2[i]);
				pstmt.setInt(2, paramPrice);
				pstmt.setString(3, arrAges[i]);
				pstmt.setString(4, paramloginId);
				pstmt.setString(5, paramScreenInfoCode);
				int ret = pstmt.executeUpdate();
				if(ret==0) {
					System.out.println("경고! 중복된 좌석예약 시도. 무언가 이상해~~~");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
	
	
}
