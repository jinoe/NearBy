<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<!-- jquery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>로그인 페이지</title>
</head>
<body>
	<div
		style="display: flex; justify-content: center; align-items: center; background: #FAFAFA;">
		<div style="background-color: white; border: 1px solid lightgray; border-radius: 10px; width: 30%; height: auto; margin: 10%; padding: 3%; text-align: center">
			<!-- 로고 -->
			<a href="/">
				<img id="logo" alt="no image" src="/images/logo.png" style="width: 100px; cursor: pointer;">
			</a>
			
			<div style="color: gray; font-family: sans-serif; font-weight: bold;">신규
				회원가입하세요</div>
			<hr>

			<!-- 회원가입 정보 -->
			<form method="post">
				<div class="form-floating mb-3"> 
					<input type="id" id="input_id" name="id" class="form-control" onchange="duplicatedIdCheck()"> 
					<label for="input_id">아이디</label>
				</div>
				<div id="caution1"
				style="display: none; color: red; margin-bottom: 10px;"></div>
				<div class="form-floating mb-3">
					<input type="password" id="input_password" name="password" class="form-control"> 
					<label for="input_password">비밀번호</label>
				</div>
				<div class="form-floating mb-3">
					<input type="text" id="input_nickname" name="nickname" class="form-control" onchange="duplicatedNickCheck()">
					<label for="input_nickname">닉네임</label>
				</div>
				<div id="caution2"
				style="display: none; color: red; margin-bottom: 10px;">이미 사용중인 이름 입니다.</div>
				<!-- <div style="color: gray; font-family: sans-serif; font-weight: bold;">
					지역 설정</div> -->
	
				<!-- <div style="display: flex; justify-content: space-around;  margin: 10px 20px;">
					<div> -->
				<select id="gu_select" name="gu"
					class="form-control">
					<option>지역 설정</option>
					<c:forEach var="gu" items="${guList}">
						<option class="gu">${gu}</option>
					</c:forEach>
				</select>

			<hr>
			<div id="caution"
				style="display: none; color: red; margin-bottom: 10px;"></div>
			<button id="sign_up" type="submit" class="btn btn-primary" style="background: #B88FCC; border:1px solid #B88FCC">가입하기</button>
			</form>

			<div style="margin-top: 10px;">
				계정이 있으신가요? <a href="loginPage" style="text-decoration: none; color:#73536F">로그인</a>
			</div>
		</div>

	</div>

	<!-- Optional JavaScript; choose one of the two! -->

	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>

	<!-- Option 2: Separate Popper and Bootstrap JS -->
	<!--
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
-->
</body>
<script>  
	function duplicatedIdCheck() {
		const userInfo = {
			id : $('#input_id').val(),
			nickname : $('#input_nickname').val()
		}
		$.ajax({
			url : "duplicatedIdCheck",
			data : JSON.stringify(userInfo),
			contentType : "application/json",
			method : "POST",
			success : function(data) {
				console.log(data);
				if(data==1){
					$('#caution1').html("이미 사용중인 아이디 입니다.")
					$('#caution1').css("display", "block")
					$('#caution1').css("color", "red")
				}
				else if(data==0){
					$('#caution1').html("사용가능한 아이디 입니다.")
					$('#caution1').css("display", "block")
					$('#caution1').css("color", "green")
				}
			}
		});
	}
	function duplicatedNickCheck() {
		const userInfo = {
			nickname : $('#input_nickname').val()
		}
		$.ajax({
			url : "duplicatedNickCheck",
			data : JSON.stringify(userInfo),
			contentType : "application/json",
			method : "POST",
			success : function(data) {
				console.log(data);
				if(data==1){
					$('#caution2').html("이미 사용중인 닉네임 입니다.")
					$('#caution2').css("display", "block")
					$('#caution2').css("color", "red")
				}
				else if(data==0){
					$('#caution2').html("사용가능한 닉네임 입니다.")
					$('#caution2').css("display", "block")
					$('#caution2').css("color", "green")
				}
			}
		});
	}

</script>
</html>