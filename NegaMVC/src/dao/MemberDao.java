package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.MemberVO;

public class MemberDao {
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	public boolean loginCheck(MemberVO memberVO) {
		
		String sql= "SELECT count(*), name FROM MEMBERVO WHERE member_id = ? AND pw = ? group by name";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberVO.getMemberId()); //session
			pstmt.setString(2, memberVO.getPw()); //session
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				int cnt = rs.getInt(1);
				if(cnt==1) return true;
				else return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	
	public String showName(MemberVO memberVO) {
		String sql = "select name from membervo where member_id = ?";
		String name = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberVO.getMemberId()); //session
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				name = rs.getString("name");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return name;
		
	}
}
