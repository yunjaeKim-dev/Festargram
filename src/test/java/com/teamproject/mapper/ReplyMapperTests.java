package com.teamproject.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.Criteria;
import com.teamproject.domain.PageDTO;
import com.teamproject.domain.Reply;
import com.teamproject.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/security-context.xml",
"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
public class ReplyMapperTests {
	@Setter @Autowired
	private ReplyMapper replyMapper;
	
	
	@Test
	public void replyMapperExist() { // 매핑이 잘 되었는지 체크
		log.info("잘된다! :: "+replyMapper);
	}
	
	@Test
	public void testReplyList() { // 해당 글(14)에 대한 댓글 목록 조회 테스트
		log.info("댓글 조회...");
		replyMapper.listByPostno(14, 0).forEach(log::info);
	}
	
	
	@Test
	public void testReplyInsert() { // 댓글 작성 테스트
		Reply vo = new Reply();
		for(int i = 0; i < 30; i++) {
			vo.setPostno(14);
			vo.setContent("댓글 테스트 입니다"+i);
			vo.setWriter("test18@test.test");
			
			replyMapper.insert(vo);
		}
	}
	
	@Test
	public void testReplyDelete() { // 댓글 삭제 테스트
		replyMapper.delete(42);	}
	
	@Test
	public void testReplyUpdate() { // 댓글  수정 테스트
		Reply vo = new Reply();
		vo.setReplyno(22);
		vo.setContent("수정된 mapper 내용임둥");
		replyMapper.update(vo);
	}
	
	@Test
	public void testReplyRead() { //댓글 단일 조회 테스트
		log.info(replyMapper.read(705));
	}

	
	@Test
	public void testLikeInsert() { // 댓글좋아요 테이블 삽입
		Reply vo = new Reply();
		vo.setReplyno(865);
		vo.setWriter("test19@test.test");
	}
	
	
	@Test
	public void testGetThcount() { // 좋아요 눌렀는지 안눌렀는지 테스트
		log.info(replyMapper.getThumb(827, "test20@test.test"));
	}
	
}