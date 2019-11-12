package com.teamproject.service;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.teamproject.domain.AttachFile;
import com.teamproject.domain.Criteria;
import com.teamproject.domain.Post;
import com.teamproject.mapper.AlarmMapper;
import com.teamproject.mapper.FileMapper;
import com.teamproject.mapper.PostMapper;

import lombok.Data;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Data @Service @Log4j
public class PostServiceImpl implements PostService{
	@Autowired @Setter
	private PostMapper mapper;
	@Autowired @Setter
	private FileMapper fileMapper ;
	@Autowired @Setter
	private AlarmMapper alarmMapper;
	
	@Override @Transactional
	public Map<String, Object> registerPost(Post vo) {
		log.info("post register..........");
		mapper.insertSelectKeyPost(vo) ;
		Integer postno = vo.getPostno();
		Integer mno = vo.getWriter();
		alarmMapper.insertPostAlarm(postno, mno);
		if(vo.getAttachList() != null && vo.getAttachList().size() > 0) {
			vo.getAttachList().forEach(attach -> {
				attach.setRefno(postno);
				fileMapper.insert(attach);
			});
		}
		
		return getPost(vo.getPostno()); 
		
	}

	@Override
	public Map<String, Object> getPost(Integer postno) {
		log.info("post getOne..............");
		Map<String, Object> map = mapper.getPost(postno);
		if(((List<AttachFile>)map.get("attachList")) != null &&((List<AttachFile>)map.get("attachList")).size() > 0) {
			((List<AttachFile>)map.get("attachList")).forEach(attach -> {
				attach.setFullName();
			});
		}
		
		return map;
	}
	@Override @Transactional
	public boolean removePost(Integer postno) {
		log.info("post remove ...............");
		fileMapper.deleteAll(postno);
		return mapper.deletePost(postno) == 1 ? true : false ;
	}

	@Override @Transactional
	public Map<String, Object> modifyPost(Post vo) {
		log.info("post modify..............");
		//기존첨부파일 모두삭제
		fileMapper.deleteAll(vo.getPostno());
		boolean retval = mapper.updatePost(vo) == 1 ? true : false ;
		if(retval && vo.getAttachList() != null && vo.getAttachList().size()>0) {
			vo.getAttachList().forEach(attach -> {
				attach.setRefno(vo.getPostno());
				fileMapper.insert(attach);
			});
		}
		return  getPost(vo.getPostno());
	}

	@Override
	public List<Map<String, Object>> getPostList() {
		log.info("post list ................");
		return mapper.getPostList();
	}

	@Override
	public List<Map<String, Object>> getMyPageTimeLine(int mno, int postRn, int sessionno) {
		log.info("postService....... getMypageTimeLine...");
		log.info("mno :: " + mno +"-- postRn :::" + postRn);
		return mapper.getMyPageTimeLine(mno, postRn,sessionno);
	}

	@Override
	public List<Map<String, Object>> getNewsfeed(int mno, int postRn) {
		log.info("postService....getNewsfeed");
		log.info("mno :: " + mno +"-- postRn :::" + postRn);
		return mapper.getNewsfeed(mno, postRn);
	}

	@Override
	public boolean modifyThcount(int postno, int mno) {
		log.info("postService....modifyThcount......");
		log.info("mno :: " + mno +"-- postRn :::" + postno);
		
		if(mapper.isPostGood(postno, mno) > 0) { // 이미 좋아요 중임 -1
			mapper.deletePostGood(postno, mno);
			mapper.updatePostGood(postno, -1);
			return true ;
		}else {
			mapper.insertPostGood(postno, mno); // 좋아요가아닌상태 +1 해줌
			mapper.updatePostGood(postno, 1);
			return false;
			
		}
	}
	
	
	
}
