package com.teamproject.mapper;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FriendMapperTests {
	@Setter @Autowired
	private FriendMapper mapper;
	
	@Test
	public void insertTest() {
		log.info("친구 추가 맵퍼 테스트");
		Map<String, String> friend = new HashMap<String, String>();
		friend.put("friend1", "test1@test.test1");
		friend.put("friend2", "test2@test.test2");
		log.info(friend.toString());
		log.info(mapper.insert1(friend));
		log.info(mapper.insert2(friend));
	}
	
	@Test
	public void selectTest() {
		log.info("친구 목록 불러오기 맵퍼 테스트");
		String email = "test1@test.test1";
		log.info(mapper.select(email));
	}
	
	@Test
	public void selectByEmail() {
		log.info("친구 하나 불러오기 맵퍼 테스트");
		Map<String, String> map = new HashMap<>();
		map.put("email1", "test1@test.test1");
		map.put("email2", "test2@test.test2");
		log.info(mapper.selectByEmail(map));
	}
	
}
