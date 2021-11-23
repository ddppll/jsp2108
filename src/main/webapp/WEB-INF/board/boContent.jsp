<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %><!-- 엔터키를 newLine이라는 변수로 치환하겠다는 뜻. 이걸 해야 본문에서 replace함수로 newLine을 <br/>태그로 치환할수있고 그래야 출력될때 엔터키도 나옴 -->
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boContent.jsp</title>
	<%@ include file="/include/bs4.jsp" %>
	<script>
		function delCheck(){
			var ans = confirm("게시글을 삭제하시겠습니까?");
			if(ans) location.href="${ctp}/boDelete.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}";
		}
	</script>
	<style>
		th{
			background-color:#eee;
			text-align : center;
		}
	</style>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
	<h2 style="text-align:center">글 내용보기</h2>
	<br/>
	<table class="table table-bordered">
		<tr>
			<th>글쓴이</th>
			<td>${vo.nickName} &nbsp;&nbsp;<a href="${ctp}/boGood.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}">💖</a>(${vo.good})</td>
			<th>작성날짜</th>
			<td>${fn:substring(vo.wDate,0,19)}</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${vo.email}</td>
			<th>조회수</th>
			<td>${vo.readNum}</td>
		</tr>
		<tr>
			<th>홈페이지</th>
			<td>
				<c:if test="${fn:length(vo.homePage)>10}"><a href="${vo.homePage}" target="_blank">${vo.homePage}</a></c:if>
				<c:if test="${fn:length(vo.homePage)<=10}">없음</c:if>
			</td>
			<th>접속IP</th>
			<td>${vo.hostIp}</td>
		</tr>
		<tr>
			<th>좋아요</th>
			<td colspan="3">❤(${vo.good})</td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3">${vo.title}</td>
		</tr>
		<tr>
			<th>글 내용</th>
			<td colspan="3" style="height:200px">${fn:replace(vo.content,newLine,'<br/>')}</td>
		</tr>
		<tr>
			<td colspan="4" class="text-center">
				<input type="button" value="돌아가기" onclick="location.href='${ctp}/boList.bo?pag=${pag}&pageSize=${pageSize}';"/>
				<c:if test="${sMid == vo.mid}">
					<input type="button" value="수정" onclick="location.href='';"/>
					<input type="button" value="삭제" onclick="delCheck()"/>
				</c:if>
			</td>
		</tr>
	</table>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>