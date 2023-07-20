package com.ojo.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ojo.dao.UserDao;
import com.ojo.entity.CharRoomView;
import com.ojo.entity.Chat;
import com.ojo.entity.ChatRoom;
import com.ojo.entity.Member;
import com.ojo.entity.Product;

@Service
public class UserService extends IndexService{

	@Autowired
	SqlSession sqlSession;

	public List<String> getGuList() {
		List<String> list = sqlSession.selectList("com.ojo.dao.MainDao.getGuList");
		return list;
	}
	
	public Member userCheck(Member member) {
		Member result = sqlSession.selectOne("com.ojo.dao.UserDao.userCheck",member);
		return result;
	}
	
	public int createUser(Member member) {
		int result = sqlSession.insert("com.ojo.dao.UserDao.createUser", member);
		return result;
	}
	public int duplicatedIdCheck(Member member) {
		Member idCheck = sqlSession.selectOne("com.ojo.dao.UserDao.duplicatedIdCheck", member);
		if(idCheck!=null)
			return 1;
		else
			return 0;
	}
	public int duplicatedNickCheck(Member member) {
		Member nickCheck = sqlSession.selectOne("com.ojo.dao.UserDao.duplicatedNickCheck", member);
		if(nickCheck!=null)
			return 1;
		else
			return 0;
	}
	public List<Product> getUserProducts(String userId, int page){
		HashMap<String, String> hmap = new HashMap<>();
		hmap.put("userId", userId);
		int	start = (page-1)*12 + 1;
		int end = page * 12;
		hmap.put("start", Integer.toString(start));
		hmap.put("end", Integer.toString(end));
		List<Product> productList = sqlSession.selectList("com.ojo.dao.UserDao.getUserProducts",hmap);
		return productList;
	}
	public int getProductCount(String userId) {
		int count = sqlSession.selectOne("com.ojo.dao.UserDao.getProductCount", userId);
		return count;
	}
	public List<Chat> getChatList(int roomIdx){
		List<Chat> chatList = sqlSession.selectList("com.ojo.dao.UserDao.getChatList", roomIdx);
		return chatList;
	}
	public int addChatting(HashMap<String, Object> hmap) {
		int result2 = sqlSession.update("com.ojo.dao.UserDao.updateRoomTime", Integer.parseInt((String)hmap.get("roomIdx")));
		int result1 = sqlSession.insert("com.ojo.dao.UserDao.addChatting", hmap);
		return (result1==1 && result2==1)?1:0;
	}
	public List<CharRoomView> getRoomList(String nickname){
		List<CharRoomView> roomList = sqlSession.selectList("com.ojo.dao.UserDao.getRoomListByNick", nickname);
		return roomList;
	}
}
