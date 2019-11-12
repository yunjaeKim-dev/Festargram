package com.teamproject.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Map;
import java.util.Random;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.domain.Member;
import com.teamproject.service.MailService;
import com.teamproject.service.MemberService;
import com.teamproject.util.Title.TitleName;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@RequestMapping("/sendMail/*")
@Controller @AllArgsConstructor
@Log4j
public class MailController {
	private MemberService memberService;
	private MailService mailService;
	
	
	@GetMapping("findPWD")
	public void memberSignup(Model model) {
		model.addAttribute("title", TitleName.FindPWD);
	}
    
	// 비밀번호 찾기
    @PostMapping("findPWD")
    public String sendMailPassword(Member vo) {
        int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String password = String.valueOf(ran)+"a";
        vo.setPassword(password);

        String subject = "[Festargram] 임시 비밀번호 발급 안내 입니다.";
        StringBuilder sb = new StringBuilder();
        sb.append("회원님의 임시 비밀번호는 " + password + " 입니다.");
        sb.append("\n");
        sb.append("해킹의 위험이 있으니 즉시 바꾸어 주시길 바랍니다.");
        sb.append(System.getProperty("line.separator"));
        sb.append(" 해킹당해도 모릅니다잉");
        mailService.send(subject, sb.toString(), "headstone1220@gmail.com", vo.getEmail());
        
        memberService.modifyPWD(vo); // 해당 유저의 DB정보 변경
        return "redirect:/member/login";
    }
	
}
