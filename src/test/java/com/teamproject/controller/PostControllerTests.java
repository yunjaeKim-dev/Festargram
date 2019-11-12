package com.teamproject.controller;

import static org.junit.Assert.assertNotNull;

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

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@WebAppConfiguration("file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml")
public class PostControllerTests {
	@Autowired @Setter
	private WebApplicationContext ctx ;
	private MockMvc mvc ;
	
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
	public void testTimeline() throws Exception {
		log.info("ControllerTests Timeline....");
		ModelMap mm = mvc.perform(MockMvcRequestBuilders.get("/post/time"))
				.andReturn()
				.getModelAndView()
				.getModelMap();
		
		log.info(mm);
	}
	
	@Test
	public void testRegisterPost() throws Exception {
		log.info("ControllerTests RegisterPost....");
		ResultActions ra = mvc.perform(MockMvcRequestBuilders.post("/post/register")
				.param("writer", "test1@test.test1")
				.param("owner", "test1@test.test1")
				.param("content", "컨트롤러 포스트등록이 되게해주세요")
				);
		
		String resultPage = ra.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
		
		
				
		
	}
	
}
