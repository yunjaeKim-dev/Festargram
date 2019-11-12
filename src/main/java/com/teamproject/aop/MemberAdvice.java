package com.teamproject.aop;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import com.teamproject.domain.Member;
import com.teamproject.security.CustomUserDetailsService;

import lombok.Setter;

@Aspect @Component
public class MemberAdvice {
	@Setter @Autowired
	private CustomUserDetailsService customUserDetailsService ;
	
	@AfterReturning("execution(* com.teamproject.service.MemberService.modify* (..)) && args(vo, auth)")
	public void refreshAuthentication(Member vo, Authentication auth) {
		SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(auth, vo.getEmail()));
	}
	
	
	private Authentication createNewAuthentication(Authentication currentAuth, String username) {
		UserDetails newPrincipal = customUserDetailsService.loadUserByUsername(username);
		UsernamePasswordAuthenticationToken newAuth =
				new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
		newAuth.setDetails(currentAuth.getDetails());
		return newAuth ;
	}
}
