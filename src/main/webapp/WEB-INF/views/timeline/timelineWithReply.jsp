<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8'>
  <meta name="viewport" content="width=device-width initial-scale=1">
  <title>timeLine</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link href="/css/webstyles.css" rel="stylesheet" type="text/css">
  <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <script>
  	function sidebarResize(){
		$("#left-sidebar").css("width",$("#sidebar-box").css("width"))
		$("#left-sidebar").css("height",$(window).height())
  	}
  	
  	function textareaResize(obj,fontsize){
  		if($(obj).prop('scrollHeight') < (fontsize * 3.5)){
  			return false;
  		}
  		$(obj).height(1).height($(obj).prop('scrollHeight')+fontsize) ;
  	}
  	
	$(function(){
		
		/* 사이드바 리사이즈 */
		sidebarResize(); 
		$(window).resize(function(){
			sidebarResize();
		});
		
		/* 친구알림  */
        $(".friend").hover(function(){
            $(this).children("td:nth-child(2)").children("div").children(".close")
            .css("display","block").parent()
        },function(){
        	$(this).children("td:nth-child(2)").children("div").children(".close")
        	.css("display","none")
        }
        )
		
        $(".reply-register").click(function(){
        	e.preventDefault();
				/* 좀더고민  */        	
        })
        
        
        $(".post-register-textarea").on('keydown keyup', function(){
        	textareaResize(this,16) ;
        	console.log($(this).css("font-size"));
        })
        
        $(".reply-register-textarea").on('keydown keyup', function(){
        	console.log(event);
        	console.log($(this).css("font-size"));
        	textareaResize(this,12.8) ;
        })
        
	})
  </script>
  <style>
  	main{min-height:1000px;}/* 추후지울것 */
  </style>
</head>
<body>
<jsp:include page="../common/timelineHeader.jsp"/>
	<main class="main-top-padding">
		<div class="container pt-2">
			<div class="row">
			<!---------좌측사이드바 --------->
				<jsp:include page="../common/sidebar.jsp"/>
				
	<!--------------------------- 메인 타임라인 ------------------------------->
				<div class="col-md-6 mt-1 rounded mt-2">
				<!---- 게시글 작성 ------- -->
					<div class="bg-white mb-4 rounded">
						<div class="bg-secondary py-2 px-3 rounded-top">
							<h6 class="m-0 text-dark">게시글 작성</h6>
						</div>
						<form>
							<div class="row m-0 pt-2 px-2 border-bottom">
								<div class="col-1 p-0">
									<img src="/images/alarm/friend.png" class="rounded-circle alarm-icon post-profile-icon" alt="프로필사진">
								</div>
								<div class="col-11">
									<textarea placeholder="세션에로그인된 유저님, 무슨 생각 하고 계심니까?" class="w-100 border-0 post-register-textarea" maxlength="5000" style="resize: none" ></textarea>
								</div>
							</div>
							<!-- 썸네일 등장하고 inputfile과 label 이 생길영역 -->
							<div>
							
							</div>
							
							<div class="small py-2 pl-lg-5 pl-md-2 pl-3">
								<div class="btn btn-light mx-xl-4 mx-sm-2 rounded-pill">
									<label for="file1" class="m-0">
										<span>
											<i class="fas fa-image"></i>
											사진/동영상
										</span>
									</label>
									<input type="file" id="file1" name="postFiles" class="d-none">
								</div>
								<div class="btn btn-light mx-xl-4 mx-sm-2 rounded-pill">
									<span>
										<i class="fas fa-user-tag"></i>
										친구 태그하기
									</span>
								</div>
								<div class="btn btn-light mx-xl-4 mx-sm-2 rounded-pill">
									<i class="fas fa-ellipsis-h"></i>
								</div>
								
							</div>
						</form>
					</div>
					
					<!-------------------------- 타임라인리스트 ------------------------------->
					<div class="bg-white rounded">
						<div>
							<div class="py-2 px-3 position-relative">
								<!-- 더보기버튼 -->
								<div class="mt-n2 position-absolute" style="right:0;left:0">
									<div class="position-absolute mt-2 mr-2" style="right:0">
										<i class="fas fa-ellipsis-h dropdown"></i>
									</div>
								</div>
								
						<!------------------- 타임라인 제목부분 ------------------->
								<div>
									<div class="clearfix">
										<div class="mr-2 float-left">
											<a href="#">
												<img src="/images/alarm/friend.png" class="rounded-circle alarm-icon post-profile-icon" alt="프로필사진">
											</a>
										</div>
										<div class="float-left">
											<h6 class="m-0"><a href="#">Power Over Whelming</a></h6>
											<span class="small">10월 5일 오후 11:00</span>
										</div>
									</div>
								</div>
								
						<!--------------------------- 본문 --------------------->
								<div>
									<textarea class="w-100 border-0" style="resize: none" readonly="readonly" rows="5">나는 오늘도... 눈물을 흘린다 
