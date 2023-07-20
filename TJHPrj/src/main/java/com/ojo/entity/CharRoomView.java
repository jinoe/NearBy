package com.ojo.entity;

import java.util.Date;

import lombok.Data;

@Data
public class CharRoomView {
	private String title;
	private String filenames;
	private int idx;
	private int productIdx;
	private String sellerNick;
	private String purchaserNick;
	private Date lastUpdate;
}
