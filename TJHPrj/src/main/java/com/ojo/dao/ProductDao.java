package com.ojo.dao;

import java.util.HashMap;
import java.util.List;

import com.ojo.entity.Product;

public interface ProductDao {
	public int createProduct(Product product);
	public int getProductsCount(HashMap<String, String> hmap);
	public Product getProduct(int idx);
	public List<Product> getUserProducts();
}
