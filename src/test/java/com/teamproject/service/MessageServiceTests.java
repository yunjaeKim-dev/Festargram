package com.teamproject.service;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.Message;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MessageServiceTests {
	@Setter @Autowired
	private MessageService service;
	
	@Test
	public void sendMessageTest() {
		log.info("service sendMessageTest --------------------");
		Message message = new Message();
		message.setSender("test0@test.test");
		message.setReceiver("test1@test.test");
		message.setContent("service 기능 테스트");
		log.info(service.sendMessage(message));
	}
	
	@Test
	public void removeAllMessageTest() {
		log.info("service removeMessageTest---------------------");
		String sender = "test0@test.test";
		String receiver = "없는사용자@test.test";
		Map<String, String> email = new HashMap<String, String>();
		email.put("sender", sender);
		email.put("receiver", receiver);
		log.info(service.removeAll(email));
	}
	
	@Test
	public void removeMessageByMessnoTest() {
		log.info("service removeMessageByMessnoTest-------------------");
		int messno = 652;
		log.info(service.removeByMessno(messno));
	}
	
	@Test
	public void messageListTest() {
		log.info("service messageListTest");
		String email = "없는사용자@test.test";
		service.messageList(email).forEach(log::info);;
	}
	
	@Test
	public void messageListByEmailTest() {
		log.info("service messageListByEmailTest---------------");
		String sender = "test0@test.test";
		String receiver = "없는사용자@test.test";
		service.messageListByEmail(sender, receiver).forEach(log::info);
	}
}
