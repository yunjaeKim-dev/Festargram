package com.teamproject.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.teamproject.domain.AttachFile;
import com.teamproject.mapper.FileMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j @Component
public class FileCheckTask {
	@Autowired @Setter
	private FileMapper fileMapper ;
	
	
	@Scheduled(cron="0 0 2 * * *")
	public void checkFiles() throws Exception{
		log.warn("File Check Task gogoSing");
		log.warn(new Date());
		
		String uploadPath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.5\\webapps\\TeamProject\\upload" ;
		
		
		// DB에 저장된 하루이전 첨부파일리스트
		List<AttachFile> fileList = fileMapper.getOldFiles();
		fileList.forEach(attach -> {
			attach.setFullName();
		});
		
		fileList.forEach(attach -> {
			log.warn(attach.getFullName());
		});
		List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get(uploadPath, vo.getFullName())).collect(Collectors.toList());
		
		fileList.stream().map(vo -> Paths.get(uploadPath, vo.getFullThumbName())).forEach(thumb -> fileListPaths.add(thumb));
		
		
		
		log.warn("===================================");
		fileList.forEach(file -> log.warn(file));
		
		//어제 날짜 파일
		File targetDir = Paths.get(uploadPath, getFolderYesterDay()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false) ;
		log.warn("===================hihihihi=====================");
		for(File file : removeFiles) {
			log.warn("==================");
			log.warn(file.getAbsolutePath());
			file.delete();
		}
		
		
		
		
	}
	
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd") ;
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		return str.replace("-", File.separator);
	}
}
