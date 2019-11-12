package com.teamproject.controller;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.WebApplicationContext;

import com.teamproject.domain.Member;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
public class MessageControllerTests {
	@Autowired @Setter
	private WebApplicationContext ctx;
	private MockMvc mvc;
	
	@Before
	public void init() {
		mvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testExist() {
		log.info("exist test......");
		assertNotNull(ctx);
		assertNotNull(mvc);
		log.info(ctx);
		log.info(mvc);
	}
	
	@Test
	public void testMessageList() throws Exception {
		log.info("controller messageList test");
		
		ModelMap mm = mvc.perform(MockMvcRequestBuilders.get("/message/messenger")
				.sessionAttr("member","test1@test.test1")
				)
				.andReturn()
				.getModelAndView()
				.getModelMap();
		log.info(mm);
	}
	
	@Test
	public void testSendMessage() throws Exception {
		log.info("메시지 보내기 테스트");
		ResultActions ra = mvc.perform(MockMvcRequestBuilders.get("/message/sendMessage")
				.param("sender", "test1@test.test1")
				.param("receiver", "test2@test.test2")
				.param("content", "1가 2에게")
//				.param("sender", "test1@test.test1")
//				.param("receiver", "test2@test.test2")
//				.param("content", "1이 2에게")
				);
//		String result = ra.andReturn();
//		log.info(result);
	}
	
	@Test
	public void testRemoveAllMessage() throws Exception{
		log.info("메시지 전부 삭제한다!");
		ResultActions ra = mvc.perform(MockMvcRequestBuilders.get("/message/removeAllMessage")
				.sessionAttr("member", "test1@test.test1")
				.param("email", "test2@test.test2")
				);
		String result = ra.andReturn().getModelAndView().getViewName();
		log.info(result);
	}
	
	@Test
	public void testRemoveByMessno() throws Exception{
		log.info("메시지 선택 제거한다!");
		ResultActions ra = mvc.perform(MockMvcRequestBuilders.get("/message/removeByMessno")
				.param("messno", "81"));
		String result = ra.andReturn().getModelAndView().getViewName();
		log.info(result);
	}
	
	@Test
	public void testMessageReload() throws Exception {
		Member member = new Member();
		member.setEmail("test1@test.test1");
		log.info(member.getEmail());
		mvc.perform(MockMvcRequestBuilders.get("/message/messageReload")
				.sessionAttr("member", member)
				.param("receiver", "test2@test.test2")
				)
			.andExpect(status().is(200));
	}
}

