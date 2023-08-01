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
	$('#idCheck').click(function() {
		let id = $("#id").val();
		if (id == "" || id.length < 3) {
			$("#resultMSG").text("아이디는 5글자 이상이어야 합니다.");
			$("#resultMSG").css("color","#A1887F");
			$("#id").focus();
			
		} else {
			$.ajax({
				url: "./checkID",
				type: "post",
				data: {"id": id},
				dataType: "html",
				success: function (data){
					$("#resultMSG").text("data : " + data);
				},
				error: function(request, status, error){
					$("#resultMSG").text("error : " + error);
					console.log(error);
				}
			});
			
			$("#resultMSG").text("사용 가능한 ID입니다.");
			$("#resultMSG").css("color","black");
		}
		return false;
		
		let pw = $("#pw").val();
		
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