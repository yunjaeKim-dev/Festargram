package com.teamproject.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.teamproject.domain.AuthVO;
import com.teamproject.domain.Criteria;
import com.teamproject.domain.Member;
import com.teamproject.domain.PageDTO;
import com.teamproject.mapper.MemberMapper;
import com.teamproject.security.CustomUserDetailsService;
import com.teamproject.util.MemberUtility;

import lombok.Data;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Data
@Log4j
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberMapper mapper;
	@Autowired
	private PasswordEncoder encoder ;
	@Autowired
	private CustomUserDetailsService customUserDetailsService ;
	

	@Override
	public Member get(String email) {
		// TODO Auto-generated method stub
		return mapper.getByEmail(email);
	}


	@Override
	public String getEmailByMno(int mno) {
		log.info("memberService...getEmailByMno");
		
		return mapper.getEmailByMno(mno);
	}

	@Override @Transactional// 회원가입
	public boolean signUp(Member vo) {
		log.info("memberService.....signUp");
		log.info(vo);
		vo.setProfimg("/profile/82adbdfd-7d14-4627-a959-a4cf9f301dd4_2019091803349_0_20190919ab031520414.png");
		vo.setPassword(encoder.encode(vo.getPassword()));
		boolean ret = false ;
		boolean ret2 = false ;
		ret = mapper.insert(vo) > 0 ? true : false ;
		ret2 = mapper.insertAuth(new AuthVO(vo.getEmail(), "ROLE_USER"))> 0 ? true : false;
		
		return ret && ret2 ;
	}

	
	
	// 회원번호를 통한 멤버객체반환 (친구리스트포함)
	@Override
	public Member getMemberByMno(int mno) {
		Member member = mapper.getByMno(mno);
		member.setFriendList(mapper.getFriendList(mno));
		return member;
	}

	//id 중복체크
	@Override
	public boolean idDoubleCheck(String email) {
		log.info("email :: " + email);
		return mapper.count(email) > 0 ? false : true ;
	}
	
	
	// 회원검색 
	@Override
	public List<Member> getMemberListByPaging(PageDTO dto) {
		log.info("service....getMemberListByPaging");
		return mapper.getMemberListByPaging(dto);
	}
	
	// 회원 기본 정보 수정
	@Override
	public boolean modifyBaseInfo(Member vo, Authentication auth) {
		log.info("service .... modify base info");
		vo.setEmail(mapper.getEmailByMno(vo.getMno()));
		if(!vo.getPassword().equals("")) {
			vo.setPassword(encoder.encode(vo.getPassword()));
		}
		return mapper.updateBaseInfo(vo) == 1 ? true : false;
	}
	// 회원 비밀번호만 수정
	@Override
	public boolean modifyPWD(Member vo) {
		log.info("service .... modify PWD");
		vo.setPassword(encoder.encode(vo.getPassword()));
		return mapper.updatePWD(vo) == 1 ? true : false;
	}
	
	// 회원 자기소개 수정
	@Override @Transactional
	public boolean modifySelfintro(Member vo ,Authentication auth) {
		log.info("service.....modify Selfintro...");
		vo.setEmail(mapper.getEmailByMno(vo.getMno()));
		
		return mapper.updateSelfintro(vo) == 1 ? true : false; 
	}
	
	// 회원 추가 정보 수정
	@Override
	public boolean modifyExtraInfo(Member vo, Authentication auth) {
		log.info("service .... modify extra info");
		vo.setEmail(mapper.getEmailByMno(vo.getMno()));
		return mapper.updateExtraInfo(vo) == 1 ? true : false;
	}
	
	// 프로필사진수정
	@Override
	public boolean modifyProfileImg(Member vo, Authentication auth) {
		log.info("service .... modifyProfileImg info");
		vo.setEmail(mapper.getEmailByMno(vo.getMno()));
		
		return mapper.modifyProfimg(vo) == 1 ? true : false; 
	}
	

	// 프로필 커버이미지 수정
	@Override
	public boolean modifyProfileCoverImg(Member vo, Authentication auth) {
		log.info("service .... modifyProfileCoverImg info");
		vo.setEmail(mapper.getEmailByMno(vo.getMno()));
		return mapper.modifyProfileCoverImg(vo) == 1 ? true : false;
	}

	// 회원 상태 변경
	@Override
	public boolean modifyMemberState(Member vo) {
		log.info("service ..... modify member state ");
		vo.setEmail(mapper.getEmailByMno(vo.getMno()));
		return mapper.updateMemberState(vo) == 1 ? true : false;
	}
	
	// 최근 접속일 업데이트
	@Override
	public boolean updateRecdate(int mno) {
		log.info("service... updateRecdate");
		return mapper.updateRecdate(mno) == 1 ? true : false;
	}




	/*-------------------친구관련---------------------*/

	// 친구목록
	@Override
	public List<Member> getFriendList(int mno) {
		log.info("service...getFriendList.........");
		return mapper.getFriendList(mno);
	}

	// 친구 목록 접속일 순 20명
	@Override
	public List<Member> getFriendListOrderRecdate(int mno) {
		log.info("service... getFriendListOrderRecdate");
		return mapper.getFriendListOrderRecdate(mno);
	}

	
	// 친구요청목록
	@Override
	public List<Member> getFriendApplyList(int mno) {
		log.info("service...getApplyList.........");
		return mapper.getFriendApplyList(mno);
	}

	// 친구신청
	@Override
	public boolean friendApply(int applicant, int target) {
		log.info("service...friendApply.........");
		return mapper.friendApply(applicant, target) == 1 ? true : false;
	}

	// 친구신청요청삭제
	@Override
	public boolean removeApply(int applicant, int target) {
		log.info("service...RemoveApply.........");
		return mapper.removeApply(applicant, target) == 1 ? true : false;
	}

	// 친구추가(수락시 실행해야될 기능)
	@Override
	@Transactional
	public boolean addFriend(int target, int applicant) {
		boolean ret = false;
		log.info("service...addFriend.........");
		ret = (mapper.removeApply(applicant, target) == 1 ? true : false)
				&& (mapper.addFriend(target, applicant) == 2 ? true : false);
		return ret;
	}

	// 친구삭제
	@Override
	public boolean removeFriend(int f1, int f2) {
		log.info("service...removeFriend.........");
		return mapper.removeFriend(f1, f2) == 2 ? true : false;
	}

	// 친구여부확인
	@Override
	public boolean isFriend(int f1, int f2) {
		log.info("service......isFriend ...");
		return mapper.isFriend(f1, f2) == 2 ? true : false;
	}

	// 친구요청중인지 확인
	@Override
	public boolean isApply(int applicant, int target) {
		log.info("service........isApply");
		return mapper.isApply(applicant, target) == 1 ? true : false;
	}

	// 회원관계 코드반환 무관계 : 0 친구요청중 : 1 친구 : 2 본인 : 3  4: target이 applicant 에게 요청중
	@Override
	public String getRelationCode(int applicant, int target) {
		log.info("service.....getRelationCode");
		if (isApply(applicant, target)) {
			return "1";
		}
		if (isFriend(applicant, target)) {
			return "2";
		}
		if ((mapper.getByMno(applicant).getMno() == mapper.getByMno(target).getMno())) {
			return "3";
		}
		if (isApply(target, applicant)) {
			return "4";
		}
		return "0";
	}
	
	
	// 알수도있는사람 리스트 반환(함께아는 사람 카운트포함)
	@Override
	public List<Map<String, Object>> getMayKnownList(int mno, Criteria cri) {
		log.info("service...getMayKnowList...");
		
		List<Map<String, Object>> list = mapper.getMayKnowList(mno, cri);
		
		return list;
	}


	@Override
	public List<Map<String, Object>> getOwnerFriendList(int ownerno, int currentno) {
		log.info("service...getOwnerFriendList...");
		
		return mapper.getOwnerFriendList(ownerno, currentno);
	}
	




	
	








}
