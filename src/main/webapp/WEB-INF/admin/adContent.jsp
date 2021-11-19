<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adContent.jsp</title>
	<%@ include file="/include/bs4.jsp" %>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>작업상황</h2>
	<hr/>
	<p><a href="${ctp}/adMemberList.ad?level=1">신규 가입자 <font color="red"><b>${newMember}</b></font> 건</a></p> <!-- 준회원 있을 경우 인원 출력 -->
	<hr/>
	<p><a href="#">최근 게시글 <font color="red"><b>XX</b></font> 건</a></p><!-- 최근 게시글 5건 보기 -->
	<hr/>
	<p><a href="#">문의사항 <font color="red"><b>XX</b></font> 건</a></p>
	<hr/>
	<p><a href="#">________</a></p>
	<hr/>
	<p>오늘 방문횟수 <font color="red">XX</font>건</p>
</div>
<br/>
</body>
</html>