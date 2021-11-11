package study.mapping;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 확장자(url) 패턴 - url 주소창에 확장자가 url로 들어오면 무조건 이곳을 거쳐감
@WebServlet("*.url")
public class UrlMappingController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}

	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 이렇게 하면 확장자가 무조건 actionDo로 들어와서 post방식이든 get 방식이든 다 처리 가능
		
		// 한글처리, 세션처리
		
		StringBuffer url = request.getRequestURL();
		System.out.println("url : " + url);
		
		String uri = request.getRequestURI();
		System.out.println("uri : " + uri);
		
		//String com = uri.substring(uri.lastIndexOf("/"), uri.length()-4);
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf(".")); //위에랑같은거
		System.out.println("com : " + com);
		
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('콘솔창을 확인하세요');");
		out.println("location.href='"+request.getContextPath()+"/URLMapping';");
		out.println("</script>");
		
	}
}
