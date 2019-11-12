package com.teamproject.mapper;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.Message;
import com.teamproject.mapper.MessageMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MessageMapperTests {
	@Setter @Autowired
	private MessageMapper messageMapper;
	
	@Test
	public void messageMapperExist() {
		log.info(messageMapper);
	}
	
	@Test
	public void insertTest() {
		log.info("message mapper insert test");
		Message message = new Message();
		message.setContent("mapper test111");
		message.setSender("test2@test.test");
		message.setReceiver("test0@test.test");
		log.info("message mapper insertr" + messageMapper.insertR(message));
		log.info("message mapper inserts" + messageMapper.insertS(message));
	}
	
	@Test
	public void selectAllTest() {
		log.info("message mapper selectAll test");
		String email = "test0@test.test";
		log.info(messageMapper.selectAll(email));
	}
	
	@Test
	public void selectByEmailTest() {
		log.info("message mapper selecetByEmail test");
		Map<String, String> user = new HashMap<>();
		user.put("sender", "test0@test.test");
		user.put("receiver", "test2@test.test");
		messageMapper.selectByEmail(user).forEach(log::info);
	}
	
	@Test
	public void deleteTest() {
		log.info("message mapper delete test");
		int messno = 141;
		log.info(messageMapper.deleteR(messno));
		log.info(messageMapper.deleteS(messno));
	}
	
	@Test
	public void deleteAllTest() {
		log.info("message mapper deleteAll test");
		Map<String, String> user = new HashMap<>();
		user.put("sender", "test0@test.test");
		user.put("receiver", "test2@test.test");
		log.warn(user);
		log.warn(user.get("sender"));
		log.warn(user.get("receiver"));
		log.info(messageMapper.deleteAllR(user));
		log.info(messageMapper.deleteAllS(user));
	}
	
	
}
