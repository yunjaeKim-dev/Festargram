package com.teamproject.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.domain.Criteria;
import com.teamproject.domain.PageDTO;
import com.teamproject.domain.Reply;
import com.teamproject.mapper.AlarmMapper;
import com.teamproject.mapper.PostMapper;
import com.teamproject.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.log4j.Log4j;

@Service @Data @AllArgsConstructor @Log4j
public class ReplyServiceImpl implements ReplyService{
	@Autowired
	private ReplyMapper mapper;
	@Autowired
	private PostMapper postMapper ;
	@Autowired
	private AlarmMapper alarmMapper;
	
	@Override @Transactional
	public int add(Reply vo) {
		log.info("reply add....." + vo);
		postMapper.updateReplyCnt(vo.getPostno(),1);
		int result = mapper.insert(vo);
		alarmMapper.insertReplyAlarm(vo.getReplyno(), vo.getWriter());
		return result;
	}

	@Override @Transactional
	public int remove(int replyno) {
		log.info("reply remove....." + replyno);
		Map<String, Object> map = get(replyno);
		int postno =  Integer.parseInt(map.get("postno").toString());
		postMapper.updateReplyCnt(postno, -1);
		return mapper.delete(replyno);
	}

	@Override
	public int modify(Reply vo) {
		log.info("reply modify....." + vo);
		return mapper.update(vo);
	}

	@Override
	public List<Map<String, Object>> list(int postno, int rn) {
		log.info("reply list....." + postno);
		return mapper.listByPostno(postno, rn);
	}

	@Override
	public Map<String, Object> get(int replyno) {
		log.info("read reply..." + replyno);
		return mapper.read(replyno);
	}

	@Override
	public boolean modifyThcount(Reply vo) {
		if(mapper.getThumb(vo.getReplyno(), vo.getWriter()) > 0) {
			mapper.deleteLike(vo);
			mapper.updateThcount(vo.getReplyno(), -1);
			return true;
		}
		else {
			mapper.insertLike(vo);
			mapper.updateThcount(vo.getReplyno(), +1);
			return false;
		}
	}

}