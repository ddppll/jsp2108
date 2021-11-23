package conn;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

// 오늘(현재)날짜와 DB의 날짜와의 시간 차이를 계산해서 돌려주는 클래스
public class TimeDiff {
	// 1.오늘 날짜와 DB의 날짜를 '문자'로 변경 : 날짜 형식 기호에 맞도록 설계
	// 2.날짜연산을 위해 '날짜'형식으로 변환
	// 3.날짜 차이를 시간으로 계산하기 위해 '숫자'형식으로 변환
	
	// 외부로부터 날짜를 입력받아 연산처리후 정수값을 돌려준다
	public int timeDiff(String wCdate) {
	// -----------오늘 날짜 처리------------	
		// 1-1.날짜 형식을 문자(202111231253)형식으로 변환
		Calendar cal = Calendar.getInstance(); //Date 써도 됨
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm"); //HH : 24시간제, hh:1~12(AM/PM)
		String strToday = sdf.format(cal.getTime());
		
		// 1-2.날짜 연산을 위해 문자 형식의 날짜를 날짜 형식으로 변환
		Date today = null;
		try {
			today = sdf.parse(strToday);
		}catch(ParseException e) {
			e.printStackTrace();
		}
	// -------------DB 날짜 처리-------------	
		// 2-1. DB에 저장된 날짜(2021-11-23 13:04:25.5) 형식을 앞과 같은 포맷으로 처리한다
		String strWCdate = wCdate.substring(0,4)+wCdate.substring(5,7)+wCdate.substring(8,10)+wCdate.substring(11,13)+wCdate.substring(14,16);
		
		// 2-2. 날짜 연산을 위해 DB에서 가져온 문자변환형식자료를 날짜형식으로 변환한다
		Date dateWdate = null;
		try {
			dateWdate = sdf.parse(strWCdate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	// ------------날짜형식으로 변경된 두 자료(today/dateWdate)를 숫자형식(getTime())으로 변경한다(시간으로 연산처리하기 위해서)--------
		//결과값은 ms 형식으로 반환됨
		long diffTime = (today.getTime() - dateWdate.getTime()) / (60*60*1000)+1;
		
		return (int)diffTime;	// 연산된 결과를 시간으로 리턴
	}
}
