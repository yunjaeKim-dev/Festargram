<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../common/header.jsp" />
<script>
 	$(function(){
		if('${error}'){
			alert('${error}');
		}
		if('${msg}'){
			alert('${msg}');
		}
	}) 
</script>
<main class="nogray py-1"> 
	<div class="container text-center py-5">
		<div class="row text-center py-5">
			<div class="col-12 col-sm-9 col-md-8 col-lg-5 mx-auto px-sm-5 pt-3 pb-5  border bg-snowgray card">
				<div class="card-head">
					<h3 class="mb-5">Festagram 로그인</h3>
				</div> 
				<form method="post" action="/login" class="text-left card-body">
					<div class="form-group">
						<label for="id" class="text-mute small font-weight-bolder">festagram 계정 이메일 </label>
						<input type="text" class="form-control" placeholder="아이디" name="username" id="id" maxlength="40">
					</div>
					<div class="form-group">
						<label for="password" class="text-mute small font-weight-bolder">비밀번호</label>
						<input type="password" class="form-control" placeholder="패스워드" name="password" maxlength="30" id="pssword" autocomplete="none">
					</div>
					<div class="form-group">
						<a href="/sendMail/findPWD">비밀번호 찾기</a>
					</div>
					<div class="form-group">
						<a href="/member/signup">아직 회원이 아니신가요?</a>
					</div>
					<div class="form-group">
						<button class="btn btn-primary btn-block" id="submit">로그인</button>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					
				</form>
			</div>
		</div>
	</div> 
</main>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>