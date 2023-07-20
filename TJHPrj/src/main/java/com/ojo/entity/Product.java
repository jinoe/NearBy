package com.ojo.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
public class Product {

	private int idx;
	private String userId;
	private String title;
	private String content;
	private int price;
	private String gu;
	private int isTrade;
	private Date writeDate;
	private String category;
	private String filenames;
	
}
