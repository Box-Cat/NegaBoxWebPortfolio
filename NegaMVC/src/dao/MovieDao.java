package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.ApiVO;
import dto.MainVO;

public class MovieDao {
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public ArrayList<MainVO> showApiMovieList(ApiVO apiVO ){ //listMain으롭 리턴. sql2부터 listMainVO타입의 파리미터 추가(리턴과 파라미터로 연결). 또 다시 MainVO로 리턴하면 또 활용가능
		ArrayList<MainVO> listMain = new ArrayList<MainVO>();
		String sql = "select movie_photo, dolby, mx, movie_code, plot, movie_name from movie where movie_name = ?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, apiVO.getMovieNm());
				rs = pstmt.executeQuery();
				while(rs.next()) {
					String movieCode = rs.getString("movie_code");
					String moviePhoto = rs.getString("movie_photo");
					String plot = rs.getString("plot");
					int dolby = rs.getInt("dolby");
					int mx = rs.getInt("mx");
					String movieName = rs.getString("movie_name");
					listMain.add(new MainVO(movieCode, moviePhoto, plot, dolby, mx, movieName));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return listMain;
	}
	
	
	
}
