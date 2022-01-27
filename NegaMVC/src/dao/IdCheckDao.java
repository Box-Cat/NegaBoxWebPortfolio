package dao;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.simple.JSONObject;

public class IdCheckDao {
	Connection conn = DBConnection.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	
	public int idCheck(String userID, int idcheck){
		String sql = "select count(*) from membervo where member_id = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				idcheck = rs.getInt(1);
				System.out.println("idcheck :" + idcheck);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return idcheck;
	}
	
	
}
