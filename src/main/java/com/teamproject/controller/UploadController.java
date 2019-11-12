package com.teamproject.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.imgscalr.Scalr;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.teamproject.domain.AttachFile;
import com.teamproject.service.FileService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import net.coobird.thumbnailator.Thumbnails;

@Log4j @RestController @AllArgsConstructor @RequestMapping("/upload/*") 
public class UploadController {
	@Autowired
	FileService service ;
	

	@PostMapping("file/{where}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<List<AttachFile>> uploadFile(MultipartFile[] uploadFile, HttpServletRequest req,@PathVariable String where) {
		log.info("upload/file 들어왔습니다.");
		log.info("aaa ::" + where);
		log.info(uploadFile.length);
		String uploadOrigin = req.getServletContext().getRealPath("/upload/") ;
		log.info(uploadOrigin);
		
		List<AttachFile> list = service.uploadFile(uploadFile, uploadOrigin,where); 
		if(list == null) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}else {
			return new ResponseEntity<>(list, HttpStatus.OK);
		}
	}
	
	@GetMapping("/display")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<byte[]> getFile(String fileName, HttpServletRequest req){
		log.info(fileName);
		String uploadOrigin = req.getServletContext().getRealPath("/upload/") ;
		File file = new File(uploadOrigin + fileName);
		
		log.info(file);
		
		ResponseEntity<byte[]> result = null ;
		
		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header, HttpStatus.OK);
		} catch (IOException e) {
			log.error(e);
		}
		
		return result ;
	}
	
	@PostMapping("/delete")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> deleteFile(String fileName, HttpServletRequest req){
		log.info("deleteFile : " + fileName);
		String uploadOrigin = req.getServletContext().getRealPath("/upload/") ;
		
		if(service.deleteFile(fileName, uploadOrigin)) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	
	
	
	
	/*// filePath : 원본파일 저장경로   fileName : 원본파일이름 fileExt : 파일확장자
	private void makeThumbnail(String filePath, String fileName, String fileExt) throws Exception {
		BufferedImage srcImg = ImageIO.read(new File(filePath)); 
		int dw = 250, dh = 150;
		int ow = srcImg.getWidth();
		int oh = srcImg.getHeight(); 
		// 원본 너비를 기준으로 하여 썸네일의 비율로 높이를 계산합니다.
		int nw = ow; int nh = (ow * dh) / dw; 
		// 계산된 높이가 원본보다 높다면 crop이 안되므로 // 원본 높이를 기준으로 썸네일의 비율로 너비를 계산합니다. 
		if(nh > oh) {
			nw = (oh * dw) / dh; nh = oh; 
		} 
		// 계산된 크기로 원본이미지를 가운데에서 crop 합니다.
		BufferedImage cropImg = Scalr.crop(srcImg, (ow-nw)/2, (oh-nh)/2, nw, nh); 
		// crop된 이미지로 썸네일을 생성합니다.
		BufferedImage destImg = Scalr.resize(cropImg, dw, dh); 
		// 썸네일을 저장합니다. 이미지 이름 앞에 "s_" 를 붙여 표시했습니다.
		String thumbName = filePath + "s_" + fileName;
		File thumbFile = new File(thumbName);
		ImageIO.write(destImg, fileExt.toUpperCase(), thumbFile);
	}
*/
	
	
	
}
