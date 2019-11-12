package com.teamproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.teamproject.domain.Alarm;
import com.teamproject.mapper.AlarmMapper;

import lombok.Data;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
@Data
public class AlarmServiceImpl implements AlarmService{
	@Autowired
	AlarmMapper mapper;
	// 게시글 알람 추가
	@Override
	public boolean addPostAlarm(Integer postno, Integer mno) {
		log.info("service add post alarm");
		return mapper.insertPostAlarm(postno, mno) > 0;
	}
	// 댓글 알람 추가
	@Override
	public boolean addReplyAlarm(Integer replyno, String email) {
		log.info("service add reply alarm ");
		return mapper.insertReplyAlarm(replyno, email) > 0;
	}
	// 메시지 알림 추가
	@Override
	public boolean addMessageAlarm(String sender, String receiver) {
		log.info("servcie add message alarm");
		if(mapper.selectMessageAlarm(sender, receiver) > 0) {
			return mapper.updateMessageAlarm(sender, receiver) > 0;
		}else {
			return mapper.insertMessageAlarm(sender, receiver) > 0;
		}
		
	}
	
	// 알림 목록 가져오기
	@Override
	public List<Alarm> getAlarmList(Integer mno) {
		log.info("service get alarm list");
		return mapper.selectAlarm(mno);
	}
	@Override
	public List<Alarm> getMessageAlarmList(Integer mno) {
		log.info("service get message alarm list");
		return mapper.selectMessageAlarmList(mno);
	}
	
	
	
}
