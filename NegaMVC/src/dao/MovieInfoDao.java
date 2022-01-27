package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import dto.ChartVO;
import dto.MovieVO;
import dto.ReviewVO;
import javafx.scene.chart.Chart;

public class MovieInfoDao {
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public ArrayList<ReviewVO> showReviews (ArrayList<ReviewVO> listReview, String mName, Date today, ArrayList<Float> listCorr) { //format 없어도 될 듯.
		String sql ="select * from review where movie_code = ? order by write_date desc";
		
		PreparedStatement pstmt;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mName);   // "#특송'
			ResultSet rs = pstmt.executeQuery();
			
			float scoreaver = 0;
			while(rs.next()) {
				String memberId = rs.getString("member_id");
				int score = rs.getInt("score");
				String reviewText = rs.getString("review_text");
				String viewingPoints = rs.getString("viewing_points");
				int report = rs.getInt("report");
				String movieCode = rs.getString("movie_code");
				Date writeDate = rs.getTimestamp("write_date");
//				System.out.println("***************************************");
				
//				System.out.println("date2222222 : " + writeDate);
//				System.out.println(writeDate.getTime());
				
				scoreaver += score;
				listReview.add(new ReviewVO(memberId,score,reviewText,viewingPoints,report,movieCode,writeDate));
			}
//			System.out.println("date2 : " + today.getTime());
			System.out.println("관람평 합계 : " + scoreaver);
			float cor = scoreaver / listReview.size();
			
			float corr = (float)(Math.round(cor*10)/10.0);
			if(Double.isNaN(corr)) {
				corr = 0;
			}
//			System.out.println("관람평 평균(corr) : " + corr);
			listCorr.add(corr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listReview;
		
	}
	
	//Action필드에 있는 변수들을 채워서, 다음에 오는 매서드들이 활용하도록 함.
	public MovieVO showMovieInfo(String movieCode, String movieName, String openingDay, int runningTime, String director, String rating, 
			String casting, String moviePhoto, String plot,  String allType ,String tag, String engName, String trailer, String trailerSub,
			String stealcut, String genre, String miniTitle, int dolby) {
			String sql = "select * from movie where movie_code = ? ";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movieCode);   // "#특송"   // mName); 
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				movieName = rs.getString("movie_name");
				openingDay = rs.getString("opening_day");
				runningTime = rs.getInt("running_time");
				director = rs.getString("director");
				rating = rs.getString("rating");
				casting = rs.getString("casting");
				moviePhoto = rs.getString("movie_photo");
				plot = rs.getString("plot");
				allType = rs.getString("alltype");
				tag = rs.getString("tag");
				engName = rs.getString("eng_name");
				trailer = rs.getString("trailer");
				trailerSub = rs.getString("trailer_sub");
				stealcut = rs.getString("stealcut");
				genre = rs.getString("genre");
				miniTitle = rs.getString("mini_title");
				dolby = rs.getInt("dolby");
//				System.out.println("showMovieInfo()결과 : "+movieName+"/"+openingDay+"/"+runningTime+"/"+director+"/"+rating+"/"+casting+"/"+moviePhoto+"/"+plot+"/"+allType+"/"+tag+"/"+engName+"/"+trailer+"/"+trailerSub+"/"+stealcut+"/"+genre+"/"+miniTitle+"/"+dolby);
//				System.out.println("-----------------------------------showMovieInfo()출력완료-----------------------------------------");
		
