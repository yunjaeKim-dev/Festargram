package com.teamproject.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.teamproject.domain.AttachFile;

public interface FileService {
	
	// 파일  저장
	List<AttachFile> uploadFile(MultipartFile[] uploadFile, String uploadOrigin, String where) ;
	
	
	// postno 를통해 List<attachFile> 반환
	List<AttachFile> getAttachListByPostno(Integer postno);
	
	// 파일이름을통해 파일 삭제
	boolean deleteFile(String fileName, String uploadOrigin) ;
	
	// 파일리스트를 받아서 파일전체삭제 (post삭제시 postno로 첨부파일리스트를 get 이후에 실행될 서비스)
	void deleteFiles(List<AttachFile> attachList, String uploadOrigin);
}
