<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import = "java.util.*" %>    
<%@ page import="dto.*" %>
<%@ page import="actions.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("UTF-8"); 
%>
<!--위의 구문을 빼먹으면, sql문에 한글이 깨진채로 입력된다.  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String db_id = "megabox";
		String db_pw = "user1234";
		
		Connection conn = null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, db_id, db_pw);
		} catch(Exception e) {   // ClassNotFoundException, SQLException
			e.printStackTrace();
		}
		
		String movie_code = request.getParameter("movie_code").trim();
		String movie_name = request.getParameter("movie_name").trim();
		String movie_photo = request.getParameter("movie_photo").trim();
		int dolby = Integer.parseInt(request.getParameter("dolby").trim());
		int mx = Integer.parseInt(request.getParameter("mx").trim());

		String rating = request.getParameter("rating").trim();
		String opening_day = request.getParameter("opening_day").trim();
		String tag = request.getParameter("tag");
		String eng_name = request.getParameter("eng_name").trim();
		String mini_title = request.getParameter("mini_title").trim();
		
		String plot = request.getParameter("plot").trim();
		String alltype = request.getParameter("alltype").trim();
		String director = request.getParameter("director").trim();
		String genre = request.getParameter("genre").trim();
		int running_time = Integer.parseInt(request.getParameter("running_time").trim());
		
		String casting = request.getParameter("casting").trim();
		String trailer = request.getParameter("trailer").trim();
		String trailer_sub = request.getParameter("trailer_sub").trim();
		String stealcut = request.getParameter("stealcut").trim();

		
		String sql = "INSERT INTO" 
				+ " movie(movie_code, movie_name, movie_photo, dolby, mx, rating, opening_day, tag, eng_name, mini_title, plot, alltype, director, genre, running_time, casting, trailer, trailer_sub, stealcut)" 
				+ " VALUES(?,?,?,?,?,  ?,?,?,?,?, ?,?,?,?,?, ?,?,?,? )";
		/* sql문을 쓸 때, movie나 values 앞의 띄어쓰기를 절대 잊지 말자. 이걸 잊으면 오류가 계속해서 뜬다. */
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, movie_code );
		pstmt.setString(2, movie_name);
		pstmt.setString(3, movie_photo);
		pstmt.setInt(4, dolby);
		pstmt.setInt(5, mx);
		
		pstmt.setString(6, rating);
		pstmt.setString(7, opening_day);
		pstmt.setString(8, tag);
		pstmt.setString(9, eng_name);
		pstmt.setString(10, mini_title);
		
		pstmt.setString(11, plot);
		pstmt.setString(12, alltype);
		pstmt.setString(13, director);
		pstmt.setString(14, genre);
		pstmt.setInt(15, running_time);
		
		pstmt.setString(16, casting);
		pstmt.setString(17, trailer);
		pstmt.setString(18, trailer_sub);
		pstmt.setString(19, stealcut);
		int r = pstmt.executeUpdate();   // 리턴값 : 영향 받은 행의 개수.
		
		if(r==1) {
	%>
			<h1>영화테이블 입력을 성공적으로 마쳤습니다. </h1>
			<a href="admin-movieP2.jsp"></a>
	<%
		}
		
		conn.close();
	%>


</body>
</html>