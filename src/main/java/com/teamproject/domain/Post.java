package com.teamproject.domain;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data @Alias("post")
public class Post {
	private Integer postno;
	private Integer writer;
	private Integer owner;
	private Integer thcount;
	private String content;
	private String regdate;
	private String moddate;
	private String recdate;
	private String scope;
	private Integer parentno;
	
	private Integer replyCnt ;
	
	private List<AttachFile> attachList ;
	
}
