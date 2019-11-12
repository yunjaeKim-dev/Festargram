package com.teamproject.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.teamproject.domain.AuthVO;
import com.teamproject.domain.Criteria;
import com.teamproject.domain.Member;
import com.teamproject.domain.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/security-context.xml",
"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
@Log4j
public class MemberMapperTests {
	@Setter @Autowired
	private MemberMapper memberMapper;
	
	@Setter @Autowired
	private PasswordEncoder encoder ;
	
	
	// 시큐리티 read 테스트
	@Test
	public void testRead() {
		Member vo = memberMapper.read("test0@test.test");
		log.info(vo);
		vo.getAuthList().forEach(log::info);
	}
	// bcrypt 체크
	@Test
	public void encodeSignUpTests() {
		for(int i=0 ; i<30; i++) {
			Member vo = new Member();
			vo.setEmail("test" + i +"@test.test");
			vo.setPassword(encoder.encode("test" +i));
			vo.setName("테스터" + i);
			vo.setPhone("01044562185");
			vo.setBirthdate("19931231");
			memberMapper.insert(vo);
			
			AuthVO avo = new AuthVO();
			avo.setEmail("test"+ i +"@test.test");
			avo.setAuth("ROLE_USER");
			memberMapper.insertAuth(avo);
		}
		
	}
	// 회원번호를 통한 회원이메일조회
	@Test
	public void getEmailByMno() {
		log.info(memberMapper.getEmailByMno(42));
	}
	@Test
	public void memberMapperExistTest() {
		log.info(memberMapper.getList());
	}
	@Test
	public void getMemberTest() {
		Member vo = new Member();
		vo.setEmail("mgz222@nate.com");
		vo.setPassword("1234");
		memberMapper.getmember(vo);
	}
	@Test
	public void insertTest() {
		Member vo = new Member();
		vo.setEmail("asdc1@jds.cx");
		vo.setPassword("1233");
		vo.setName("ppaapjds");
		vo.setPhone("01032141234");
		vo.setBirthdate("961220");
		log.info(memberMapper.insert(vo));
	}
	
	@Test
	public void countTests() {
		log.info(memberMapper.count("test1@test.test"));
	}
	
	// 회원 기본 정보 (비밀번호, 폰번호, 이름) 수정
	@Test
	public void updateBaseInfoTest() {
		Member vo = new Member();
		vo.setMno(1);
		vo.setName("김윤재");
		vo.setPassword(encoder.encode("1q2w3e4r!"));
		log.info(memberMapper.updateBaseInfo(vo));
	}
	// 회원 비밀번호 수정
	@Test
	public void testUpdatePWD() {
		Member vo = new Member();
		vo.setEmail("test20@test.test");
		vo.setPassword(encoder.encode("qwer1234"));
		log.info(memberMapper.updatePWD(vo));
	}
	
	// 회원 자기소개 수정
	@Test
	public void updateSelfintroTests() {
		Member vo = new Member();
		vo.setMno(3);
		vo.setSelfintro("자기소개 수정수정수정수정수정수정수정수정");
		if(memberMapper.updateSelfintro(vo)> 0) {
			log.info("정보수정 성공");
		}else {
			log.info("정보 수정 실패");
		}
		
	}
	
	// 회원 추가 정보 (주소, 성별, 학교, 직장, 흥미) 수정
	@Test
	public void updateExtraInfoTest() {
		Member vo = new Member();
		vo.setMno(1);
		vo.setAddress("경기도 안산시 상록구 성포동 신우연립 5동 305호");
		vo.setJob("갓수");
		vo.setSchool("명지대학교");
		vo.setInteresting("영화, 음악 감상");
		log.info(memberMapper.updateExtraInfo(vo));
	}
	// 회원 프로필 사진수정
	@Test
	public void modifyProfileImg() {
		Member vo = new Member();
		vo.setMno(42);
		vo.setProfimg("/profile/giphy.gif");
		memberMapper.modifyProfimg(vo);
	}
	
