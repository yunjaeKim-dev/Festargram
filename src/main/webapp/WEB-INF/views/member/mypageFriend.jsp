<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.teamproject.domain.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>

<jsp:include page="../common/timelineHeader.jsp"/>
<sec:authorize access="isAuthenticated()">
  	<sec:authentication property="principal.member.email" var="replyer"/>
  </sec:authorize>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.member.mno" var="sessionMno"/>
</sec:authorize>

<script src="/js/friend.js"></script>
<script src="/js/common.js"></script>
<script src="/js/post.js"></script>
<script src="/js/reply.js"></script>
    <style>
        textarea{resize: none;}
        .profile-button {right:20px;bottom: 15px;}
        .profile-photo {left: 20px; bottom:-20px}
     	.profile-name{bottom: 20px;}   
    </style>
    <script>
        $(function(){
			var postRn = 0;
			var isEnd = 0 ;
			var posts = [];
        	
        	var csrfHeaderName = "${_csrf.headerName}";
    		var csrfTokenValue = "${_csrf.token}";
    		  
    		$(document).ajaxSend(function(e, xhr){
    			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    		});
    		
        	var hostMno = ${host.mno} ;
        	var currentUserMno = ${sessionMno} ;
        	console.log(hostMno);
        	console.log(currentUserMno);
        	
        	
        	friendBtn(currentUserMno, hostMno);
        	/* 친구관계에따라 화면변경 */
        	function friendBtn(currentUserMno, hostMno){
        		friendService.getRelationCode(currentUserMno, hostMno, function(relationCode){
        			console.log("함수안 :::" + relationCode)
        			var str = '';
        			if(relationCode == '3'){
        				str += '<a class="btn btn-sm btn-light px-2  mx-2 cursor" id="profile-modify">프로필 수정</a>' ;
        			}
        			if(relationCode == '2'){
        				str += '<a class="btn btn-sm btn-light px-2  mx-2 cursor" id="remove-friend-btn"><i class="fas fa-check"></i>친구</a>';
        			}
        			if(relationCode == '1'){
        				str += '<a class="btn btn-sm btn-light px-2  mx-2 cursor" id="apply-cancel-btn">친구 요청중</a>' ;
        			}
        			if(relationCode == '0'){
        				str += '<a class="btn btn-sm btn-light px-2  mx-2 cursor" id="friend-apply-btn">친구 요청하기</a>' ;
        			}
   	           		$("#profile-area").html(str) ;
        		});
        	}
        	
			
        	
            /* 친구요청리스트 */
            function getFriendApplyList(currentUserMno){
            	friendService.getFriendApplyList(currentUserMno ,function(data){
            		console.log(data);
            	},function(error){
            		console.log(error) ;
            	});
            }
            /* 친구요청하기 */
            function friendApply(currentUserMno, hostMno){
            	friendService.friendApply(currentUserMno, hostMno, function(data){
            		console.log(data);
            		friendBtn(currentUserMno, hostMno)
            	},function(error){
            		console.log(error) ;
            	});
            }
            
            // 친구요청 취소하기
            function cancelApply(currentUserMno, hostMno){
            	friendService.removeApply(currentUserMno, hostMno, function(data){
            		console.log(data);
            		friendBtn(currentUserMno, hostMno);
            	},function(error){
            		console.log(error) ;
            	});
            }
            
            // 친구삭제
            function removeFriend(currentUserMno, hostMno){
            	friendService.removeFriend(currentUserMno, hostMno, function(){
            		console.log(data);
            		friendBtn(currentUserMno, hostMno);
            	},function(error){
            		console.log(error) ;
            	})
            }
            
            // 마이페이지 타임라인불러오기
            function getMyPagePost(hostMno){
            	postService.getMyPagePost(hostMno, postRn, function(data){
            		console.log(data);
            		var str = '';
            		for(var i in data){
	            		str += '<li class="mb-3 border">';
	            		str += '<div class="bg-white rounded post" data-postno="'+data[i].postno + '"><div><div class="py-2 px-3 position-relative"><div class="mt-n2 position-absolute right left">' ;
	            		// 게시글 수정 삭제 --- 버튼
	            		if(data[i].writer == currentUserMno){
		            		str += '<div class="position-absolute mt-2 mr-2 right cursor dropdown dropright">';
		            		str += '<i class="fas fa-ellipsis-h dropdown-toggle" data-toggle="dropdown"></i>';
		            		str += '<div class="dropdown-menu"><a class="dropdown-item cursor">게시글 수정</a><a class="dropdown-item cursor">게시글 삭제</a></div>'
		            		str += '</div>' ;
	            		}
	            		
	            		// -----------------------------------------------------------------
	            		str += '</div>' ;
	            		str += '<div><div class="clearfix"><div class="mr-2 float-left">' ;
	            		//글작성자 프로필아이콘 추후 프로필이미지 폴더 생기면 작성자프로필로 변경
	            		str += '<a href="#"><img src="/images/alarm/friend.png" class="rounded-circle alarm-icon post-profile-icon" alt="프로필사진"></a>	</div>' ;
	            		str += '<div class="float-left">' ;
	            		str += '<h6 class="m-0"><a href="/member/mypage?mno=' +data[i].writer +'">' + data[i].writerName + '</a></h6>' ;
	            		str += '<span class="small">' + data[i].regdate + '</span></div></div></div>' ;
	            		str += '<div><div class="p-2 pre-line">'+data[i].content + '</div>  </div><div>' ;
	            		/* <textarea class="w-100 border-0" style="resize: none" readonly="readonly">' +data[i].content + '</textarea> */
	            		//첨부파일영역(임시)
	            		str += '<div style="height:100px;"></div>' ;
	            		//
	            		
	            		str += '<div class="reply-point"><div class=""><div class="py-2 mx-3 d-flex justify-content-between border-bottom">' ;
	            		str += '<div><i class="fas fa-thumbs-up text-primary mr-2"></i>' ;
	            		
	            		str += '<span class="small">'+data[i].thcount +'</span></div>';
	            		str += '<div>' ;
	            		str += '<div class="d-inline mx-2 small text-dark showReplies">댓글 <span>' + data[i].replyCnt +'</span>개</div>' ;
	            		// 공유하기 카운트 나중에생각
	            		str += '<div class="d-inline mx-2 small text-dark ">공유 <span>66</span>회</div></div></div></div>' ;
						str += '<div class="border-bottom"><div class="m-0 text-center px-3 py-2 row justify-content-between">';
						str += '<div class="col-4 cursor"><i class="far fa-thumbs-up"></i><span>좋아요</span>										</div>';
						// 댓글 버튼 두석이 댓글버튼이벤트 아이디로 걸려있는거 수정해야함
						str += '<div class="col-4 cursor showReplies"><i class="far fa-comment-alt"></i><span class="reply-show-btn">댓글</span></div>';
						// 공유하기버튼
						str += '<div class="col-4 cursor"><i class="fas fa-share"></i><span>공유</span></div></div></div></div>';
						// 댓글작성폼 위치인듯
						str += '<div class="px-2 pt-2"><div class="reply-update-area row m-0 mb-2"></div>';
						str += '<div class="reply-list-area"><ul class="reply-area p-0"></ul>';
						str += '<button type="button" class="more-view d-none btn btn-block btn-primary">더보기</button>';
						str += '</div>';
						str += '</div></div></div></div></div>';
						str += '</li>';
						
						
						console.log("반복문안에서 :: " + data[i].rn)
						postRn = data[i].rn ;
						isEnd = data[i].isEnd ;
						posts.push({no : data[i].postno});
           			}
            		
            		console.log(posts);
					$("#post-list-area").append(str);
					$(".dropdown-toggle").dropdown();
						
	            	},function(error){
	            		console.log(error);
	            	})
            	
            }
            /* -------------------------------------댓글관련 함수 영역 ----------------------------------------- */
            
            var writer = "${replyer}"; // 글쓴이 지정
    		
    		
    		function showReplyForm(postno){ // 댓글 입력창 동적 생성
    			var str = '';
    		    str += '<div class="col-2 col-sm-1 col-md-2 col-lg-1 p-0 text-center">';
    		        str += '<img alt="로그인된유저 아이콘" src="/images/friend.png" class="reply-icon rounded-circle">';
    		    str += '</div>';
    		    str += '<div class="col-10 col-sm-11 col-md-10 col-lg-11 p-0">';
    		        str += '<form class="form-group">';
    		            str += '<div class="position-relative form-group">';
    		                str += '<div>';
    		                    str += '<textarea rows="1" placeholder="댓글을 입력하세요" class="replyContent reply-radius pr-5 pl-3 py-2 small border d-block w-100 reply-register-textarea" name="replyContent" style="resize:none"></textarea>';
    		                str += '</div>';
    		                str += '<div class="position-absolute bottom right">';
    		                    str += '<label for="replyFile" class="m-0 mr-3 px-3 py-1 pb-2 cursor" title="사진 첨부">';
    		                        str += '<i class="fas fa-image text-secondary"></i>';
    		                    str += '</label>';
    		                    str += '<input type="file" id="replyFile" name="replyFile" class="d-none"> ';
    		                str += '</div>';
    		            str += '</div>';
    		        str += '</form>';
    		            str += '<button type="button" class="regBtn">댓글테스트</button>';
    		    str += '</div>';
    		    $("[data-postno="+postno+"]").find(".reply-update-area").html(str);
    		}
    		
    		
            function showList(postno, isStart){ // 댓글 리스트 불러오기
            	var $replyUL = $("[data-postno="+postno+"]").find(".reply-area");
            	var $moreView = $("[data-postno="+postno+"]").find(".more-view") ;
            	var idx = 0;
            	for(var idx in posts) {
            		if(posts[idx].no == postno) {
            			break;
            		}
            	}
            	var rn = 0;
            	if(!isStart) {
            		rn = posts[idx].rn;
            	}
           		console.log("idx", idx);

            	console.log(postno);
    			replyService.getList({postno:postno, rn:rn || 0},function(list){
    				console.log(list);
    				var str = '';
    				for(var i = 0; i < (list.length || 0); i++){
    					if(list[i].parentno != list[i].replyno){
    						str += '<li class="mb-2 pl-5">';
    					}
    					else{
    						str += '<li class="mb-2">';
    					}
    					    str += '<div class="row m-0">';
    					        str += '<div class="col-1 p-0 text-center">';
    					            str += '<img alt="로그인된유저 아이콘" src="/images/friend.png" class="reply-icon rounded-circle">';
    					        str += '</div>';
    					        str += '<div class="col-10 p-0">';
    					            str += '<div class="d-inline-block bg-snowgray m-0 py-1 px-2 small pre-line reply-radius"><a href="#" class="mr-2 font-weight-bold">'+list[i].name+'</a>'+list[i].content+'</div>';
    					            str += '<div class="small">';
    					                str += '<ul class="nav">';
    					                    str += '<li class="nav-item">';
    					                        str += '<a href="#" class="px-1 mx-1">좋아요</a>';
    					                        str += '<div class="d-inline">';
    					                            str += '<i class="fas fa-thumbs-up text-primary small"></i>';
    					                            str += '<span class="small">'+list[i].thcount+'</span>';
    					                        str += '</div>';
    					                    str += '</li>';
    					                    str += '<li class="nav-item">';
    					                        str += '<span>&nbsp;·&nbsp;</span>';
    					                    str += '</li>';
    					                    str += '<li class="nav-item">';
    					                        str += '<a href="#" class="px-1 mx-1 reply-register">답글달기</a>';
    					                    str += '</li>';
    					                    str += '<li class="nav-item">';
    					                        str += '<a class="px-1 mx-1">'+list[i].regdate+'</a>';
    					                    str += '</li>';
    					                str += '</ul>';
    					            str += '</div>';
    					        str += '</div>';
    					        //작성자 일때 댓글 수정,삭제 버튼 생성
    					       	if(writer == list[i].writer){
    						        str += '<div class="col-1 p-0 text-center dropdown">';
    						            str += '<i class="fas fa-ellipsis-h cursor dropdown-toggle" data-toggle="dropdown"></i>';
    						            str += '<div class="dropdown-menu dropdown-menu-right">';
    						                str += '<a class="dropdown-item cursor">수정</a>';
    						                str += '<a class="dropdown-item cursor rmBtn" data-rno="'+list[i].replyno+'">삭제</a>';
    						            str += '</div>';
    						        str += '</div>';
    					       	}
    					        
    					    str += '</div>';
    					str += '</li>';
    					posts[idx].rn = list[i].rn; 
    					posts[idx].isend = list[i].isend;
    					
    				};
    				
    				if(isStart) {
    					$replyUL.html(str);
    				}
    				else {
    					$replyUL.html($replyUL.html()+str);
    				}
    				if(!posts[idx].isend){
    					$moreView.removeClass("d-none");
    					$moreView.prop("disabled", false).text("더보기")
    				}
    				else{
    					$moreView.prop("disabled", true).text("더이상 댓글이 없습니다")
    				} 
    				console.log(posts);
    			});
   				$(".dropdown-toggle").dropdown(); 
    		}

            
            
            /* ------------------------------------------------------------------------------------------- */
            
            
            
            /* -------------------------------------댓글관련 이벤트 영역 ----------------------------------------- */
			/*------------------------------------- 댓글리스트--------------------------------------- */            
		$("#post-list-area").on("click", ".showReplies",function(){  // 댓글 클릭시 댓글입력창,댓글리스트 호출
			var postno =$(this).closest('.post').data("postno");
			showReplyForm(postno);
			showList(postno,true);
		});
		
            
        
			/*------------------------------------- 댓글삭제--------------------------------------- */	
		$("#post-list-area").on("click", ".reply-area .rmBtn", function(){// 댓글 삭제  (대댓글이 있는 댓글은 삭제가 안됨)
			var replyno = $(this).data("rno");
			var postno =$(this).closest('.post').data("postno");
    		replyService.remove({replyno:replyno, writer:writer}, function(result){ // result는 문자열타입임
    			console.log(result);
    			showReplyForm(postno);
    			showList(postno,true);
    		});
		});
        
			
		/*------------------------------------- 댓글등록--------------------------------------- */
		$("#post-list-area").on("click", ".reply-update-area .regBtn",function(){  // 댓글입력 버튼 클릭시 ~
			var postno =$(this).closest('.post').data("postno");
			var reply = {
				postno : postno,
				writer : writer,
				content : $(this).prev().find("textarea").val()
			};
			
			replyService.add(reply, function(result){ // result는 문자열타입임
				console.log(result)
				showReplyForm(postno);
				showList(postno, true);
			});
		});
  		
		//댓글 더보기 버튼
		$("#post-list-area").on("click",".more-view", function(){ // 댓글 클릭시 댓글입력창,댓글리스트 호출
			var postno =$(this).closest('.post').data("postno");
			/* showList(postno); */
			showList(postno);
		});
		
            
            
            /* ------------------------------------------------------------------------------------------- */
            
            
            
            /* -------------------------------------마이페이지이벤트부분 ----------------------------------------- */
            
			/* 친구요청취소 */
			$('#profile-area').on('click','#apply-cancel-btn',function(){
				if(confirm('친구요청을 취소하시겠습니까?')){
					cancelApply(currentUserMno, hostMno);
				}else{
					return false ;
				}
			});
            // 친구 신청 버튼
		    $('#profile-area').on('click','#friend-apply-btn',function(){
           		friendApply(currentUserMno, hostMno);
			});
	
            //친구 삭제버튼
            $('#profile-area').on('click','#remove-friend-btn', function(){
            	if(confirm('${host.name}' + '님과 친구 상태가 해제됩니다.')){
            		removeFriend(currentUserMno, hostMno);
            		friendBtn(currentUserMno, hostMno);
            	}else{
            		return false;
            	}
            });
            /* host에게 글남기기 */
			$("#post-register-btn").click(function(){
				var content = $(".post-register-textarea") ;
				if(content.val().length ==0){
					alert("글 내용을 입력해주세요!");
					return false;
				}
				console.log(content);
				var post = {
					writer : currentUserMno,
					owner : hostMno,
					content : content.val()
				}
				postService.postRegister(post,function(data){
					console.log(data);
					alert("글작성이 완료되었습니다.");
					content.val("");
					textareaResize(content);
				},function(er){
					console.log(er) ;
				})
			})
            
            
            
            // host타임라인 list
            $(document).scroll(function(){
            	if(isEnd == 1){
            		return false;
            	}
            	var maxHeight = $(document).height();
			    var currentScroll = $(window).scrollTop() + $(window).height();
				if(maxHeight == currentScroll){
	            	setTimeout(function(){
							getMyPagePost(hostMno);
						
	            	},800);
				}
			})
            
			getMyPagePost(hostMno, postRn);
            
            /* 사이드바 리사이즈 */
    		sidebarResize(); 
    		$(window).resize(function(){
    			sidebarResize();
    		});
    		/* textarea */
    		$("#timeLine-area").on("keydown keyup", "[class$='register-textarea']",function(){
    			textareaResize(this) ;
    		})
            
        });
        
        
        
    </script>
	<main class="main-top-padding">
		<div class="container">
			<div class="row">
				<!-----------좌측사이드바 -------------->
				<jsp:include page="../common/sidebar.jsp"/>
				<!---------------------------------->
				<div class="col-md-9">
				
					<div class="col-12">
	                    <!-- 커버이미지 -->
	                    <div class="row">
	                        <div class="col-12 p-0">
	                            <img src="/images/mypage/cover.jpg" class="w-100" height="280">
	                        </div>
	                    </div>
	                    <!-- 이름 -->
	                    <div class="position-absolute w-100">
	                    	<div class="position-absolute profile-name w-100">
	                    		<div class="row">
		                    		<div class="col-sm-4 col-md-3 col-lg-3"></div>
		                    		<div class="col-6">
		                    			<h5 class="m-0"><a href="#" class="text-body font-weight-bold">${host.name}</a></h5>
		                    		</div>
	                    		</div>
	                    	</div>
	                    </div>
	                    <!-- 하단 메뉴바 -->
	                    <div class="row bg-white">
	                        <!-- 프로필 편집 버튼 -->
	                        <div class="position-absolute w-100">
								<div class="position-absolute profile-button small" id="profile-area">
									
									
								</div>
							</div>
	                        <!-- 프로필 사진 -->
	                        <div class="position-absolute d-none d-sm-block  d-lg-block d-md-block w-100">
	                            <div class="position-absolute profile-photo">
	                                <img src="/images/mypage/mypic.jpg" class="rounded-circle border rounded-lg" width="150" height="150">
	                            </div>
	                        </div>
	                        <!-- 메뉴 목록 -->
	                        <div class="col-sm-4 col-md-5 col-lg-5"></div>
	                        <div class="col-12 col-sm-7 col-md-6 mb-3">
	                            <ul class="list-group list-group-flash list-group-horizontal d-sm-flex justify-content-center">
	                                <li class="list-item border border-top-0 border-bottom-0 p-2 px-3">
	                                    <a href="#" class="text-decoration-none">정보</a>
	                                </li>
	                                <li class="list-item border border-top-0 border-bottom-0 border-left-0 p-2 px-3">
	                                    <a href="#" class="text-decoration-none">친구</a>
	                                </li>
	                                <li class="list-item border border-top-0 border-bottom-0 border-left-0 p-2 px-3">
	                                    <a href="#" class="text-decoration-none">사진</a>
	                                </li>
	                                <li class="list-item border border-top-0 border-bottom-0 border-left-0 p-2 px-3">
	                                    <a href="#" class="text-decoration-none">더 보기</a>
	                                </li>
	                            </ul>
	                        </div>
	                    </div> 
	                </div>
		            <div id="friend-apply-area" class="row my-2 clearfix">
		          
		            </div>
		            <div class="row m-0">
		                <!-- 본문? -->
		                <div class="col-12 p-2" id="timeLine-area">
		                <!-- 친구들 -->
		                	<div class="">
		                		<ul class="list-group w-100">
		                			<li class="list-item d-block w-50">
		                				<div class="d-inline-block h-100"><img src="/images/friend.png"></div>
		                				<div class="d-inline-block h-100">
		                					<div><p class="p-0 m-0">아무개</p></div>
		                					<div><span class="p-0 m-0">친구 4천명</span></div>
		                				</div>		                				
		                				<div class="d-inline-block h-100"><button>칭구</button></div>
		                			</li>
		                			<li class="list-item d-block w-50">
		                				<div class="d-inline-block h-100"><img src="/images/friend.png"></div>
		                				<div class="d-inline-block h-100">
		                					<div><p class="p-0 m-0">아무개</p></div>
		                					<div><span class="p-0 m-0">친구 4천명</span></div>
		                				</div>		                				
		                				<div class="d-inline-block h-100"><button>칭구</button></div>
		                			</li>
		                		</ul>
		                	</div>
		                </div>
		            </div>
	            </div>
	        </div>
		</div>
	</main>
</body>
</html>