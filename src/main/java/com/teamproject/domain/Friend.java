package com.teamproject.domain;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data @Alias("friend")
public class Friend {
	private String friend1;
	private String friend2;
	private String regdate;
	private String ignored;
	private String mess_block;
}
