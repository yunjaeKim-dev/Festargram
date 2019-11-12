package com.teamproject.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.teamproject.domain.Member;
import com.teamproject.mapper.MemberMapper;
import com.teamproject.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	@Setter @Autowired
	private MemberMapper memberMapper ;
	
		
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("회원의 이메일은 :: " + username);
		
		Member member = memberMapper.read(username);
		log.warn("-------------------------------------------------------");
		log.warn("read 후 멤버객체는 ::" + member );
		return member == null ? null : new CustomUser(member);
	}
	
}
