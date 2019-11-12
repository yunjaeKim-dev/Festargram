package com.teamproject.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.Alarm;
import com.teamproject.domain.Message;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/security-context.xml",
"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class AlarmMapperTests {
	@Setter @Autowired
	private AlarmMapper mapper;
	
	// mapper 존재 테스트
	@Test
	public void mapperExsistTest() {
		log.info(mapper);
	}
	
	// 게시글 알람 추가
	@Test
	public void insertPostAlarmTest() {
		log.info(mapper.insertPostAlarm(100, 2));
	}
	// 댓글 알람 추가
	@Test
	public void insertReplyAlarmTest() {
		log.info(mapper.insertReplyAlarm(734, "test2@test.test"));
	}
	// 메시지 알람 추가
	@Test
	public void insertMessageAlarmTest() {
		Message vo = new Message();
		log.info(mapper.insertMessageAlarm("test1@test.test","test2@test.test"));
	}
	// 메시지 알람 갱신
	@Test
	public void updateMessageAlarmTest() {
		Message vo = new Message();
		log.info(mapper.updateMessageAlarm("test1@test.test","test2@test.test"));
	}
	// 알림 목록 불러오기 테스트
	@Test
	public void selectTest() {
		log.info(mapper.selectAlarm(1));
	}
}
