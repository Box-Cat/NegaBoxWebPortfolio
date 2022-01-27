package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.MainVO;

public class ReviewDao {
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	//관람평 합평균 점수 메서드
	public ArrayList<Float> avgScore(ArrayList<MainVO> listMain){
		ArrayList<Float> reviewCount = new ArrayList<Float>();
		String sql = "SELECT round(sum(score)/count(*) ,1) AS score FROM review WHERE movie_code = ?";
			try {
				pstmt = conn.prepareStatement(sql);
				for(MainVO vo : listMain) {
					pstmt.setString(1, vo.getMovieCode());
					rs = pstmt.executeQuery();
					while(rs.next()) {
						reviewCount.add(rs.getFloat("score"));
						System.out.println(vo.getMovieCode() + " 관람평 점수  : " + rs.getFloat("score"));
					}
				} 
			}catch (Exception e) {
				e.printStackTrace();
			}
		
		return reviewCount;
	}
	
}
