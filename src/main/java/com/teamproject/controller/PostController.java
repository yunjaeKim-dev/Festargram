package com.teamproject.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamproject.service.PostService;
import com.teamproject.util.Title.TitleName;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller @RequestMapping("/post/*") @Log4j @AllArgsConstructor
public class PostController {
	private PostService postService ;
	
	@GetMapping("time")
	public String timeline(Model model) {
		log.info("timeLine controller");
		model.addAttribute("title",TitleName.TimeLine);
		/*model.addAttribute("postList", postService.getPostList());*/
		return "timeline/timeline" ;
	}
	
}
