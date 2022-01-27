package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONObject;

public class EmailDao {
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public String checkEmailNumber (String to, String ret){
		String sql = "select svalue from svalue where email = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				ret = rs.getString("svalue");
				System.out.println("ret :" + ret);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	
	public void deleteUsedEmailNumber(String to) {
		String sql = "DELETE FROM svalue WHERE email=?";
		PreparedStatement pstmt;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void insertEmailNumber(String to, String sValue) {
		String sql = "INSERT INTO svalue(email, svalue) VALUES (?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, to);
			pstmt.setString(2, sValue);
			pstmt.executeUpdate();
			
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
}
