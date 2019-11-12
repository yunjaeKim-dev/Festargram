package com.teamproject.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.teamproject.domain.AuthVO;
import com.teamproject.domain.Criteria;
import com.teamproject.domain.Member;
import com.teamproject.domain.PageDTO;

public interface MemberMapper {
	// security 권한리스트 조인해서 권한리스트가진 멤버반환
	Member read(String email);
	
	
	List<Member> getList();
	Member getByEmail(String email);
	Member getmember(Member vo);
	Member getByMno(int mno);
	// 회원번호를 통한 이메일조회
	String getEmailByMno(int mno);
	
	//회원가입
	int insert(Member vo);
	int insertAuth(AuthVO vo);
	
	
	
	
	// 프로필 이미지 수정
	int modifyProfimg(Member vo);
	// 프로필 커버 이미지 수정
	int modifyProfileCoverImg(Member vo);
	
	// 기본 CRUD 들 수정예정
	int delete(String email);
	int update(Member vo);
	int updatemember(Member vo);
	
	// 회원 기본 정보 (비밀번호, 폰번호, 이름) 수정
	int updateBaseInfo(Member vo);
	
	// 회원 자기소개 수정
	int updateSelfintro(Member vo);
	
	// 회원 추가 정보 (주소, 성별, 학교, 직장, 흥미) 수정
	int updateExtraInfo(Member vo);
	
	// 회원 탈퇴 상태 변경
	int updateMemberState(Member vo);
	
	// 중복체크를 위한 email 로 회원카운트
	int count(String email);
	
	// 회원검색(검색,페이징)
	List<Member> getMemberListByPaging(PageDTO dto) ;
	
	// 최근 접속일 업데이트
	int updateRecdate(@Param("mno") int mno);
	
	//비밀번호만 교체(임시비밀번호)
	int updatePWD(Member vo);
	
	
	
	
	
		/*친구관련*/
	
	// 친구 목록 get
	List<Member> getFriendList(int mno) ;
	
	// 친구 목록 최근 일자 정렬
	List<Member> getFriendListOrderRecdate(int mno);
	
	// 친구 신청목록 가져오기
	List<Member> getFriendApplyList(int mno) ;
	
	// 친구 신청
	int friendApply(@Param("applicant") int applicant, @Param("target") int target) ;
	
	// 친구 신청목록에서 삭제
	int removeApply(@Param("applicant") int applicant, @Param("target") int target) ;
	
	// 친구리스트에 삽입
	int addFriend(@Param("f1")int f1 ,@Param("f2") int f2) ;
	
	// 친구삭제
	int removeFriend(@Param("f1")int vo,@Param("f2") int vo2);
	
	// 친구인지 확인
	int isFriend(@Param("f1") int f1, @Param("f2") int f2) ;
	
	//친구요청중인지 확인
	int isApply(@Param("applicant") int applicant, @Param("target") int target);
	
	// 알수도있는 사람
	List<Map<String, Object>> getMayKnowList(@Param("mno") int mno, @Param("cri") Criteria cri); 
	
	// 함께아는사람 COUNT
	int getMutualFriendsCount(@Param("f1")int f1 ,@Param("f2") int f2) ;

	// 마이페이지 owner 의 친구리스트(로그인된 회원과의 관계포함)
	List<Map<String, Object>> getOwnerFriendList(@Param("ownerno") int ownerno, @Param("currentno") int currentno);
}
