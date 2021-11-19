<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ajax1.jsp</title>
	<%@ include file="/include/bs4.jsp" %>
	<script>
		function idCheck(){
			var mid = searchForm.mid.value;
			if(mid == ""){
				alert("아이디를 입력하세요.");
				searchForm.mid.focus();
				return false;
			}
			
			var query = {
				mid : mid
			}
			
			//alert("입력된 아이디 : " + mid);
			//$.ajax({변수1:값1, 변수2:값2});
			$.ajax({
				type : "get", //전송방식
				url : "${ctp}/ajax1Ok",	//action - 이건 디렉토리패턴으로 따로 커맨드를 만들어줌
				//data : {mid : 'qwerty',age:22,....}
				data : query,
				success : function(data){
					// 성공적으로 ajax(비동기식) 처리를 끝내고 돌아왔을 경우 수행하는 곳
					if(data == ""){
						alert("검색된 자료가 없습니다");					
					}
					else{
						alert("검색된 이름 : " + data);
					}
				},
				error : function(data){
					// ajax(비동기식) 처리 실패시 수행하는 곳
					alert("검색시 오류 발생");
				}
			});
		}
		
		//ajax로 User 테이블에 등록하기
	    function inputCheck() {
	    	var name = $("#name").val();
	    	var age = $("#age").val();
	    	
	    	if(name == "") {
	    		alert("성명을 입력하세요!");
	    		$("#name").focus();
	    		return false;
	    	}
	    	
	    	var query = {
	    			name : name,
	    			age  : age
	    	}
	    	
	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/userInput",
	    		data : query,
	    		success : function(data) {
	    			if(data == "1") {
	    				alert("등록 성공!");
	    			}
	    		}
	    	});
	    }
		
	</script>
	<style>
		th, td{
			text-aligh : center;
			border: 1px solid #ccc;
		}
		th{
			background-color : #ddd;
		}
	</style>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
	<h2>Ajax 연습</h2>
	<form name="searchForm" >
		아이디 : <input type="text" name="mid" />
		<input type="button" value="아이디검색" onclick="idCheck()"/>
	</form>
	<br/>
	<form name="inputForm">
		<table class="table table-bordered">
			<tr style="text-align:center;">
				<td colspan="2"><h3>User 가입</h3></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" id="name" class="form-control" autofocus required /></td>
			</tr>
			<tr>
				<th>나이</th>
				<td><input type="number" name="age" id="age" value="20" class="form-control"/></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center;">
		          <input type="button" value="등록" onclick="inputCheck()" class="btn btn-secondary"/>
		          <input type="reset" value="다시입력" class="btn btn-secondary"/>
		          <input type="button" value="User전체조회" onclick="listCheck()" class="btn btn-secondary"/>
        		</td>
			</tr>
		</table>
	</form>
	<hr/>
	<!-- 출력창 -->
	<h2>User 테이블 전체 리스트</h2>
	<table class="table">
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>나이</th>
		</tr>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td>${vo.idx}</td>
				<td>${vo.name}</td>
				<td>${vo.age}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>