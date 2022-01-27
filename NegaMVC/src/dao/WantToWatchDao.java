package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import dto.MainVO;

public class WantToWatchDao {
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//영화당 좋아요 개수 세기
	public ArrayList<Integer> countLike(ArrayList<MainVO> listMain) {
		String sql = "select count(*) from want_to_watch where movie_code = ?";
		ArrayList<Integer> heartCount = new ArrayList<Integer>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			for(MainVO vo : listMain) {
				pstmt.setString(1, vo.getMovieCode());
				rs = pstmt.executeQuery();
				rs.next();
				heartCount.add(rs.getInt("count(*)")); // 좋아요 카운트 영화 순서별.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return heartCount;
	}
	
	//해당 회원의 좋아요 개수 세기
	public HashMap<String, Integer> countLikeMember(ArrayList<MainVO> listMain, String loginId) {
		String sql	= "select count(*) from want_to_watch where member_id = ? and movie_code = ?";
		HashMap<String, Integer> hmapMovieCodeLike = new HashMap<String, Integer>();
		for(MainVO vo : listMain) {
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,loginId); //session 불러와야 함. 파라미터로 session 받기
				pstmt.setString(2,vo.getMovieCode());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					hmapMovieCodeLike.put(vo.getMovieCode(), rs.getInt(1));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return hmapMovieCodeLike;
	}
}
