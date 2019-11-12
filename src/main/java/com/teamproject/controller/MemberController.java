package com.teamproject.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.teamproject.domain.Member;
import com.teamproject.domain.PageDTO;
import com.teamproject.service.MemberService;
import com.teamproject.util.Title.TitleName;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
@Log4j
public class MemberController {
	private MemberService service;

	@GetMapping("signup")
	public void memberSignup(Model model) {
		model.addAttribute("title", TitleName.Signup);
	}

	@PostMapping("signup") // 생년월일은 스크립트가 3개의 날짜를 조합해줌
	public String memberSignup(Member vo, RedirectAttributes rttr) {
		log.info("member ::" + vo);
		if(service.signUp(vo)) {
			rttr.addFlashAttribute("msg", "회원가입이 완료되었습니다.") ;
			return "redirect:/member/login" ; 
		}else {
			rttr.addFlashAttribute("msg", "회원가입 실패") ;
			return "redirect:/member/signup" ;
		}
		
		
	}
	
	@GetMapping("login")
	public String memberLogin(Authentication auth,String error, Model model) {
		log.info("로그인회원" + auth);
		model.addAttribute("title",TitleName.Login);
		return "member/login";
	}
	
	
	@PostMapping("login")
	public String memberPostLogin(Authentication auth,String error, Model model) {
		log.info("로그인회원" + auth);
		
		return "member/login";
	}
	

	@GetMapping("mypage")
	public String myPage(Model model, int mno, RedirectAttributes rttr) {
		model.addAttribute("title", TitleName.MyPage);
		Member vo = service.getMemberByMno(mno);
		if(vo.getState().equals("1")) {
			rttr.addFlashAttribute("msg", "탈퇴한 회원의 페이지입니다.");
			return "redirect:/post/time";
		}
		model.addAttribute("host", vo);
		
		return "member/mypage";
	}
	
	@GetMapping("mypageBro")
	public String myPageBro(Model model, int mno) {
		model.addAttribute("title", TitleName.MyPageBro);
		model.addAttribute("host", service.getMemberByMno(mno));
		
		return "member/mypageBro";
	}
	
	
	//헤더에서 검색버튼누르면 검색어가지고 페이지이동
	@GetMapping("searchUser")
	public String searchUser(@RequestParam("keyword") String keyword, Model model, HttpSession session) {
		log.info("searchUserGet.....");
		model.addAttribute("currentUser", session.getAttribute("member"));
		model.addAttribute("keyword", keyword) ;
		
		return "member/searchUser" ;
	}
	
	
	// 회원리스트를 페이징해서 ajax로 넘겨줄컨트롤러
	@PostMapping("searchUser")
	public ResponseEntity<List<Member>> getMemberListWithPaging(@RequestBody PageDTO dto){
		log.info("searchUserPost.....");
		log.info("DTO ::::::" + dto);
		return new ResponseEntity<>(service.getMemberListByPaging(dto),HttpStatus.OK);
	}
	
	@PostMapping("doubleCheck")
	public ResponseEntity<String> doubleCheckId(@RequestBody Member vo){
		log.info(" doublc check  id ::: " + vo.getEmail());
		
		if(service.idDoubleCheck(vo.getEmail())) {
			return new ResponseEntity<>("available", HttpStatus.OK); 
		}else {
			return new ResponseEntity<>("unavailable", HttpStatus.OK);
		}
		
	}
	
	// 최근 접속 시간 갱신
	@GetMapping("updateRecdate/{mno}")
	public ResponseEntity<String> updateRecdate(@PathVariable int mno){
		return service.updateRecdate(mno) == true ? new ResponseEntity<String>("recdate update",HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value="/modifyProfileImg", produces="application/text; charset=utf-8")
	public ResponseEntity<String> modifyProfileImg(@RequestBody Member vo, Authentication auth){
		log.info("Controller...modifyProfileImg....");
		log.info("Member :: " + vo);
		
		if(service.modifyProfileImg(vo,auth)) {
			return new ResponseEntity<>("프로필 이미지 수정이 완료되었습니다.", HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	
	@PostMapping(value="/modifyProfileCoverImg", produces="application/text; charset=utf-8")
	public ResponseEntity<String> modifyProfileCoverImg(@RequestBody Member vo, Authentication auth){
		log.info("Controller...modifyProfileCoverImg....");
		log.info("Member :: " + vo);
		
		if(service.modifyProfileCoverImg(vo,auth)) {
			return new ResponseEntity<>("프로필 이미지 수정이 완료되었습니다.", HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	/*
	 * 자기소개수정
	 * 2019/10/29
	 * 
	 * 
	 * */
	@PostMapping("modifySelfintro")
	public ResponseEntity<String> modifySelfintro(@RequestBody Member vo, Authentication auth){
		log.info("Controller...modifySelfintro....");
		log.info("Member vo :: " + vo);
		
		if(service.modifySelfintro(vo,auth)) {
			return new ResponseEntity<>("selfintro modify success", HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping("modifyExtraInfo")
	public ResponseEntity<String> modifyExtraInfo(@RequestBody Member vo, Authentication auth){
		log.info("Controller...modifyExtraInfo....");
		log.info("Member :: " + vo);
		
		if(service.modifyExtraInfo(vo, auth)) {
			return new ResponseEntity<>("ExtraInfo modify success", HttpStatus.OK);
		}else {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
	}
	
	// 회원 기본 정보(비밀번호, 이름, 생일) 수정페이지 이동
	@GetMapping("modifyBaseInfo")
	public String modifyBaseInfo(Model model) {
		log.info("Controller....modifyBaseInfo get");
		model.addAttribute("title",TitleName.MyInfo);
		return "/member/modifyBaseInfo";
	}
	
	// 회원 기본 정보 수정
	@PostMapping("modifyBaseInfo")
	public String modifyBaseInfo(Member vo, Authentication auth) {
		log.info("Controller...modifyBaseInfo post");
		log.info("vo :: " + vo);
		service.modifyBaseInfo(vo, auth);
		return "/member/modifyBaseInfo";
	}
	
	@PostMapping("removeMember")
	public String removeMember(Member vo, Authentication auth) {
		log.info("Controller... revmove member post");
		service.modifyMemberState(vo);
		return "/index";
	}
}