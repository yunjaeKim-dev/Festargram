package com.teamproject.service;

import java.util.List;
import java.util.Map;

import com.teamproject.domain.Message;

public interface MessageService {
	// 메시지 보내기
	boolean sendMessage(Message message);
	// 메시지 전체 삭제
	int removeAll(Map<String, String> email);
	// 메시지 선택 삭제
	boolean removeByMessno(int messno);
	// 전체 메시지 조회
	List<Message> messageList(String email);
	// 특정대상 메시지 조회
	List<Message> messageListByEmail(String sender, String receiver);
	

}
