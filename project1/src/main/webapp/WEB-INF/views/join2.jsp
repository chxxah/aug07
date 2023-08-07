<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="./css/menu-white.css">
<link rel="stylesheet" href="./css/board.css">
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<script type="text/javascript">
	var xhr = new XMLHttpRequest();// 객체 생성
	//xhr.setRequestHeader('content-type', 'application/json');

	function checkID() {
		let id = document.getElementById("id");
		if (id.value == "" || id.value.length < 4) {
			document.getElementById("resultMSG").innerHTML = "아이디 입력!";
			id.focus();
		}
		//요청을 초기화하면서 요청 방식, 주소, 동기화 여부 지정
		xhr.open("POST", "./checkID2?id=" + id.value, true);
		xhr.onreadystatechange = viewMessage;
		xhr.send();
		return false;
	}

	function viewMessage() {
		if (xhr.readyState == 4) {
			if (xhr.status == 200) {
				var str = xhr.responseText;
				if (str == 1) {
					str = "이미 가입되어 있습니다.";
					document.getElementById("resultMSG").style.color = "red";//색변경
				} else {
					str = "가입할 수 있습니다. 계속 진행하세요.";
					document.getElementById("resultMSG").style.color = "green"; //색변경
				}
				document.getElementById("resultMSG").innerHTML = str;
			}
		} else {
			document.getElementById("resultMSG").innerHTML = "에러가 발생했습니다. 다시 시도하세요.";
		}

		return false;
	}
</script>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<div class="join-div">
		<form action="./join" method="post" onsubmit="return false">
			<h1>회원가입2</h1>
			<hr>
			<div class="label-row">
				<div class="label-name">아이디</div>
				<div class="label-in">
					<input type="text" name="id" id="id">
					<button id="idCheck" onclick="return checkID();">중복검사</button>
				</div>
			</div>
			<div class="label-row" style="height: 40px" id="resultForm">
				<div class="label-name"></div>
				<div class="label-in">
					<span id="resultMSG"></span>
				</div>
			</div>
			<div class="label-row">
				<div class="label-name">비밀번호</div>
				<div class="label-in">
					<input type="password" name="pw1"> <input type="password"
						name="pw2">
				</div>
			</div>
			<div class="label-row">
				<div class="label-name">이 름</div>
				<div class="label-in">
					<input type="text" name="name">
				</div>
			</div>
			<div class="label-row">
				<div class="label-name">주 소</div>
				<div class="label-in">
					<input type="text" name="addr">
				</div>
			</div>
			<div class="label-row">
				<div class="label-name">MBTI</div>
				<div class="label-in">
					<select name="mbti">
						<option value="0">선택하세요</option>
						<optgroup label="내향형">
							<option value="ISTJ">ISTJ</option>
							<option value="ISTP">ISTP</option>
							<option value="ISFJ">ISFJ</option>
							<option value="ISFP">ISFP</option>
							<option value="INTJ">INTJ</option>
							<option value="INTP">INTP</option>
							<option value="INFJ">INFJ</option>
							<option value="INFP">INFP</option>
						</optgroup>
						<optgroup label="외향형">
							<option value="ESTJ">ESTJ</option>
							<option value="ESTP">ESTP</option>
							<option value="ESFJ">ESFJ</option>
							<option value="ESFP">ESFP</option>
							<option value="ENTJ">ENTJ</option>
							<option value="ENTP">ENTP</option>
							<option value="ENFJ">ENFJ</option>
							<option value="ENFP">ENFP</option>
						</optgroup>
					</select>
				</div>
			</div>
			<div class="label-row">
				<div class="label-name">생년월일</div>
				<div class="label-in">
					<input type="date" name="birth">
				</div>
			</div>
			<div class="label-row">
				<div class="label-name">성별</div>
				<div class="label-in">
					<input type="radio" name="gender" id="m" value="1"> <label
						for="m">남자</label> <input type="radio" name="gender" id="f"
						value="0"> <label for="f">여자</label>
				</div>
			</div>
			<hr>
			<div class="label-row lrbtn">
				<button type="reset">취소</button>
				<button type="submit">가입하기</button>
			</div>
		</form>
	</div>





</body>
</html>