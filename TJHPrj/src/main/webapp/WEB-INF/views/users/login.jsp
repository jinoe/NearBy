<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<!-- jquery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
	<div
		style="display: flex; justify-content: center; align-items: center; background: #FAFAFA;">
		<div
			style="background-color: white; border: 1px solid lightgray; border-radius: 10px; width: 30%; height: auto; margin: 10%; padding: 3%; text-align: center">
			<!-- 로고 -->
			<div>
				<a href="/">
					<img id="logo" alt="no image" src="/images/logo.png" style="width: 100px; cursor:pointer;">
				</a>
			</div>
			<div style="color: gray; font-family: sans-serif; font-weight: bold;">로그인
				하세요</div>
			<hr>
			
			<!-- 회원가입 정보 -->
			<form action="login_check" method="post">
			<div class="form-floating mb-3">
				<input type="text" class="form-control" name="id"
					placeholder="name@example.com"> <label for="input_email">아이디</label>
			</div>
			
			<div class="form-floating mb-3">
				<input type="password" class="form-control" name="password"
					placeholder="name@example.com"> <label for="input_password">비밀번호</label>
			</div>
				<button type="submit" class="btn btn-primary" style="background: #B88FCC; border:1px solid #B88FCC; width: 100%;"><b>로그인</b></button>
				<br>
			</form>
			<%-- 
			<div class="otherButton text-center">
                    <span class="text-secondary">다른 계정으로 로그인</span>
			<button type ="button" class = "btn" onclick="location.href='${urlNaver}'"><img src='./images/btnG_축약형.png' style="width: 85px; height: 40px;"></button>
			<button type ="button" class = "btn" onclick="location.href='${urlKakao}'"><img src='./images/kakao_login_small.png' style="width: 85px; height: 40px;"></button>
			 </div>
			 --%>
			<hr>
			<div style="margin-top: 10px;">
				계정이 없으신가요? <a id="join" href="signup" style="text-decoration: none; color:#73536F">회원가입</a>
			</div>
		</div>

	</div>

	<script>
		if(${loginFail}){
			alert("아이디와 비밀번호가 잘못되었습니다.");
		}
/* 		$('#logo').click(function() {
			//console.log("콘솔");
			var form = $('<form></form>');
			form.attr("method", "post");
			form.attr("action", "main");
			form.appendTo('body');
			form.append($('<input type="hidden" value="clear" name=clear>'));
			form.submit();
		}); */
	
	
		/* $('#sign_in').click(function() {

			let id = $('#input_email').val();
			let password = $('#input_password').val();

			$.ajax({
				url : "login",
				data : {
					id : id,
					password : password
				},
				method : "POST",
				success : function(data) {
					//console.log("성공");
					if(data=="로그인실패"){
						alert("아이디 또는 비밀번호를 확인하세요.");
					} else {
						location.replace("main");
					}
					
				},
				error : function(request, status, error) {
					alert("아이디 또는 비밀번호를 확인하세요.")
					console.log("에러");
				},
				complete : function() {
					console.log("완료");
				}
			});
		}); */
	</script>

</body>
</html>