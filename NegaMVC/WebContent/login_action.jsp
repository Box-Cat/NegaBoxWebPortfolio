<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="actions.*" %>
<%@ page import="dao.*" %>


<%
	//Dao와 Action 둘로 나누자.

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userId = "megabox";
	String userPw = "user1234";
	
	Connection conn = null;
	
	try {
		Class.forName(driver);
		conn = DriverManager.getConnection(url, userId, userPw);
	} catch(Exception e) {   
		e.printStackTrace();
	} 
	
	String id = request.getParameter("id"); //servlet에서 값을 받아오도록
	String pw = request.getParameter("pw"); //servlet에서 값을 받아오도록
	
	String sql= "SELECT count(*), name FROM MEMBERVO WHERE member_id = ? AND pw = ? group by name";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	pstmt.setString(1, id);
	pstmt.setString(2, pw);
	String name = "";
	ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			name = rs.getString("name");
			session.setAttribute("member_id", id);
			session.setAttribute("name", name);
		%>
			<script>
			    location.href = "main_page.jsp";
			</script>
		<%
		} else {
		%>
			<script>
				alert("아이디 또는 비밀번호가 맞지 않습니다. "
						+ "로그인 정보를 다시 확인바랍니다.");
				location.href = "main_page.jsp";
			</script>
		<%
		}
	
%>
