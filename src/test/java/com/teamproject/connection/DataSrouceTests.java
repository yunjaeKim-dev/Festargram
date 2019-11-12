package com.teamproject.connection;

import java.sql.Connection;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
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
public class DataSrouceTests {
	@Setter @Autowired
	private SqlSessionFactory sessionFactory;
	
	@Test
	public void testMyBatis() {
		try (SqlSession session = sessionFactory.openSession(); Connection conn = session.getConnection();){
			log.info(session);
			log.info(conn);
		} catch (Exception e) {
			log.error(e.getMessage());;
		}
	}
}
