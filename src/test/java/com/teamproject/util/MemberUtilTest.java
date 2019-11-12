package com.teamproject.util;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.Member;
import com.teamproject.service.ReplyServiceTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
public class MemberUtilTest {
	/*@Autowired @Setter
	private MemberUtility utility;

	@Test
	public void sha256Test() {
		log.info(utility.encryptSHA256("1234"));
		
	}
	
	@Test
	public void memberInfoCheck() {
		Member member = new Member();
		member.setEmail("mgz222@nat.com");
		member.setPwd("no77you@");
		member.setPhone("0102832112");
		member.setBirthdate("19911221");
		member.setName("2aa");
		log.info("결과값:"+utility.memberInfocheck(member,2));
	}
	//패턴 테스트 메소드
	@Test
	public void patter() {
		String idPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
		log.info("mgz222@nat".matches(idPattern));
	}*/
}

