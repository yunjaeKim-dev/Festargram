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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
    textarea{resize: none;}
    .profile-button {right:20px;bottom: 15px;}
    .profile-photo {left: 20px; bottom:-20px}
 	.profile-name{bottom: 20px;}   
 	
 	
</style>
    <script>
    	var writer = "${currentUser.email}"; // 댓글쓴이 지정
       	var csrfHeaderName = "${_csrf.headerName}";
   		var csrfTokenValue = "${_csrf.token}";
   		
   		$(document).ajaxSend(function(e, xhr){
   			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
   		});
   		
       	var hostMno = ${host.mno} ;
       	var hostProfimg = '${host.profimg}' ;
       	var owner = hostMno ;
       	var currentUserProfimg = '${currentUser.profimg}';
       	var currentUserMno = ${currentUser.mno} ;
       	var currentName = '${currentUser.name}' ; 
		var postRn = 0;
		var isEnd = 0 ;
		var posts = [];
       	
        $(function(){
        	console.log(hostMno);
        	console.log(currentUserMno);
        	
        	//페이지 로드시 친구관계에따라 버튼생성
        	friendBtn(currentUserMno, hostMno);
        	/* 친구관계에따라 화면변경 */
        	function friendBtn(currentUserMno, hostMno){
        		friendService.getRelationCode(currentUserMno, hostMno, function(relationCode){
        			console.log("함수안 :::" + relationCode);
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
        			if(relationCode == '4'){
        				str += '<a class="btn btn-sm btn-light px-2  mx-2 cursor" id="add-friend-btn">요청 수락</a>' ;
        			}
        			if(relationCode == '0'){
        				str += '<a class="btn btn-sm btn-light px-2  mx-2 cursor" id="friend-apply-btn">친구 요청하기</a>' ;
        			}
   	           		$("#profile-area").html(str) ;
        		});
        	}
         
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
            
    		/* 사이드바 리사이즈 */
    		$(window).resize(function(){
    			sidebarResize();
    		});
    		/* textarea */
    		$("#timeLine-area").on("keydown keyup", "[class$='register-textarea']",function(){
    			textareaResize(this) ;
    		})
           
    		
    		/* 자기소개 추가 */
    		$(".add-selfintro-btn").click(function(){
    			$(".modify-selfintro").removeClass("d-none");
    			$(".selfintro").addClass("d-none");
    		});
    		$(".modify-intro-cancel").click(function(){
    			$(".modify-selfintro").addClass("d-none");
    			$(".selfintro").removeClass("d-none");
    		});

    		
    		/*
    		자기소개 수정버튼 클릭시 자기소개 수정후 소개창 변경
    		memberService.modifySelfintro 호출
    		2019/10/29 작성
    		*/
    		$(".modify-intro-btn").click(function(){
    			var selfintro = $(this).prev().val();
    			memberService.modifySelfintro(currentUserMno, selfintro, function(data){
    				console.log(data);
    				$(this).prev().val(selfintro);
    				$(".selfintro").find("p").html(selfintro).next().text("수정하기");
    				$(".modify-selfintro").addClass("d-none");
        			$(".selfintro").removeClass("d-none");
    			})
    		})
    		
    		/* 카카오 주소 API */
    		$("#searchAddress").click(function(){
    		    new daum.Postcode({
    		        oncomplete: function(data) {
    		            $("input[name='address']").val('대한민국 ' + data.sido + ' ' + data.sigungu);
    		        }
    		    }).open();
    		})
    		
    		$("#modifyExtraInfoBtn").click(function(){
    			if(confirm('수정하시겠습니까?')){
	    			var school = $("#school").val();
	    			var job = $("#job").val();
	    			var gender = $("input[name='gender']:checked").val();
	    			var interesting = $("#interesting").val();
	    			var address = $("#address").val();
	    			var member = {mno : currentUserMno, school : school, job : job, gender : gender, interesting : interesting, address : address};
	    			memberService.modifyExtraInfo(member,function(data){
	    				console.log(data);
	    				var str = '';
	    				
	    				if(school != ''){
	    					str += '<div class="mb-1"><i class="fas fa-school mr-1 text-muted"></i></i><span class="text-muted mr-1">' + school + '</span>졸업</div>';
	    				}
	    				if(job != ''){
	    					str += '<div class="mb-1"><i class="far fa-building mr-1 text-muted"></i><span class="text-muted mr-1">'+ job + '</span> 재직</div>';
	    				}
	    				
	    				if(address != ''){
	    					str += '<div class="mb-1"><i class="fas fa-map-marker-alt mr-1 text-muted"></i><span class="text-muted mr-1">'+ address +'</span> 거주</div>';
	    				}
	    				
	    				if(interesting != ''){
	    					str += '<div class="mb-1"><i class="fas fa-icons mr-1 text-muted"></i><span class="text-muted mr-1">'+ interesting + '</span> 관심</div>';
	    				}
	    			
						$("#extraInfoArea").html(str);    				
	    				alert('수정이 완료되었습니다.');
	    				$("#modifyExtraInfo").modal("toggle");
	    				
	    				
	    			}) 
    				
    			}else{
    				return false ;
    			}
    			
    			
    		})
    		
    		
    		// reday시 첫페이지 포스트 불러옴
			getMyPagePost(hostMno, postRn);
             
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
	                        			<img src="/images/nocover.png" class="w-100 h-100"></img>
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
	                        <div class="col-sm-4 col-md-5 col-lg-2">
	                        
	                        </div>
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
		            <div class="row m-0">
			            <!-- 왼쪽 바 -->
		                <div class="d-none d-md-block col-md-4 p-2 mypage-left-sidebar">
		                    <!-- 소개 -->
		                    <div class="">
		                        <ul class="list-group list-group-flash">
		                            <li class="list-item bg-white mb-2">
		                            	<div class="bg-secondary py-2 px-3 rounded-top">
		                            		<h6 class="m-0 text-dark"><i class="fas fa-globe-asia mr-2"></i>소개</h6>
		                            	</div>
		                                <!-- 페이지 주인일때 -->
		                                	<c:if test="${currentUser.mno eq host.mno}">
		                                		<c:choose>
				                                	<c:when test="${not empty host.selfintro}">
						                                <div class="py-2 px-3 text-center border-bottom">
						                                	<div class="selfintro">
							                                    <p class="small">${host.selfintro}</p>
							                                    <a class="py-0 px-1 mx-auto small add-selfintro-btn text-primary cursor text-decoration-underline">수정하기</a>
						                                	</div>
															<div class="modify-selfintro d-none">
							                                    <form class="from-group pb-3">
							                                        <textarea class="form-control mb-3" rows="4">${host.selfintro}</textarea>
							                                        <button type="button" class="btn btn-sm btn-primary p-0 px-1 mr-1 small modify-intro-btn">수정</button>
							                                        <button type="button" class="btn btn-sm btn-light p-0 px-1 small modify-intro-cancel">취소</button>
							                                    </form>
															</div>
						                                </div>
		                                			</c:when>
		                                			<c:otherwise>
							                                <div class="text-center py-2 px-3 border-bottom">
							                                	<div class="selfintro">
								                                    <p class="text-muted small">회원님에 대해 자세히 알려주세요!</p>
								                                    <a class="py-0 px-1 mx-auto small add-selfintro-btn text-primary cursor text-decoration-underline">소개 추가</a>
							                                	</div>
							                                    <div class="modify-selfintro d-none">
								                                    <form class="from-group pb-3">
								                                        <textarea class="form-control mb-3" rows="4" placeholder="회원님을 소개해주세요!"></textarea>
								                                        <button type="button" class="btn btn-sm btn-primary p-0 px-1 mr-1 small modify-intro-btn">저장</button>
								                                        <button type="button" class="btn btn-sm btn-light p-0 px-1 small modify-intro-cancel">취소</button>
								                                    </form>
							                                    </div>
							                                </div>
		                                			</c:otherwise> 
		                                		</c:choose>
		                                		<div class="py-2 px-2 small">
		                                			<div id="extraInfoArea">
			                                			<c:if test="${not empty host.school}">
			                                				<div class="mb-1">
			                                				<i class="fas fa-school mr-1 text-muted"></i><span class="text-muted mr-1">${host.school}</span>졸업
			                                				</div>
			                                			</c:if>
			                                			<c:if test="${not empty host.job}">
			                                				<div class="mb-1">
			                                				<i class="far fa-building mr-1 text-muted"></i><span class="text-muted mr-1">${host.job}</span> 재직
			                                				</div>
			                                			</c:if>
			                                			<c:if test="${not empty host.address}">
			                                				<div class="mb-1">
			                                					<i class="fas fa-map-marker-alt mr-1 text-muted"></i><span class="text-muted mr-1">${host.address}</span> 거주
			                                				</div>
			                                			</c:if>
			                                			<c:if test="${not empty host.interesting}">
			                                				<div class="mb-1">
			                                					<i class="fas fa-icons mr-1 text-muted"></i><span class="text-muted mr-1">${host.interesting}</span> 관심
			                                				</div>
			                                			</c:if>
		                                			</div>
		                                			<div class="text-center mt-2 px-2">
		                                				<button type="button" class="btn btn-block bg-light" data-toggle="modal" data-target="#modifyExtraInfo">상세정보수정</button>
		                                			</div>
		                                		</div>
		                                	</c:if>
		                                	<!-- 회원 상세정보 수정 모달 -->
	                           				<div class="modal fade" id="modifyExtraInfo">
												<div class="modal-dialog">
													<div class="modal-content">
														<div class="modal-header bg-whitegray">
															<h6 class="modal-title">회원님을 소개할 항목을 구성해보세요.</h6>
															<button type="button" class="close" data-dismiss="modal">&times;</button>
														</div>
														<div class="bg-darkgray text-center py-4">
															<h6 class="text-white m-0">등록하신 상세정보는 전체 공개되며 뉴스피드에 등록되지 않습니다.</h6>
														</div>
														<div class="modal-body p-0">
															<div>
																<div class="bg-whitegray px-3 py-4 d-flex">
																	<label for="school" class="m-0 mr-auto pt-1"><i class="fas fa-school mr-1 text-muted"></i>학교</label>
																	<input type="text" id="school" class="w-75 p-1 text-muted" value="${host.school}">
																</div>
															</div>
															<div>
																<div class="bg-whitegray px-3 py-4 d-flex">
																	<label for="job" class="m-0 mr-auto pt-1"><i class="far fa-building mr-1 text-muted"></i>직장</label>
																	<input type="text" id="job" class="w-75 p-1 text-muted" value="${host.job}">
																</div>
															</div>
															<div>
																<div class="bg-whitegray px-3 py-4 d-flex">
																	<label class="m-0 mr-auto pt-1" for="interesting"><i class="fas fa-icons mr-1 text-muted"></i>흥미</label>
																	<input type="text" id="interesting" class="w-75 p-1 text-muted" value="${host.interesting }">
																</div>
															</div>
															<div>
																<div class="bg-whitegray px-3 py-4 d-flex">
																	<h6 class="m-0 mr-auto pt-1"><i class="fas fa-icons mr-1 text-muted"></i>성별</h6>
																	<div class="w-75">
																		<label class="m-0 mr-2"><input type="radio" class="" value="1" name="gender">남</label>
																		<label class="m-0 mx-2"><input type="radio" class="" value="0" name="gender">여</label>
																	</div>
																</div>
															</div>
															<div>
																<div class="bg-whitegray px-3 py-4">
																	<div class="d-flex mb-2">
																		<h6 class="m-0 mr-auto mb-2 pt-1"><i class="fas fa-map-marker-alt mr-1 text-muted"></i>거주지</h6>
																		<input type="text" id="address" class="w-75 p-1 text-muted" name="address" readonly="readonly" placeholder="주소는 시 구 까지만 입력됩니다" value="${host.address}">
																	</div>
																	<button type="button" class="btn btn-info d-block py-1 ml-auto" id="searchAddress">주소검색</button>
																</div>
															</div>   
														</div>
														<div class="modal-footer">
															<div>
																<button type="button" class="btn btn-sm btn-primary" id="modifyExtraInfoBtn">저장</button>
																
															</div>
														</div>
													</div>
												</div> 
											</div>
		                                	<!-- 방문자일때 -->
		                                	<c:if test="${currentUser.mno ne host.mno}">
		                                		<div class="py-2 px-2 small">
		                                			<c:if test="${not empty host.selfintro}">
		                                				<div class="px-2 mb-4 border-bottom">
		                                					${host.selfintro}
		                                				</div>
		                                			</c:if>
		                                			<c:if test="${empty host.selfintro}">
		                                				<div class="px-2 mb-4 border-bottom text-center">
		                                					해당 회원의 소개가 아직없습니다.
		                                				</div>
		                                			</c:if>
		                                			<c:if test="${not empty host.school}">
		                                				<div class="mb-1">
		                                				<i class="fas fa-school mr-1 text-muted"></i><span class="text-muted mr-1">${host.school}</span>졸업
		                                				</div>
		                                			</c:if>
		                                			<c:if test="${not empty host.job}">
		                                				<div class="mb-1">
		                                				<i class="far fa-building mr-1 text-muted"></i><span class="text-muted mr-1">${host.job}</span> 재직
		                                				</div>
		                                			</c:if>
		                                			<c:if test="${not empty host.address}">
		                                				<div class="mb-1">
		                                					<i class="fas fa-map-marker-alt mr-1 text-muted"></i><span class="text-muted mr-1">${host.address}</span> 거주
		                                				</div>
		                                			</c:if>
		                                			<c:if test="${not empty host.interesting}">
		                                				<div class="mb-1">
		                                					<i class="fas fa-icons mr-1 text-muted"></i><span class="text-muted mr-1">${host.interesting}</span> 관심
		                                				</div>
		                                			</c:if>
		                                		</div>
		                                	</c:if>
			                                
		                            </li>
		                            <li class="list-item bg-white mb-2">
		                            	<div class="bg-secondary py-2 px-3 rounded-top mb-2">
		                            		<i class="fas fa-user-friends text-dark" title="친구"></i>
		                            		<c:set var="friendList" value="${host.friendList}"/>
		                            		<span>친구</span><span>&nbsp;·&nbsp;</span>${fn:length(friendList)}명<span></span>
		                            		<a href="/member/mypageBro?mno=${host.mno}" class="small float-right">모두보기</a>
		                            	</div>
		                            	<div id="friend-list" class="row m-0">
		                            		<c:forEach begin="0" end="8" var="i">
		                            		<c:if test="${not empty friendList[i]}">
		                            		<c:set var="frprofimg" value="${fn:replace(friendList[i].profimg,'/profile/', '/profile/s_') }"></c:set>
			                            		<div class="col-4 p-0 text-center">
			                            			<div class=""><!-- 프로필아이콘 추가할공간 -->
	                            						<a href="/member/mypage?mno=${friendList[i].mno}"><img src="/upload/display?fileName=${frprofimg}" class="apply-icon "></a>
			                            			</div>
			                            			<div>
				                            			<a href="/member/mypage?mno=${friendList[i].mno}" class="text-primary small"><c:out value="${friendList[i].name}"></c:out></a>
			                            			</div>
			                            		</div>
		                            		</c:if>
		                            		</c:forEach>
		                            	</div>
		                            </li>
		                            <li>
		                            
		                            
		                            </li>
		                            <li>
		                            <div class="small txet-body p-2 text-center">
										<p>개인정보처리방침 · 이용 약관 · 광고 · AdChoices · 쿠키 · </p>
										<p>	Festargram © 2019</p>
									</div>
		                            </li>
		                        </ul>
		                    </div>
		                </div>
		                <!-- 본문? -->
		                <div class="col-12 col-md-8 p-2" id="timeLine-area">
		                <!-- 타임라인 영역 -->
		                    <div class="bg-white">
		                    	<div class="bg-white mb-4 rounded">
									<div class="bg-secondary py-2 px-3 rounded-top">
										<h6 class="m-0 text-dark">게시글 작성</h6>
									</div>
									<form id="register-post">
										<div class="row m-0 pt-2 px-2 border-bottom">
											<div class="col-1 p-0">
												<img src="/upload/display?fileName=${currentUserProfimg}" class="rounded-circle alarm-icon post-profile-icon" alt="프로필사진">
											</div>
											<c:if test="${currentUser.mno eq host.mno}">
												<div class="col-11">
													<textarea placeholder="${host.name}님 무슨 생각을 하고 계신가요?" class="w-100 border-0 post-register-textarea" maxlength="5000" style="resize: none" ></textarea>
												</div>
											</c:if>
											<c:if test="${currentUser.mno ne host.mno}">
												<div class="col-11">
													<textarea placeholder="${host.name}님에게 글을 남겨보세요." class="w-100 border-0 post-register-textarea" maxlength="5000" style="resize: none" ></textarea>
												</div>
											</c:if>
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
												<input type="file" id="uploadFileInput" data-cate="reg" name="uploadFile" multiple class="d-none uploadFileInput" accept=".jpg, .jpeg, .png, .svg, .gif, .webp">
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
		                    </div>
		                    <div>
		                    	<ul class="p-0" id="post-list-area">
		                    	
		                    	</ul>
		                    </div>
		                </div>
		            </div>
	            </div>
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
										<h6 class="m-0 text-dark">게시글 수정</h6>
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