/* textDB2 */
/* 책 정보 테이블(books) */
create table books(
	bookId int not null auto_increment primary key, /* 책 고유번호 */
	bookName varchar(20) not null, /* 책 이름 */
	publisher varchar(20) not null, /* 출판사명 */
	price int /* 책 가격(정가) */
	/*primary key(bookId, bookName) primary key는 이렇게 여러개를 줄 수 있음*/
);

desc books;

insert into books values (1,'축구의 역사','굿스포츠',7000);
insert into books values (2,'축구아는 여자','나무수',13000);
insert into books values (3,'축구의 이해','대한미디어',22000);
insert into books values (4,'골프 바이블','대한미디어',35000);
insert into books values (5,'피겨 교본','굿스포츠',8000);
insert into books values (6,'역도 단계별기술','굿스포츠',6000);
insert into books values (7,'야구의 추억','이상미디어',20000);
insert into books values (8,'야구를 부탁해','이상미디어',13000);
insert into books values (9,'올림픽 이야기','삼성당',7500);
insert into books values (10,'Olympic Champions','Pearson',13000);
insert into books values (11,'자바의 정석','도우출판사',30000);
insert into books values (12,'포토샵 CS6','제우미디어',25000);
insert into books values (13,'노인과 바다','이상미디어',13000);
insert into books values (14,'C#','삼성당',22000);
insert into books values (15,'전산세무2급','제우미디어',15000);
insert into books values (16,'반응형웹','ICOX',28000);
insert into books values (17,'파이썬따라잡기','이상미디어',22000);
insert into books values (18,'이젠나도자바','삼성당',19000);
insert into books values (19,'구기종목 정복','굿스포츠',9900);
insert into books values (20,'컬러리스트길잡이','나무수',31000);

select * from books;

/* 갯수를 구하는 함수? count() */
-- 전체 책의 권수는?
select count(*) from books;

-- 전체 책의 권수는?(단, 열 이름을 '총 권수'라고 지정하기)
select count(*) as '총 권수' from books;
select count(*) 총 권수 from books;

-- 삼성당 출판사의 개수는?
select count(*) 삼성당출판사개수 from books where publisher='삼성당';

-- 전체 책의 가격 합계?(열 이름 : 총가격)
select sum(price) 총가격 from books;
select format(sum(price),0) 총가격 from books;

-- '삼성당' 출판사의 전체 책 평균(열 이름 : 삼성당책평균) - 소수이하 1자리까지 출력
select format(avg(price),1) 삼성당책평균 from books where publisher='삼성당';

-- 가격이 2만원 이상인 책들의 전체 금액 합계
select format(sum(price),0) from books where price>=20000;

-- 가장 비싼 책과 가장 싼 책의 가격을 출력
select max(price), min(price) from books;

-- 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색
select * from books where publisher='굿스포츠' or publisher='대한미디어';
select * from books where publisher in ('굿스포츠','대한미디어');

-- 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색
select * from books where publisher not in ('굿스포츠','대한미디어');

-- 도서 이름중에서 '축구'가 포함된 출판사를 검색(단, 책 이름과 출판사명만 출력)
select bookName, publisher from books where bookName like '%축구%';

-- 도서이름의 왼쪽 두번째 위치에 '구'라는 문자열을 갖는 도서 검색
select * from books where bookName like '_구%';

-- '축구'에 관한 도서 중 가격이 2만원 이상인 도서만 검색
select * from books where price>=20000 and bookName like '%축구%';

-- 도서를 가격순으로 검색하되 가격이 같으면 이름순으로 내림차순 검색
select * from books order by price, bookName desc;

-- 도서테이블에서 모든 출판사를 검색하시오(중복 허용) - 출판사필드만 검색
select publisher from books;

-- 도서테이블에서 모든 출판사를 검색하시오(중복 불허) - 출판사필드만 검색
select distinct publisher from books;

/* 그룹으로 묶어서 작업처리 : group by ~ having(조건 : 집계함수) 
 * group by 뒤의 검색조건필드를 select절의 필드로 적어준다
 * 또한, select 절에서는 group by 뒤의 검색조건필드를 집계함수와 함께 사용할 수 있다 */
-- 도서테이블에서 모든 출판사를 검색하시오(중복 불허 : group by 사용) - 출판사필드만 검색
select publisher from books group by publisher;

-- 책을 납품한 출판사의 납품한 책 총 권수는?
select publisher, count(publisher) from books group by publisher;

--출판사별로 책 가격의 전체 합계와 평균
select publisher, sum(price), format(avg(price),1) from books group by publisher;

