<%@page import="java.util.List"%>
<%@page import="study.mapping2.UserVO"%>
<%@page import="study.mapping2.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>jstl2.jsp</title>
	<%@ include file="/include/bs4.jsp" %>
</head>
<body>
<%@ include file="/include/header_home.jsp" %>
<jsp:include page="/include/nav.jsp"/>
<p><br></p>
<div class="container">
	<h2>JSTL 제어문</h2>
	<p><b>조건문 - 참일 때 수행할 내용만 기술 가능.(else문이 없음)</b></p>
	<b> 문법 : < c :if test="$ {조건식}">참일때수행내용</ c :if> </b><br/>
	<p>일반 비교 연산은 '문자'로 연산처리한다. 숫자로 변형하려면 변수명 뒤에 +0을 붙여준다</p>
	<c:set var="su1" value="1000"/>
	<c:set var="su2" value="5000"/>
	su1 = ${su1} / su2 = ${su2}<br/>
	1. su1 lt su2 ==>> <c:if test="${su1+0 > su2}">su1이 더 크다</c:if><br/>
	2. <c:if test="${su1 == su2+0}"> su1과 su2는 같다.</c:if><br/>
	3. <c:if test="${su1 != su2+0}"> su1과 su2는 같지 않다.</c:if><br/>
	4. <c:if test="${su1 >= su2+0}"> su1는 su2보다 크거나 같다.</c:if><br/>
	5. <c:if test="${su1 < su2+0}"> su1이 su2보다 작다.</c:if><br/>
	6. <c:if test="${su1 <= su2+0}"> su1은 su2는 작거나 같다.</c:if><br/><br/>
	<hr/>
	<b>다중조건비교(choose~when~when~otherwise) - switch문과 비슷</b><br/>
	su1 = ${su1} / su2 = ${su2}<br/>
	=>
	<c:choose>
		<c:when test="${su1+0 > su2}">su1이 더 크다</c:when>
		<c:when test="${su1+0 >= su2}">su1이 더 크거나 같다</c:when>
		<c:when test="${su1+0 < su2}">su1이 더 작다</c:when>
		<c:when test="${su1+0 <= su2}">su1이 더 작거나 같다</c:when>
		<c:when test="${su1+0 == su2}">su1과 su2가 같다</c:when>
		<c:when test="${su1+0 != su2}">su1과 su2가 같지 않다</c:when>
		<c:otherwise>해당사항없음</c:otherwise>
	</c:choose>
	<br/><br/>
	점수할당 : <c:set var="jumsu" value="85"/>
	<c:choose>
		<c:when test="${jumsu > 90}"><c:set var="grade" value="A"/></c:when>
		<c:when test="${jumsu > 80}"><c:set var="grade" value="B"/></c:when>
		<c:when test="${jumsu > 70}"><c:set var="grade" value="C"/></c:when>
		<c:when test="${jumsu > 60}"><c:set var="grade" value="D"/></c:when>
		<c:otherwise>F학점</c:otherwise>
	</c:choose>
	<br/>
	학점은 <font color='red'><b>${grade}</b></font> 학점<br/>
	<hr/>
	<h3>반복문(forEach문)</h3>
	<p>문법 : < c :forEach var="변수" items="$ {배열/객체}" >수행할내용< / c:forEach></p>
	<p>문법2 : < c :forEach var="변수" begin="초기값" end="최종값" step="증감값" varStatus="인자" >수행할내용< / c:forEach></p>
	<p>1.반복문 예시<br/>
		- '안녕' 10번 출력<br/>
		<c:forEach var="no" begin="1" end="10" step="1">
			${no}.안녕 /
		</c:forEach>
	</p>
	<p>2.반복문 예시 - varStatus count/index<br/>
	count는 반복 횟수, index는 var="no"와 같은 의미<br/>
		<c:forEach var="no" begin="0" end="10" step="1" varStatus="st">
			${no}.안녕 : count = ${st.count} / index = ${st.index}<br/><%-- varStatus는 현재 상태를 담는다. var과 다름 --%>
		</c:forEach>
	</p>
	<p>3.반복문 예시 - varStatus first/last<br/>
		<c:forEach var="no" begin="10" end="20" step="2" varStatus="st">
			${no}.안녕 : ${st.first} / ${st.last}<br/>
		</c:forEach>
	</p>
	<hr/>
	<p>4.반복문 예시(member 객체 이용)<br/>
