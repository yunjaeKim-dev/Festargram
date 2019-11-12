package com.teamproject.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		
		log.info("login success..~");
		List<String> roleNames = new ArrayList<>();
		
		auth.getAuthorities().forEach(a->{
			roleNames.add(a.getAuthority());
		});
		
		log.warn(roleNames);
		
		if(roleNames.contains("ROLE_USER")) {
			log.info("로그인한 사용자의 권한은  ROLE_USER");
			response.sendRedirect("/post/time");
			return ;
		}
		
	}
	
}
