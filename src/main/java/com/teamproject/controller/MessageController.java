package com.teamproject.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamproject.util.Title.TitleName;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
//메신저 창으로 이동하기 위한 컨트롤러
@Controller @RequestMapping("/messenger/*") @Log4j
@AllArgsConstructor
public class MessageController {
	// 메신저 창으로 이동
	@GetMapping("messenger") 
	public String messenger(Model model) {
		log.info("메신저로 이동중...");
		model.addAttribute("title",TitleName.Messenger);
		return "messenger/messenger";
	}
	
}
