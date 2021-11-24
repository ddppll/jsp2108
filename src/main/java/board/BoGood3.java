package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/boGood3")
public class BoGood3 extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		BoardDAO dao = new BoardDAO();
		
		// 좋아요수 증가처리(중복방지)
		// 세션배열(객체배열:ArrayList()) : 'good3' + '현재글의 고유번호'
		String sw = "1";
		HttpSession session = request.getSession();
		ArrayList<String> good3Idx = (ArrayList)session.getAttribute("sGood3Idx");
		if(good3Idx == null) { //로그아웃했따가 들어오면 세션이 없는상태. 세션이 없으면 세션을 생성해줘야함. 그게 이 조건문 부분
			good3Idx = new ArrayList<String>();
			session.setAttribute("sGood3Idx", good3Idx);
			//System.out.println("1.contentIdx : " + contentIdx);
		}
		String imsiGoodIdx = "good3" + idx;
		if(!good3Idx.contains(imsiGoodIdx)) { //기존 세션에 지금 만든 imsiGoodIdx가 없으면 좋아요누른적이 없다는 뜻
			dao.setGoodUpdate(idx); //그러면 좋아요 처리를 하고
			good3Idx.add(imsiGoodIdx); // 세션에 지금 만든 imsi를 넣어준다. 이제 세션은 null이 아니기 때문에 다시 위로 들어가서 if goodIdx==null인 부분에서 null이 아니기 때문에 그냥 dao.getboardcontent로 게시글만 그대로 내보냄. 좋아요는 증가하지 않고.
			sw = "0";
			//System.out.println("2.contentIdx : " + contentIdx);
		}
		
		response.getWriter().write(sw);
	}
}
