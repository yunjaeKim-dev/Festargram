package com.teamproject.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.teamproject.domain.Criteria;
import com.teamproject.domain.Post;

public interface PostMapper {
	// 모든Post
	List<Map<String, Object>> getPostList();
	// 마이페이지 타임라인
	List<Map<String, Object>> getMyPageTimeLine(@Param("mno") int mno, @Param("postRn") int postRn, @Param("sessionno") int sessionno) ;
	// 로그인된유저 뉴스피드
	List<Map<String, Object>> getNewsfeed(@Param("mno") int mno, @Param("postRn") int postRn) ;
	// post 단일조회
	Map<String, Object> getPost(Integer postno);
	// post 등록
	int insertPost(Post vo);
	// post 등록
	int insertSelectKeyPost(Post vo);
	// post 삭제
	int deletePost(Integer postno);
	// post 수정
	int updatePost(Post vo);
	// 댓글수 증가
	void updateReplyCnt(@Param("postno") int postno , @Param("amount") int amount);
	// post 좋아요 
	int updatePostGood(@Param("postno") int postno , @Param("amount") int amount);
	// 좋아요 테이블 insert
	int insertPostGood(@Param("postno") int postno , @Param("mno") int mno);
	// 좋아요 테이블 delete 
	int deletePostGood(@Param("postno") int postno , @Param("mno") int mno);
	// 해당게시글 좋아요했는지 확인
	int isPostGood(@Param("postno") int postno , @Param("mno") int mno);
}
