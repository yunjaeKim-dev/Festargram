package com.teamproject.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.domain.Reply;
import com.teamproject.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController @RequestMapping("/reply") @Log4j @AllArgsConstructor
public class ReplyController {
	private ReplyService service;
	
	@GetMapping("/getList/{postno}/{rn}")
	public List<Map<String, Object>> getList(@PathVariable int postno, @PathVariable int rn) { // 댓글 리스트
		log.info(postno);
		log.info(rn);
		return service.list(postno, rn);
	}
	
	@PostMapping("/new")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> add(@RequestBody Reply vo) { // 댓글 작성
		log.info(vo);
		int cnt = service.add(vo);
		String reNo = "방금 등록한 댓글의 번호 : "+Integer.toString(vo.getReplyno());
		return cnt == 1 ? 
				new ResponseEntity<>( reNo , HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(value="/{replyno}", method= {RequestMethod.PUT ,RequestMethod.PATCH})
	@PreAuthorize("principal.member.email == #vo.writer")
	public ResponseEntity<String> modify(@PathVariable int replyno, @RequestBody Reply vo) { // 댓글 수정
		log.info("reply modify....." + replyno);
		vo.setReplyno(replyno);
		return service.modify(vo) == 1 ? 
				new ResponseEntity<>("success", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping("/{replyno}")
	@PreAuthorize("principal.member.email == #vo.writer")
	public ResponseEntity<String> remove(@PathVariable int replyno, @RequestBody Reply vo) { // 댓글 삭제
		log.info("reply remove....." + replyno);
		
		return service.remove(replyno) == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping("/thumb")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> modifyThcount(@RequestBody Reply vo) { // 댓글 작성
		log.info(vo);
		int cnt = 0;
		String thumb = "";
		if(service.modifyThcount(vo)) {
			cnt = 1;
			thumb = "thumbM";
		}else {
			cnt = 1;
			thumb = "thumbP";
		}
		return cnt == 1? 
				new ResponseEntity<>( thumb , HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}