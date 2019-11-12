<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8'>
  <meta name="viewport" content="width=device-width initial-scale=1">
  <title>${title}</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link href="/css/webstyles.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <script>
  	$(function(){
  		$("#loginBtn").click(function(){
  			var mail = $("#email").val();
  			var pw = $("#pwd").val()
/*   			if(mail.length == 0){
  				alert("아이디를 입력해주세요.");
  				$("#email").focus();
  				$("#headLogin").submit();
  			}
  			if(pw.length == 0){
  				alert("비밀번호를 입력해주세요.");
  				$("#pwd").focus();
  				$("#headLogin").submit();
  			} */
  			$("#headLogin").submit();
  		});
  		
  		$("#email, #pwd").keydown(function(key){ // 엔터키 누르면 로그인
  			if(key.keyCode == 13){
  				$("#loginBtn").click();
  			}
  		});
  		
  		
  	})
  </script>
</head>
<body>
<header>
	<div class="container">
	  <div class="row">
	    <div class="col-xl-3 col-lg-2">
	    <a href="/" class="float-left">
		    <img src="/images/logo/Festargram-logo-white.png" class="d-lg-none d-xl-block logo-lg-icon">
		    <img src="/images/logo/F-logo-white.png" class="d-none d-lg-block d-xl-none alarm-icon">
	    </a>  
	    <div class="d-xl-none d-lg-none float-right">
	    	<a href="/member/login" class="btn btn-primary">로그인</a> 
	    </div>
	    </div>
	    <div class="col-xl-1 d-none d-xl-block"></div>
	    <div class="col-xl-8 col-lg-10 d-none d-xl-block d-lg-block d-xl-none">
	      <form method="post" class="form-inline" id="headLogin" action="/login">
	      	<div>
		        <label for="email">Email : 
		        <input type="text" class="form-control m-2" id="email" placeholder="이메일을 적어주세요." name="username"></label>
	        </div>
	        <div>
		        <label for="pwd">Pw : 
		        <input type="password" class="form-control m-2" id="pwd" placeholder="비밀번호를 적어주세요" name="password"></label>
	        </div>
	       <!--  <div class="form-check">
	          <label class="form-check-label">
	            <input class="form-check-input" type="checkbox" name="remember">아이디 저장
	          </label>
	        </div> -->
	        <button type="button" class="btn btn-primary" id="loginBtn">로그인</button>
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	      </form>
	    </div>
	    
	  </div>
	</div>
</header>