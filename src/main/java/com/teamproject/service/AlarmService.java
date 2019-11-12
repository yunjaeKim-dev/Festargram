package com.teamproject.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.domain.Alarm;

public interface AlarmService {
	// 게시글 알림 추가
	boolean addPostAlarm(Integer postno, Integer mno);
	// 댓글 알람 추가
	boolean addReplyAlarm( Integer replyno, String writer);
	//메시지 알람 추가
	boolean addMessageAlarm(String sender, String receiver);
	// 알림 목록 불러오기
	List<Alarm> getAlarmList(Integer mno);
	// 메시지 알리미 목록 불러오기
	List<Alarm> getMessageAlarmList(Integer mno);
}
