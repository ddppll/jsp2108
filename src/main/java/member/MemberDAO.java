package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conn.GetConn;

public class MemberDAO {
	GetConn getConn = GetConn.getInstance(); //클래스를 불러와서
	
	private Connection conn = getConn.getConn(); //getConn.으로 getConn 컨넥션 객체를 불러옴
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	MemberVO vo = null;

	//아이디 중복체크
	public String idCheck(String mid) {
		String name = "";
		try {
			sql = "select * from member where mid =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			if(rs.next()) name = rs.getString("name");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}

	//닉네임 중복체크
	public String nickCheck(String nickName) {
		String name = "";
		try {
			sql = "select * from member where nickName =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			if(rs.next()) name = rs.getString("name");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return name;
	}

	// 해시테이블에서 pwdKey에 해당하는 pwdValue을 찾아서 리턴
	public long getHashTableSearch(int pwdKey) {
		long pwdValue = 0;
		try {
			sql = "select*from hashTable where pwdKey = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pwdKey);
			rs = pstmt.executeQuery();
			rs.next();
			pwdValue = rs.getLong("pwdValue");
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return pwdValue;
	}

	// 회원 가입 처리
	public int setMemberJoinOk(MemberVO vo) {
		int res = 0;
		try {
			sql = "insert into member values (default,?,?,?,?,?,?,?,?,?,?,?,?,?,default,?,?,default,default,default,default,default,default,default)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setInt(3, vo.getPwdKey());
			pstmt.setString(4, vo.getNickName());
			pstmt.setString(5, vo.getName());
			pstmt.setString(6, vo.getGender());
			pstmt.setString(7, vo.getBirthday());
			pstmt.setString(8, vo.getTel());
			pstmt.setString(9, vo.getAddress());
			pstmt.setString(10, vo.getEmail());
			pstmt.setString(11, vo.getHomePage());
			pstmt.setString(12, vo.getJob());
			pstmt.setString(13, vo.getHobby());
			pstmt.setString(14, vo.getContent());
			pstmt.setString(15, vo.getUserInfor());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 로그인 체크(아이디가 동일한 자료가 있으면 해당 자료를 vo에 담아서 넘긴다)
	public MemberVO loginCheck(String mid) {
		vo = new MemberVO();
		try {
			sql = "select * from member where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo.setMid(mid);
				vo.setPwd(rs.getString("pwd"));
				vo.setPwdKey(rs.getInt("pwdKey"));
				vo.setNickName(rs.getString("nickName"));
				vo.setLevel(rs.getInt("level"));
				vo.setLastDate(rs.getString("lastDate"));
				vo.setPoint(rs.getInt("point"));
			}
			else {
				vo = null;
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 마지막 접속 시간 - 로그인하는 순간을 마지막접속시간으로
	public void setLastDateUpdate(String mid) {
		try {
			sql="update member set lastDate = now(), point = point+10, visitCnt = visitCnt+1 where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		
	}
}
