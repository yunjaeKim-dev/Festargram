package com.teamproject.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.AttachFile;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class FileServiceTests {
	@Autowired @Setter
	FileService service ;
	
	// 첨부파일 업로드 테스트
	@Test //multipart[] 을 파라미터로 던질 방법을 모르겠어서 추후 테스트예정
	public void uploadFileTests(){
		
		
	}
	
	// 게시글번호를  통한 첨부파일리스트반환 테스트
	@Test
	public void getAttachListByPostnoTests() {
		service.getAttachListByPostno(164).forEach(log::info);
	}

	@Test
	public void deleteFileTests() {
		String fileName = "2019/10/27/2aeac9fc-2bac-447f-b246-e0f5e910c938_다운로드.jpg";
		String uploadOrigin = "D:\\spring-web\\.metadata\\plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\TeamProject\\upload" ;
		if(service.deleteFile(fileName, uploadOrigin)) {
			log.info("파일삭제성공");	
		}else {
			log.info("파일삭제실패");
		}
	}
	
	@Test
	public void deleteFilesTests() {
		
	}
	
}
