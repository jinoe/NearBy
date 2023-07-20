<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- sock JS -->
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- JQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<link rel="stylesheet" href="/css/chat.css">
</head>
<body>

	<div class="main">
		<div class="chat_wrap">
			<div class="header">CHAT</div>
			<div class="chat">
				<ul>
					<!-- 동적 생성 -->
				</ul>
			</div>
			<div class="input-div">
				<textarea placeholder="메세지 입력"></textarea>
			</div>

			<!-- format -->

			<div class="chat format">
				<ul>
					<li>
						<div class="sender">
							<span></span>
						</div>
						<div class="message">
							<span></span>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div class="chatList">
			<div class="header">채팅방 목록</div>
			<div class="chat-items">
				<ul>
					<c:forEach var="room" items="${roomList}">
						<li roomIdx="${room.idx}">
							<div>
								<div class="roomNick">${(room.purchaserNick==member.nickname)?room.sellerNick:room.purchaserNick}</div>
								<div class="roomTitle">${room.title}</div>
							</div> <img src="/uploadImages/${fn:split(room.filenames,' ')[0]}">
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>



</body>
<script type="text/javascript">
	var sock = new SockJS('http://localhost:8080/users/chat');
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	sock.onopen = onOpen;

	function onOpen(evt) {
		//sendMessage("1", "${member.nickname}", "","enter");
	}

	function onMessage(msg) {
		var data = JSON.parse(msg.data)
		let chatLi = createChat(data.nickname, data.msg);
		// 메세지 추가
		$('div.chat:not(.format) ul').append(chatLi);
		// 스크롤바 아래 고정
		$('.chat ul').scrollTop($('.chat ul').prop('scrollHeight'));
	}

	function onClose(evt) {

	}

	$(".chat-items ul li").on(
			"click",
			function(e) {
				var roomIdx = $(this).attr("roomIdx");
				// 입장 메세지 보내기
				//sendMessage("${member.nickname}", "","out");
				sendMessage(roomIdx, "${member.nickname}", "", "enter");
				// textarea에 채팅방 번호 붙이기 (전송시 DB에 출력하기 위해)
				$("div.input-div textarea").attr("roomIdx", roomIdx);
				var data = {
					'roomIdx' : roomIdx
				}
				$.ajax({
					type : "GET",
					url : "/users/chat/chatting?roomIdx=" + roomIdx,
					dataType : "json",
					success : function(result) {
						clearUl();
						/* 이전 대화기록 가져오기 */
						for (var i = 0; i < result.length; i++) {
							data = result[i];
							let chatLi = createChat(data.sender, data.content);
							$('div.chat:not(.format) ul').append(chatLi);
							$('.chat ul').scrollTop(
									$('.chat ul').prop('scrollHeight'));
						}
					}
				});

			});

	function sendMessage(roomIdx, nickname, msg, cmd) {
		var data = {
			roomIdx : roomIdx,
			nickname : nickname,
			msg : msg,
			cmd : cmd
		}
		var jsonData = JSON.stringify(data);
		sock.send(jsonData);
	}

	$(document).on('keydown', 'div.input-div textarea', function(e) {
		if (e.keyCode == 13 && !e.shiftKey && $(this).val().trim() != "") {
			e.preventDefault();
			if ($(this).attr("roomIdx") != null) {
				var roomIdx = $(this).attr("roomIdx");
				const message = $(this).val();
				// 메시지 전송
				sendMessage(roomIdx, "${member.nickname}", message, "send");
				// 입력창 clear
				clearTextarea();
				// DB에 저장
				var chat = {
					'roomIdx' : roomIdx,
					'nickname' : "${member.nickname}",
					'msg' : message
				}
				$.ajax({
					type : "POST",
					url : "/users/chat/chatting",
					data : JSON.stringify(chat),
					contentType : "application/json"
				});
			}
		}
	});

	function createChat(nickname, msg) {
		// 형식 가져오기
		let chatLi = $('div.chat.format ul li').clone();

		// 값 채우기
		if (nickname != "") {
			if (nickname != "${member.nickname}")
				chatLi.addClass("left");
			else
				chatLi.addClass("right");
		}
		chatLi.find('.sender span').text(nickname);
		chatLi.find('.message span').text(msg);

		return chatLi;
	}

	// 메세지 입력박스 내용 지우기
	function clearTextarea() {
		$('div.input-div textarea').val('');
	}
	function clearUl() {
		var ul = document.querySelector(".chat").getElementsByTagName("ul")[0];
		ul.innerHTML = "";
	}
</script>
</html>