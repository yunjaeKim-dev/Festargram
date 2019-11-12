package com.teamproject.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Alias("message") @AllArgsConstructor @NoArgsConstructor
public class Message {
	// 메시지 고유 번호
	private int messno;
	// 로그인한 유저
	private String sender;
	// 대화 상대
	private String receiver;
	private String profimg;
	private String content;
	private String regdate;
	// 1 : 받은 메시지, 2 : 보낸 메시지
	private String type;
}
