package study.mapping2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class URLMappingDeleteCommand implements URLInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		UserDAO dao = new UserDAO();
		
		int res = dao.setUserDel(idx);
		
		if(res == 1) {
			request.setAttribute("msg", "userDeleteOk");
		}
		else {
			request.setAttribute("msg", "userDeleteNo");			
		}
		request.setAttribute("url", request.getContextPath()+"/urlMappingList.um");//삭제되든 못됐든 어쨌든 목록으로 보내는거니까 if랑 elseif 둘다 이거 처리하게 여기다 씀
	}

}
