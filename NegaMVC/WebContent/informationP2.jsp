<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import = "java.util.*" %>   
<%@ page import = "java.sql.Date" %> 
<%@ page import="dto.*" %>
<%@ page import="actions.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("UTF-8"); 
%>

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
		String birth = request.getParameter("birth");
		String name = request.getParameter("name");

		Date birth2 = Date.valueOf(birth);

		String id = request.getParameter("id");
		String pw = request.getParameter("password");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		
		String sql = "INSERT INTO membervo(member_id, pw, email, phone, birthday, name, administrator) values (?,?,?,?,?,?,0)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, email);
		pstmt.setString(4, phone);
		pstmt.setDate(5, birth2);
		pstmt.setString(6, name);
	
		
		
		int r = pstmt.executeUpdate(); 
		if(r==1) {
%>
			<script>
			location.href = "Controller?command=main";
			</script>
<%
		}
		
		conn.close();
%>
</body>
</html>