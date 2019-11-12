<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authentication property="principal.member" var="currentUser"/>
<jsp:include page="../common/timelineHeader.jsp" />

<script>
	$(function() {
	
		$("#newpassword").keydown(checkpassword($('#newpassword')));

	/* 	$("#phone").keydown(checkphone($('#phone')));
		$("#name").keydown(checkname($("#name")));

		$("#submit").click(
				function() {
					if ($("#password").val() === "") {
						alert("비밀번호는 입력은 필수 입니다.");
						return false;
					}
					getbirthdate();
					var boolan = true;
					boolan = boolan && checkpassword($('#newpassword"'));
					boolan = boolan && checkphone($("#phone"));
					boolan = boolan && checkname($("#name"));
					boolan = boolan
							&& cmpPassword($("#newpassword"),
									$("#newConfirmPassword"));
					boolan = boolan && checkbirthdate($("#birthdate"));
					return boolan;
				}); */
	});
</script>
<body>
<main class="main-top-padding">
<div class="container">
	<div class="row">
		<div class="col-12">
			<div class="text-center mx-auto mt-4 col-8">
				<h4 class="col-12">회원정보수정</h4>
			</div>

			<form method="POST" action="myinfo" class="mt-3 col-sm-10 mx-auto text-left">
				<div class="row my-3 col-12 border-top pt-3 border-dark">
					<div class="col-md-4 my-auto">
						<label for="email" class="my-auto mb-xl-0">아이디</label>
					</div>
					<div class="col-md">
						<input type="email"	class="form-control col-11 col-12 mt-xl-0 mt-1"	
							value="${currentUser.email}" name="email" id="email" readonly>
					</div>
				</div>
				<div class="row my-3 col-12">
					<div class="col-md-4 my-auto">
						<label for="oldPwd" class="my-auto">현재 비밀번호</label>
					</div>
					<div class="col-md">
						<input type="password" class="form-control mt-xl-0 mt-1" name="oldPwd" id="oldPwd" readonly="readonly" value="******">
					</div>
				</div>
				<div class="row my-3 col-12">
					<div class="col-md-4 my-auto">
						<label for="password" class="my-auto">새 비밀번호</label>
					</div>
					<div class="col-md">
						<input type="password" class="form-control mt-xl-0 mt-1" name="password" id="password" maxlength="30">
					</div>
				</div>
				<div class="row my-3 col-12">
					<div class="col-md-4 my-auto">
						<label for="newPwd" class="my-auto">새 비밀번호 확인</label>
					</div>
					<div class="col-md">
						<input type="password" class="form-control mt-xl-0 mt-1" id="newPwd"  maxlength="30">
					</div>
				</div>
				<div class="row my-3 col-12">
					<div class="col-md-4 my-auto">
						<label for="name" class="my-auto">이름</label>
					</div>
					<div class="col-md">
						<input type="text" class="form-control mt-xl-0 mt-1" maxlength="8"
							value="${currentUser.name}" name="name" id="name">
					</div>
				</div>
				<div class="row my-3 col-12 ">
					<div class="col-md-4 my-auto">
						<label for="phone" class="my-auto">휴대전화</label>
					</div>
					<div class="col-md">
						<input type="tel" name="phone" class="form-control mt-xl-0 mt-1"
							maxlength="11" value="${currentUser.phone}" id="phone">
					</div>
				</div>
				<div class="row my-3 col-12 ">
					<div class="col-md-4 my-auto">
						<label for="text" class="my-auto">생년월일</label>
					</div>
					<div class="col-md">
						<div class="row col-12">
							<div class="col-lg-4 col-md-5 col-sm-5 col-4 pl-0">
								<select class="form-control" id="year">
									<option selected="selected" value="">년</option>
									<c:forEach begin="0" end="69" var="i">
										<option value="${2019 - i}">${2019 -i}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-lg-3 col-md col-sm col pl-0">
								<select class="form-control" id="month">
									<option selected="selected" value="">월</option>
									<option value="01">01</option>
									<option value="02">02</option>
									<option value="03">03</option>
									<option value="04">04</option>
									<option value="05">05</option>
									<option value="06">06</option>
									<option value="07">07</option>
									<option value="08">08</option>
									<option value="09">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
								</select>
							</div>
							<div class="col-lg-3 col-md col-sm col pl-0">
								<select class="form-control" id="day">
									<option selected="selected">일</option>
									<option value="01">01</option>
									<option value="02">02</option>
									<option value="03">03</option>
									<option value="04">04</option>
									<option value="05">05</option>
									<option value="06">06</option>
									<option value="07">07</option>
									<option value="08">08</option>
									<option value="09">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									<option value="25">25</option>
									<option value="26">26</option>
									<option value="27">27</option>
									<option value="28">28</option>
									<option value="29">29</option>
									<option value="30">30</option>
									<option value="31">31</option>
								</select>
								<input type="hidden" id="birthdate" name="birthdate">
								<!--생년월일을 합쳐서 보낸기 위한 태그 -->
							</div>
						</div>
					</div>
				</div>
				<div class="col-12 border-bottom pb-3 border-dark">
					<button class="btn btn-primary btn-block" id="submitBtn">수정</button>
				</div>
			</form>
		</div>
	</div>
</div>
</main>
<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>