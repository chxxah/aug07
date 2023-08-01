<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHXX AH' LOGIN</title>
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="./css/menu-black.css">
<link rel="stylesheet" href="./css/login.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
	integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	//스크립트 영역
	let msg = document.getElementById("msg");// 전역변수

	function checkID() {
		msg.innerHTML = "<p>" + document.getElementById("id").value
				+ "아이디를 변경했습니다.</p>";
	}

	function check() {
		let id = document.getElementById("id");
		let msg = document.getElementById("msg");
		if (id.value.length < 4) {
			alert("아이디는 4글자 이상 입력하세요.");
			msg.innerHTML = "<p>올바른 아이디를 입력하세요.</p>";
			id.focus();
			return false;
		}

		let pw = document.getElementById("pw");
		if (pw.value.length < 4) {
			alert("패스워드는 4글자 이상 입력하세요.");
			pw.focus();
			return false;
		}
	}

	// jQuery
	$(function() {
		$(".login").click(function() {

			let id = $("#id").val();
			let pw = $("#pw").val();
			if (id.length < 3) {
				alert("아이디를 3글자 이상 입력하세요.");
				$('#id').focus();
			} else {
				if (pw.length < 3) {
					alert("비밀번호를 3글자 이상 입력하세요.");
					$('#pw').focus();
				} else {
					// 아이디하고 암호가 정확하게 입력되었을 때
					let form = $("<form></form>");
					form.attr("method", "post");
					form.attr("action", "./login");
					form.append($("<input/>", {
						type : "hidden",
						name : "id",
						value : id
					}));
					form.append($("<input/>", {
						type : "hidden",
						name : "pw",
						value : pw
					}));
					form.appendTo("body");
					form.submit();
				}
			}

		});
	});
</script>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<div style="height: 70px; width: 100%"></div>
	<hr class="hr">
	<div class=wrap>
		<div class="img_form"></div>
		<div class="login_form">
			<h1>LOGIN</h1>
			<!-- <form action="./login" method="post" onsubmit="return check()">
			</form> -->

			<input type="text" name="id" id="id" placeholder="ID"
				required="required" maxlength="20" onchange="checkID()"> <input
				type="password" name="pw" id="pw" placeholder="PW"
				required="required" maxlength="20">
			<button class="login">LOGIN</button>
			<div class="footer">
				<a>아이디 찾기</a> &nbsp; | &nbsp; <a>비밀번호 찾기</a> &nbsp; <span>|</span>
				&nbsp; <a href="./join">회원가입</a>
			</div>
		</div>
	</div>
</body>
</html>