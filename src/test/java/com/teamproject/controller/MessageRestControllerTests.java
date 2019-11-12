package com.teamproject.controller;

import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import com.google.gson.Gson;

import com.teamproject.domain.Member;
import com.teamproject.domain.Message;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml","file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@WebAppConfiguration @Log4j
public class MessageRestControllerTests {
	@Setter @Autowired
	private WebApplicationContext ctx;
	private MockMvc mvc;
	
	@Before
	public void init() {
		mvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testExist() {
		log.info("testExist");
		assertNotNull(ctx);
		assertNotNull(mvc);
		log.info(ctx);
		log.info(mvc);
		
	}
	
	@Test
	public void messageListTest() throws Exception {
		String email = new Gson().toJson("test2@test.test2");
		Member member = new Member();
		member.setEmail("test1@test.test1");
		mvc.perform(MockMvcRequestBuilders.post("/message/messageList")
				.requestAttr("member", member)
				.contentType(MediaType.APPLICATION_JSON_UTF8)
				.content(email)
				).andExpect(status().is(200));
	}
	
	@Test
	public void sendTest() throws Exception {
		Message message = new Message();
		message.setContent("컨트롤러에서 보내는 메시지");
		message.setReceiver("test1@test.test1");
		message.setSender("test2@test.test2");
		String jsonStr = new Gson().toJson(message);
		log.info(jsonStr);
		mvc.perform(MockMvcRequestBuilders.post("/message/new")
				.contentType(MediaType.APPLICATION_JSON_UTF8)
				.content(jsonStr)
				).andExpect(status().is(200));
	}
	
	@Test
	public void removeMessageTest() throws Exception{
		mvc.perform(MockMvcRequestBuilders.post("/message/remove/177"))
			.andExpect(status().is(200));
	}
	
}