				MovieVO vo = new MovieVO(movieCode, movieName, openingDay, runningTime, director, rating, casting, moviePhoto, plot, allType, tag, engName, trailer, trailerSub, stealcut, genre, miniTitle, dolby);
				return vo;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	
	public String countReview(String mName, String reviewCount){
		String sql = "select count(*) from review where movie_code = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mName); 
			rs = pstmt.executeQuery();
			if(rs.next());
			reviewCount = rs.getString("count(*)");
//			System.out.println("reviewCount : " + reviewCount);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reviewCount;
	}
	
	
	public ChartVO reviewCalc (String mName, int chartStory, int chartProduction, int chartOst, int chartVisual, int chartActor, String chartPit1, String chartPit2){
		String sql = "select count(*) story, "
			+ "(select count(*) from review where viewing_points like '%연출%' GROUP by movie_code HAVING movie_code = ?) production, "
			+ "(select count(*) from review where viewing_points like '%OST%' GROUP by movie_code HAVING movie_code = ?) ost, "
			+ "(select count(*) from review where viewing_points like '%영상미%' GROUP by movie_code HAVING movie_code = ?) visual, "
			+ "(select count(*) from review where viewing_points like '%배우%' GROUP by movie_code HAVING movie_code = ?) actor "
			+ "from review where viewing_points like '%스토리%' GROUP by movie_code HAVING movie_code = ?";
			
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mName);
			pstmt.setString(2, mName);
			pstmt.setString(3, mName);
			pstmt.setString(4, mName);
			pstmt.setString(5, mName);
			
			rs = pstmt.executeQuery();
			
			/*
			int chartStory = 0;
			int chartProduction = 0;
			int chartOst = 0;
			int chartVisual = 0;
			int chartActor = 0;
			String chartPit1 = "";
			String chartPit2 = "";
			*/
			if(rs.next()) {
				
				chartStory = rs.getInt("story");
				chartProduction = rs.getInt("production");
				chartOst = rs.getInt("ost");
				chartVisual = rs.getInt("visual");
				chartActor = rs.getInt("actor");
				
				int[] chartResult = {chartStory,chartProduction,chartOst,chartVisual,chartActor };
				
				int max1 = 0;
				int max2 = 0;
				for(int i =0; i < chartResult.length; i++) {
					if(chartResult[i] > max1) {
						max2 = max1;
						max1 = chartResult[i];
					} else if (chartResult[i] > max2) {
						max2 = chartResult[i];
					}
				}
				chartPit1 = "";
				chartPit2 = "";
				if(chartStory == max1) {
					chartPit1 = "스토리";
				}
				if(chartProduction == max1) {
					chartPit1 = "연출";
				}
				if(chartOst == max1) {
					chartPit1 = "OST";
				}
				if(chartVisual == max1) {
					chartPit1 = "영상미";
				}
				if(chartActor == max1) {
					chartPit1 = "배우";
				}
				
				
				if(chartStory == max2) {
					chartPit2 = "스토리";
				}
				if(chartProduction == max2) {
					chartPit2 = "연출";
				}
				if(chartOst == max2) {
					chartPit2 = "OST";
				}
				if(chartVisual == max2) {
					chartPit2 = "영상미";
				}
				if(chartActor == max2) {
					chartPit2 = "배우";
				}
				
//				System.out.println("가장높은 카운트 수 :" + chartPit1);
//				System.out.println("두번째 높은 카운트 수 : " + chartPit2);
			} else {
				System.out.println("에러임!!");
				chartPit1 = "";
				chartPit2 = "";
			}
			//conn.close();
				
			ChartVO vo = new ChartVO(chartStory,chartProduction,chartOst,chartVisual,chartActor,chartPit1,chartPit2);
			return vo;
			//chartPit1,chartPit2,attendance,cntApiDay를 모두 담아줄 값이 필요함!!!!!!!!!!!!!!!!
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//ajax Dao
	public void writeReview(String loginId, int starscore, String textarea, String pit, String movieCode){
		String sql ="INSERT INTO review(member_id,score,review_text,viewing_points,movie_code) VALUES(?,?,?,?,?)";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, loginId);
			pstmt.setInt(2, starscore);
			pstmt.setString(3, textarea);
			pstmt.setString(4, pit);
			pstmt.setString(5, movieCode);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	//중간삽입 Dao
	
}
