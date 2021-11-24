<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boUpdate.jsp</title>
	<%@ include file="/include/bs4.jsp" %>
	<script>
		function fCheck(){
			var title = myform.title.value;
			var content = myform.content.value;
			
			if(title.trim() == ""){
				alert("제목을 입력하세요");
				myform.title.focus();
			}
			else if(content.trim() == ""){
				alert("글 내용을 입력하세요");
				myform.content.focus();
			}
			else{
				myform.submit();
			}
			
		}
	</script>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<%@ include file="/include/nav.jsp" %>
<p><br/></p>
<div class="container">
	<form name="myform" method="post" action="${ctp}/boUpdateOk.bo">
		<table class="table table-bordeless">
			<tr>
				<td><h2>수정하기</h2></td>
			</tr>
		</table>
		<table class="table">
			<tr>
				<th>작성자</th>
				<td>${sNickName}</td> <!-- loginOk에서 세션에 닉네임 담아둔거 있음 -->
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" value="${vo.title}" class="form-control" autofocus required /></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email" value="${vo.email}" class="form-control"/></td>
			</tr>
			<tr>
				<th>홈페이지</th>
				<td><input type="text" name="homePage" value="${vo.homePage}" class="form-control"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="6" name="content" class="form-control" required >${vo.content}</textarea></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align : center">
					<input type="button" value="수정하기" onclick="fCheck()" class="btn btn-secondary"/>&nbsp;
					<input type="reset" value="재입력"  class="btn btn-secondary"/>&nbsp;
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/boList.bo';" class="btn btn-secondary"/>
				</td>
			</tr>
		</table>	
		<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
		<input type="hidden" name="idx" value="${vo.idx}"/>
		<input type="hidden" name="pag" value="${pag}"/>
		<input type="hidden" name="pageSize" value="${pageSize}"/>
	</form>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>	
</body>
</html>