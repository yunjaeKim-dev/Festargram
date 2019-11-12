var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
var regpasswordExp = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
var regExpPhone = "^01[0-9]{1}[0-9]{7,8}$";
var regExmpbirthdate = "^[0-9]{8}$";
var regExmpname = /^[가-힣a-zA-Z]{0,20}$/ ;

function getbirthdate() {
	return $("#birthdate").val(
			$("#year").val() + $("#month").val() + $("#day").val())
}
function checkemail(id) {
	if (!(id.val().match(regExp))) {
		$(id).parent().find("h6").text("아이디는 이메일 형식이어야 합니다.")
		$("#id").next().addClass("text-danger");
	} else if (!(id.val().length >= 6 && id.val().length < 41)) {// 6글자 이상
		$(id).parent().find("h6").text("아이디는 6글자 이상 40글자 이하로 입력해주세요")
		$("#id").next().addClass("text-danger");
	} else {
		$(id).parent().find("h6").text("")
		return true;
	}

	return false;
}

function checkpassword(password) {
	$(password).next().addClass("text-danger");
	$(password).next().removeClass("text-success");
	if (password.val().length == 0) {
		$(password).parent().find("h6").text("비밀번호는 반드시 입력해야합니다.");
		return false ;
	} else if (!(password.val().match(regpasswordExp))) {
		$(password).parent().find("h6").text("비밀번호는 6~20자 이내이고 문자, 숫자 조합이여야합니다.")
		return false ;
	} else {
		$(password).parent().find("h6").removeClass("text-danger");
		$(password).parent().find("h6").text("");
		return true;
	}
	return false;
}

function checkphone(phone) {
	console.log('phone ?? ' + phone.val());
	if (!(phone.val().match(regExpPhone) || phone.val() == null)) {
		console.log('checkPhone false');
		$(phone).parent().find("h6").addClass("text-danger");
		$(phone).parent().find("h6").removeClass("text-success");
		$(phone).parent().find("h6").text("휴대폰 형식이 맞지 않습니다.")
		return false;
	}
	console.log('checkPhone succeess');
	$(phone).parent().find("h6").addClass("text-success");
	$(phone).parent().find("h6").removeClass("text-danger");
	$(phone).parent().find("h6").text("")

	return true;
}

function checkbirthdate(birthdate) {
	if (!(birthdate.val().match(regExmpbirthdate))) {
		$(birthdate).parent().find("h6").addClass("text-danger");
		$(birthdate).parent().find("h6").removeClass("text-success");
		$(birthdate).parent().find("h6").text("생일을 전부 선택해주세요.");
		return false;
	}

	$(birthdate).parent().find("h6").addClass("text-success");
	$(birthdate).parent().find("h6").removeClass("text-danger");
	$(birthdate).parent().find("h6").text("");
	return true;
}

function checkname(name) {
	$(name).parent().find("h6").addClass("text-danger");
	$(name).parent().find("h6").removeClass("text-success");
	if (name.val() == "") {
		$(name).parent().find("h6").text("이름은 반드시 입력하셔야 합니다.");
	} else if (!(name.val().match(regExmpname))) {
		$(name).parent().find("h6").text("한글 , 영문 2~20글자 여야 합니다.");
	} else {
		$(name).parent().find("h6").addClass("text-success");
		$(name).parent().find("h6").removeClass("text-danger");
		$(name).parent().find("h6").text("");
		return true;
	}

	return false;

}

