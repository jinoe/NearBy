package com.ojo.dao;

import java.util.HashMap;
import java.util.List;

import com.ojo.entity.CharRoomView;
import com.ojo.entity.Chat;
import com.ojo.entity.ChatRoom;
import com.ojo.entity.Member;
import com.ojo.entity.Product;

public interface UserDao {
	public Member userCheck(Member member);
	public int createUser(Member member);
	public Member duplicatedIdCheck(Member member);
	public Member duplicatedNickCheck(Member member);
	public List<Product> getUserProducts(HashMap<String, String> hmap);
	public int getProductCount(String userId);
	public List<Chat> getChatList(int roomIdx);
	public int addChatting(HashMap<String, Object> hmap);
	public int updateRoomTime(int roomIdx);
	public List<CharRoomView> getRoomListByNick(String nickname);
}
