package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	// getConnection() : DB접속 후 '접속정보'와 관련된 Connection객체의 참조값을 리턴.
	public static Connection getConnection() {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "megabox";
		String dbPw = "user1234";
		
		Connection conn = null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbId, dbPw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
}









