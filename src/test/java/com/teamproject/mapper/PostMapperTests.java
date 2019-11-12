package com.teamproject.mapper;

import static org.hamcrest.CoreMatchers.instanceOf;
import static org.junit.Assert.assertNotNull;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.AttachFile;
import com.teamproject.domain.Criteria;
import com.teamproject.domain.Post;
import com.teamproject.mapper.PostMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/security-context.xml",
"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class PostMapperTests {
	@Setter @Autowired
	private PostMapper postMapper;
	
	@Test
	public void postMapperExist() {
		log.info(postMapper);
		assertNotNull(postMapper);
	}
	
	@Test
	public void testGetList() {
		log.info("mapper GetList.................");
		postMapper.getPostList().forEach(log::info);
	}
	
	@Test
	public void testGetPost() {
		log.info("mapper GetPost.................");
		log.info(postMapper.getPost(83));
	}
	
	@Test
	public void testInsert() {
		log.info("mapper Insert.................");
		Post post = new Post();
		post.setWriter(5);
		post.setOwner(5);
		post.setContent("mapperTest");
		postMapper.insertPost(post);
	}
	
	@Test
	public void testInsertSelectKey() {
		log.info("mapper InsertSelectKey................");
		Post post = new Post();
		post.setWriter(5);
		post.setOwner(5);
		post.setContent("mapperSelectKeyTest");
		postMapper.insertSelectKeyPost(post);
		log.info(post.getPostno());
	}
	
	@Test
	public void testUpdate() {
		log.info("mapper UPDATE.................");
		Post post = new Post();
		post.setPostno(57);
		post.setWriter(5);
		post.setOwner(5);
		post.setContent("mapperUpdateTest");
		postMapper.updatePost(post);
		
		log.info("UPDATE COUNT :: " + postMapper.updatePost(post));
	}

	@Test
	public void testDelete() {
		log.info("mapper DELETE.................");
		log.info("아 왜안대!");
		postMapper.deletePost(44);
	}
	
	
	// 마이페이지의 owner의 타임라인list get (paging) (테스트완료)
	@Test
	public void testgetMyPageTimeLine() {
		log.info("mapper testgetMyPageTimeLine...");
		List<Map<String, Object>> list = postMapper.getMyPageTimeLine(42, 0,42);
		for(Map<String, Object> map : list) {
			Object o = map.get("attachList");
//			log.info(o);
			if(o instanceof List) {
				log.info("야" + ((List)o).size());
			}
		}
	}
	
	@Test
	public void getNewsfeedTests() {
		log.info("mapper testgetMyPageTimeLine...");
		List<Map<String, Object>> list = postMapper.getNewsfeed(42, 0);
		for(Map<String, Object> map : list) {
			Object o = map.get("attachList");
//			log.info(o);
			if(o instanceof List) {
				log.info("야" + ((List)o).size());
			}
		}
	}
	
	@Test
	public void updatePostGoodTests() {
		log.info("mapper updatePostGoodTests...");
		if(postMapper.updatePostGood(220, -1) > 0) {
			log.info("성공");
		}else {
			log.info("실패");
		}
	}
	@Test
	public void insertPostGoodTests() {
		log.info("mapper insertPostGoodTests...");
		if(postMapper.insertPostGood(220, 42) > 0) {
			log.info("성공");
		}else {
			log.info("실패");
		}
	}
	@Test
	public void deletePostGoodTests() {
		log.info("mapper deletePostGoodTests...");
		if(postMapper.deletePostGood(220, 42) > 0) {
			log.info("성공");
		}else {
			log.info("실패");
		}
		
	}
	
	@Test
	public void isPostGoodTests() {
		log.info("mapper isPostGood Tests....");
		if(postMapper.isPostGood(220, 42) > 0) {
			log.info("좋아요 이미했음");
		}else {
			log.info("좋아요 안했음");
		}
	}
	
	
	
	// 댓글등록시 리플갯수증가시킬 mapper (테스트완료)
	@Test
	public void updateReplyCntTests() {
		log.info("mapper updateReplyCntTests...");
		postMapper.updateReplyCnt(51,1);
	}
	
}
