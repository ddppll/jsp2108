/* board.sql */
show tables;
desc board;
create table board(
	idx int not null auto_increment, 	 /* 게시글 고유번호 */
	nickName varchar(20) not null,		 /* 게시글 올린이 닉네임 */
	title varchar(100) not null,		 /* 게시글 제목 */
	email varchar(50),					 /* 게시글 올린이 이메일 */
	homePage varchar(50),				 /* 올린이 홈페이지 */
	content text not null,				 /* 글 내용 */
	wDate datetime not null default now(), /* 작성 날짜(기본값 : 현재 날짜/시간)*/
	readNum int default 0,				 /* 조회수 */
	hostIp varchar(50) not null,		 /* 접속 IP 주소 */
	goods int default 0,				 /* 좋아요 횟수 */
	mid	varchar(20) not null,			 /* 회원 아이디(게시글 조회시 사용) */
	primary key(idx)					 /* 기본키 : 글 고유번호 */
);
select * from board order by idx desc;
insert into board values (default, '관리자','게시판 서비스 시작','manager@naver.com','blog.daum.net/manager','이곳은 게시판입니다. 테스트 글 입력중입니다.',default, default,'218.236.203.155',default,'admin');