	// 커버 이미지 수정
	@Test
	public void modifyprofileCoverImg() {
		Member vo = new Member();
		vo.setMno(42);
		vo.setCoverimg("/profile/93607873-b82b-4660-a6fd-67c81634ff8c_69912950_741754752904231_6146660884241448960_o.jpg");
		memberMapper.modifyProfileCoverImg(vo);
	}
	
	// 회원 탈퇴 상태 변경
	@Test
	public void updateMemberStateTest() {
		Member vo = new Member();
		vo.setMno(42);
		vo.setState("1");
		log.info(memberMapper.updateMemberState(vo));
	}
	
	// 최근 접속일 업데이트
	@Test
	public void updateRecdateTest() {
		log.info(memberMapper.updateRecdate(3));
	}
	
	// 검색어로 회원리스트 GET 페이징포함
	@Test
	public void getMemberListWithPaging() {
		PageDTO dto = new PageDTO();
		dto.setKeyword("루이즈");
		dto.setCri(new Criteria(5, 5));
		memberMapper.getMemberListByPaging(dto).forEach(log::info) ;
	}
	
	
	// 회원번호로 회원 get
	@Test
	public void getByMnoTests() {
		log.info(memberMapper.getByMno(2));
	}
	
	
	// 친구목록리스트 get Test
	@Test
	public void getFriendListTests() {
		log.info("mapper Test.. getFriendList Test...");
		memberMapper.getFriendList(40).forEach(log::info);
	}

	// 친구 목록 최근 접속일 순으로 정렬
	@Test
	public void getFriendListOrderRecdateTest() {
		log.info("mapper tets getFriendListOrderRecdate test");
		memberMapper.getFriendListOrderRecdate(3).forEach(log::info);;
	}
	
	 /*나한테온 친구신청목록 get List<Member>*/
	@Test
	public void getFriendApplyList() {
		log.info("mapper Test..getFriendApplyList..");
		memberMapper.getFriendApplyList(1).forEach(log::info);
	}
	
	
	/* 친구신청 */
	@Test
	public void friendApplyTest() {
		log.info("mapper Test..friendApply....");
		
		log.info(memberMapper.friendApply(2, 3) + "개의 행 삽입");
		
	}
	
	/* 친구신청  삭제 */
	@Test
	public void removeApplyTests() {
		log.info("mapper Test removeFrinedApply....");
		log.info(memberMapper.removeApply(1, 2) + "개의 행 삭제");
	}
	
	// 친구 등록 두행을 한번에 인서트
	@Test
	public void addFriendTests() {
		log.info("mapper Test addFriend....");
		
		log.info(memberMapper.addFriend(2, 3) + "개");
		
	}
	
	// 친구삭제 두행 삭제
	@Test
	public void removeFriendTests() {
		log.info("mapper Test removeFriend");
		
		log.info(memberMapper.removeFriend(2, 3) + "개");
	}
	
	// 친구인지확인
	@Test
	public void isFriendTests() {
		log.info("mapper Test isFriend");
		
		log.info(memberMapper.isFriend(2, 3)==2 ? "친구" : "친구아님");
	}
	
	
	// 친구요청중인지 확인
	@Test
	public void isApplyTests() {
		log.info("mapper Test isApply............");
		
		log.info(memberMapper.isApply(7, 8) + "1이면 요청중");
	}
	// 알수도있는사람 리스트
	@Test
	public void getMayKnowListTests() {
		log.info("mapper Test.. getMayKnowListTests");
		Criteria cri = new Criteria();
		cri.setAmount(10);
		memberMapper.getMayKnowList(42,cri).forEach(log::info);
	}
	//함께아는 사람 
	@Test
	public void getMutualFriendsCountTests() {
		log.info("mapper Test.. getMutualFriendsCountTests");
		log.info("함께아는 친구 :: " + memberMapper.getMutualFriendsCount(42, 2) + "명");
	}
	
	
	// Owner 의 친구리스트
	@Test
	public void getOwnerFriendListTests() {
		log.info("mapper Test.. getOwnerFriendListTests");
		memberMapper.getOwnerFriendList(1, 42).forEach(map -> {
			log.info(map.get("school"));
		});
	}
	
}