package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemLoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.loginCheck(mid);
		
		if(vo != null) { // 아이디 검색 성공, 비번 맞는지 체크
			// DB에 저장된 암호를 복호화시키기(실무에서는 이런 작업 안함)
			long decPwd;
			long intPwd = Long.parseLong(vo.getPwd()); //db에서 가져온 비밀번호
			long pwdValue = (long) dao.getHashTableSearch(vo.getPwdKey());
			decPwd = intPwd ^ pwdValue;
			
			// 복원된 비밀번호는 숫자로 된 비밀번호이기에 문자로 변경 후 2개씩 분리해서 다시 문자로 변환시켜 준다
			String strPwd = String.valueOf(decPwd);
			
			String result = "";
			char ch;
			
			for(int i=0; i<strPwd.length(); i+=2) {
				ch = (char)Integer.parseInt(strPwd.substring(i, i+2));
				result += ch;
			}
			HttpSession session = request.getSession();
			if(pwd.equals(result)) {	// 비밀번호 인증 ok
				session.setAttribute("sMid", mid);
				session.setAttribute("sNickName", vo.getNickName());
				session.setAttribute("sLevel", vo.getLevel());
				
				// 최종 접속일 알아오기
				session.setAttribute("sLastDate", vo.getLastDate().substring(0, vo.getLastDate().lastIndexOf(".")));
				
				//고객의 현재 총 포인트를 가져와서 세션에 담음
				session.setAttribute("sPoint", vo.getPoint());
				
				
				dao.setLastDateUpdate(mid);	//신규 로그인시 수정항목 처리(포인트, 방문수 등)
				
				request.setAttribute("msg", "memberLoginOk");
				request.setAttribute("url", request.getContextPath()+"/memMain.mem");
				request.setAttribute("val", vo.getNickName());
			}
			else {	//아이디는 맞지만 비밀번호 틀림
				request.setAttribute("msg", "memberLoginPwdNo");
				request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
			}
			
		}
		else {	// 아이디 틀림
			request.setAttribute("msg", "memberLoginNo");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
		}
	}

}
