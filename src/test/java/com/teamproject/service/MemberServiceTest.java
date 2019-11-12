package com.teamproject.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.Criteria;
import com.teamproject.domain.Member;
import com.teamproject.domain.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MemberServiceTest {
	@Setter @Autowired
	private MemberService memberService;
	
	// 회원 기본 정보 수정 테스트
	@Test
	public void modifyBaseInfoTest() {
		Member vo = new Member();
		vo.setMno(442);
		vo.setPassword("1234qwer!");
		vo.setName("누굴까");
		vo.setPhone("11133332222");
		log.info("service :::: modify base info test");
		/*log.info(memberService.modifyBaseInfo(vo)); 테스트 완료 aop 적용해서 주석함*/
	}
	// 회원비밀번호 수정 테스트
	@Test
	public void testModifyPWD() {
		Member vo = new Member();
		vo.setEmail("test20@test.test");
		vo.setPassword("abcdas12");
		log.info("service :::: modifyPWD test");
		/*log.info(memberService.modifyPWD(vo)); 테스트 완료 aop 적용해서 주석함*/
	}
	
	// 회원 자기소개 수정테스트
	@Test
	public void modifySelfintroTests() {
		Member vo = new Member();
		vo.setMno(3);
		vo.setSelfintro("자기소개 수정수정수정수정수정수정수정수정");
		/*if(memberService.modifySelfintro(vo)) {
			log.info("정보수정 성공");
		}else {
			log.info("정보 수정 실패");
		} aop 적용후  주석처리함 테스트 성공*/
	}
	
	
	// 회원 추가 정보 수정 테스트
	@Test
	public void modifyExtraInfoTest() {
		Member vo = new Member();
		vo.setMno(3);
		vo.setSchool("서울 고등학교");
		vo.setJob("서울회사");
		vo.setInteresting("게임, 게임, 게임");
		/*log.info(memberService.modifyExtraInfo(vo));*/
	}

	// 회원 상태 변경 테스트
	@Test
	public void modifyMemberStateTest() {
		Member vo = new Member();
		vo.setMno(1);
		vo.setState("%");
		log.info(memberService.modifyMemberState(vo));
	}
	
	@Test
	public void deleteTest() {
		
	}
/*	@Test
	public void memberloginTest() {
		Member vo = new Member();
		vo.setEmail("mgz222@nate.com");
		vo.setPassword("1234");
	}*/
/*	@Test
	public void insertTest() {
		Member vo = new Member();
		vo.setEmail("42222@nate.com");//테스트시 다른이름으로
		vo.setPassword("1234");
		vo.setPhone("010xxxxxxxx");
		vo.setBirthdate("19910501");
		vo.setName("마리오");
		//model떄문에 테스토로 확인불가능
		
	}*/
/*	@Test
	public void updateMeberTest() {
		Member vo = new Member();
		vo.setEmail("42222@nate.com");//테스트시 다른이름으로
		vo.setPassword("123");
		vo.setPhone("010yyyyyyyy");
		vo.setBirthdate("19901111");
		vo.setName("루이즈");
		//세션값확인때문에 서비스테스트는 서버로 실행함
	}
	*/
	
	
	
	// 프로필이미지 수정 테스트
	@Test
	public void modifyprofileImgTests() {
		Member vo = new Member();
		vo.setMno(42);
		vo.setProfimg("/profile/9b9fe0a1-cf68-4a07-b82d-f28b1e2283c9_KakaoTalk_20191018_093053923.jpg");
		
		/* 시큐리티 적용 후 authentication 을 받아올수없어 임시 주석처리 memberService.modifyProfileImg(vo);*/
	}
	
	//프로필 커버 이미지 수정 테스트
	@Test
	public void modifyprofileCoverImgTests() {
		Member vo = new Member();
		vo.setMno(42);
		vo.setCoverimg("/profile/b8c3bd64-5f8f-4855-ba5b-ee3a65fc14c0_4715snow31_576391356107239_8692700411930345472_n.jpg");
		/*memberService.modifyProfileCoverImg(vo);*/
	}
	
	
	
	@Test
	public void idDoubleCheckTests() {
		log.info(memberService.idDoubleCheck("sdfsafsf33@gmail.com"));
	}
	
	// 회원번호로 get
	@Test
	public void getByMno() {
		log.info("getMemberByMno....");
		log.info(memberService.getMemberByMno(2));
	}
	
	// 최근 접속일 업데이트
	@Test
	public void updateRecdateTest() {
		log.info("service updateRecdate test");
		log.info(memberService.updateRecdate(2));
	}
	
	// 회원리스트(페이징,검색)
	@Test
	public void getMemberListByPagingTests() {
		log.info("getMemberListByPagingTest....");
		PageDTO dto = new PageDTO();
		dto.setKeyword("테스터");
		dto.setCri(new Criteria(5, 0));
		log.info(memberService.getMemberListByPaging(dto).size());
		memberService.getMemberListByPaging(dto).forEach(log::info);
	}
	/* 친구관련 테스트 */
	
	
	// 친구목록
	@Test
	public void getFriendListTests() {
		log.info("serviceTests getFriendList..") ;
		memberService.getFriendList(99).forEach(log::info); 
	}
	// 친구 목록 최근 접속일 순 
	@Test
	public void getFriendListOrderRecdateTest() {
		log.info("service getFriendListOrderRecdate test");
		memberService.getFriendListOrderRecdate(9999);
	}
	//친구요청목록
	@Test
	public void getFriendApplyListTests() {
		log.info("serviceTests getFriendApplyList..") ;
		memberService.getFriendApplyList(2).forEach(log::info);
	}
	
	
	// 친구신청
	@Test
	public void friendApplyTests() {
		log.info("serviceTests friendApplyTests....");
		if(memberService.friendApply(6, 13)) {
			log.info("친구신청 성공");
		}else{
			log.info("친구신청 실패");
		};
	}
	
	// 친구신청요청삭제
	@Test
	public void removeApplyTests() {
		log.info("serviceTests removeApplyTests....");
		if(memberService.removeApply(6, 13)) {
			log.info("친구요청삭제 성공");
		}else {
			log.info("친구요청 삭제실패");
		}
	}
	
	
	// 친구추가 vo가 기존에 친구신청했던녀석이여야함
	@Test
	public void addFriendTests() {
		log.info("serviceTets.....addFriend....");
		if(memberService.addFriend(13, 6)) {
			log.info("친구신청 성공");
		}else {
			log.info("친구신청 실패");
		}
	}
	
	// 친구삭제
	@Test
	public void removFriendTests() {
		log.info("serviceTets.....removeFriend....");
		if(memberService.removeFriend(6, 13)) {
			log.info("친구삭제 성공");
		}else {
			log.info("친구삭제 실패");
		}
	}
	
	// 친구여부확인
	@Test
	public void isFriendTests() {
		log.info("service Test isFriend");
		if(memberService.isFriend(1, 2)) {
			log.info("친구네! 친구여!");
		}else {
			log.info("초면입니다.");
		}
	}
	
	// 친구요청중인지 확인
	
	@Test
	public void isApplyTests() {
		log.info("service Test isApply............");
		
		if(memberService.isApply(1231, 8)) {
			log.info("친구요청중 !");
		}else {
			log.info("친구요쳥중아님") ;
		}
	}
	
	// 친구관계코드 테스트
	@Test
	public void getRelationCodeTests() {
		log.info("service Tests  getRelationCodeTests...");
		
		log.info("relationCode ::::" +memberService.getRelationCode(99987, 99987));
	}
	
	// 알수도있는사람 리스트 테스트
	@Test
	public void getMayKnowListTests() {
		log.info("service Tests getMayKnowListTests....");
		Criteria cri = new Criteria();
		cri.setAmount(10);
		memberService.getMayKnownList(42,cri).forEach(log::info);
	}
	
	// Owner 의 친구리스트
	@Test
	public void getOwnerFriendListTests() {
		log.info("mapper Test.. getOwnerFriendListTests");
		memberService.getOwnerFriendList(1, 42).forEach(map -> {
			log.info(map.get("school"));
		});
	}
	
}
