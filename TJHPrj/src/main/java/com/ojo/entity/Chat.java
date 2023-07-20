package com.ojo.entity;

import java.util.Date;

import lombok.Data;

@Data
public class Chat {
	private int idx;
	private int roomIdx;
	private String sender;
	private Date writeTime;
	private String content;
	private int read_chk;
}
