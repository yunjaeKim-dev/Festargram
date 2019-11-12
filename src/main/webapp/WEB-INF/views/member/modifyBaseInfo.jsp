<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.teamproject.domain.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>

<jsp:include page="../common/timelineHeader.jsp"/>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.member" var="currentUser"/>
</sec:authorize>
<c:set var="currentUserProfimg" value="${fn:replace(currentUser.profimg,'/profile/', '/profile/s_') }"></c:set>


<script src="/js/common.js"></script>
<script src="/js/post.js"></script>
<script src="/js/reply.js"></script>
<script src="/js/memberUtility.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>
		$(function() {
			
			// 회원 정보 변경용 패스워드체크 함수
			function checkModifyPassword(password) {
				$(password).next().addClass("text-danger").removeClass("text-success");
				if (password.val().length != 0) {
					 if (!(password.val().match(regpasswordExp))) {
							$(password).parent().find("h6").text("비밀번호는 6~20자 이내이고 문자, 숫자 조합이여야합니다.")
							return false ;
						} else {
							$(password).parent().find("h6").removeClass("text-danger");
							$(password).parent().find("h6").text("");
							return true;
						}
				}
				return true;
			}

			function checkModifyPhone(phone) {
				if( phone.val().length != 0){
					if (!(phone.val().match(regExpPhone))) {
						console.log('checkPhone false');
						$(phone).parent().find("h6").addClass("text-danger").removeClass("text-success").text("휴대폰 번호 형식이 올바르지 않습니다.");
						return false;
					}
				}
				console.log('checkPhone succeess');
				$(phone).parent().find("h6").addClass("text-success").removeClass("text-danger").text("");

				return true;
			}
			
			
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			$(document).ajaxSend(function(e, xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			})
			
			
			
			var currentUserYear = '${currentUser.birthdate.substring(0,4)}';
			var currentUserMonth = '${currentUser.birthdate.substring(5,7)}';
			var currentUserDay = '${currentUser.birthdate.substring(8,10)}';
			console.log(currentUserYear);
			console.log(currentUserMonth);
			console.log(currentUserDay);
			
			
			// 생일 input에 나타내기
			$("#year").val(currentUserYear);
			$("#month").val(currentUserMonth);
			$("#day").val(currentUserDay);
			
			
			
			getbirthdate();
			
			$("#delBtn").click(function(){ //회원탈퇴시
				var result = confirm("정말 탈퇴 하시겠습니까?");
				if(result){
					alert("그동안 이용해 주셔서 감사합니다.");
					$(this).submit();
				}else{
					alert("탈퇴가 취소 되었습니다.");
					return false;
				}
			})
			
			$("#modBtn").click(function(){ //정보수정시
				if (!checkModifyPassword($("#password"))) {
					$("#password").focus();
					return false;
				}
				if($("#cmppassword").val() != $("#password").val()){
					$("#cmppassword").focus();
					$("#cmppassword").parent().find("h6").addClass("text-danger");
					$("#cmppassword").parent().find("h6").removeClass("text-success");
					$("#cmppassword").parent().find("h6").text("비밀번호 확인이 일치하지 않습니다.");
					return false;
				}
				if (!checkname($("#name"))) {
					$("#name").focus();
					return false;
				}
				if (!checkModifyPhone($("#phone"))) {
					$("#phone").focus();
					return false;
				}
				if (!checkbirthdate($("#birthdate"))) {
					$("#birthdate").focus();
					return false;
				}
				alert("수정완료!");
				getbirthdate();
				return $("#MemModifyForm").submit();
			})
			
			
		})
	</script>
	<main class="main-top-padding">
		<div class="container text-center py-5">
			<div class="row text-center">
				<div class="col-12 mb-3">
					<h3>회원 정보 변경</h3>
				</div>
			</div> 
			<div class="row text-center">
				<div class="col-12 col-sm-9 col-md-8 col-lg-5 mx-auto">
					<form method="post" class="text-left" id="MemModifyForm" action="/member/modifyBaseInfo">
						<div class="form-group">
							<label for="id" class="text-mute small font-weight-bolder not-check">festagram 계정 이메일 </label>
							<input type="text" class="form-control " id="id" placeholder="이메일형식의 아이디를 입력해주세요" name="email" maxlength="40" autocomplete="off" spellcheck="false" value="${currentUser.email}" readonly="readonly">
							<h6 class="pt-2 small"></h6>
						</div>
						<div class="form-group">
							<label for="password" class="text-mute small font-weight-bolder">비밀번호 <span class="text-muted"> (변경시에만 입력하세요.)</span></label>
							<input type="password" class="form-control "placeholder="비밀번호를 입력해주세요." name="password" id="password" autocomplete="off" spellcheck="false" >
							<h6 class="pt-2 small"></h6>
						</div>
						<div class="form-group">
							<input type="password" class="form-control "placeholder="비밀번호 재입력" id="cmppassword" autocomplete="off" spellcheck="false" >
							<h6 class="pt-2 small"></h6>
						</div>
						<div class="form-group">
							<label for="name" class="text-mute small font-weight-bolder">이름</label>
							<input type="text" class="form-control" maxlength="20" id="name" placeholder="ex ) 김복자, Anderson David" name="name" autocomplete="off" spellcheck="false" value="${currentUser.name}">
							<h6 class="pt-2 small"></h6>
						</div>
						<div class="form-group">
							<label for="phone" class="text-mute small font-weight-bolder">휴대폰 번호</label>
							<input type="text" class="form-control " id="phone" placeholder="ex ) 01045648752" maxlength="11" name="phone" autocomplete="off" spellcheck="false" value="${currentUser.phone}">
							<h6 class="pt-2 small"></h6>
						</div>
						<div class="form-group">
							<div class="text-mute small font-weight-bolder mb-2">생일</div>
							<div class="row col-12">
								<div class="col-lg-4 col-md-5 col-sm-5 col-4 pl-0">
									<select class="form-control" id="year">
										<option selected="selected" value="">년</option>
										<c:forEach begin="0" end="69" var="i">
											<option value="${2019 -i}">${2019 - i }</option>
										</c:forEach>
									</select>
								</div>
								<div class="col-lg-3 col-md col-sm col pl-0">
									<select class="form-control" id="month">
										<option selected="selected" value="">월</option>
										<c:forEach begin="1" end="12" var="i">
										<c:set var="month"><fmt:formatNumber minIntegerDigits="2" value="${i}" /></c:set>
											<option value="${month}"><fmt:formatNumber minIntegerDigits="2" value="${i}" /></option>
										</c:forEach>
									</select> 
								</div>
								<div class="col-lg-3 col-md col-sm col pl-0">
									<select class="form-control" id="day">
										<option selected="selected" value="">일</option>
										<c:forEach begin="1" end="31" var="i">
										<c:set var="day"><fmt:formatNumber minIntegerDigits="2" value="${i}" /></c:set>
											<option value="${day}"><fmt:formatNumber minIntegerDigits="2" value="${i}"/></option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group">
									<input type="hidden" id="birthdate" name="birthdate">
								</div>
								<!--생년월일을 합쳐서 보낸기 위한 태그 -->
							</div>
						</div>
						<div class="form-group my-5">
							<button type="button" class="btn btn-primary btn-block" id="modBtn">수정하기</button>
							<button type="submit" class="btn btn-danger btn-block" id="delBtn" formaction="/member/removeMember" formmethod="post">회원 탈퇴 하기</button>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						<input type="hidden" name="mno" value="${currentUser.mno}">
					</form>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>