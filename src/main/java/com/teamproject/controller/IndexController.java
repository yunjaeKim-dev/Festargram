package com.teamproject.controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.teamproject.util.Title.TitleName;

import lombok.extern.log4j.Log4j;

@Controller @Log4j @RequestMapping("/*") @Service
public class IndexController {
	@GetMapping("/")
	public String indexController(Locale locale,Model model) {
		log.info(locale);
		model.addAttribute("title",TitleName.Festargram);
		return "index";
	}
}
