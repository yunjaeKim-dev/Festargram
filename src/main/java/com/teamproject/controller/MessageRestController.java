package com.teamproject.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.domain.Message;
import com.teamproject.service.MessageService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

// 메시지 RestController
@RestController @Log4j
@RequestMapping("/message/*") @AllArgsConstructor
public class MessageRestController {
	private MessageService messageService;
	
	// 메시지 내용 불러오기
	// sender : 자신 , receiver : 상대 
	@PostMapping(value="messageLoad",produces="application/json; charset=utf-8")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<List<Message>> messageLoad(@RequestBody Map<String, String> email){
		/*log.info("상대방과 메시지 불러오기 restController");
		log.info("email :: " + email);
		log.info(email.get("sender"));
		log.info(email.get("receiver"));*/
		return new ResponseEntity<List<Message>>(messageService.messageListByEmail(email.get("sender"),email.get("receiver")),
				HttpStatus.OK);
	}
	/*//  전체 메시지 리스트 불러오기
	@PostMapping(value="/messageList",produces="application/json; charset=utf-8")
	public ResponseEntity<List<Message>> messageList(@RequestBody String email,HttpSession session){
		log.info(email);
		return null;
//		return new ResponseEntity<>(messageService.messageListByEmail(sender, email),HttpStatus.OK);
	}*/
	
	
	// 메시지 보내기
	// messageVo 객체를 받아서 보냄
	@PostMapping(value="/new",produces="application/json; charset=utf-8")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> send(@RequestBody Message message){
		/*log.info(message);*/
		boolean retVal = messageService.sendMessage(message);
		return retVal == true ? 
				new ResponseEntity<>("success",HttpStatus.OK) : 
					new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 메시지 하나 삭제
	@DeleteMapping(value="/remove/{messno}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> removeMessage(@PathVariable int messno) {
		/*log.info("contorller messno :: " + messno);*/
		boolean retVal = messageService.removeByMessno(messno);
		return retVal == true ?  
				new ResponseEntity<>("success",HttpStatus.OK) :
					new ResponseEntity<>("fail",HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 대상과 메시지 전부 삭제
	@DeleteMapping(value="/removeAll")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> removeAllMessage(@RequestBody Map<String, String> email){
//		log.info("restController removeAll email :: " + email );
//		log.info(email);
//		log.info(email.get("sender"));
//		log.info(email.get("receiver"));
		boolean retVal = messageService.removeAll(email) > 0;
//		log.info("controller :::::::::::::::::" + retVal);
		return retVal == true ? new ResponseEntity<>("success",HttpStatus.OK) :
			new ResponseEntity<>("fail",HttpStatus.OK);
	}
}
