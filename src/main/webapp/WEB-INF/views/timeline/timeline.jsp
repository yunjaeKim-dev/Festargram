<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/timelineHeader.jsp"/>
  <script src="/js/reply.js"></script>
  <script src="/js/postService.js"></script>
  <script src="/js/post.js"></script>
  <script src="/js/friend.js"></script>
  <sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.member" var="currentUser"/>
  </sec:authorize>
  

  <script>
  	if('${msg}'){
  		alert('${msg}');
  	}
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(function(e, xhr){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	})
  	var writer = "${currentUser.email}"; // 댓글쓴이 지정
	var currentUserProfimg = '${currentUser.profimg}';
	var currentUserMno = ${currentUser.mno};
	var owner = currentUserMno ;
	var currentName = '${currentUser.name}' ;  
	var postRn = 0;
	var isEnd = 0 ;
	var posts = [];
	

	function showMayKnownList(currentUserMno){
		/* 우측사이드바에 알수도있는사람 10개까지 불러오기 */
		friendService.getMayKnownList(currentUserMno, 10 ,function(list){
			if(list == null || list.length ==0){
				$("#mayKnownSidebar").html('');
				return ;
			}
			var str = '';
			for(var i in list){
				if(list[i]){
					str += '<li class="mb-3">';
					str += '<div class="d-flex">' ;
					str += '<a href="/member/mypage?mno='+list[i].mno+ '" class="d-lg-block d-none mr-2">';
					str += '<img src="/upload/display?fileName=' +list[i].profimg.replace('/profile/','/profile/s_') + '" class="rounded-circle right-side-icon" alt="프로필사진"></a>'
					str += '<div class="mr-auto align-self-center">';
					str += '<a href="/member/mypage?mno='+list[i].mno+ '" class="text-truncate d-block">'+list[i].name +'</a>';
					str += '<p class="text-muted small m-0">함께 아는 친구 '+ list[i].count+'명</p></div>';
						str += '<div class="small align-self-center">';
					str += '<a href="/member/mypage?mno='+list[i].mno+ '" class="btn btn-sm btn-primary small d-none d-xl-block">방문하기</a>';
					str += '<a href="/member/mypage?mno='+list[i].mno+ '" class="btn btn-sm btn-primary small d-block d-xl-none">방문</a>';
					str += '</div></div></li>';
				}
			}
			$("#mayKnownSidebar").html(str);				
		});
	}
	$(function(){
		
		/* 친구알림  */
        $(".friend").hover(function(){
            $(this).children("td:nth-child(2)").children("div").children(".close")
            .css("display","block").parent()
        },function(){
        	$(this).children("td:nth-child(2)").children("div").children(".close")
        	.css("display","none")
        })
		
        $(".reply-register").click(function(){
        	e.preventDefault();
				/* 좀더고민  */        	
        })
        
        
       
		
  /*----------- --------------------------이벤트------------------------------------------------------------------------------- */
        // host타임라인 list
        $(document).scroll(function(){
        	if(isEnd == 1){
        		return false;
        	}
        	var maxHeight = $(document).height();
		    var currentScroll = $(window).scrollTop() + $(window).height();
			if(maxHeight == currentScroll){
            	setTimeout(function(){
            		   getNewsfeed(currentUserMno);
            	},800);
			}
		})
        // reday시 첫페이지 포스트 불러옴
        getNewsfeed(currentUserMno);
        /* 사이드바 리사이즈 */
		sidebarResize(); 
		$(window).resize(function(){
			sidebarResize();
		});
		showMayKnownList(currentUserMno);
		
		/* textarea */
		$("#timeLine-area").on("keydown keyup", "[class$='register-textarea']",function(){
			textareaResize(this) ;
		});
		
		// 게시글 작성시 알림 추가
        function addPostAlarm(){
        	alarmService.addPostAlarm()
        }
		// 댓글 작성시 알림 추가
        function addReplyAlarm(){
        	alarmServcie.addReplyAlarm()
        }
		
	})
  </script>
  <style>
  	main{min-height:1000px;}/* 추후지울것 */
  </style>
