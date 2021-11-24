package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.GetConn;
import conn.TimeDiff;

public class BoardDAO {
	GetConn getConn = GetConn.getInstance();
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	BoardVO vo = null;

	// 게시글 전체보기
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize) {
		List<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			sql = "select * from board order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setHomePage(rs.getString("homePage"));
				vo.setContent(rs.getString("content"));
				
				// 날짜를 24시간제로 체크하기 위해 사용자정의메소드로 만든 timeDiff()를 사용한다
				vo.setwDate(rs.getString("wDate")); // 만약 wDate가 날짜타입일 경우
				vo.setwCdate(rs.getString("wDate"));// 날짜타입 wDate를 문자타입 wCdate로 저장 후 
				TimeDiff timeDiff = new TimeDiff(); 
				int res = timeDiff.timeDiff(vo.getwCdate()); 	// 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내서 오늘시간과 계산해서 시간차 리턴받기
				vo.setwNdate(res); 	//시간차를 숫자형식변수에 저장
				
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setGood(rs.getInt("good"));
				vo.setMid(rs.getString("mid"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	public int setBoInput(BoardVO vo) {
		int res = 0;
		try {
			sql = "insert into board values (default,?,?,?,?,?,default,default,?,default,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNickName());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getHomePage());
			pstmt.setString(5, vo.getContent());
			pstmt.setString(6, vo.getHostIp());
			pstmt.setString(7, vo.getMid());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 게시글의 총 건수 구해오기
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	//게시글 내용 상세보기(idx로 가져오기)
	public BoardVO getBoardContent(int idx) {
		vo = new BoardVO();
		try {
			sql="select * from board where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setIdx(idx);
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setHomePage(rs.getString("homePage"));
				vo.setContent(rs.getString("content"));
				vo.setwDate(rs.getString("wDate")); 
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setGood(rs.getInt("good"));
				vo.setMid(rs.getString("mid"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 조회수 1 증가처리
	public void setReadNum(int idx) {
		try {
			sql="update board set readNum = readNum + 1 where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 게시글 삭제
	public int setBoardDelete(int idx) {
		int res = 0;
		try {
			sql="delete from board where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 좋아요 수 증가
	public void setGoodUpdate(int idx) {
		try {
			sql="update board set good = good + 1 where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 좋아요 증감
	public void setGoodUpdate2(int idx, int flag) {
		try {
			if(flag == 1) {
				sql = "update board set good = good + 1 where idx = ?";
	  	} else {
				sql = "update board set good = good - 1 where idx = ?";
		  }
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}
	
	//최근글 갯수 가져오기
	public int totRecCntLately(int lately) {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from board where date_sub(now(), interval ? day) < wDate";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lately);
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	//최근 게시글 보기
	public List<BoardVO> getBoardListLately(int startIndexNo, int pageSize, int lately) {
		List<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			sql = "select * from board where date_sub(now(), interval ? day) < wDate order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lately);
			pstmt.setInt(2, startIndexNo);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setHomePage(rs.getString("homePage"));
				vo.setContent(rs.getString("content"));
				
				// 날짜를 24시간제로 체크하기 위해 사용자정의메소드로 만든 timeDiff()를 사용한다
				vo.setwDate(rs.getString("wDate")); // 만약 wDate가 날짜타입일 경우
				vo.setwCdate(rs.getString("wDate"));// 날짜타입 wDate를 문자타입 wCdate로 저장 후 
				TimeDiff timeDiff = new TimeDiff(); 
				int res = timeDiff.timeDiff(vo.getwCdate()); 	// 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내서 오늘시간과 계산해서 시간차 리턴받기
				vo.setwNdate(res); 	//시간차를 숫자형식변수에 저장
				
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setGood(rs.getInt("good"));
				vo.setMid(rs.getString("mid"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 게시글 수정처리
	public int setBoUpdateOk(BoardVO vo) {
		int res = 0;
		try {
			sql="update board set title=?, email=?, homePage=?, content=?, hostIp=? where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getHomePage());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getHostIp());
			pstmt.setInt(6, vo.getIdx());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 이전&다음글 
	public BoardVO preNextSearch(String str, int idx) {
		vo = new BoardVO();
		try {
			if(str.equals("pre")) {
				sql="select * from board where idx < ? order by idx desc limit 1";
			}
			else {
				sql="select * from board where idx > ? limit 1";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			//이전글 있을 때
			if(str.equals("pre") && rs.next()) {
				vo.setPreIdx(rs.getInt("idx"));
				vo.setPreTitle(rs.getString("title"));
			}
			else if(str.equals("next") && rs.next()) {
				vo.setNextIdx(rs.getInt("idx"));
				vo.setNextTitle(rs.getString("title"));
			}
			else {
				vo.setPreIdx(0);
				vo.setNextIdx(0);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 검색창에 입력된 내용을 포함한 레코드 수 구하기
	public int totRecCnt(String search, String searchString) {
		int totRecCnt = 0;
		try {
			sql = "select count(*) from board where "+search+" like ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+searchString+"%");
			rs = pstmt.executeQuery();
			rs.next();
			totRecCnt = rs.getInt(1);
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	// 검색 처리 부분
	public List<BoardVO> getBoardSearch(String search, String searchString, int startIndexNo, int pageSize) {
		List<BoardVO> vos = new ArrayList<BoardVO>();
		try {
			sql = "select * from board where "+search+" like ? order by idx desc limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+searchString+"%");
			pstmt.setInt(2, startIndexNo);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setHomePage(rs.getString("homePage"));
				vo.setContent(rs.getString("content"));
				
				// 날짜를 24시간제로 체크하기 위해 사용자정의메소드로 만든 timeDiff()를 사용한다
				vo.setwDate(rs.getString("wDate")); // 만약 wDate가 날짜타입일 경우
				vo.setwCdate(rs.getString("wDate"));// 날짜타입 wDate를 문자타입 wCdate로 저장 후 
				TimeDiff timeDiff = new TimeDiff(); 
				int res = timeDiff.timeDiff(vo.getwCdate()); 	// 문자타입 wCdate를 timeDiff()메소드 인자값으로 보내서 오늘시간과 계산해서 시간차 리턴받기
				vo.setwNdate(res); 	//시간차를 숫자형식변수에 저장
				
				vo.setReadNum(rs.getInt("readNum"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setGood(rs.getInt("good"));
				vo.setMid(rs.getString("mid"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}
	
	
}