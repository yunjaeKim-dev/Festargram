package com.teamproject.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.teamproject.domain.Member;

import lombok.Getter;

@Getter
public class CustomUser extends User{
	private Member member ;


	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(Member member) {
		super(member.getEmail(), member.getPassword(), member.getAuthList().stream()
				.map(a -> 
				new SimpleGrantedAuthority(a.getAuth())).collect(Collectors.toList()));
		this.member = member; 
	}
	
}