투명드래곤이 울부 짖어따
									</textarea>
								</div>
							</div>
							<div style="height:500px;">
								<div class="row m-0 h-50">
									<div class="col-6 p-0">
										<img src="/images/mypage/cover.jpg" class="img-thumbnail w-100 h-100">
									</div>
									<div class="col-6 p-0">
										<img src="/images/mypage/cover.jpg" class="img-thumbnail w-100 h-100">
									</div>
								</div>
								<div class="row m-0 h-50">
									<div class="col-6 p-0">
										<img src="/images/mypage/cover.jpg" class="img-thumbnail w-100 h-100">
									</div>
									<div class="col-6 p-0">
										<img src="/images/mypage/cover.jpg" class="img-thumbnail w-100 h-100">
									</div>
								</div>
							</div>
						<!----------------------------- 댓글부분 ------------------------->
							<div>
								<div class="">
									<div class="py-2 mx-3 d-flex justify-content-between border-bottom">
										<div class="">
											<i class="fas fa-thumbs-up text-primary mr-2"></i>
											<span class="small">125</span>
										</div>
										<div>
											<div class="d-inline mx-2 small text-dark">댓글 <span>15</span>개</div>
											<div class="d-inline mx-2 small text-dark ">공유 <span>66</span>회</div>
										</div>
									</div>
									<div class="border-bottom">
										<div class="m-0 text-center px-3 py-2 row justify-content-between">
											<div class="col-4 cursor">
												<i class="far fa-thumbs-up"></i>
												<span>좋아요</span>
											</div>
											<div class="col-4 cursor">
												<i class="far fa-comment-alt"></i>
												<span>댓글</span>
											</div>
											<div class="col-4 cursor">
												<i class="fas fa-share"></i>
												<span>공유</span>
											</div>
										</div>			
									</div>
								</div>
		<!-------------------------------------------- 댓글 작성 ---------------------------------->
								<div class="px-2 pt-2">
									<div class="row m-0 mb-2">
										<div class="col-2 col-sm-1 col-md-2 col-lg-1 p-0 text-center">
											<img alt="로그인된유저 아이콘" src="/images/friend.png" class="reply-icon rounded-circle">
										</div>
										<div class="col-10 col-sm-11 col-md-10 col-lg-11 p-0">
											<form>
												<div class="position-relative">
													<div>
														<textarea rows="1" placeholder="댓글을 입력하세요" class="reply-radius pr-5 pl-3 py-2 small border d-block w-100 reply-register-textarea" style="resize:none"></textarea>
													</div>
													<div class="position-absolute bottom right">
														<label for="replyFile" class="m-0 mr-3 px-3 py-1 pb-2 cursor" title="사진 첨부">
															<i class="fas fa-image text-secondary"></i>
														</label>
														<input type="file" id="replyFile" name="replyFile" class="d-none"> 
													</div>
												</div>
											</form>
										</div>
									</div>
	<!--------------------------------- 댓글목록 ------------------------------------------------>
									<div class="">
										<ul class="p-0">
											<li class="mb-2">
												<div class="row m-0">
													<div class="col-1 p-0 text-center">
														<img alt="로그인된유저 아이콘" src="/images/friend.png" class="reply-icon rounded-circle">
													</div>
													<div class="col-10 p-0">
													<!-- div에 바로 텍스트쓰는상황이라 일부러 붙여쓴행임  -->
														<div class="d-inline-block bg-snowgray m-0 py-1 px-2 small pre-line reply-radius"><a href="#" class="mr-2 font-weight-bold">장두석</a>안녕하세요?저는 잘생긴 장두석입니다. 하하하하하하 호호호호호호 </div>
														<div class="small">
															<ul class="nav">
																<li class="nav-item">
																	<a href="#" class="px-1 mx-1">좋아요</a>
																	<!-- 댓글좋아요 갯수 -->
																	<div class="d-inline">
																		<i class="fas fa-thumbs-up text-primary small"></i>
																		<span class="small">125</span>
																	</div>
																</li>
																<li class="nav-item">
																	<span>&nbsp;·&nbsp;</span>
																</li>
																<li class="nav-item">
																	<a href="#" class="px-1 mx-1 reply-register">답글달기</a>
																</li>
																<li class="nav-item">
																	<a class="px-1 mx-1">4시간</a>
																</li>
															</ul>
														</div>
													</div>
													<div class="col-1 p-0 text-center dropdwon dropright">
														<i class="fas fa-ellipsis-h cursor dropdown-toggle" data-toggle="dropdown"></i>
														<div class="dropdown-menu">
															<a class="dropdown-item cursor">수정</a>
															<a class="dropdown-item cursor">삭제</a>
														</div>
													</div>
												</div>
	<!--------------------------------------------- 대댓글이있을경우 필요한 영역 ---------------------------->
												<div class="pl-5 pt-2">
													<div class="pt-1">
														<i class="fas fa-reply rotate-180"></i>
												<!------ 현재 데이터토글형태로하긴했는데 여러개일시 아이디값이 중복될문제가있음 나중에 실제로 출력할떄 아이디값에 index값 넣어야할듯함
														그리고 대댓글목록이나온이후엔 숨기기버튼을 따로만들어야하는지
												 ------>
														<a href="#" class="small ml-2" data-toggle="collapse" data-target="#demo1">
															답글 <span>3</span>개
														</a>
													</div>
													<ul class="p-0 collapse" id="demo1">
														<li>
															<div class="row m-0">
																<div class="col-1 p-0 text-center">
																	<img alt="로그인된유저 아이콘" src="/images/friend.png" class="reply-child-icon rounded-circle">
																</div>
																<div class="col-10 p-0">
																	<div class="d-inline-block bg-snowgray m-0 py-1 px-2 small pre-line reply-radius"><a href="#" class="mr-2 font-weight-bold">장두석</a>안녕하세요?저는 잘생긴 장두석입니다. 하하하하하하 호호호호호호 </div>
																	<div class="small">
																		<ul class="nav">
																			<li class="nav-item">
																				<a href="#" class="px-1 mx-1">좋아요</a>
																							<!-- 댓글좋아요 갯수 -->
																				<div class="d-inline">
																					<i class="fas fa-thumbs-up text-primary small"></i>
																					<span class="small">125</span>
																				</div>
																			</li>
																			<li class="nav-item">
																				<span>&nbsp;·&nbsp;</span>
																			</li>
																			<li class="nav-item">
																				<a href="#" class="px-1 mx-1">답글달기</a>
																			</li>
																			<li class="nav-item">
																				<a class="px-1 mx-1">4시간</a>
																			</li>
																		</ul>
																	</div>
																</div>
																<div class="col-1 p-0 text-center dropdwon dropright">
																	<i class="fas fa-ellipsis-h cursor dropdown-toggle" data-toggle="dropdown"></i>
																	<div class="dropdown-menu">
																		<a class="dropdown-item cursor">수정</a>
																		<a class="dropdown-item cursor">삭제</a>
																	</div>
																</div>
															</div>
														</li>
													</ul>
												</div>
												
	<!--------------------------------------------- 대댓글이있을경우 필요한 영역 ---------------------------->
											</li>
											<li class="mb-2">
												<div class="row m-0">
													<div class="col-1 p-0 text-center">
														<img alt="로그인된유저 아이콘" src="/images/friend.png" class="reply-icon rounded-circle">
													</div>
													<div class="col-10 p-0">
														<div class="d-inline-block bg-snowgray m-0 py-1 px-2 small pre-line reply-radius"><a href="#" class="mr-2 font-weight-bold">장두석</a>안녕하세요?저는 잘생긴 장두석입니다. 하하하하하하 호호호호호호 </div>
														<div class="small">
															<ul class="nav">
																<li class="nav-item">
																	<a href="#" class="px-1 mx-1">좋아요</a>
																	<!-- 댓글좋아요 갯수 -->
																	<div class="d-inline">
																		<i class="fas fa-thumbs-up text-primary small"></i>
																		<span class="small">125</span>
																	</div>
																</li>
																<li class="nav-item">
																	<span>&nbsp;·&nbsp;</span>
																</li>
																<li class="nav-item">
																	<a href="#" class="px-1 mx-1 reply-register">답글달기</a>
																</li>
																<li class="nav-item">
																	<a class="px-1 mx-1">4시간</a>
																</li>
															</ul>
														</div>
													</div>
													<div class="col-1 p-0 text-center dropdwon dropright">
														<i class="fas fa-ellipsis-h cursor dropdown-toggle" data-toggle="dropdown"></i>
														<div class="dropdown-menu">
															<a class="dropdown-item cursor">수정</a>
															<a class="dropdown-item cursor">삭제</a>
														</div>
													</div>
												</div>
	<!--------------------------------------------- 대댓글이있을경우 필요한 영역 ---------------------------->
												<div class="pl-5 pt-2">
													<div class="pt-1">
														<i class="fas fa-reply rotate-180"></i>
												<!------ 현재 데이터토글형태로하긴했는데 여러개일시 아이디값이 중복될문제가있음 나중에 실제로 출력할떄 아이디값에 index값 넣어야할듯함
														그리고 대댓글목록이나온이후엔 숨기기버튼을 따로만들어야하는지
												 ------>
														<a href="#" class="small ml-2" data-toggle="collapse" data-target="#demo2">
															답글 <span>3</span>개
														</a>
													</div>
													<ul class="p-0 collapse" id="demo2">
														<li>
															<div class="row m-0">
																<div class="col-1 p-0 text-center">
																	<img alt="로그인된유저 아이콘" src="/images/friend.png" class="reply-child-icon rounded-circle">
																</div>
																<div class="col-10 p-0">
																	<div class="d-inline-block bg-snowgray m-0 py-1 px-2 small pre-line reply-radius position-relative"><a href="#" class="mr-2 font-weight-bold">장두석</a>안녕하세요?저는 잘생긴 장두석입니다. 하하하하하하 </div>
																	<div class="small">
																		<ul class="nav">
																			<li class="nav-item">
																				<a href="#" class="px-1 mx-1">좋아요</a>
																				<!-- 댓글좋아요 갯수 -->
																				<div class="d-inline">
																					<i class="fas fa-thumbs-up text-primary small"></i>
																					<span class="small">125</span>
																				</div>
																			</li>
																			<li class="nav-item">
																				<span>&nbsp;·&nbsp;</span>
																			</li>
																			<li class="nav-item">
																				<a href="#" class="px-1 mx-1 reply-register">답글달기</a>
																			</li>
																			<li class="nav-item">
																				<a class="px-1 mx-1">4시간</a>
																			</li>
																		</ul>
																	</div>
																</div>
																<div class="col-1 p-0 text-center dropdwon dropright">
																	<i class="fas fa-ellipsis-h cursor dropdown-toggle" data-toggle="dropdown"></i>
																	<div class="dropdown-menu">
																		<a class="dropdown-item cursor">수정</a>
																		<a class="dropdown-item cursor">삭제</a>
																	</div>
																</div>
															</div>
														</li>
													</ul>
												</div>
	<!--------------------------------------------- 대댓글이있을경우 필요한 영역 ---------------------------->
											</li>
										</ul>
									</div>
								</div>
								<br>
								<br>
								<br>
								<br>
								<br>
								<br>
								<br>
							</div>
						</div>
					</div>
				</div>



				
				<aside class="col-md-3 d-none d-md-block px-1 mt-2">
				<!-------- 알수도있는사람 --------------->
					<div class="bg-white mb-3 rounded">
						<div class="px-2 py-2 px-lg-3 border-bottom overflow-auto small">
							<span class="text-body float-left">알 수도 있는 사람</span>
							<a href="#" class="float-right">모두 보기</a>
						</div>
						<div class="p-0 pt-1 pb-2 px-1">
							<ul class="p-0 m-0">
								<li class="mb-1">
									<div class="px-1 py-1 small overflow-auto">
										<a href="#" class="float-left pt-lg-2">
											<img src="/images/alarm/friend.png" class="rounded-circle right-side-icon" alt="프로필사진">
										</a>
										<div class="float-left pl-lg-2 pl-md-1">
											<div class="mb-2 mb-xl-0 w-100">
												<a href="#" class="text-truncate">곽철용</a>
											</div>
											<div class="mb-1 d-none d-xl-block">
												<p class="m-0"><a href="#" class="text-body">정마담</a>님을 함께 알고있습니다.</p>
											</div>
											<div class="small">
												<button><i class="fas fa-user-plus fa-sm"></i>친구 추가</button>
												<button>삭제</button>
											</div>
										</div>
									</div>
								</li>
								<li class="mb-1">
									<div class="px-1 py-1 small overflow-auto">
										<a href="#" class="float-left pt-lg-2">
											<img src="/images/alarm/friend.png" class="rounded-circle right-side-icon" alt="프로필사진">
										</a>
										<div class="float-left pl-lg-2 pl-md-1">
											<div class="mb-2 mb-xl-0 w-100">
												<a href="#" class="text-truncate">곽철용</a>
											</div>
											<div class="mb-1 d-none d-xl-block">
												<p class="m-0"><a href="#" class="text-body">정마담</a>님을 함께 알고있습니다.</p>
											</div>
											<div class="small">
												<button><i class="fas fa-user-plus fa-sm"></i>친구 추가</button>
												<button>삭제</button>
											</div>
										</div>
									</div>
								</li>
								<li class="mb-1">
									<div class="px-1 py-1 small overflow-auto">
										<a href="#" class="float-left pt-lg-2">
											<img src="/images/alarm/friend.png" class="rounded-circle right-side-icon" alt="프로필사진">
										</a>
										<div class="float-left pl-lg-2 pl-md-1">
											<div class="mb-2 mb-xl-0 w-100">
												<a href="#" class="text-truncate">곽철용</a>
											</div>
											<div class="mb-1 d-none d-xl-block">
												<p class="m-0"><a href="#" class="text-body">정마담</a>님을 함께 알고있습니다.</p>
											</div>
											<div class="small">
												<button><i class="fas fa-user-plus fa-sm"></i>친구 추가</button>
												<button>삭제</button>
											</div>
										</div>
									</div>
								</li>
								<li class="mb-1">
									<div class="px-1 py-1 small overflow-auto">
										<a href="#" class="float-left pt-lg-2">
											<img src="/images/alarm/friend.png" class="rounded-circle right-side-icon" alt="프로필사진">
										</a>
										<div class="float-left pl-lg-2 pl-md-1">
											<div class="mb-2 mb-xl-0 w-100">
												<a href="#" class="text-truncate">곽철용</a>
											</div>
											<div class="mb-1 d-none d-xl-block">
												<p class="m-0"><a href="#" class="text-body">정마담</a>님을 함께 알고있습니다.</p>
											</div>
											<div class="small">
												<button><i class="fas fa-user-plus fa-sm"></i>친구 추가</button>
												<button>삭제</button>
											</div>
										</div>
									</div>
								</li>
								<li class="mb-1">
									<div class="px-1 py-1 small overflow-auto">
										<a href="#" class="float-left pt-lg-2">
											<img src="/images/alarm/friend.png" class="rounded-circle right-side-icon" alt="프로필사진">
										</a>
										<div class="float-left pl-lg-2 pl-md-1">
											<div class="mb-2 mb-xl-0 w-100">
												<a href="#" class="text-truncate">곽철용</a>
											</div>
											<div class="mb-1 d-none d-xl-block">
												<p class="m-0"><a href="#" class="text-body">정마담</a>님을 함께 알고있습니다.</p>
											</div>
											<div class="small">
												<button><i class="fas fa-user-plus fa-sm"></i>친구 추가</button>
												<button>삭제</button>
											</div>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
<!------------------------------ 기타 사이드바 --------------------------------->
					<div class="bg-white rounded">
						<div class="px-2 py-2 px-lg-3 border-bottom overflow-auto small">
							<span class="text-body float-left">뭐하는사이드바?</span>
							<a href="#" class="float-right">모두 보기</a>
						</div>
						<div class="p-2">
							<br>
							<br>
							<br>
							<br>
							<br>
							<br>
							<br>
							<br>
							<br>
							<br>
						</div>
					
					</div>

<!------------------------ 푸터라침 ---------------------------------------->
					<div class="small txet-body p-2">
						<p>개인정보처리방침 · 이용 약관 · 광고 · AdChoices · 쿠키 · </p>
						<p>	Facebook © 2019</p>
					</div>
				</aside>
			</div>
		</div>
	</main>
</body>
</html>