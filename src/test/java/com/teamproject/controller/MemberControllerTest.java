package com.teamproject.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.teamproject.domain.Member;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
public class MemberControllerTest {
	@Autowired
	@Setter
	private WebApplicationContext ctx;
	private MockMvc mockmvc;

	@Before
	public void setup() {
		this.mockmvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

	@Test
	public void memberLoginTest() throws Exception {//2019-10-09 성공
		log.info(mockmvc.perform(MockMvcRequestBuilders.get("/member/login")).andReturn().getModelAndView().getModel());
	}

	@Test
	public void memberPostLogtitnTest() throws Exception {//2019-10-09 실패 서버로 성공
		Member vo = new Member();
		log.info(mockmvc.perform(
				MockMvcRequestBuilders.post("/member/login")
				.param("email", "mgz222@nate.com").param("pwd", "1234"))
				.andReturn().getModelAndView().getViewName());
	}

	@Test
	public void memberSitgnuptTest() throws Exception {//2019-10-09 성공
		log.info(
				mockmvc.perform(MockMvcRequestBuilders.get("/member/signup"))
				.andReturn().getModelAndView().getModel());
	}

	@Test
	public void memberPostSignupTest() throws Exception {//2019-10-09 성공
		log.info(mockmvc.perform(MockMvcRequestBuilders.post("/member/signup").param("email", "나는용자다3@nate.com")
				.param("pwd", "1234").param("phone", "01012345678").param("birthdate", "911225").param("name", "나는용자다"))
				.andReturn().getModelAndView().getViewName());

	}

	@Test
	public void memberMyinfoTest() throws Exception {
		log.info(
				mockmvc.perform(MockMvcRequestBuilders.get("/member/myinfo")).andReturn().getModelAndView().getModel());
	}

	@Test
	public void memberPostMyinfoTest() throws Exception {// 세션정보가 없기때문에 테스로 통과못함
		log.info(mockmvc.perform(MockMvcRequestBuilders.post("/member/myinfo").param("email", "mgz222@nate.com")
				.param("pwd", "1234").param("name", "자바맨").param("phone", "01025552233").param("updatapwd", "1234"))
				.andReturn().getModelAndView().getViewName());
	}

	@Test
	public void memberLogout() throws Exception {
		log.info(
				mockmvc.perform(MockMvcRequestBuilders.get("/member/logout"))
				.andReturn().getModelAndView().getModel());
	}
	// 아이디 찾기 컨트롤러
	@Test
	public void memberFindid() throws Exception {
		log.info(
				mockmvc.perform(MockMvcRequestBuilders.get("/member/findid"))
				.andReturn().getModelAndView().getModel());
	}

}
