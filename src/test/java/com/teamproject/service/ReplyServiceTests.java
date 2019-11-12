package com.teamproject.service;

import static org.junit.Assert.assertNotNull;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.Criteria;
import com.teamproject.domain.PageDTO;
import com.teamproject.domain.Reply;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/security-context.xml",
"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
public class ReplyServiceTests {
	@Setter @Autowired
	private ReplyService service;
	
	@Test
	public void testExist() {
		log.info("testExist");
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void addTest() { // 댓글 추가 테스트
		Reply vo = new Reply();
		vo.setPostno(500);
		vo.setWriter("test20@test20.test");
		vo.setContent("테스트 댓글1");
		service.add(vo);
	}
	
	@Test
	public void removeTest() { // 댓글 삭제 테스트
		service.remove(5000);
	}
	
	@Test
	public void modifyTest() { // 댓글 수정 테스트
		Reply vo = new Reply();
		vo.setContent("댓글 수정 테스트12");
		vo.setReplyno(85);
		service.modify(vo);
	}
	
	@Test
	public void listTest() { // 댓글 목록 불러오기 테스트
		service.list(500, 0).forEach(log::info);;
	}
	
	@Test
	public void testGet() { // 댓글 단일 조회 테스트
		log.info(service.get(3000));
	}
	
	
	@Test
	public void testmodifyThcount() { // 댓글 좋아요 조회
		log.info("thcount test........");
		Reply vo = new Reply();
		vo.setReplyno(827);
		vo.setWriter("test19@test.test");
		log.info(service.modifyThcount(vo));
	}
}