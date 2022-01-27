package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import dto.HeartsVO;

public class HeaartCalcDao {
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	//rs.next() == true
	public HeartsVO deleteHeart(int heart, String loginId, String movieCode, boolean heartTrueFalse, HeartsVO resultHeartVO){
		String sql = "delete from want_to_watch where member_id = ? and movie_code = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginId);
			pstmt.setString(2, movieCode);
			pstmt.executeUpdate();
			heartTrueFalse = false;
			heart -= 1;
			resultHeartVO = new HeartsVO(heart, heartTrueFalse);
			System.out.println("deleteHeart로 제거완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultHeartVO;
	}

	//rs.next() == false
	public HeartsVO insertHeart(int heart, String loginId, String movieCode, boolean heartTrueFalse, HeartsVO resultHeartVO){
		
		String sql = "insert into want_to_watch(member_id,movie_code) values(?,?)";
	
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginId);
			pstmt.setString(2, movieCode);
			pstmt.executeUpdate();
			heart += 1;
			heartTrueFalse = true;
			resultHeartVO = new HeartsVO(heart, heartTrueFalse);
			System.out.println("insertHeart로 입력완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultHeartVO;
	}

	public HeartsVO showHeart(int heart, String loginId, String movieCode, boolean heartTrueFalse, HeartsVO resultHeartVO){
		System.out.println("showHeart로 들어옴");
		String sql = "select * from want_to_watch where member_id = ? and movie_code = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginId);
			pstmt.setString(2, movieCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				resultHeartVO = deleteHeart(heart, loginId, movieCode, heartTrueFalse, resultHeartVO);
			}else {
				resultHeartVO = insertHeart(heart, loginId, movieCode, heartTrueFalse, resultHeartVO);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultHeartVO;
	}
	
}
