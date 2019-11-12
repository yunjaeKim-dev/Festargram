package com.teamproject.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.teamproject.domain.Criteria;
import com.teamproject.domain.PageDTO;
import com.teamproject.domain.Reply;

public interface ReplyService {
	// 댓글 등록
	int add(Reply vo);
	// 댓글 삭제
	int remove(int replyno);
	// 댓글 수정
	int modify(Reply vo);
	// 댓글 목록
	List<Map<String, Object>> list(int postno, int rn);
	
	//댓글 단일 조회
	Map<String, Object> get(int replyno);
	
	
	// 댓글 좋아요 증감
	boolean modifyThcount(Reply vo);
	
}