package com.teamproject.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.teamproject.domain.Alarm;

public interface AlarmMapper {
	// 게시글 알람 추가
	int insertPostAlarm(@Param("postno") Integer postno, @Param("mno") Integer mno);
	// 댓글 알람 추가
	int insertReplyAlarm(@Param("replyno") Integer replyno, @Param("writer") String wirter);
	// 메시지 알림 등록 확인
	int selectMessageAlarm(@Param("sender") String sender, @Param("receiver") String receiver);
	//메시지 알람 추가
	int insertMessageAlarm(@Param("sender") String sender, @Param("receiver") String receiver);
	//메시지 알람 갱신
	int updateMessageAlarm(@Param("sender") String sender, @Param("receiver") String receiver);
	// 알림 목록 불러오기
	List<Alarm> selectAlarm(@Param("mno") Integer mno);
	// 메시지 알림 목록 불러오기
	List<Alarm> selectMessageAlarmList(@Param("mno") Integer mno);
}
