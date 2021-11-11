package study.mapping2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface URLInterface {
	//인터페이스니까 추상메소드 사용. 추상메소드는 실행부분이 없으니 중괄호 없이 ;로 끝냄
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException; 
}
