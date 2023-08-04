<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHXX AH' BOARD</title>
<link rel="stylesheet" href="./css/menu-white.css">
<link rel="stylesheet" href="./css/board.css">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<script type="text/javascript">
	function linkPage(pageNo){
		location.href = "./board?pageNo="+pageNo;
	}	
</script>
</head>
<body>
	<%@ include file="menu.jsp"%>
	
	<div class=bg_board>
		<div class="head">BOARD</div>
	</div>
	<br>
	<br>
	<br>
	<div class=btn>
		<input type="text"> <img alt="" src="./img/search.png"
			style="width: 8%;"> &nbsp;
		<c:if test="${sessionScope.mname ne null}">
			<img alt="" src="./img/write.png" style="width: 8%;"
				onclick="location.href='./write'">
		</c:if>
	</div>
	<c:choose>
		<c:when test="${fn:length(list) gt 0 }">
			<table>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<c:forEach items="${list }" var="row">
					<tr class="board_list"
						onclick="location.href='./detail?bno=${row.bno }'">
						<td class="td1">${row.bno }</td>
						<td class="title">${row.btitle } 
						<small>
						<c:if test="${row.commentcount ne 0}">
						[${row.commentcount }]</c:if></small></td>
						<td class="td1">${row.m_name }</td>
						<td class="td2">${row.bdate }</td>
						<td class="td1">${row.blike }</td>
					</tr>
				</c:forEach>
			</table>
			<div class="page">
			<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="linkPage" />
			</div>

		</c:when>
		<c:otherwise>
			<h1>출력할 데이터가 없습니다.</h1>
		</c:otherwise>
	</c:choose>

	<div class="block1"></div>
</body>
</html>