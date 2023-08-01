<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기 GET</title>
<link rel="stylesheet" href="./css/menu-black.css">
<link rel="stylesheet" href="./css/write.css">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">


<!-- include libraries(jQuery, bootstrap) -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<div style="height: 70px; width: 100%"></div>
	<hr class="hr">
	<h1>글쓰기</h1>
	<div class="write-div">
		<form action="./write" method="post" onsubmit="return check()">
			<input type="text" name="title">
			<textarea id="summernote" name="content"></textarea>
			<button class="btn100 btn btn-primary" type="submit">글쓰기</button>
		</form>
	</div>

	<script>
		$(document).ready(function() {
			$('#summernote').summernote({
				height : 400
			});
		});

		function check() {
			let title = document.getElementById("title");
			title.value;
			title.value.length;
			if (title.value = null) {

			}

		}
	</script>
</body>
</html>