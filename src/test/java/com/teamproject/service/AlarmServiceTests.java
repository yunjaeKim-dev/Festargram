package com.teamproject.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.Alarm;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class) @Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class AlarmServiceTests {
	@Autowired @Setter
	AlarmService service;
	
	@Test
	public void serviceExsistTest() {
		log.info(service);
	}
	// 게시글 알림 추가 테스트
	@Test
	public void addPostAlarmTest() {
		log.info("서비스 게시글 알림 추가 테스트");
		log.info(service.addPostAlarm(100, 2));
	}
	// 댓글 알림 추가 테스트
	@Test
	public void addReplyAlarmTest() {
		log.info("서비스 댓글 알림 추가 테스트");
		log.info(service.addReplyAlarm(732, ""));
	}
	//메시지 알림 추가 테스트
	@Test
	public void addMessageAlarmTets() {
		log.info("서비스 메시지 알림 추가 테스트");
		log.info(service.addMessageAlarm("test1@test.test","test2@test.test"));
	}
	// 알림 목록 불러오기 테스트
	@Test
	public void getAlarmListTest() {
		log.info("서비스 알림 목록 불러오기 테스트");
		service.getAlarmList(1).forEach(log::info);
	}
	
	//메시지 알림 목록 불러오기 테스트
	@Test
	public void getMessageAlarmTest() {
		log.info("서비스 메시지 알림 목록 불러오기 테스트");
		service.getMessageAlarmList(1).forEach(log::info);
	}
	
	
}
