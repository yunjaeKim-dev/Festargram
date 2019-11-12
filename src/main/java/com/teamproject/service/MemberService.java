package com.teamproject.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.ui.Model;

import com.teamproject.domain.Criteria;
import com.teamproject.domain.Member;
import com.teamproject.domain.PageDTO;

public interface MemberService {
	//회원가입
	boolean signUp(Member vo);
	//간단한 조건검색시 사용중 이름변경예정
	Member get(String email);
	
	String getEmailByMno(int mno);
	
	// 회원번호를 통한 멤버객체반환 (친구리스트포함)
	Member getMemberByMno(int mno) ;
	List<Member> getMemberListByPaging(PageDTO dto) ;
	
	boolean idDoubleCheck(String email) ;
	
	
	// 회원 기본 정보 (비밀번호, 폰번호, 이름) 수정
	boolean modifyBaseInfo(Member vo, Authentication auth);
	
	// 회원 비밀번호 수정
	boolean modifyPWD(Member vo);
	
	// 회원 자기소개 수정
	boolean modifySelfintro(Member vo, Authentication auth);
	
	// 회원 추가 정보 (주소, 성별, 학교, 직장, 흥미) 수정
	boolean modifyExtraInfo(Member  vo, Authentication auth);
	
	// 회원 프로필 이미지 수정
	boolean modifyProfileImg(Member vo, Authentication auth);
	
	// 회원 프로필 커버이미지 수정
	boolean modifyProfileCoverImg(Member vo, Authentication auth);
	// 회원 탈퇴 상태 변경
	boolean modifyMemberState(Member vo);
	
	
	// 최근 접속일 업데이트
	boolean updateRecdate(int mno);
	/*친구관련*/
	
	/* 친구리스트 get */
	List<Member> getFriendList(int mno) ;
	
	// 친구 목록 날짜순 정렬
	
	List<Member> getFriendListOrderRecdate(int mno);
	// 친구 신청목록 가져오기
	List<Member> getFriendApplyList(int mno) ;
	
	// 친구 신청
	boolean friendApply(int applicant, int target) ;
	
	// 친구 신청목록에서 삭제
	boolean removeApply(int applicant, int target) ;
	
	// 친구리스트에 삽입
	boolean addFriend(int target, int applicant) ;
	
	// 친구삭제
	boolean removeFriend(int f1, int f2);
	
	// 친구인지 확인
	boolean isFriend(int f1, int f2) ;
	
	// 친구요청중인지 확인
	boolean isApply(int applicant, int target) ;
	
	// 회원관계 코드반환 0 : 아무관계아님  1 : 친구요청중      2: 친구         3: 본인   
	String getRelationCode(int applicant, int target);
	
	// 알수도있는사람 리스트
	List<Map<String, Object>> getMayKnownList(int mno, Criteria cri);
	
	// owner 의 친구리스트(로그인된유저와의 관계포함)
	List<Map<String, Object>> getOwnerFriendList(int ownerno, int currentno);
}
