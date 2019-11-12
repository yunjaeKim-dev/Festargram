package com.teamproject.service;

import java.util.List;
import java.util.Map;

import com.teamproject.domain.Criteria;
import com.teamproject.domain.Post;

public interface PostService {
	/*포스트등록*/
	Map<String, Object> registerPost(Post vo);
	/*포스트 get*/
	Map<String, Object> getPost(Integer postno);
	/*포스트 삭제*/
	boolean removePost(Integer postno);
	/*포스트 수정*/
	Map<String, Object> modifyPost(Post vo);
	
	/*포스트 리스트*/
	List<Map<String, Object>> getPostList();
	// 마이페이지 타임라인 리스트
	List<Map<String, Object>> getMyPageTimeLine(int mno, int postRn, int sessionno) ;
	// 로그인된유저 뉴스피드
	List<Map<String, Object>> getNewsfeed(int mno, int postRn) ;
	
	// 좋아요 , 좋아요되있는지여부에따라 +1 혹은 -1 
	boolean modifyThcount(int postno, int mno);
	
}
