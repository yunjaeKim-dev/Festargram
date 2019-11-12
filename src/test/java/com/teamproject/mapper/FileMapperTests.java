package com.teamproject.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.AttachFile;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/security-context.xml",
"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class FileMapperTests {
	@Setter @Autowired
	private FileMapper fileMapper;
	
	@Test
	public void fileMapperExist() {
		log.info(fileMapper);
	}
	@Test
	public void fileInsertTest() {
		AttachFile vo = new AttachFile("sf33we3i2a123", "노희원바보", "2019/15/41", "image/jpeg", 5454214L);
		vo.setRefno(51);
		fileMapper.insert(vo);
	}
	
	@Test
	public void fileDeleteTest() {
		fileMapper.delete("sf33we3i2a123");
	}
	
	@Test
	public void fileDeleteAllTest() {
		fileMapper.deleteAll(51);
	}
	@Test
	public void FileListByPostNoTest() {
		fileMapper.getAttachListByPostno(83).forEach(log::info);
	}
	
	
	
	
	
}
