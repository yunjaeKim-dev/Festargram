<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header class="fixed-top p-0">
	<div class="container">
		<nav class="navbar navbar-expand p-0">
			<a class="navbar-brand" href="/cs/home">
				<img src="/images/logo3.png" alt="고객센터 홈">
			</a>
			<form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 w-50 navbar-search small">
				<div class="input-group w-100">
					<input type="text" class="form-control border-0 my-auto" placeholder="검색할 내용을 입력하세요" aria-label="Search" aria-describedby="basic-addon2">
					<div class="input-group-append">
					<button class="btn btn-dark" type="button">
						<i class="fas fa-search"></i>
					</button>
					</div>
				</div>
			</form>
			<ul class="navbar-nav ml-auto">
				<!--작아졌을떄 나오는 검색아이콘 -->
				<li class="nav-item no-arrow d-sm-none">
					<a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-search fa-fw text-white"></i>
					</a>
					<!--  그아이콘 누르면 나오는 검색바  -->
					<div class="dropdown-menu p-1 w-100 shadow animated--grow-in" aria-labelledby="searchDropdown">
						<form class="form-inline mr-auto w-100 navbar-search">
						<div class="input-group">
							<input type="text" class="form-control border-0 small" placeholder="검색할 내용을 입력하세요" aria-label="Search" aria-describedby="basic-addon2">
							<div class="input-group-append">
							<button class="btn btn-primary" type="button">
								<i class="fas fa-search fa-sm"></i>
							</button>
							</div>
						</div>
						</form>
					</div>
				</li>
			</ul>
			<a href="/post/time">
				<i class="fas fa-undo cursor text-white">타임라인</i>
			</a>
		</nav>
	</div>
</header>