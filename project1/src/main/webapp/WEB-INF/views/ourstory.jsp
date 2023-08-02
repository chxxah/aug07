<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/menu-white.css">
<link rel="stylesheet" href="./css/ourstory.css">
<link rel="stylesheet" href="./css/board.css">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(function () {
		// 보드 내용 가져오기
		var lists = [];// ajax에서 가져오면 lists에 담을 예정임
		$.ajax({
			url: "./boardList2",
			type: "get",
			data: {"pageNo": 1},
			dataType: "json",
			success: function(data) {
				alert("정상입니다. :" + data);
			},
			error: function (error) {
				alert("에러가 발생했습니다. :" + error);
			}
		});
		
		
		const list = [{bno : 1, btitle : '제목입니다', m_name : '홍길동', bdate : '2023-08-02', blike : 15},{bno : 1, btitle : '제목입니다', m_name : '홍길동', bdate : '2023-08-02', blike : 15},{bno : 1, btitle : '제목입니다', m_name : '홍길동', bdate : '2023-08-02', blike : 15},{bno : 1, btitle : '제목입니다', m_name : '홍길동', bdate : '2023-08-02', blike : 15},{bno : 1, btitle : '제목입니다', m_name : '홍길동', bdate : '2023-08-02', blike : 15},{bno : 1, btitle : '제목입니다', m_name : '홍길동', bdate : '2023-08-02', blike : 15},{bno : 1, btitle : '제목입니다', m_name : '홍길동', bdate : '2023-08-02', blike : 15},{bno : 1, btitle : '제목입니다', m_name : '홍길동', bdate : '2023-08-02', blike : 15},{bno : 1, btitle : '제목입니다', m_name : '홍길동', bdate : '2023-08-02', blike : 15},{bno : 1, btitle : '제목입니다', m_name : '홍길동', bdate : '2023-08-02', blike : 15}];
		
		for(let i = 0; i < list.length; i++){
			$(".tableHead").append("<tr><td>"+list[i].bno+"</td><td>"+list[i].btitle+
				"</td><td>"+list[i].m_name+"</td><td>"+list[i].bdate+"</td><td>"+list[i].blike+"</td></tr>");		
		}
	});


</script>
</head>
<body>
<%@ include file="menu.jsp" %>
	<h1>OUR STORY</h1>
	<div class = table>
	<table class="tableHead">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>좋아요</td>
		</tr>
	
	</table>
	</div>
</body>
</html>