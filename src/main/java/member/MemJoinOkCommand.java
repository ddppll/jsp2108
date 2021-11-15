package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid").trim();
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd").trim();
		String nickName = request.getParameter("nickName") == null ? "" : request.getParameter("nickName").trim();
		String name = request.getParameter("name") == null ? "" : request.getParameter("name").trim();
		String name_ = name;
		String email1 = request.getParameter("email1") == null ? "" : request.getParameter("email1").trim();
		String email2 = request.getParameter("email2") == null ? "" : request.getParameter("email2").trim();
		String email = email1 +"@"+ email2;
		String gender = request.getParameter("gender") == null ? "" : request.getParameter("gender").trim();
		String birthday = request.getParameter("birthday") == null ? "" : request.getParameter("birthday").trim();
		String tel1 = request.getParameter("tel1") == null ? "" : request.getParameter("tel1").trim();
		String tel2 = request.getParameter("tel2") == null ? "" : request.getParameter("tel2").trim();
		String tel3 = request.getParameter("tel3") == null ? "" : request.getParameter("tel3").trim();
		String tel = tel1 + "/"+ tel2+"/"+tel3;
		String address = request.getParameter("address") == null ? "" : request.getParameter("address").trim();
		String homePage = request.getParameter("homePage") == null ? "" : request.getParameter("homePage").trim();
		String job = request.getParameter("job") == null ? "" : request.getParameter("job").trim();
		String userInfor = request.getParameter("userInfor") == null ? "" : request.getParameter("userInfor").trim();
		String[] hobbys = request.getParameterValues("hobby"); //배열로 들어오는건 getparametervalues로 받음
		String hobby = "";
		for(int i=0; i<hobbys.length; i++) {
			hobby += hobbys[i] + "/";
		}
		hobby = hobby.substring(0,hobby.lastIndexOf("/"));
		String content = request.getParameter("content") == null ? "" : request.getParameter("content").trim();
		
		// 아이디와 닉네임 중복 체크를 저장 전에 한번 더 수행시켜주기
		MemberDAO dao = new MemberDAO();
		
		name = dao.idCheck(mid);
		if(!name.equals("")) { 
			request.setAttribute("msg", "idCheckNo");
			request.setAttribute("url", request.getContextPath()+"/memJoin.mem");
			return;
		}
		
		//닉네임 중복체크하기
		name = dao.nickCheck(nickName);
		if(!name.equals("")) { 
			request.setAttribute("msg", "nickCheckNo");
			request.setAttribute("url", request.getContextPath()+"/memJoin.mem");
			return;
		}
		//DB에 저장될 각각의 필드의 길이 체크
		
		// 비밀번호 암호화 처리
		long intPwd;
		String strPwd = "";
		for(int i=0; i<pwd.length(); i++) {
			intPwd = (long) pwd.charAt(i);
			strPwd += intPwd;
		}
		
		intPwd = Long.parseLong(strPwd);	//연산할 준비 완료 - 변환하는 과정에서 자리수가 늘어날 수 있으므로 long 타입으로 받음
		
		int pwdKey = (int)(Math.random()*20);
		long pwdValue = dao.getHashTableSearch(pwdKey);
		
		long encPwd;
		
		// 암호화 작업(인코딩)
		encPwd = intPwd ^ pwdValue;	// 원본 비번과 암호키값을 배타적OR시킨다(exclusive or)
		strPwd = String.valueOf(encPwd);
		
		//모든 체크 완료 후 정확한 회원 정보를 DB에 저장할 준비를 한다
		MemberVO vo = new MemberVO();
		vo.setMid(mid);
		vo.setPwd(strPwd);
		vo.setPwdKey(pwdKey);
		vo.setNickName(nickName);
		vo.setName(name_);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setJob(job);
		vo.setHobby(hobby);
		// 이미지 처리
		vo.setContent(content);
		vo.setUserInfor(userInfor);
		
		int res = dao.setMemberJoinOk(vo);
		
		if(res==1) { //정상적으로 회원가입 완료
			request.setAttribute("msg", "memberJoinOk");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
		} else {
			request.setAttribute("msg", "memberJoinNo");
			request.setAttribute("url", request.getContextPath()+"/memJoin.mem");
		}
		
	}

}
