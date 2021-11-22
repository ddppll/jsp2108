<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boInput.jsp</title>
	<%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
	<form name="myform" method="post" action="${ctp}/boInputOk.bo">
		<table class="table table-bordeless">
			<tr>
				<td><h2>게시판 글쓰기</h2></td>
			</tr>
		</table>
		<table class="table">
			<tr>
				<th>작성자</th>
				<td>${sNickName}</td> <!-- loginOk에서 세션에 닉네임 담아둔거 있음 -->
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" placeholder="제목을 입력하세요" class="form-control"/></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email" placeholder="이메일을 입력하세요" value="${email}" class="form-control"/></td>
			</tr>
			<tr>
				<th>홈페이지</th>
				<td><input type="text" name="homePage" placeholder="홈페이지를 입력하세요" value="${homePage}" class="form-control"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="6" name="content" class="form-control"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align : center">
					<input type="button" value="글쓰기" onclick="fCheck()" class="btn btn-secondary"/>&nbsp;
					<input type="reset" value="재입력"  class="btn btn-secondary"/>&nbsp;
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/boList.bo';" class="btn btn-secondary"/>
				</td>
			</tr>
		</table>	
		<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
	</form>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>	
</body>
</html>