package com.teamproject.mapper;

import java.util.List;
import java.util.Map;

import com.teamproject.domain.Message;

public interface MessageMapper {
	// CRUD
	
	// 메시지 보내기
	int insertR(Message message);
	int insertS(Message message);
	
	// 대상 친구와 메시지 조회
	List<Message> selectByEmail(Map<String, String> user);
	
	// 나의 전체 메시지 조회
	List<Message> selectAll(String email);
	
	// 메시지 단일 삭제
	int deleteS(int messno);
	int deleteR(int messno);
	
	// 메시지 전체 삭제
	int deleteAllS(Map<String, String> user);
	int deleteAllR(Map<String, String> user);
}
