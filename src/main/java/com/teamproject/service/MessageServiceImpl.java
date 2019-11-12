package com.teamproject.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.domain.Message;
import com.teamproject.mapper.AlarmMapper;
import com.teamproject.mapper.MessageMapper;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@Data @Service @Log4j @AllArgsConstructor @NoArgsConstructor
public class MessageServiceImpl implements MessageService{
	@Autowired
	private MessageMapper mapper;
	@Autowired
	private AlarmMapper alarmMapper;
	// 메시지 보내기
	@Override @Transactional
	public boolean sendMessage(Message message) {
		log.info("service send message>.<");
		boolean retVal = (mapper.insertR(message) == 1) && (mapper.insertS(message) == 1 );
		String sender = message.getSender();
		String receiver = message.getReceiver();
		if(alarmMapper.selectMessageAlarm(sender, receiver) > 0) {
			alarmMapper.updateMessageAlarm(sender, receiver);
		}else {
			alarmMapper.insertMessageAlarm(sender, receiver);
		}
		return retVal;
	}

	// 대화 상대와 메시지 전부 제거 :: 윤재오빠 메롱
	// sender : 로그인 유저, receiver : 상대 
	@Override @Transactional
	public int removeAll(Map<String, String> email) {
		log.info("service remove all message !@!@!@!@!@");
		log.warn(email.get("sender"));
		log.warn(email.get("receiver"));
		return mapper.deleteAllR(email) + mapper.deleteAllS(email);
	}

	// 메시지 번호로 메시지 하나 제거
	@Override @Transactional
	public boolean removeByMessno(int messno) {
		log.info("service remove by messno ~~~~~~~~~");
		boolean retVal1 = mapper.deleteR(messno) == 1;
		boolean retVal2 = mapper.deleteS(messno) == 1;
		return  retVal1 && retVal2;
	}

	// 나의 전체 메시지 불러오기
	@Override
	public List<Message> messageList(String email) {
		log.info("service message list -__-");
		return mapper.selectAll(email);
	}

	// 특정 대상과 메시지 불러오기
	@Override
	public List<Message> messageListByEmail(String sender, String receiver) {
		log.info("service message list by email ^^");
		Map<String, String> user = new HashMap<>();
		user.put("sender", sender);
		user.put("receiver", receiver);
		return mapper.selectByEmail(user);
	}
}