--출판사별로 책 가격 중 최고 가격과 최저 가격인 책 출력
select publisher, format(max(price),0), format(min(price),0) from books group by publisher;

-- 책 1권 가격이 2만원 이상인 책을 납품한 출판사(출판사명 중복 불허)
select publisher, price from books where price >=20000 group by publisher;
select publisher, price from books group by publisher having price >=20000; /*틀림 : having 절에는 집계함수가 와야함*/

-- 책을 납품한 횟수가 2회 이상인 출판사와 납품횟수 출력
select publisher, count(publisher) from books group by publisher having count(publisher)>=2;

-- 책을 2번 이상 납품한 출판사의 책 중 최고 가격인 책의 출판사명을 출력
select publisher, max(price) from books group by publisher having count(publisher)>=2;

/* 한계치를 적용한 출력 : 'limit 처음인덱스위치, 개수' */
-- 처음부터 10권의 책을 출력
select bookName from books limit 0,10;

-- 책 자료 중 2번째부터 5건 출력
select bookName from books limit 1,5;

-- 책 가격이 가장 높은 순으로 5건만 출력
select * from books order by price desc limit 5;

/* -------------------다중 테이블 활용하기-------------------------------- */
/* 주문자(고객*) 테이블 : customer */
create table customer(
	custId int not null auto_increment primary key, /* 고객 고유 아이디 */
	name varchar(20) not null, /* 고객명 */
	address varchar(30) not null, /* 주소 */
	phone varchar(15) /* 고객 연락처 */
);

-- customer(고객정보 등록)
INSERT INTO customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO customer VALUES (3, '김말숙', '대한민국 강원도', '000-7000-0001');
INSERT INTO customer VALUES (4, '손흥민', '영국 토트넘', '000-8000-0001');
INSERT INTO customer VALUES (5, '박세리', '대한민국 대전',  null);
INSERT INTO customer VALUES (6, '이순신', '대한민국 아산',  '');


/* 주문 테이블(orders) */
-- on update cascade : 원본테이블 데이터 변경시 참조테이블이 영향을 받음
-- on delete restrict : 원본테이블 데이터 삭제시 참조테이블이 영향을 받음(참조테이블에서 참조를 하고 있다면 삭제 불가)
create table orders(
	orderId int not null auto_increment, /* 주문 고유번호 */
	custId int not null, /* 고객(주문자) 아이디*/
	bookId int not null, /* 책 고유번호 */
	salePrice int not null, /* 책 할인가격(실제 판매가격) */
	orderDate timestamp, /* 책 주문 날짜(날짜형식) */
	primary key(orderId), /* 주 키 : orderId */
	foreign key(custId) references customer(custId) on update cascade on delete restrict,
	foreign key(bookId) references books(bookId) on update cascade on delete restrict
	
);

-- orders(주문정보) 데이터 생성
INSERT INTO orders VALUES (1, 1, 1, 6000, '2009-07-01'); 
INSERT INTO orders VALUES (2, 1, 3, 21000, '2018-02-03');
INSERT INTO orders VALUES (3, 2, 5, 8000, '2021-05-03'); 
INSERT INTO orders VALUES (4, 3, 6, 6000, '2020-06-04'); 
INSERT INTO orders VALUES (5, 4, 7, 20000, '2019-11-05');
INSERT INTO orders VALUES (6, 1, 2, 12000, '2021-09-07');
INSERT INTO orders VALUES (7, 4, 8, 13000, '2019-03-07');
INSERT INTO orders VALUES (8, 3, 10, 12000, '2018-07-08'); 
INSERT INTO orders VALUES (9, 2, 10, 9000, '2019-05-09'); 
INSERT INTO orders VALUES (10, 3, 11, 27000, '2020-06-15');
INSERT INTO orders VALUES (11, 2, 13, 11000, '2021-06-18');
INSERT INTO orders VALUES (12, 3, 15, 13000, '2021-08-20');
INSERT INTO orders VALUES (13, 6, 18, 19000, '2021-10-10');
INSERT INTO orders VALUES (14, 6, 16, 27000, '2021-11-20');
INSERT INTO orders VALUES (15, 3, 20, 30000, '2021-11-20');
INSERT INTO orders VALUES (16, 4, 16, 26000, '2021-11-25');
INSERT INTO orders VALUES (17, 4, 8, 13000, '2021-06-10');
INSERT INTO orders VALUES (18, 6, 8, 12000, '2021-06-10');
INSERT INTO orders VALUES (19, 2, 15, 13000, '2021-07-12');
INSERT INTO orders VALUES (20, 2, 17, 22000, '2021-10-15');


select * from customer;
select * from orders;
select * from books; 
