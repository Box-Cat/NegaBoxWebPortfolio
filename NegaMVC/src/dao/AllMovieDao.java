package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import dto.ApiVO;
import dto.MovieAll;

public class AllMovieDao {
	static Connection conn = null; //DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public AllMovieDao() {
		if(conn==null)
			conn = DBConnection.getConnection();
	}
	
	public ArrayList<MovieAll> showLists(ArrayList<MovieAll> list, ArrayList<ApiVO> apiList){
		String sql ="select movie_photo, dolby, mx, movie_code, plot, opening_day, rating, movie_name FROM movie where movie_name = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			String moviePhoto = "";
			int dolby = 0;
			int mx = 0;
			String plot = "";
			String movieCode = "";
			String movieName = "";
			String rating = "";
			
			for(ApiVO vo : apiList) {
				pstmt.setString(1, vo.getMovieNm());
				rs = pstmt.executeQuery();
			
				rs.next();
					moviePhoto = rs.getString("movie_photo");
					dolby = rs.getInt("dolby");
					mx = rs.getInt("mx");
					plot = rs.getString("plot");
					movieCode = rs.getString("movie_code");
					movieName = rs.getString("movie_name");
					rating = rs.getString("rating");
					Date openingDay = rs.getTimestamp("opening_day");
					list.add(new MovieAll(movieCode,movieName,openingDay,rating,moviePhoto,plot,dolby,mx));
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public ArrayList<Integer> countLike (ArrayList<Integer> countList, ArrayList<MovieAll> list){
		String sql = "select count(*) from want_to_watch where movie_code = ?";
		int cot = 0;
			try {
				pstmt = conn.prepareStatement(sql);
				for(MovieAll vo : list) {
					pstmt.setString(1, vo.getMovieCode()); // cot 1 -> 4;
					rs = pstmt.executeQuery();
					rs.next();
					countList.add(rs.getInt("count(*)"));
				}	
			} catch (Exception e) {
				e.printStackTrace();
			} 
			return countList; 
	}

	public int movieCount (){
		String sql = "select count(*) from movie";
		int movieCount = 0;
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			movieCount = rs.getInt("count(*)");
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return movieCount;
	}
	
	public ArrayList<MovieAll> showNotLists(ArrayList<ApiVO> apiList, ArrayList<MovieAll> notlist) {
		String sql = "select movie_photo, dolby, mx, movie_code, plot, opening_day, rating, movie_name from movie where movie_name not in (?,?,?,?,?,?,?,?,?,?)"; //10개
		try {
			pstmt = conn.prepareStatement(sql);
			int j = 1;
			for(ApiVO vo : apiList) {
				pstmt.setString(j, vo.getMovieNm());
				j++;
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String moviePhoto = rs.getString("movie_photo");
				int dolby = rs.getInt("dolby");
				int mx = rs.getInt("mx");
				String movieCode = rs.getString("movie_code");
				String plot = rs.getString("plot");
				Date openingDay = rs.getTimestamp("opening_day");
				String rating = rs.getString("rating");
				String movieName = rs.getString("movie_name");
				notlist.add(new MovieAll(movieCode,movieName,openingDay,rating,moviePhoto,plot,dolby,mx));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return notlist;
	}
	
	public ArrayList<Integer> countLikeNot(ArrayList<Integer> countListNot, ArrayList<MovieAll> notlist){
		String sql = "select count(*) from want_to_watch where movie_code = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			for(MovieAll vo : notlist) {
				pstmt.setString(1, vo.getMovieCode());
				rs = pstmt.executeQuery();
				rs.next();
				countListNot.add(rs.getInt("count(*)"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return countListNot;
	}
	
	public ArrayList<Float> reviewCount(ArrayList<Float> reviewCount, ArrayList<MovieAll> list) {
		String sql = "select round(sum(score)/count(*) ,1) score from review where movie_code = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			for(MovieAll vo : list) {
				pstmt.setString(1, vo.getMovieCode());
				rs = pstmt.executeQuery();
				rs.next();
				reviewCount.add(rs.getFloat("score"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return reviewCount;
	}
	
	public ArrayList<Float> reviewCountNot(ArrayList<Float> reviewCountNot, ArrayList<MovieAll> notlist) {
			String sql = "select round(sum(score)/count(*) ,1) score from review where movie_code = ?";
			try {
				pstmt = conn.prepareStatement(sql);
				for(MovieAll vo : notlist) {
				pstmt.setString(1, vo.getMovieCode());
				rs = pstmt.executeQuery();
				rs.next();
				reviewCountNot.add(rs.getFloat("score"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		return reviewCountNot;
	}
	
	public void countMemberLike(String loginId, HashMap<String, Integer> hmapMovieCodeLike, HashMap<String, Integer> hmapMovieCodeLike2, ArrayList<MovieAll> list, ArrayList<MovieAll> notlist){
		String sql	= "select count(*) from want_to_watch where member_id = ? and movie_code = ?";
		//HashMap<String, Integer> hmapMovieCodeLike = new HashMap<String, Integer>();
		//HashMap<String, Integer> hmapMovieCodeLike2 = new HashMap<String, Integer>();
		for(MovieAll vo : list) {
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,loginId);
				pstmt.setString(2,vo.getMovieCode());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					hmapMovieCodeLike.put(vo.getMovieCode(), rs.getInt(1));
				}
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		for(MovieAll vo : notlist) {
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,loginId);
				pstmt.setString(2,vo.getMovieCode());
				rs = pstmt.executeQuery();
				if(rs.next()) {
					hmapMovieCodeLike2.put(vo.getMovieCode(), rs.getInt(1));
				}
				rs.close();
				pstmt.close();
				//conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	/*
	public void removeHeart(int heart, String loginId, String movieCode) {
		heart -= 1;
		String sql = "delete from want_to_watch where member_id = ? and movie_code = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, loginId);
		pstmt.setString(2, movieCode);
		pstmt.executeUpdate();
		obj.put("like", false); //질문
		obj.put("likeHeart", heart);
		out.print(obj);
	}
	
	public void addHeart(int heart, String loginId, String movieCode) {
		heart += 1;
		String sql = "insert into want_to_watch(member_id,movie_code) values(?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, loginId);
		pstmt.setString(2, movieCode);
		pstmt.executeUpdate();
		obj.put("like", true);
		obj.put("likeHeart", heart);
		out.print(obj);
	}

	public (String loginId, String movieCode){
		String sql = "select * from want_to_watch where member_id = ? and movie_code = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, loginId);
		pstmt.setString(2, movieCode);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			removeHeart();
		}else {
			addHeart();
		}
	}
	*/
	
	
}
