<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../common/header.jsp" />
<script>
$(function(){
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(function(e, xhr){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	})
	
	$(".sendMail").click(function(){
		var mail = $(this).parent().parent().find("#email").val();
		mail = mail.trim()
		if(mail.length == 0){
			alert("이메일을 입력해주세요.");
			$(this).parent().parent().find("#email").focus();
			return false;
		}
		
		$.ajax({
			contentType : "application/json; charset=UTF-8",
			type : 'post',
			url : '/member/doubleCheck',
			data : JSON.stringify({email : mail}),
			dataType : 'text', 
			success : function(data){
				console.log(data);
				if(data=='unavailable'){
					alert("회원님의 이메일에 임시비밀번호를 전송했습니다.");
					return $("#findPWDForm").submit();
				}else{
					alert("해당 회원이 존재하지 않습니다.")
					return false;
				}
			}
		});
		
	});
})
</script>
<main class="mb-5 nogray">
	<div class="container text-center py-5">
		<div class="row text-center py-5">
			<div class="col-12 col-sm-9 col-md-8 col-lg-5 mx-auto px-sm-5 py-5  border bg-snowgray card"> 
				<h3 class="mb-5 card-head">Festagram 비밀번호 찾기</h3>
				<form method="post" class="text-left card-body" id="findPWDForm">
					<div class="form-group">
						<label for="email" class="text-mute small font-weight-bolder">festagram 계정 이메일 </label>
						<input type="text" class="form-control" placeholder="아이디" name="email" id="email" maxlength="40">
					</div>
					<div class="form-group">
						<a href="/member/signup">아직 회원이 아니신가요?</a>
					</div>
					<div class="form-group">
						<button class="btn btn-primary btn-block sendMail" type="button">전송하기</button>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>
			</div>
		</div>
	</div> 
	<div class="py-5">
	</div> 
	<div class="py-1"></div>
	<div class="py-1"></div>
	<div class="py-4">
	 
	</div>
</main>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>	