package com.teamproject.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamproject.security.domain.CustomUser;
import com.teamproject.service.AlarmService;
import com.teamproject.util.Title;
import com.teamproject.util.Title.TitleName;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller @RequestMapping("/alarm/*")
@Log4j @AllArgsConstructor
public class AlarmController {
	@Autowired @Setter
	AlarmService service;
	
	// 알림 목록 페이지로 이동과 동시에 알림 목록 불러옴
	@GetMapping("alarm")
	public String alarm(Model model, Principal principal) {
		log.info("컨트롤러 알람 넘어가욧");
		model.addAttribute("title","알림");
		CustomUser user = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Integer mno = user.getMember().getMno();
		//log.info(user.getMember().getMno());
		model.addAttribute("alarmList", service.getAlarmList(mno));
		return "/alarm/alarm";
	}
	
	@GetMapping("friendApply")
	public String friendApply(Model model) {
		log.info("알람컨트롤러.. 친구요청 및 알수도있는사람 리스트");
		model.addAttribute("title",TitleName.FriendApply);
		return "/alarm/friendApply" ;
	}
}
