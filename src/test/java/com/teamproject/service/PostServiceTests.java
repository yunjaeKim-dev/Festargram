package com.teamproject.service;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.Post;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class PostServiceTests {
	@Setter @Autowired
	private PostService service;
	
	@Test
	public void getListTest() {
		log.info("service.....getListTest");
		service.getPostList().forEach(log::info);
	}
	// post 단일조회
	@Test
	public void getPostTest() {
		log.info("service ........getPostTest");
		log.info(service.getPost(99999));
	}
	// post 등록
	@Test 
	public void addPostTest() {
		log.info("service......addPostTest");
		Post post = new Post();
		post.setWriter(5);
		post.setOwner(5);
		post.setContent("serviceAddTest");
		Map<String, Object> map = service.registerPost(post);
		for(Map.Entry<String, Object> entry : map.entrySet()) {
			log.info(entry.getKey() + "::" + entry.getValue());
		}
	}
	
	// post수정
	@Test
	public void modifyPostTests() {
		log.info("service....modifyPostTest");
		Post post = new Post();
		post.setPostno(203);
		post.setWriter(5);
		post.setOwner(5);
		post.setContent("serviceModifyTest");
		service.modifyPost(post);
		
	}
	// post 삭제
	@Test
	public void deletePostTest() {
		log.info("service.......deletePostTest");
		if(service.removePost(99999)) {
			log.info("삭제성공");
		}else{
			log.info("삭제실패");
		};
	}
	
	// 마이페이지의 owner의 타임라인list get (paging) (테스트완료)
	@Test
	public void testgetMyPageTimeLine() {
		log.info("service Tests testgetMyPageTimeLine...");
		List<Map<String, Object>> list = service.getMyPageTimeLine(9999, 99,999);
		for(Map<String, Object> map : list) {
			Object o = map.get("attachList");
//				log.info(o);
			if(o instanceof List) {
				log.info("야" + ((List)o).size());
			}
		}
	}
	// 뉴스피드 리스트 
	@Test
	public void getNewsfeedTests() {
		log.info("service Tests getNewsfeedTests...");
		List<Map<String, Object>> list = service.getNewsfeed(42, 0);
		list.forEach(log::info);
	}
	
	// post 좋아요 테스트
	@Test
	public void updatePostGoodTests() {
		log.info("service Tests.............");
		if(service.modifyThcount(216, 42)) {
			log.info("좋아요 마이너스");
			service.getPost(216).get("thcount");
		}else {
			log.info("좋아요 플러스");
			service.getPost(216).get("thcount");
		}
	}
	
}
