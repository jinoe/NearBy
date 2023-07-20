package com.ojo.entity;

import java.util.Date;

import lombok.Data;
import lombok.ToString;

@Data
public class Member {
	
	private String id;
	private String password;
	private String nickname;
	private String content;
	private String gu;
	private Date opendate;
	private String profileImage;
	
}