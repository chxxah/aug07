<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/menu-black.css">
<link rel="stylesheet" href="./css/detail.css?version=0.2">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	function edit() {
		if (confirm("수정하시겠습니까?")) {
			location.href = "./edit?bno=${dto.bno }"
		}
	}

	function del() {
		let chk = confirm("삭제하시겠습니까?");
		alert(chk);
		if (chk) {
			location.href = "./delete?bno=${dto.bno }";
		}
	}
	
	$(function () {
		$(".commentBox").hide();
		$("#openComment").click(function () {
			$(".commentBox").show('slow');
			$("#openComment").remove;
		});
	});
</script>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<div style="height: 70px; width: 100%"></div>
	<hr class="hr">
	<div class="info_box">
		<div class="board_logo">
			<img alt="" src="./img/board_logo.png">
		</div>
		<div class="namebar">
			<div class="name">${dto.m_name } (${dto.m_id })&nbsp;&nbsp;&nbsp;${dto.m_mbti }</div>
			<div class="etc">
				<div class="date">작성일 : ${dto.bdate }</div>
				<div class="ip">IP : ${dto.bip }</div>
				<div class="like"><img alt="" src="./img/view.png">&nbsp;조회수 : ${dto.blike }</div>
			</div>
		</div>
	</div>
	<hr class="hr">
	<div class="detail-content">
		<div class="title"><small>No.${dto.bno }</small>&nbsp;&nbsp; ${dto.btitle }
			<div class="button_edit">
			<c:if test="${sessionScope.mid ne null && sessionScope.mid eq dto.m_id}">
				<img alt="" src="./img/edit.png" style="width: 50%" onclick="edit()">&nbsp;
				<img alt="" src="./img/del.png"  style="width: 50%" onclick="del()">
			</c:if>
			</div>
		</div>
		<div class="commentBox"></div>
		<div class="content">${dto.bcontent }</div>
		<c:choose>
		<c:when test="${fn:length(commentsList) gt 0 }">
		<div class = "comments">
			<c:forEach items="${commentsList }" var="c">
				
			<div>${c.m_id } / ${c.m_name } / ${c.c_comment } / ${c.c_date }</div>
			
			</c:forEach>
		</div>
		댓글
		
		</c:when>
		<c:otherwise>댓글이 없습니다.</c:otherwise>
		</c:choose>
	</div>
	<c:if test="${sessionScope.mid ne null}">
	<button type="button" id="openComment">댓글 쓰기</button>
		<div class="commentBox">
			<div>
				<form action="./comment" method="post">
					<textarea id="commenttextarea" name="comment" placeholder="댓글을 입력하세요."></textarea>
					<button type="submit" id="comment">글쓰기</button>
					<input type="hidden" name="bno" value="${dto.bno }">
				</form>
			</div>
		</div>
	</c:if>

</body>
</html>