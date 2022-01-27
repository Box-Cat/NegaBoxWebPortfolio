package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RegisterDao {
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	public int insertMember(String id, String pw, String email, String phone, Date birth2, String name, int ret) {
		String sql = "INSERT INTO membervo(member_id, pw, email, phone, birthday, name, administrator) values (?,?,?,?,?,?,0)";
		
		PreparedStatement pstmt;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, email);
			pstmt.setString(4, phone);
			pstmt.setDate(5, birth2);
			pstmt.setString(6, name);
			
			int r = pstmt.executeUpdate(); 
			if(r==1) {
				ret = 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return ret;
		
	}	
	
}
