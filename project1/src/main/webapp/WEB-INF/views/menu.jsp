<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav>
	<div class="header">
		<div class="head_left">
			<img alt="" src="./img/chxx.png"> &nbsp; <span class="ch"><a href='./index'>CHXX AH</a></span>
		</div>
		<div class="head_center">
			<ul>
				<li onclick="link('board')"><span class="list1">BOARD</span></li>
				<li onclick="link('ourstory')"><span class="list2">OUR
						STORY</span></li>
				<li onclick="link('notice')"><span class="list3">NOTICE</span></li>
				<li onclick="link('contact')"><span class="list4">CONTACT</span></li>
				<li onclick="link('members')"><span class="list5">LIST</span></li>
			</ul>
		</div>

		<div class="head_right">
		<c:choose>
			<c:when test="${sessionScope.mname eq null}">
				<li class= "box_login" onclick="link('join')"><span class="list6">SIGN UP</span></li>
				&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
				<li class= "box_login" onclick="link('login')"><span class="list6">LOGIN</span></li>
			</c:when>
			<c:otherwise>
				<li class= "box_id" onclick="link('myInfo')"><span class="list6">${sessionScope.mid }  
						</span></li> 
						&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
				<li class= "box_logout" onclick="link('logout')"><span class="list6">LOGOUT</span></li>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
</nav>
<script>
	function link(url) {
		location.href = "./" + url;
	}
</script>