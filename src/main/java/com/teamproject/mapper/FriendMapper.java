package com.teamproject.mapper;

import java.util.List;
import java.util.Map;

import com.teamproject.domain.Friend;

public interface FriendMapper {
	// 친구 추가
	int insert1(Map<String, String> friend);
	int insert2(Map<String, String> friend);
	// 친구 목록 불러오기
	List<Friend> select(String email);
	// 친구 한명만 불러오기
	List<Friend> selectByEmail(Map<String,String> friend);
	// 친구 목록에서 사제
	void delete1(Map<String, String> friend);
	void delete2(Map<String, String> friend);
	// 친구 단일 삭제
	void ignore(Map<String, String> friend);
	// 친구 단일 삭제 복원
	void restore(Map<String, String> friend);
}
