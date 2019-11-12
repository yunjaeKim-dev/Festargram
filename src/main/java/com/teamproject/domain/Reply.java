package com.teamproject.domain;

import org.apache.ibatis.type.Alias;
import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data @Alias("reply")
public class Reply {
	private int replyno;
	private int postno;
	private String writer;
	private String regdate;
	private String moddate;
	private Integer parentno;
	private String content;
	private int thcount;
	
}