<%
	UserDAO dao = new UserDAO();
	List<UserVO> vos = dao.getUserList();
	request.setAttribute("vos", vos);
	//for(UserVO vo : vos){
		//out.println("성명 : " + vo.getName() + "<br/>");
	//}
%>	
	<hr/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			${st.count}.(${st.index}) 성명 : ${vo.name} / 나이 : ${vo.age}<br/>
		</c:forEach>
	</p>
	<hr/>
	<p>5.반복문 예시(member 객체 이용) - 첫번째와 마지막 자료의 이름/나이 출력<br/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<c:if test="${st.first}">첫번째 자료 : ${vo.name} / ${vo.age}<br/></c:if>
			<c:if test="${st.last}">마지막 자료: ${vo.name} / ${vo.age}</c:if>
		</c:forEach>
	</p>
	<hr/>
	<p>6.반복문 예시(member 객체 이용) - 짝수번째 자료 출력<br/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<c:if test="${st.count % 2 == 0}">${st.count} : ${vo.name} / ${vo.age}<br/></c:if>
		</c:forEach>
	</p>
	<hr/>
	<p>7.반복문 예시(member 객체 이용) - 짝수번째 자료 출력(begin~end 사용)<br/>
		<c:set var="vosCnt" value="<%=vos.size()%>"/>
		<c:forEach var="vo" items="${vos}" begin="0" end="${vosCnt-1}" varStatus="st"><%--begin end는 index니까 -1해줘야함 end에서 --%>
			<c:if test="${st.count % 2 == 0}">${st.count} : ${vo.name} / ${vo.age}<br/></c:if>
		</c:forEach>
	</p>
	<hr/>
	<p>9. 이중 반복구조<br/>
		<c:set var="cnt" value="0"/>
		<c:forEach var="i" begin="1" end="5">
			<c:forEach var="j" begin="1" end="3">
				<c:set var="cnt" value="${cnt+1}"/>
				${cnt}번째 /
			</c:forEach>
		</c:forEach>
	</p>
	<hr/>
	<p>10. 반복문(배열연습-1차원)<br/>
	    <c:forEach var="arr" items="${arr1}" varStatus="st">
	    	${st.count} :  ${arr}<br/>
	    </c:forEach>
	 </p>
	 <hr/>
	<p>11. 반복문(배열 연습 - 2차원 배열)<br/>
		<c:forEach var="rowArr" items="${arr2}" varStatus="rowSt">
			<c:forEach var="colArr" items="${rowArr}" varStatus="colSt">
				rowSt = ${rowSt.count} : colst = ${colSt.count} : ${colArr}<br/>
			</c:forEach>
		</c:forEach>
	 </p>
	 <hr/>
	<p>12. 반복문(배열 연습 - 2차원 배열 2)<br/>
		<c:set var="cnt" value="0"/>
		<c:forEach var="rowArr" items="${arr2}">
			<c:forEach var="colArr" items="${rowArr}">
				<c:set var="cnt" value="${cnt + 1}"/>
				${cnt} : ${colArr} / &nbsp;
				<c:if test="${cnt%2==0}"><br/></c:if>
			</c:forEach>
		</c:forEach>
	 </p>
	 <hr/>
	<p>14. 반복문(배열 연습 - 2차원 배열 - 지역번호 : 지역명)<br/>
    	<c:forEach var="rowTel" items="${tel}">
    		<c:forEach var="tel" items="${rowTel}">
    			${tel} : 
    		</c:forEach>
    		<br/>
    	</c:forEach>
    </p>
	<hr/>
<%
	String hobbys = "등산/낚시/바둑/영화감상/수영";
	pageContext.setAttribute("hobbys", hobbys);
%>
	<p>토큰(특정 기호)을 이용한 분리 : forTokens<br/>
		<취미> <br/>
		<c:forTokens var="hobby" items="${hobbys}" delims="/">
			${hobby}<br/> 
		</c:forTokens>
	</p>
	<hr/>	
	<p>취미 중 바둑은 빨강, 수영은 파랑색으로 출력<br/>
		<취미> <br/>
		<c:forTokens var="hobby" items="${hobbys}" delims="/">
			<c:if test="${hobby eq '바둑'}"><font color="red">${hobby}</font><br/></c:if>
			<c:if test="${hobby eq '수영'}"><font color="blue">${hobby}</font><br/></c:if>
			<c:if test="${hobby != '수영' && hobby != '바둑'}">${hobby}<br/></c:if>
		</c:forTokens>
	</p>
	<hr/>
</div>
<br/>
<%@ include file="/include/footer.jsp" %>
</body>
</html>