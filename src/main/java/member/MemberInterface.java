package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface MemberInterface {
	//추상메소드라 실행블록 없ㅇ음
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException; 
	
}
