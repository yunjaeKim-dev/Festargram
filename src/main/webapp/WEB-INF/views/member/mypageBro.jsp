<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.teamproject.domain.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>

<jsp:include page="../common/timelineHeader.jsp"/>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.member" var="currentUser"/>
</sec:authorize>
<c:set var="currentUserProfimg" value="${fn:replace(currentUser.profimg,'/profile/', '/profile/s_') }"></c:set>


<script src="/js/postService.js"></script>
<script src="/js/post.js"></script>
<script src="/js/reply.js"></script>

<style>
    textarea{resize: none;}
    .profile-button {right:20px;bottom: 15px;}
    .profile-photo {left: 20px; bottom:-20px}
 	.profile-name{bottom: 20px;}   
 	
</style>
    <script>
       	var csrfHeaderName = "${_csrf.headerName}";
   		var csrfTokenValue = "${_csrf.token}";
   		$(document).ajaxSend(function(e, xhr){
   			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
   		});
   		
       	var hostMno = ${host.mno} ;
       	var owner = hostMno ;
       	var hostProfimg = '${host.profimg}' ;
       	var currentUserProfimg = '${currentUser.profimg}';
       	var currentUserMno = ${currentUser.mno} ;
       	
        $(function(){
        	console.log(hostMno);
        	console.log(currentUserMno);
        	
        	//페이지 로드시 친구관계에따라 버튼생성
        	friendBtn(currentUserMno, hostMno);
        	/* 친구관계에따라 화면변경 */
        	function friendBtn(currentUserMno, hostMno){
        		friendService.getRelationCode(currentUserMno, hostMno, function(relationCode){
        			console.log("함수안 :::" + relationCode)
        			var str = '';
        			if(relationCode == '3'){
        				str += '<a class="btn btn-sm btn-light px-2  mx-2 cursor" id="profile-modify" data-toggle="modal" data-target="#modifyExtraInfo">프로필 수정</a>' ;
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
            
            // 해당페이지 owner의 친구리스트 불러오기
            function getOwnerFriendList(ownerno, currentno){
            	friendService.getOwnerFriendList(ownerno, currentno, function(data){
            		console.log(data);
             		var str = '';
            		for(var i in data){
            			str += '<li class="col-12 col-sm-6 p-2"><div class="border d-flex">';
            			str += '<a href="/member/mypage?mno='+data[i].mno+'" class="mr-2 border">';
            			str += '<img src="/upload/display?fileName=' +data[i].profimg.replace('/profile/','/profile/s_') + '" class="register-thumbnail-image"></a>';
            			str += '<div class="align-self-center mr-auto">';
            			str += '<a href="/member/mypage?mno='+data[i].mno+'" class="d-block mb-1">'+ data[i].name + '</a>';
            			str += '<p class="m-0 small text-muted">친구 '+data[i].frcount+ ' 명</p></div>' ;
            			str += '<div class="small align-self-center">';
            			if(data[i].realtion == '1'){
            				str += '<a class="btn btn-sm btn-whitegray px-2  mx-2 cursor apply-cancel-btn" data-mno="'+data[i].mno + '">친구요청중</a>';
            			}
            			if(data[i].realtion == '2'){
            				str += '<a class="btn btn-sm btn-whitegray px-2  mx-2 cursor add-friend-btn" data-mno="'+data[i].mno + '">친구수락</a>';
            			}
            			if(data[i].realtion == '3'){
            				str += '<a class="btn btn-sm btn-whitegray px-2  mx-2 cursor remove-friend-btn" data-mno="'+data[i].mno + '" data-name="'+data[i].name + '"><i class="fas fa-check"></i>친구</a>';
            			}
            			if(data[i].realtion == '4'){
            				str += '<a class="btn btn-sm btn-whitegray px-2  mx-2 cursor friend-apply-btn" data-mno="'+data[i].mno + '">친구요청</a>';
            			}
            			str += '</div></div></li>'
            		}
            		$("#friendListArea").html(str);
            	})
            }
            // 해당페이지 owner의 친구리스트 불러오기와서 화면에 찍음
            getOwnerFriendList(hostMno, currentUserMno); 
           
            
            /* -------------------------------------마이페이지이벤트부분 ----------------------------------------- */
            
		 
			/* 친구요청취소 */
			$('#profile-area').on('click','#apply-cancel-btn',function(){
				if(confirm('친구요청을 취소하시겠습니까?')){
					friendService.removeApply(currentUserMno, hostMno, function(data){
	            		console.log(data);
	            		friendBtn(currentUserMno, hostMno);
	            	})
				}else{
					return false ;
				}
			});
            // 친구 신청 버튼
		    $('#profile-area').on('click','#friend-apply-btn',function(){
		    	friendService.friendApply(currentUserMno, hostMno, function(data){
            		console.log(data);
            		friendBtn(currentUserMno, hostMno);
            	})
			});
	
            //친구 삭제버튼
            $('#profile-area').on('click','#remove-friend-btn', function(){
            	if(confirm('${host.name}' + '님과 친구 상태가 해제됩니다.')){
            		friendService.removeFriend(currentUserMno, hostMno, function(data){
                		console.log(data);
                		friendBtn(currentUserMno, hostMno);
                	})
            	}else{
            		return false;
            	}
            });
            
            //친구 추가버튼
            $("#profile-area").on("click", "#add-friend-btn",function(){
                function addFriend(currentUserMno, hostMno){
                	friendService.addFriend(currentUserMno, hostMno, function(data){
                		console.log(data);
                		friendBtn(currentUserMno, hostMno);
                	})
                }
            })
            
         /* ----------------------------owner 친구리스트와 친구관계 버튼 이벤트들----------------------------- */
            // owner의 친구리스트중 친구요청중일시 요청취소
            $("#friendListArea").on("click",".apply-cancel-btn",function(){
            	var friendMno = $(this).data("mno");
            	friendService.removeApply(currentUserMno, friendMno, function(data){
            		console.log(data);
            		getOwnerFriendList(hostMno, currentUserMno);
            	})
            })
            
            // owner의 친구리스트의 친구에게 친구신청
            $("#friendListArea").on("click", ".friend-apply-btn", function(){
            	var friendMno = $(this).data("mno");
            	friendService.friendApply(currentUserMno, friendMno, function(data){
            		console.log(data);
            		getOwnerFriendList(hostMno, currentUserMno);
            	})
            })
            
            // owner의 친구리스트의 친구와 친구삭제
            $("#friendListArea").on("click", ".remove-friend-btn", function(){
            	var friendMno = $(this).data("mno");
            	var friendName = $(this).data("name");
            	if(confirm(friendName + '님과 친구상태가 해제됩니다')){
            		friendService.removeFriend(currentUserMno, friendMno, function(data){
                		console.log(data);
                		getOwnerFriendList(hostMno, currentUserMno);
                	})
            	}else{
            		return false;
            	}
            })
            
            // owner의 친구리스트의 친구가 로그인된유저에게 친구요청중일시 친구수락
            $("#friendListArea").on("click",".add-friend-btn", function(){
            	var friendMno = $(this).data("mno");
            	friendService.addFriend(currentUserMno, friendMno, function(data){
            		console.log(data);
            		getOwnerFriendList(hostMno, currentUserMno);
            	})
            })
            
            
					
    		/* 사이드바 리사이즈 */
    		$(window).resize(function(){
    			sidebarResize();
    		});
           
            /* 사이드바 리사이즈 */
    		sidebarResize();
            
            
        });
        
        
        
    </script>
	<main class="main-top-padding">
		<div class="container">
			<div class="row">
				<!-----------좌측사이드바 -------------->
				<jsp:include page="../common/sidebar.jsp"/>
				<!---------------------------------->
				<div class="col-md-9 pt-2">
				
					<div class="col-12">
	                    <!-- 커버이미지 -->
	                    <div class="row">
	                        <div class="col-12 p-0 profile-cover-image position-relative">
 	                        	<c:if test="${currentUser.mno eq host.mno}">
	                        		<div class="position-absolute top left mt-2 ml-3"><i class="fas fa-camera cursor camera-hover px-2 py-2" data-toggle="modal" data-target="#profileCoverImgModify"></i></div>
	                         	</c:if>
	                        	<c:choose>
	                        		<c:when test="${empty host.coverimg}">	                        			
	                        			<div class="w-100 h-100 bg-coverimg"></div>
	                        		</c:when>
	                        		<c:otherwise>
			                            <img src="/upload/display?fileName=${host.coverimg}" class="w-100 h-100">
	                        		</c:otherwise>
	                        	</c:choose>
	                        </div>
	                    </div>
	                    <!-- 이름 -->
	                    <div class="position-absolute w-100">
	                    	<div class="position-absolute profile-name w-100">
	                    		<div class="row">
		                    		<div class="col-sm-4 col-md-4 col-lg-3"></div>
		                    		<div class="col-6">
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
	                            	<c:if test="${currentUser.mno eq host.mno}">
	                            	<div class="position-absolute hover-box w-100 h-100 rounded-circle cursor" data-toggle="modal" data-target="#profileImgModify"></div>
	                            	</c:if>
	                                <img src="/upload/display?fileName=${host.profimg}" class="rounded-circle border rounded-lg profile-photo-img" data-fullname="${host.profimg}">
	                            </div>
	                        </div>
	                        <!-- 메뉴 목록 -->
	                        <div class="col-sm-4 col-md-5 col-lg-2"></div>
	                        <div class="col-12 col-sm-7 col-md-6">
	                            <ul class="list-group list-group-flash list-group-horizontal d-sm-flex">
	                            	<li class="list-item p-2 px-3 mr-3">
	                            		<h5 class="m-0"><a href="/member/mypage?mno=${host.mno}" class="text-dark">${host.name}</a></h5>
	                                </li>
	                            	<li class="list-item border border-top-0 border-bottom-0 p-2 px-3">
	                                    <a href="/member/mypage?mno=${host.mno}" class="text-decoration-none">타임라인</a>
	                                </li>
	                                <li class="list-item border border-top-0 border-bottom-0 border-left-0 p-2 px-3">
	                                    <a href="/member/mypageBro?mno=${host.mno}" class="text-decoration-none">친구</a>
	                                </li>
	                            </ul>
	                        </div> 
	                    </div> 
	                </div>
		            <div id="friend-apply-area" class="row my-1 clearfix">
		          
		            </div>
		            <div class="border pb-5 min-h-700">
		            	<div class="bg-lightgray p-3">
		            		<h4 class="m-0"><i class="fas fa-user-friends text-dark"></i>친구</h4>
		            	</div>
		            	<div class="bg-white">
		            		<ul class="row p-0 m-0" id="friendListArea">

		            		</ul>
		            	</div>
		            </div>
	            </div>
	        </div>
	        <!-- 프로필이미지 수정 모달 -->
			<div class="modal fade" id="profileImgModify">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">프로필 수정</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body text-center">
							<div id="profileThumbNailArea">
								<img src="/upload/display?fileName=${host.profimg}" class="rounded-circle border rounded-lg profile-photo-img mb-3" data-fullname="${host.profimg}">
							</div>
							<div class="clearfix">
								<p class="small text-muted float-right">적정사이즈 : 150px * 150px</p>
							</div>
							<div>
								<input type="file" class="d-none" id="profileImgUploadForm">
								<label class="btn-block btn btn-outline-secondary mb-3 cursor" for="profileImgUploadForm">사진 업로드</label>
								<button type="button" class="btn-block btn btn-outline-primary" id="profileImgSave">저장</button>
							</div>
						</div>
						<div class="modal-footer">
						</div>
					</div>
				</div> 
			</div>
			
			<!-- 프로필커버이미지 수정 모달 -->
			<div class="modal fade" id="profileCoverImgModify">
				<div class="modal-dialog modal-xl"> 
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">커버 이미지 수정</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body text-center">
							<div id="profileCoverThumbNailArea" class="profile-cover-image">
								<c:choose>
	                        		<c:when test="${empty host.coverimg}">	                        			
	                        			<div class="w-100 h-100 bg-coverimg"></div>
	                        		</c:when>
	                        		<c:otherwise>
			                            <img src="/upload/display?fileName=${host.coverimg}" class="w-100 h-100">
	                        		</c:otherwise>
	                        	</c:choose>
							</div>
							<div>
								<input type="file" class="d-none" id="profileCoverImgUploadForm">
								<label class="btn-block btn btn-outline-secondary mb-3 cursor" for="profileCoverImgUploadForm">사진 업로드</label>
								<button type="button" class="btn-block btn btn-outline-primary" id="profileCoverImgSave">저장</button>
							</div>
						</div>
						<div class="modal-footer">
						</div>
					</div>
				</div> 
			</div>
		</div>
	</main>
</body>
</html>