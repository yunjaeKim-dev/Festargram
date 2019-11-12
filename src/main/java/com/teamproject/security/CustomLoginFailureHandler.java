package com.teamproject.security;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.teamproject.domain.Member;
import com.teamproject.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {
	@Setter @Autowired
	MemberMapper memberMapper ;
	
	
		
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		log.info("CustomLoginFailureHandler....");
		log.info(request.getParameter("username"));
		
		String error = "";
		String username = request.getParameter("username");
		Member vo = memberMapper.getByEmail(username);
	/*	if(vo != null) {
			if(vo.getState().equals("1")) {
				error = URLEncoder.encode("탈퇴한 회원입니다 고객센터에 문의하세요", "utf-8");
				response.sendRedirect("/member/login?error=" + error);
				return ;
			}
		}
		error = URLEncoder.encode("아이디 혹은 패스워드가 일치하지 않습니다.", "utf-8");
		response.sendRedirect("/member/login?error=" + error);*/
		if(vo != null) {
			if(vo.getState().equals("1")) {
				request.setAttribute("error", "탈퇴한 회원입니다 고객센터에 문의하세요");
				request.getRequestDispatcher("/member/login").forward(request, response);
				return ;
			}
		}
		request.setAttribute("error", "아이디 혹은 패스워드가 일치하지 않습니다.");
		request.getRequestDispatcher("/member/login").forward(request, response);
		
	}
	

}
