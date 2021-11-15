package conn;
//DB연동하는 클래스

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetConn {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String driver = "com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/javacourse";
	private String user = "root";
	private String password = "1234";
	
	private GetConn() { //싱글톤으로 만들어서 외부에서 접근 못하게 하기 위해 private으로 만듦
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패");
		} catch (SQLException e) {
			System.out.println("DB연동 실패");
		}
	}
	//메소드 영역에 static으로 올려줌
	private static GetConn instance = new GetConn();
	//게터생성, 이 게터를 부르면 instance를 가져옴
	public static GetConn getInstance() {
		return instance;
	}
	
	public Connection getConn() {
		return conn;
	}
	
	public void rsClose() {
		if(rs!=null) {
			try {
				rs.close();
				pstmtClose();
			} catch (Exception e) {}
		}
	}

	public void pstmtClose() {
		if(pstmt!=null) {
			try {
				pstmt.close();
			} catch (Exception e) {}
		}
	}
}
