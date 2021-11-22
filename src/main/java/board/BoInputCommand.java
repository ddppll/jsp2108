package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.MemberDAO;
import member.MemberVO;

public class BoInputCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = session.getAttribute("mid") == null ? "" : (String)session.getAttribute("mid");
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getUserInfor(mid); //아이디 일치하는 자료 가져오기
		
		request.setAttribute("email", vo.getEmail());
		request.setAttribute("homePage", vo.getHomePage());
	}

}
