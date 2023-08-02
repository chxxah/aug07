<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CHXX AH' JOIN</title>
<link rel="icon" href="./img/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="./css/menu-black.css">
<link rel="stylesheet" href="./css/join.css?version=0.2">
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#idCheck").click(function () {
		let id = $("#id").val();// id의 값을 뽑아내서 변수에 담음
		// console.log(id);// 콘솔은 그냥 확인용
		// console.log(id.length);
		
		// 비어있거나 4글자 미만일 경우
		if ( id == "" || id.length < 4 ) {
			$("#resultMSG").text("Please enter at least 4 characters.");
			$("#resultMSG").css("color", "#E91E63").css("font-size", "12pt");
			$("#id").css("border","2px solid #E91E63").focus();
			
		} else {// 정확히 입력했을 경우 
			$.ajax({// ajax 시작
				url : "./checkID",// post-mapping의 checkID
				type : "post",
				data : {"id" : id},// 값으로 id
				dataType : "json", // json형태 : {result : 0}
				success : function(data){// 성공했을 경우
					// 서버에서 날라오는 data
					// alert(data.result); = 오는 데이터에서 result만 뽑겠습니다. 라는 뜻
					if (data.result == 1) {// 이미 등록된 아이디일 경우
						$("#resultMSG").text("This username is already taken.").css("color", "#E91E63").css("font-size", "12pt");
						$("#id").css("border","2px solid #E91E63").focus();
						
					} else {// 가입할 수 있는 경우
						$("#resultMSG").text("This username is available.").css("color", "#424242").css("font-size", "12pt").css("font-weight", "border");
						$("#id").css("border","1px solid black").css("background-color","#E8F0FE");
					}
				},
				error : function (request, status, error){// 실패했을 경우
					// 에러는 기본적으로 3가지 종류가 있음 : request, status, error
					$("#resultMSG").text("Sorry, there was an error with your registration.").css("color", "#E91E63").css("font-size", "12pt");
				}

			});
		}
		return false;// 더 이상 진행을 멈춤
	});
	
});

</script>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<div style="height: 70px; width: 100%"></div>
	<hr class="hr">
	<div class="join">
		<h1>USER REGISTRATION</h1>
		<div class="text">
			PLEASE ENTER YOUR PERSONAL<BR> INFORMATION BELOW TO SIGN UP.
		</div>
		
		<hr style="border: 3px solid #EC87C0; margin: 0px 300px 50px 300px;">
		
		<div class="title">
			<form action="./join" method="post">
			ID<br><input type="text" name="id" id="id"> 
			<button id ="idCheck">DUPLICATE<br>CHECK</button>
			<span id ="resultMSG"></span>
			<br><br><br>
			PASSWORD<br><input type="password" name="pw1">
			<br><br><br>
			VERIFY PASSWORD<br><input type="password" name="pw2">
			<br><br><br>
			NAME<br><input type="text" name="name">
			<br><br><br>
			GENDER<br>
			 <div class="select">
            <input type="radio" id="select" name="gender" value="1">
            <label for="select">MALE</label> 
            <input type="radio" id="select2" name="gender" value="0">
            <label for="select2">FEMALE</label>
         	</div>
			<br><br>
			ADDRESS<br><input type="text" name="addr"> 
			<br><br><br>
			BIRTH DATE<br><input type="date" name="birth">
			<br><br><br>
			MBTI<br>
			<div class="mbti">
               <select class="mb" name="mbti" id="mbti">
               <option value="CHOOESE">SELECT ONE</option>
                  <option value="ISTJ">ISTJ</option>
                  <option value="ISFJ">ISFJ</option>
                  <option value="INFJ">INFJ</option>
                  <option value="INTJ">INTJ</option>
                  <option value="ISTP">ISTP</option>
                  <option value="ISFP">ISFP</option>
                  <option value="INFP">INFP</option>
                  <option value="INTP">INTP</option>
                  <option value="ESTP">ESTP</option>
                  <option value="ESFP">ESFP</option>
                  <option value="ENFP">ENFP</option>
                  <option value="ENTP">ENTP</option>
                  <option value="ESTJ">ESTJ</option>
                  <option value="ESFJ">ESFJ</option>
                  <option value="ENFJ">ENFJ</option>
                  <option value="ENTJ">ENTJ</option>
               </select>
               </div>
            <br><br>
			 <div class="btt">
				 <button type="reset" class="cancel">CANCEL</button>
           	  <button type="submit" class="signup">SIGN UP</button>
         	</div>
			</form>
		</div>
	</div>
	<div style="height: 100px;"></div>
</body>
</html>