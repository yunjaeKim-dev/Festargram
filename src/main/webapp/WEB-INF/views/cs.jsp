<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<head>
  <meta charset='utf-8'>
  <meta name="viewport" content="width=device-width initial-scale=1">
  <title>고객지원</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link href="/css/webstyles.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <link href="/vendor/fontawesome-free/css/all.min.css" type="text/css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="cs/cs_header.jsp"></jsp:include>
<div class="container">
	<h2>Toggleable Tabs</h2><br>
	<ul class="nav nav-tabs" role="tablist">
		<li class="nav-item">
			<a class="nav-link active" data-toggle="tab" href="#home">Home</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="tab" href="#menu1">사용문의</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="tab" href="#menu2">계정관리</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="tab" href="#menu2">보안</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="tab" href="#menu2">이용약관</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-toggle="tab" href="#menu2">1:1문의</a>
		</li>
	</ul>

	<div class="tab-content">
		<div id="home" class="container tab-pane active"><br>
			<h3>자주묻는 질문</h3>
			<div id="accordion">
				<jsp:include page="cs/cs_home_content.jsp"></jsp:include>
			</div>
		</div>
		<div id="menu1" class="container tab-pane fade"><br>
			<h3>사용문의맨</h3>
			<p></p>
		</div>
		<div id="menu2" class="container tab-pane fade"><br>
			<h3>계정관리맨</h3>
			<p></p>
		</div>
		<div id="menu3" class="container tab-pane fade"><br>
			<h3>보안맨</h3>
			<p></p>
		</div>
		<div id="menu4" class="container tab-pane fade"><br>
			<h3>이용약관맨</h3>
			<p></p>
		</div>
		<div id="menu5" class="container tab-pane fade"><br>
			<h3>1:1문의맨</h3>
			<p></p>
		</div>
	</div>
</div>
<jsp:include page="common/footer.jsp"></jsp:include>
</body>
</html>