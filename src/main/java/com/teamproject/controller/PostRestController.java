package com.teamproject.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.domain.AttachFile;
import com.teamproject.domain.Criteria;
import com.teamproject.domain.Post;
import com.teamproject.service.FileService;
import com.teamproject.service.PostService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController @Log4j @AllArgsConstructor
@RequestMapping("/postrest/*")
public class PostRestController {
	@Autowired @Setter
	private PostService postService ;
	@Autowired @Setter
	private FileService fileService ;
	
	
	// 글작성
	@PostMapping("/new")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Map<String, Object>> postRegister(@RequestBody Post vo) {
		log.info("PostVo :: " + vo);
		vo.getAttachList().forEach(log::info);
		if(vo.getContent() == null || vo.getWriter() ==null || vo.getOwner() == null) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity<>(postService.registerPost(vo) , HttpStatus.OK);
	}
	
	
	//게시글 삭제
	@DeleteMapping("/remove/{postno}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> removePost(@PathVariable Integer postno, HttpServletRequest req){
		log.info("removePost................");
		String uploadOrigin = req.getServletContext().getRealPath("/upload/") ;
		List<AttachFile> attachList = fileService.getAttachListByPostno(postno);
		
		if(postService.removePost(postno)) {
			fileService.deleteFiles(attachList, uploadOrigin);
			return new ResponseEntity<>("post remove success", HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	
	
	
	
	@GetMapping("/newsFeed/{mno}/{postRn}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<List<Map<String, Object>>> getNewsFeed(@PathVariable int mno, @PathVariable int postRn){
		log.info("postrest getNewsFeed....................");
		log.info("postRN :: " + postRn);
		log.info("Mno :: " + mno);
		List<Map<String, Object>> newsfeed = postService.getNewsfeed(mno, postRn) ;
		newsfeed.forEach(post -> {
			Object attachList = post.get("attachList") ; 
			if(attachList != null) {
				((List<AttachFile>)attachList).forEach(file -> {
					file.setFullName();
				});
			}
		});
		return new ResponseEntity<>(newsfeed, HttpStatus.OK) ;
	}
	
	@GetMapping("/myPageList/{mno}/{postRn}/{currentUserMno}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<List<Map<String, Object>>> getMyPageTimeLine(@PathVariable int mno, @PathVariable int postRn, @PathVariable int currentUserMno){
		log.info("postrest getMyPageTimeLine....................");
		log.info("postRN :: " + postRn);
		log.info("Mno :: " + mno);
		List<Map<String, Object>> timeLine = postService.getMyPageTimeLine(mno,postRn, currentUserMno) ;
		timeLine.forEach(post -> {
			Object attachList = post.get("attachList") ; 
			if(attachList != null) {
				((List<AttachFile>)attachList).forEach(file -> {
					file.setFullName();
				});
			}
		});
		return new ResponseEntity<>(timeLine, HttpStatus.OK) ;
	}
	
	
	@GetMapping("/getPost/{postno}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Map<String, Object>> getPostByPostno(@PathVariable int postno){
		log.info("postrest getPostByPostno......");
		log.info("postno ::: " + postno );
		
		Map<String, Object> post = postService.getPost(postno) ;
		
		if(post == null){
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}else {
			return new ResponseEntity<>(post, HttpStatus.OK);
		}
	}
	
	@PutMapping("/modifyPost")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<Map<String, Object>> modifyPost(@RequestBody Post vo){
		log.info("controller ........modifyPost..");
		log.info("post :: " + vo);
		vo.getAttachList().forEach(log::info);
		if(vo.getPostno() == null || vo.getContent() == null) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity<>(postService.modifyPost(vo),HttpStatus.OK);
		
	}
	
	
	@PostMapping("/updateGood/{postno}/{mno}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> updateGood(@PathVariable int postno, @PathVariable int mno){
		log.info("controller.......updateGood");
		log.info("postno :: " + postno  + "mno :: " + mno);
		
		if(postService.modifyThcount(postno, mno)) {
			return new ResponseEntity<>("minus", HttpStatus.OK);
		}else {
			return new ResponseEntity<>("plus", HttpStatus.OK);
		}
		
	}
	
}