<body>
<c:set var="currentUserProfimg" value="${fn:replace(currentUser.profimg,'/profile/', '/profile/s_') }"></c:set>
	<main class="main-top-padding">
		<div class="container pt-2">
			<div class="row">
			<!---------좌측사이드바 --------->
				<jsp:include page="../common/sidebar.jsp"/>
				
	<!--------------------------- 메인 타임라인 ------------------------------->
				<div class="col-md-6 mt-1 rounded mt-2" id="timeLine-area">
				<!---- 게시글 작성 ------- -->
					<div class="bg-white mb-4 rounded">
						<div class="bg-secondary py-2 px-3 rounded-top">
							<h6 class="m-0 text-white">게시글 작성</h6>
						</div>
						<form id="register-post">
							<div class="row m-0 pt-2 px-2 border-bottom">
								<div class="col-1 p-0">
									<img src="/upload/display?fileName=${currentUserProfimg}" class="rounded-circle alarm-icon post-profile-icon" alt="프로필사진">
								</div>
								<div class="col-11">
									<textarea placeholder="${currentUser.name}님 무슨생각을 하고 계신가요?" class="w-100 border-0 post-register-textarea" maxlength="5000" style="resize: none" ></textarea>
								</div>
							</div>
							<!-- 썸네일 등장하고 inputfile과 label 이 생길영역 -->
							<div id="tumbnail-area">
								<ul class="p-0 m-0 overflow-auto no-wrap">
								
								</ul>
							</div>
							
							<div class="small py-2 pl-lg-5 pl-md-2 pl-3">
								<div class="btn btn-light mx-xl-4 mx-sm-2 rounded-pill cursor">
									<label for="uploadFileInput" class="m-0 cursor">
										<span><i class="fas fa-image"></i>사진/동영상</span>
									</label>
									<input type="file" id="uploadFileInput" name="uploadFile" data-cate="reg" multiple class="d-none uploadFileInput" accept=".jpg, .jpeg, .png, .svg, .gif, .webp">
								</div>
								<div class="btn btn-light mx-xl-4 mx-sm-2 rounded-pill cursor NotImplemented">
									<span><i class="fas fa-user-tag"></i>친구 태그하기</span>
								</div>
								<div class="btn btn-light mx-xl-4 mx-sm-2 rounded-pill cursor NotImplemented">
									<i class="fas fa-ellipsis-h"></i>
								</div>
							</div>
							<div class="p-2">
								<button type="button" class="btn btn-primary btn-block" id="post-register-btn">게시하기</button>
							</div>
						</form>
					</div>
					
					<!-------------------------- 타임라인리스트 ------------------------------->
					<div>
						<ul class="p-0" id="post-list-area">
							
						</ul>
					</div>
				</div>
				<div class="modal fade" id="postModifyModal" data-postno="">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">포스트 수정</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<!-- Modal body -->
						<div class="modal-body">
							<div class="bg-white">
		                    	<div class="bg-white mb-4 rounded">
									<div class="bg-secondary py-2 px-3 rounded-top">
										<h6 class="m-0 text-dark">포스트 수정</h6>
									</div>
									<form id="modifyPost">
										<div class="row m-0 pt-2 px-2 border-bottom">
											<div class="col-1 p-0">
												<img src="/upload/display?fileName=${currentUserProfimg}" class="rounded-circle alarm-icon post-profile-icon" alt="프로필사진">
											</div>
											<div class="col-11">
												<textarea class="w-100 border-0 post-register-textarea" maxlength="5000" style="resize: none" ></textarea>
											</div>
										</div>
										<!-- 썸네일 등장하고 inputfile과 label 이 생길영역 -->
										<div id="modifyTumbnailArea">
											<ul class="p-0 m-0 overflow-auto no-wrap">
								
											</ul>
										</div>
										
										<div class="small py-2 pl-lg-5 pl-md-2 pl-3">
											<div class="btn btn-light mx-xl-4 mx-sm-2 rounded-pill cursor">
												<label for="modifyFileInput" class="m-0">
													<span><i class="fas fa-image"></i>사진/동영상</span>
												</label>
												<input type="file" id="modifyFileInput" data-cate="modify" name="uploadFile" multiple class="d-none uploadFileInput" accept=".jpg, .jpeg, .png, .svg, .gif, .webp">
											</div>
											<div class="btn btn-light mx-xl-4 mx-sm-2 rounded-pill cursor NotImplemented">
												<span><i class="fas fa-user-tag"></i>친구 태그하기</span>
											</div> 
											<div class="btn btn-light mx-xl-4 mx-sm-2 rounded-pill cursor NotImplemented">
												<i class="fas fa-ellipsis-h"></i>
											</div>
										</div>
										<div class="p-2">
											<button type="button" class="btn btn-primary btn-block" id="postModifyBtn">수정하기</button>
										</div>
									</form>
								</div>
		                    </div>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
						</div>
					</div>
				</div>
			</div>
	
				
				<aside class="col-md-3 d-none d-md-block px-1 mt-2">
				<!-------- 알수도있는사람 --------------->
					<div class="bg-white mb-3 rounded">
						<div class="py-2 px-3 rounded-top d-flex border-bottom bg-secondary">
							<h6 class="m-0 mr-auto text-white">알 수도 있는 사람</h6>
							<a href="/alarm/friendApply" class="small text-white">모두 보기</a>
						</div>
						<div class="">
							<ul class="p-2 m-0" id="mayKnownSidebar">
								
							</ul>
						</div>
					</div>
<!------------------------------ 기타 사이드바 --------------------------------->
					<div class="bg-white rounded">
						<div class="px-2 py-2 px-lg-3 border-bottom overflow-auto small">
							<span class="text-body float-left">광고</span>
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
						<p>	Festargram © 2019</p>
					</div>
				</aside>
			</div>
					<!-- The Modal 이미지 원본보기 모달 -->
			<div class="modal" id="myModal">
				<div class="modal-dialog w-100">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">이미지 상세보기</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<!-- Modal body -->
						<div class="modal-body">
							<div id="slider" class="slider">
								
							</div>
						</div>
						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
</html>