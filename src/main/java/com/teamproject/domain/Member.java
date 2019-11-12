package com.teamproject.domain;


import java.util.List;

import com.teamproject.domain.AuthVO;

import lombok.Data;

@Data
public class Member {
	//이메일형식아이디
	private String email;
	//비밀번호
	private String password;
	// 회원이름
	private String name;
	// 회원연락처
	private String phone;
	// 회원주소
	private String address;
	// 회원성별
	private String gender;
	//회원 생년월일
	private String birthdate;
	// 가입일
	private String joindate;
	// 최근접속일
	private String recdate;
	// 회원상태(나중에 탈퇴유무)
	private String state;
	// 마이페이지에 따로 정보수정할 기타 정보들
	private String school;
	private String job;
	private String interesting;
	// 회원프로필이미지,및 커버이미지
	private String coverimg;
	private String profimg;
	// 회원 자기소개
	private String selfintro;
	
	//회원번호
	private int mno ;
	
	//친구리스트
	private List<Member> friendList ;
	// 권한
	private List<AuthVO> authList ;
}
