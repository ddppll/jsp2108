package board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoSearchCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String search = request.getParameter("search") == null ? "" : request.getParameter("search");
		String searchString = request.getParameter("searchString") == null ? "" : request.getParameter("searchString");
		BoardDAO dao = new BoardDAO();
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
		  int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		  int pageSize = request.getParameter("pageSize") == null? 5 : Integer.parseInt(request.getParameter("pageSize"));
		  
		  // 검색창에 입력된 내용을 포함한 레코드 수 구하기
		  int totRecCnt = dao.totRecCnt(search, searchString);
		  
		  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		  int startIndexNo = (pag - 1) * pageSize;
		  int curScrStrarNo = totRecCnt - startIndexNo;
		  int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
		  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
		  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
		  /* 블록페이징처리 끝 */
		  
		  	List<BoardVO> vos =  dao.getBoardSearch(search, searchString, startIndexNo, pageSize); //전체자료검색
		  	
			request.setAttribute("vos", vos);
			request.setAttribute("pag", pag);
			request.setAttribute("totPage", totPage);
			request.setAttribute("curScrStrarNo", curScrStrarNo);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("curBlock", curBlock);
			request.setAttribute("lastBlock", lastBlock);
			request.setAttribute("pageSize", pageSize);
			
			// 검색을 위해 추가
			String searchTitle = "";
			if(search.equals("title")) searchTitle = "제목";
			else if(search.equals("nickName")) searchTitle = "작성자";
			else searchTitle = "내용";
			
			request.setAttribute("searchTitle", searchTitle);
			request.setAttribute("search", search);
			request.setAttribute("searchString", searchString);
			request.setAttribute("searchCount", totRecCnt);
	}

}
