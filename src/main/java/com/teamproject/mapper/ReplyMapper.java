package com.teamproject.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.teamproject.domain.Criteria;
import com.teamproject.domain.PageDTO;
import com.teamproject.domain.Reply;

public interface ReplyMapper {
	// 글번호에 대한 댓글 리스트
	List<Map<String, Object>> listByPostno(@Param("postno") int postno, @Param("rn") int rn);
	// 댓글 추가
	int insert(Reply vo);
	// 댓글 삭제
	int delete(int replyno);
	// 댓글 수정
	int update(Reply vo);
	
	//댓글 단일조회
	Map<String, Object> read(@Param("replyno") int replyno);
	
	//댓글 좋아요
	int insertLike(Reply vo);
	
	//댓글 좋아요 취소
	int deleteLike(Reply vo);
	
	//댓글 좋아요 했나 안했나 체크
	int getThumb(@Param("replyno") int replyno, @Param("writer") String writer);
	
	//좋아요 갯수 증감
	int updateThcount(@Param("replyno") int replyno, @Param("amount") int amount);
}