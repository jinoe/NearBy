package com.ojo.dao;

import java.util.HashMap;
import java.util.List;

import com.ojo.entity.Member;
import com.ojo.entity.Product;

public interface MainDao {
	public List<String> getGuList();
	public Member getMember(String userId);
	public List<Product> getNewProducts(HashMap<String, String> hmap);
}
