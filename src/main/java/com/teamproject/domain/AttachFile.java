package com.teamproject.domain;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Data @Log4j
public class AttachFile {
	
	
	private String uuid ;
	private String fileName ;
	private String uploadPath;
	private String mimeType ;
	private String regdate;
	private Long fileSize ;
	private Integer refno ;
	private String fullName;
	private String fullThumbName;
	
	private static final String realPath = "/upload/" ;
	private static final String profilePath = "/upload/profile/" ;
	
	
	
	public void setFullName() {
		String path = this.uploadPath.replace("\\", "/") + "/";
		this.fullName = path + this.uuid + "_" + this.fileName;
		this.fullThumbName = path + "s_" + this.uuid + "_" + this.fileName;
	}
	

	public AttachFile(String uuid, String fileName, String uploadPath, String mimeType, Long fileSize) {
		this.uuid = uuid;
		this.fileName = fileName;
		this.uploadPath = uploadPath;
		this.mimeType = mimeType;
		this.fileSize = fileSize;
		
		String path = uploadPath.replace("\\", "/") + "/";
		fullName = path + uuid + "_" + fileName;
		fullThumbName = path + "s_" + uuid + "_" + fileName;
	}

	public AttachFile() {}
	
	
}
