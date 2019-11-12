<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<title>새 비밀번호 설정</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="/js/memberUtility.js"></script>
	<script>
		$(function() {
			$("#submit").click(function() {
				var boolan = true;
				getbirthdate();
				
				
				boolan = boolan && checkpassword($("#password"));
				boolan = boolan && boolan && cmpPassword($("#newpassword"),$("#newConfirmPassword"));
				
				return boolan;
			})
		})
	</script>
</head>
<body>
	<div class="container">
			<div class="text-center mx-auto col-sm-8">
				<div class="mt-3 col-sm-12 text-center auto-magin">
					<h4>비밀번호 재설정</h4>
				</div>

				<form method="POST" class="mt-3 col-sm-12 text-left mx-auto">

					<div class="form-group row">
						<label for="text"
							class="col-sm-12 col-xl-3 min-size-01 mb-2 auot-magin2">새
							아이디</label>
						<div class="col-sm-12 col-xl-8 min-size-07">
							<input type="text" class="form-control" value="${vo.email}" name="email" id="id" readonly>
						</div>
					</div>
					<div class="form-group row">
						<label for="text"
							class="col-sm-12 col-xl-3 min-size-01 mb-2 auot-magin2">새
							비밀번호</label>
						<div class="col-sm-12 col-xl-8 min-size-07">
							<input type="password" class="form-control" value="" id="password">
						</div>
					</div>
					<div class="form-group row">
						<label for="text"
							class="col-sm-12 col-xl-3 mb-2">새
							비밀번호 확인</label>
						<div class="col-sm-12 col-xl-8">
							<input type="password" class="form-control" value="">
						</div>
					</div>
					<input class="d-none" name="cipher" value="${vo.cipher}">
					<div class="form-group text-center">
						<button id="submit">수정하기</button>
					</div>
				</form>

			</div>
		</div>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>