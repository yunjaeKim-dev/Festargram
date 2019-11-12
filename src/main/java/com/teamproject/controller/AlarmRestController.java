package com.teamproject.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.teamproject.domain.Alarm;
import com.teamproject.service.AlarmService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j @RequestMapping("/alarmRest/*")
@AllArgsConstructor
public class AlarmRestController {
	@Autowired @Setter
	AlarmService service;
	
	// 알림 목록 불러오기
	@GetMapping(value="alarmList/{mno}", produces="application/json; charset=utf-8")
	public ResponseEntity<List<Alarm>> alarmList(@PathVariable("mno") Integer mno) {
		log.info("알림페이지!");
		return new ResponseEntity<>(service.getAlarmList(mno),HttpStatus.OK);
	}
	
	// 메시지 알림 목록 불러오기
	@GetMapping(value="messageAlarmList/{mno}", produces="application/json; charset=utf-8")
	public ResponseEntity<List<Alarm>> messageAlarmList(@PathVariable("mno") Integer mno){
		log.info("메시지 알림 불러오기");
		return new ResponseEntity<List<Alarm>>(service.getMessageAlarmList(mno),HttpStatus.OK);
	}
}
