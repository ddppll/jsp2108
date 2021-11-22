<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boList.jsp</title>
	<%@ include file="/include/bs4.jsp" %>
	<style>
		th, td{
			text-align : center;
		}
	</style>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
	<table class="table table-borderless">
		<tr>
			<td><h2>게시판 글목록</h2></td>
		</tr>
		<tr>
			<td class="text-left">
				<a href="${ctp}/boInput.bo" class="btn btn-secondary">글쓰기</a>
			</td>
		</tr>
	</table>
	<table class="table table-hover">
		<tr class="table-dark text-dark">
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일시</th>
			<th>조회수</th>
			<th>좋아요</th>
		</tr>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td>${vo.idx}</td>
				<td>${vo.title}</td>
				<td>${vo.nickName}</td>
				<td>${vo.wDate}</td>
				<td>${vo.readNum}</td>
				<td>${vo.goods}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>	
</body>
</html>