<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../../include/sCheck.jsp" %>
<%
	//String nickName = (String)session.getAttribute("sNickName");
	//닉이랑 레벨을 따로 서블릿으로 빼서 거기에 세션에 담아줌
	//저장소에 이제 세션으로 담겨져있으니 html 본문에서 ${}로 꺼낼수있음
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>memMain.jsp</title>
	<%@ include file="../../include/bs4.jsp" %>
</head>
<body>
<%@ include file="../../include/header_home.jsp" %>
<%@ include file="../../include/nav.jsp" %>
<p><br></p>
<div class="container">
	<h2>정규 회원방</h2>
	<hr/>
	<p><font color="blue">${sNickName}</font>님 로그인 중입니다.</p>
	<p>현재 레벨은 <font color="red">${strLevel}</font> 입니다.</p>
	<hr/>
	<p>최종 접속일 : ${sLastDate}</p>
	<p>총 방문횟수 : ___</p>
	<p>오늘 방문횟수 : ___</p>
	<p>포인트 합계 : ___</p>
	<p>활동 내역 : 
	  방명록에 올린 글 : __개 : 성명이나 아이디, 닉네임이 일치하는 자료의 갯수를 불러온다.<br/>
	  전체 게시글 : __개<br/>
	  자료실 업로드 횟수 : __개<br/>
	</p>
</div>
<br/>
<%@ include file="../../include/footer.jsp" %>
</body>
</html>