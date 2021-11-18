package admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conn.GetConn;
import member.MemberVO;

public class AdminDAO {
	GetConn getConn = GetConn.getInstance(); //클래스를 불러와서
	
	private Connection conn = getConn.getConn(); //getConn.으로 getConn 컨넥션 객체를 불러옴
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	MemberVO vo = null;

	

	// 회원 등급 변경 처리
	public void setMemberLevelChange(int idx, int level) {
		try {
			sql="update member set level = ? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, level);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}
}
