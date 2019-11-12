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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.domain.Criteria;
import com.teamproject.domain.Member;
import com.teamproject.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController @Log4j @AllArgsConstructor
@RequestMapping("/friend/")
public class FriendRestController {
	MemberService memberService ;
	
	/*친구Strnig List*/
	@GetMapping("/friendList/{mno}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<List<Member>> getFriendList(@PathVariable int mno){
		log.info("Controller...getFriendList....");
		log.info(mno);
		return new ResponseEntity<List<Member>>(memberService.getFriendList(mno), HttpStatus.OK);
	}
	
	// 친구 목록 최근 접속일 순서
	@GetMapping("/friendListOrderRecdate/{mno}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<List<Member>> getFriendListOrderRecdate(@PathVariable int mno){
		log.info("restController... getFriendListOrderRecdate");
		log.info(mno);
		return new ResponseEntity<List<Member>>(memberService.getFriendListOrderRecdate(mno), HttpStatus.OK);
	}
	
	/* 친구요청리스트 return List<Member> */
	@GetMapping("/applyList/{mno}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<List<Member>> getFriendApplyList(@PathVariable int mno){
		log.info("Controller...getFriendApplyList....");
		log.info(mno);
		return new ResponseEntity<List<Member>>(memberService.getFriendApplyList(mno), HttpStatus.OK);
	}
	
	/* 친구신청 */
	@PutMapping("/friendApply/{applicant}/{target}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> friendApply(@PathVariable int applicant, @PathVariable int target){
		log.info("Controller.friendApply.............");
		log.info("applicant : " + applicant + "// target " + target);
		if(memberService.friendApply(applicant, target)){
			return new ResponseEntity<String>("Friend Apply success.", HttpStatus.OK) ;
		}else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR) ;
		}
	}
	
			/*친구요청삭제*/
	@DeleteMapping("friendApply/{applicant}/{target}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> removeApply(@PathVariable int applicant, @PathVariable int target){
		log.info("applicant : " + applicant + "// target " + target);
		if(memberService.removeApply(applicant, target)) {
			return new ResponseEntity<String>("remove Apply success",HttpStatus.OK) ;
		}else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR) ;
		}
	}
	
	
	/*친구인지 return boolean*/
	@GetMapping("/isFriend/{f1}/{f2}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> isFriend(@PathVariable int f1, @PathVariable int f2){
		if(memberService.isFriend(f1,f2)) {
			return new ResponseEntity<String>("we are friend",HttpStatus.OK) ;
		}else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR) ;
		}
		
	}
	
	/*친구요청중인지 return boolean*/
	@GetMapping("/isApply/{applicant}/{target}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> isApply(@PathVariable int applicant, @PathVariable int target){
		if(memberService.isApply(applicant, target)) {
			return new ResponseEntity<String>("friend apply.",HttpStatus.OK) ;
		}else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR) ;
		}
	}
	
	//친구수락
	@PostMapping("/addFriend/{target}/{applicant}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> addFriend(@PathVariable int target, @PathVariable int applicant){
		log.info("target :: " + target + " --applicant ::" + applicant);
		if(memberService.addFriend(target, applicant)) {
			return new ResponseEntity<String>("add friend success",HttpStatus.OK) ;
		}else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR) ;
		}
	}
	
	
	//친구삭제
	@DeleteMapping("/removeFriend/{f1}/{f2}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> removeFriend(@PathVariable int f1, @PathVariable int f2){
		log.info("f1 ::" + f1 + "f2 ::" + f2);
		if(memberService.removeFriend(f1, f2)) {
			return new ResponseEntity<String>("remove friend success",HttpStatus.OK) ;
		}else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR) ;
		}
	}
	
	// 관계코드반환
	@GetMapping("/relation/{applicant}/{target}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> getRelationCode(@PathVariable int applicant, @PathVariable int target){
		log.info("restcontroller...getRelationCode");
		return new ResponseEntity<String>(memberService.getRelationCode(applicant, target),HttpStatus.OK);
	}
	
	// 알수도있는사람 리스트 반환
	@PostMapping("/getMayKnow/{mno}")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<List<Map<String, Object>>> getMayKnownList(@PathVariable int mno, @RequestBody Criteria cri){
		log.info("restcontroller...getMayKnownList");
		log.info(cri);
		return new ResponseEntity<>(memberService.getMayKnownList(mno,cri), HttpStatus.OK);
		
	} 
	
	// owner 의 친구리스트 반환
	@GetMapping("/getOwnerFriendList/{ownerno}/{currentno}")
	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public List<Map<String, Object>> getOwnerFriendList(@PathVariable int ownerno, @PathVariable int currentno){
		log.info("friendrestcontroller....getOwnerFriendList ");
		log.info("ownerno :: " + ownerno  + "   currnetno :: " + currentno);
		
		return memberService.getOwnerFriendList(ownerno, currentno);
		
	}
	
	
}
