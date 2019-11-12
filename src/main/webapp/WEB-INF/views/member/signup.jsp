<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe0c4ed56df599130b5cb3f741e2c237"></script>
<body>
	<jsp:include page="../common/header.jsp" />
	<script src="/js/memberUtility.js"></script>
	<script>
		$(function() {
			
			
			
			
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			$(document).ajaxSend(function(e, xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			})
			if('${msg}'){
				alert('${msg}');
			}
			
			//유효성검사 flag 변수
			var idck = false;
			
			
			function checkId(){
				if (checkemail($("#id"))) {
					var email = $("#id").val();
					
					var promise = $.ajax({
						contentType : "application/json; charset=UTF-8",
						type : 'post',
						url : '/member/doubleCheck',
						data : JSON.stringify({email : email})
					});
					promise.done(function(data){
						console.log('data :: ' +  data);
						if(data=='available'){
							console.log('available!!');
							tu = true ;
							$("#id").next().text('사용 가능한 아이디 입니다.').removeClass("text-danger").addClass("text-success");
						}else if(data =='unavailable'){
							console.log('unavailable!!!');
							tu = false ;
							$("#id").next().text('이미 사용중인 아이디 입니다.').removeClass("text-success").addClass("text-danger");
						}
					});
				}else{
					tu = false ;
				}
				$("#id").next().removeClass("text-success");
				$("#id").next().addClass("text-danger");
			}
			// 아이디 포커스아웃될때마다 유효성검사
			$("#id").change(function(){
				checkId();
			}); 
			
			$("#testbtn").click(function(){
				alert(tu);
			})
			$("#cmppassword").keyup(function(){
				console.log('cmp :: ' + $("#cmppassword").val());
				console.log('pwd :: ' + $("#password").val());
				if($("#cmppassword").val() != $("#password").val()){
					$("#cmppassword").focus();
					$("#cmppassword").parent().find("h6").addClass("text-danger");
					$("#cmppassword").parent().find("h6").removeClass("text-success");
					$("#cmppassword").parent().find("h6").text("비밀번호 확인이 일치하지 않습니다.");
				}else{
					$("#cmppassword").parent().find("h6").text("");
				}
			})
			
			$("#signupForm").submit(function() {
				getbirthdate();
				checkId() ;
				if (!tu) {
					$("#id").focus();
					return false;
				}
				if (!checkpassword($("#password"))) {
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
				if (!checkphone($("#phone"))) {
					$("#phone").focus();
					return false;
				}
 
				if (!checkbirthdate($("#birthdate"))) {
					$("#birthdate").focus();
					return false;
				}
				return true ;
			})
			getbirthdate()
		})
	</script>
	<main>
		<div class="container text-center py-5">
			<div class="row text-center">
				<div class="col-12 mb-3">
					<h3>새 계정 만들기</h3>
				</div>
			</div> 
			<div class="row text-center">
				<div class="col-12 col-sm-9 col-md-8 col-lg-5 mx-auto">
					<form method="post" class="text-left" id="signupForm">
						<div class="form-group">
							<label for="id" class="text-mute small font-weight-bolder">festagram 계정 이메일 </label>
							<input type="text" class="form-control " id="id" placeholder="이메일형식의 아이디를 입력해주세요" name="email" maxlength="40" autocomplete="off" spellcheck="false">
							<h6 class="pt-2 small"></h6>
						</div>
						<div class="form-group">
							<label for="password" class="text-mute small font-weight-bolder">비밀번호</label>
							<input type="password" class="form-control "placeholder="비밀번호를 입력해주세요." name="password" id="password" autocomplete="off" spellcheck="false">
							<h6 class="pt-2 small"></h6>
						</div>
						<div class="form-group">
							<input type="password" class="form-control "placeholder="비밀번호 재입력" id="cmppassword" autocomplete="off" spellcheck="false">
							<h6 class="pt-2 small"></h6>
						</div>
						<div class="form-group">
							<label for="name" class="text-mute small font-weight-bolder">이름</label>
							<input type="text" class="form-control" maxlength="20" id="name" placeholder="ex ) 김복자, Anderson David" name="name" autocomplete="off" spellcheck="false">
							<h6 class="pt-2 small"></h6>
						</div>
						<div class="form-group">
							<label for="phone" class="text-mute small font-weight-bolder">휴대폰 번호</label>
							<input type="text" class="form-control " id="phone" placeholder="ex ) 01045648752" maxlength="11" name="phone" autocomplete="off" spellcheck="false">
							<h6 class="pt-2 small"></h6>
						</div>
						<div class="form-group">
							<div class="text-mute small font-weight-bolder mb-2">생일</div>
							<div class="row col-12">
								<div class="col-lg-4 col-md-5 col-sm-5 col-4 pl-0">
									<select class="form-control" id="year">
										<option selected="selected" value="">년</option>
										<option value="2019">2019</option>
										<option value="2018">2018</option>
										<option value="2017">2017</option>
										<option value="2016">2016</option>
										<option value="2015">2015</option>
										<option value="2014">2014</option>
										<option value="2013">2013</option>
										<option value="2012">2012</option>
										<option value="2011">2011</option>
										<option value="2010">2010</option>
										<option value="2009">2009</option>
										<option value="2008">2008</option>
										<option value="2007">2007</option>
										<option value="2006">2006</option>
										<option value="2005">2005</option>
										<option value="2004">2004</option>
										<option value="2003">2003</option>
										<option value="2002">2002</option>
										<option value="2001">2001</option>
										<option value="2000">2000</option>
										<option value="1999">1999</option>
										<option value="1998">1998</option>
										<option value="1997">1997</option>
										<option value="1996">1996</option>
										<option value="1995">1995</option>
										<option value="1994">1994</option>
										<option value="1993">1993</option>
										<option value="1992">1992</option>
										<option value="1991">1991</option>
										<option value="1990">1990</option>
										<option value="1989">1989</option>
										<option value="1988">1988</option>
										<option value="1987">1987</option>
										<option value="1986">1986</option>
										<option value="1985">1985</option>
										<option value="1984">1984</option>
										<option value="1983">1983</option>
										<option value="1982">1982</option>
										<option value="1981">1981</option>
										<option value="1980">1980</option>
										<option value="1979">1979</option>
										<option value="1978">1978</option>
										<option value="1977">1977</option>
										<option value="1976">1976</option>
										<option value="1975">1975</option>
										<option value="1974">1974</option>
										<option value="1973">1973</option>
										<option value="1972">1972</option>
										<option value="1971">1971</option>
										<option value="1970">1970</option>
										<option value="1969">1969</option>
										<option value="1968">1968</option>
										<option value="1967">1967</option>
										<option value="1966">1966</option>
										<option value="1965">1965</option>
										<option value="1964">1964</option>
										<option value="1963">1963</option>
										<option value="1962">1962</option>
										<option value="1961">1961</option>
										<option value="1960">1960</option>
										<option value="1959">1959</option>
										<option value="1958">1958</option>
										<option value="1957">1957</option>
										<option value="1956">1956</option>
										<option value="1955">1955</option>
										<option value="1954">1954</option>
										<option value="1953">1953</option>
										<option value="1952">1952</option>
										<option value="1951">1951</option>
										<option value="1950">1950</option>
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
										<option selected="selected" value="">일</option>
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
								</div>
								<div class="form-group">
									<input class="d-none" id="birthdate" name="birthdate">
									<h6 class="pt-2 small"></h6>
								</div>
								<!--생년월일을 합쳐서 보낸기 위한 태그 -->
							</div>
						</div>
						<div class="form-group my-5">
							<button class="btn btn-primary btn-block">가입하기</button>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						<div id="map" style="width:500px;height:400px;"></div>
						
					</form>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp"></jsp:include>
</body>
</html>