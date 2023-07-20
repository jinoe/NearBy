package com.ojo.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ojo.dao.MainDao;
import com.ojo.entity.Member;
import com.ojo.entity.Product;

public class IndexService {
	
	@Autowired
	SqlSession sqlSession;
	
	public List<String> getGuList() {
		MainDao dao =  sqlSession.getMapper(MainDao.class);
		return dao.getGuList();
	}
	
	public Member getMember(String userId) {
		Member member = sqlSession.selectOne("com.ojo.dao.MainDao.getMember",userId);
		return member;
	}
	
	public List<Product> getProducts(String gu){
		return getProducts(gu, "", "", 1);
	}

	public List<Product> getProducts(String gu, String query, String category, int page){
		if(gu.equals("전체")) gu = "";
		HashMap<String, String> hmap = new HashMap<>();
		hmap.put("gu",gu);
		hmap.put("query",query);
		hmap.put("category", category);
		
		int start = (page-1)*25+1;
		int end = page * 25;
		hmap.put("start", Integer.toString(start));
		hmap.put("end", Integer.toString(end));
		
		List<Product> productList = sqlSession.selectList("com.ojo.dao.MainDao.getNewProducts", hmap);
		return productList;
	}
	
	public List<Product> getUserProducts(String userId){
		List<Product> productList = sqlSession.selectList("com.ojo.dao.ProductDao.getUserProducts",userId);
		return productList;
	}
}
