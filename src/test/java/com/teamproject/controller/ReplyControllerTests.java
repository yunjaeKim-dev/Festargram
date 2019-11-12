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
import com.teamproject.domain.Reply;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" })
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@Log4j
public class ReplyControllerTests {
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
	public void testGetList() throws Exception { // 글번호(14)에 대한 댓글목록
		log.info("list test.......");
		mvc.perform(MockMvcRequestBuilders.get("/reply/getList/14")).andExpect(status().is(200));
	}
	
	@Test
	public void testAdd() throws Exception { // 18번글에 댓글 달기
		Reply vo = new Reply();
		log.info("insert test......");
		
		vo.setPostno(18);
		vo.setContent("컨트롤러 레스트테스트 댓글내용");
		vo.setWriter("jds96@jds.jds");
		
		String jsonStr = new Gson().toJson(vo);
		log.info(jsonStr);
		mvc.perform(MockMvcRequestBuilders.post("/reply/new")
				.contentType(MediaType.APPLICATION_JSON_UTF8)
				.content(jsonStr)).andExpect(status().is(200));
	}
	
	@Test
	public void testModify() throws Exception { // 댓글번호 22번 글내용 수정
		log.info("insert test......");
		Reply vo = new Reply();
		vo.setContent("jUnit4 에서 수정한 댓글");

		String jsonStr = new Gson().toJson(vo);
		log.info(jsonStr);
		
		mvc.perform(MockMvcRequestBuilders.put("/reply/22")
				.contentType(MediaType.APPLICATION_JSON_UTF8)
				.content(jsonStr)).andExpect(status().is(200));
	}
	
	@Test
	public void testRemove() throws Exception { // 댓글번호 144번 삭제
		mvc.perform(MockMvcRequestBuilders.delete("/reply/144")).andExpect(status().is(200));
	}
	
}