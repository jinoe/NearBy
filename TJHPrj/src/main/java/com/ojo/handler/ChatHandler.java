package com.ojo.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

public class ChatHandler extends TextWebSocketHandler{
	
	private List<Map<String, Object>> sessionList = new ArrayList<>();
//	private List<WebSocketSession> sessionList = new ArrayList<>();
	private ObjectMapper objectMapper = new ObjectMapper();
	
	// session 은 [id, uri] 의 형태로 되어있다.
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Map<String, String> data = objectMapper.readValue(message.getPayload(), Map.class);
		
		switch (data.get("cmd")) {
		
		case "enter":
			boolean notfoundsession = true;
			for(Map<String, Object> hmap : sessionList) {
				if(hmap.get("session") == session) {
					notfoundsession = false;
					// 기본 채팅방에서 다른 채팅방에 접속시 roomIdx 업데이트
					if(hmap.get("roomIdx")!=data.get("roomIdx")) {
						hmap.put("roomIdx", data.get("roomIdx"));
					}
				}
			}
			
			if(notfoundsession) {
				Map<String, Object> newSession = new HashMap<>();
				newSession.put("roomIdx",data.get("roomIdx"));
				newSession.put("nickname", data.get("nickname"));
				newSession.put("session", session);
				sessionList.add(newSession);
			}
			break;
			
		case "send":
			for(Map<String, Object> s : sessionList) {
				if(s.get("roomIdx").equals(data.get("roomIdx"))) {
					WebSocketSession destination = (WebSocketSession) s.get("session");
					destination.sendMessage(message);
				}
			}
			break;
		default:
			break;
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		Iterator<Map<String,Object>> _sessionList = sessionList.iterator();
		while(_sessionList.hasNext()) {
			if(_sessionList.next().get("session") == session) {
				_sessionList.remove();
				break;
			}
		}
	}
}
