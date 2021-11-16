package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemUpdateCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.loginCheck(mid);
		
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
		
		vo.setPwd(result);
		
		// 이메일 처리
		String[] email = vo.getEmail().split("@");
		request.setAttribute("email1", email[0]);
		request.setAttribute("email2", email[1]);
		
		// 성별
		request.setAttribute("gender", vo.getGender());
		
		// 생일
		request.setAttribute("birthday", vo.getBirthday().substring(0,10));
		
		// 전화번호
		String[] tel = vo.getTel().split("/");
		request.setAttribute("tel1", tel[0]);
		request.setAttribute("tel2", tel[1]);
		request.setAttribute("tel3", tel[2]);
		
		// 주소
		String[] address = vo.getAddress().split("/");
		request.setAttribute("address1", address[0]);
		request.setAttribute("address2", address[1]);
		request.setAttribute("address3", address[2]);
		request.setAttribute("address4", address[3]);
		
		// 직업
		request.setAttribute("job", vo.getJob());
		
		// 나머지 일반적인 모든 내용들은 vo에 있으므로 vo를 저장소에 담아서 넘겨준다
		request.setAttribute("vo", vo);
	}

}
