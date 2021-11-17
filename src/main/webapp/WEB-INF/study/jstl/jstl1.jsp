<%@page import="member.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>jstl1.jsp</title>
	<%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
	<h2>JSTL(Java Standard Tag Library)</h2>
	<table class="table">
		<tr>
			<th>라이브러리명</th>
			<th>주소(URL) </th>
			<th>접두어(prefix)</th>
			<th>문법</th>
		</tr>
		<tr>
			<td>Core</td>
			<td>http://java.sun.com/jsp/jstl/core</td>
			<td>c</td>
			<td>< c : 태그 ></td>
		</tr>
		<tr>
			<td>Function</td>
			<td>http://java.sun.com/jsp/jstl/functions</td>
			<td>fn</td>
			<td>$ { fn : 태그 }</td>
		</tr>
		<tr>
			<td>Formatting</td>
			<td>http://java.sun.com/jsp/jstl/fmt</td>
			<td>fmt</td>
			<td>< fmt : 태그 ></td>
		</tr>
		<tr>
			<td>SQL</td>
			<td>http://java.sun.com/jsp/jstl/sql</td>
			<td>sql</td>
			<td>< sql : 태그 ></td>
		</tr>
	</table>
	<hr/>
	<h3>Core 라이브러리 : 변수 제어/선언/할당, 제어문/반복문</h3>
	
	<p>변수 선언 : < c :set var="변수명" value="값" /></p>
	<p>변수 (값) 출력 : < c :out value="변수(el표기법)or값" /></p>
	<p>변수 제거 : <  c : remove var="변수명" /> 설정한 변수 메모리를 제거한다.</p>
	<p>예외처리 : <c : catch 문장 ... /></p>
	
	
	su1 변수 선언 => <c:set var="su1" value="500"/><br/>
	'100' 값 출력 => <c:out value="100"/><br/>
	su1 값 출력 => <c:out value="${su1}"/><br/><br/>
	
	<b>< c : out ... ./> 대신 바로 EL 표기법으로 출력 가능</b><br/>
	ㄴ>su1 값 출력 => ${su1}<br/><br/>
	
<% String name = "홍길동";%>
	<b>String 값을 c : set 저장소에 담아서 EL로 출력하기</b><br/>
 	<c:set var="name" value="<%=name %>"/>
 	name : ${name}<br/>
 	<hr/>
 	
 	<h3>jstl Core 라이브러리 응용</h3>
 	<p>연산</p>
 	<c:set var="su2" value="100"/><br/>
 	su1 + su2(c out 사용해서 출력) = <c:out value="${su1+su2}"/><br/>
 	su1 + su2(EL로만 출력) = ${su1 + su2}<br/>
 	su1 - su2 = ${su1 - su2}<br/>
 	su1 * su2 = ${su1 * su2}<br/>
 	su1 / su2 = ${su1 / su2}<br/>
 	su1 % su2 = ${su1 % su2}<br/>
 	<hr/>
<%
	MemberVO vo = new MemberVO();
	vo.setName("홍길동");
	vo.setAddress("서울");
	vo.setEmail("abc1234@naver.com");
	request.setAttribute("vo", vo);
	//pageContext.setAttribute("vo", vo); 리퀘스트도 되고 이것도 됨
%>
	VO 객체 name : ${vo.name}; <br/>
	VO 객체 address : ${vo.address}; <br/>
	VO 객체 email : ${vo.email}; <br/>
	VO 객체 name을 jstl 변수 name에 담아서 출력 : <!--이건 vo에 있는걸 꺼낸거  -->
	<c:set var="name" value="${vo.name}"/>	
	name = ${name}<br/><br/>	<!-- 이건 jstl에 있는걸 꺼낸거 -->
	
	<h4>vo 객체의 name 필드에 '김말숙'을 저장시켜보자</h4>
	<!-- <c:set target="${vo}" property="name" value="김말숙"/> property를 변수명이라 생각하면 쉬움 -->
	<c:set var="irum" value="이기자"/>
	<c:set target="${vo}" property="name" value="${irum}"/><!-- 이렇게 먼저 irum이라는 변수를 만들고 그걸 value에 el로 넣어도 됨 -->
	저장된 vo 객체의 name 필드값 : $ { vo.name} : ${vo.name} / < %= vo.getname %> : <%=vo.getName()%><br/>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>