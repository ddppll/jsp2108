/* 날짜 함수 연습 */

/* 오늘 날짜 */
select now();
select sysdate();
select localtime();

/* 날짜함수에 +1을 하면? : 'yyyyMMddHHmmss + 1' */
select now(), now()+1;
select sysdate()+1;
select localtime()+1;

/* 오늘 날짜만? */
select curdate();

/* 오늘 연도? */
select year(now());

/* 오늘 월? */
select month(now());

/* 오늘 일? */
select day(now());

select concat(year(now()), '-', month(now()), '-', day(now()));

select nickName, wDate from board order by idx desc;
select nickName, year(wDate), month(wDate), day(wDate) from board order by idx desc;
/*DB에 저장된 날과 오늘 날짜-1이 같은 자료 출력 - 날짜 연산이 됨*/
select nickName, day(wDate) from board where day(wDate) = day(now())-1 order by idx desc;

/* 현재 시간 */
select hour(now());
select minute(now());
select second(now());

/* 요일 - 인덱스 값으로 반환 : 일-1 / 월-2 / 화-3 / 수-4 / 목-5 / 금-6 / 토-7 */
select dayofweek(now());

/* 오늘 요일 영문 표기 */
select dayname(now());
select dayname(curdate());

select nickName, wDate, dayname(wDate) from board;

/* 해당월의 마지막 일(Last_Day) : 평년의 2월 28일, 윤년의 2월 29일 */
select last_day("2020-02-01");
select last_day("2021-02-01");
select last_day("2021-11-01 11:56:25");
select last_day(now());
select nickName, last_day(wDate) from board;

/* 날짜 형식 설정 : date_format(날짜, 형식) */
/*
	%Y : 4자리 년도, %y : 2자리 년도
	%M : 영문 달 이름(풀네임), %b : 영문 달 이름(간략)
	%m : 달 숫자 두자리 표시, %c : 숫자월(한자리 달은 한자리로 표시) 
	%d : 일자(두자리), %e : 일자(한자리 일은 한자리로 표시)
	%l : 시간(12시간제), %H : 시간(24시간제)
	%i : 분
	%s : 초
	%r : hh:mm:ss AM/PM
	%T : hh:mm:ss(24시간제)
	
	Y / m / d / H / T 제일 자주 씀
*/
select date_format(now(), "%Y / %y");
select date_format(now(), "%M / %b");
select date_format(now(), "%m / %c");
select date_format("2021-04-01 11:42:23", "%m / %c");
select date_format("2021-04-01 11:42:23", "%d / %e");
select date_format("2021-04-01 16:42:23", "%l / %h");
select date_format("2021-04-01 16:42:23", "%l / %h / %r / %T");

/* 두 날짜 사이의 값 비교 DATEDIFF() : 앞쪽날짜 - 뒤쪽날짜 */
select datediff("2021-11-24", "2021-11-1");
select datediff(now(), "2021-11-1");
select datediff(now(), "2021-1-1");
select datediff("2021-12-31", now());

/* -----날짜연산(date_add()) / date_sub())----- */
/* interval 정수 인자 - month / day / hour / minute */

/* 오늘 날짜에 한 달을 더한 날짜 */
select date_add(now(), interval 1 month); 

/* 오늘 날짜에 두 달을 더한 날짜 */
select date_add(now(), interval 2 month);

/* 오늘 날짜에 두 달을 뺀 날짜 */
select date_add(now(), interval -2 month);

/* 1개월 이내의 자료만 출력 */
select nickName, wDate from board  where date_add(now(), interval -1 month) < wDate;

/* 1일 이내의 자료만 출력 */
select nickName, wDate from board  where date_add(now(), interval -1 day) < wDate;

/* 24시간 이내의 자료만 출력(date_add()) */
select nickName, wDate from board  where date_add(now(), interval -24 hour) < wDate;

/* 24시간 이내의 자료만 출력(date_sub()) - 그냥 24를 해야 뺌 */
select nickName, wDate from board  where date_sub(now(), interval 24 hour) < wDate;


