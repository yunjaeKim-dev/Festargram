package com.teamproject.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.teamproject.domain.AttachFile;
import com.teamproject.mapper.FileMapper;

import lombok.Data;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j @Data @Service
public class FileServiceImpl implements FileService{

	@Autowired @Setter
	FileMapper fileMapper ;
	
	
	

	@Override
	public List<AttachFile> getAttachListByPostno(Integer postno) {
		log.info("fileService...getAttachListByPostno");
		return fileMapper.getAttachListByPostno(postno);
	}

	
	@Override
	public List<AttachFile> uploadFile(MultipartFile[] uploadFile, String uploadOrigin, String where) {
		log.info("fileService....uploadFile");
		Tika tika = new Tika() ; 
		// make Folder
		File uploadPath = null ;
		if(where.equals("0")) {
			uploadPath = new File(uploadOrigin, getFolder()) ;
		}else if(where.equals("1")){
			uploadPath = new File(uploadOrigin, "/profile") ;
		}
		
		log.info(uploadPath);
		
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		List<AttachFile> list = new ArrayList<>();
		
		for(MultipartFile multipartFile : uploadFile) {
			// MimeType
			try {
				String mimeType = tika.detect(multipartFile.getInputStream());
				// 파일 사이즈
				Long fileSize = multipartFile.getSize() ;
				// 파일이름
				String uploadFileName = multipartFile.getOriginalFilename();
				// IE has file path
				uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1) ;
				// 파일정보 로그확인
				log.info("Upload File Name : " + multipartFile.getOriginalFilename());
				log.info("FileSize : " + fileSize);
				log.info("MimeType :: " + mimeType);
				
				// 마임타입체크 이미지가 아닐경우 리턴
				if(!mimeType.startsWith("image")) {
					return null ;// 이미지 파일이 아닐경우 false 
				}
				// uuid 생성
				String uuid = UUID.randomUUID().toString() ;
				// uuid _ 파일이름 String 변수 생성
				String realuploadFileName = uuid + "_" + uploadFileName ;
				
				File file = new File(uploadPath, realuploadFileName);
				 // 파일존재유무 확인
				log.info(file.exists());
				// 파일저장
				multipartFile.transferTo(file); 
				if(where.equals("0")) {
					AttachFile attachFile = new AttachFile(uuid, uploadFileName , getFolder(), mimeType, fileSize);
					list.add(attachFile);
				}else if(where.equals("1")){
					AttachFile attachFile = new AttachFile(uuid, uploadFileName , "/profile", mimeType, fileSize);
					list.add(attachFile);
				}
				
				///썸네일생성 
				FileOutputStream fos = new FileOutputStream(new File(uploadPath, "s_" + realuploadFileName)) ;
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 100, 100);
				fos.close();
				
			} catch (IllegalStateException | IOException e) {
				log.error(e);
			}
	
		}
		return list ;
	}
	
	
	
	// 물리적경로 파일삭제
	@Override
	public boolean deleteFile(String fileName, String uploadOrigin) {
		log.info("fileService....deleteFile");
		File file = null ;
		File sfile = null ;
		try {
			log.info("decode :: " + URLDecoder.decode(fileName, "utf-8"));
			file = new File(uploadOrigin + URLDecoder.decode(fileName, "utf-8"));
			file.delete();
			
			String largeFileName = file.getAbsolutePath().replace("s_", "");
			log.info("largeFileName" + largeFileName);
			sfile = new File(largeFileName);
			sfile.delete();
			
			if(!file.exists() && !sfile.exists()) {
				return true ;
			}else {
				return false ;
			}
		} catch (UnsupportedEncodingException e) {
			log.error(e);
		}

		return false;
	}
	
	@Override
	public void deleteFiles(List<AttachFile> attachList, String uploadOrigin) {
		if(attachList == null || attachList.size() ==0) {
			return ;
		}
		log.info("delete attach files....");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			attach.setFullName();
			Path file = Paths.get(uploadOrigin + attach.getFullName()) ;
			Path thumbNail = Paths.get(uploadOrigin, attach.getFullThumbName());
			
			try {
				Files.delete(file);
				Files.delete(thumbNail);
			} catch (IOException e) {
				log.error("delete File error" + e);
			}
		});
	}
	
	
	
	
	private String getFolder() {
		return new SimpleDateFormat("yyyy" + File.separator + "MM" + File.separator + "dd").format(new Date());
	}



}
