package com.ojo.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ojo.entity.Product;

@Service
public class ProductService extends IndexService {

	@Autowired
	SqlSession sqlSession;
	
	public int createProduct(Product product) {
		int result = sqlSession.insert("com.ojo.dao.ProductDao.createProduct", product);
		return result;
	}
	public int getProductsCount(String gu, String query, String category) {
		if(gu.equals("전체")) gu = "";
		HashMap<String, String> hmap = new HashMap<>();
		hmap.put("gu",gu);
		hmap.put("query",query);
		hmap.put("category", category);
		int productCount = sqlSession.selectOne("com.ojo.dao.ProductDao.getProductsCount",hmap);
		return productCount; 
	}
	public Product getProduct(int idx) {
		Product product = sqlSession.selectOne("com.ojo.dao.ProductDao.getProduct",idx);
		return product;
	}
}
