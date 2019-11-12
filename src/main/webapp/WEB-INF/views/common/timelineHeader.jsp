<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<meta name="viewport" content="width=device-width initial-scale=1">
<title>${title}</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link href="/css/webstyles.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- bx -->
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.8.16/dayjs.min.js"></script>
<script src="/js/common.js"></script>
<script src="/js/message.js"></script>
<script src="/js/friend.js"></script>
<script src="/js/memberService.js"></script>
<script src="/js/member.js"></script>
<script src="/js/alarm.js"></script>
<sec:authentication property="principal.member" var="currentUser"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(function(e, xhr){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	})
	 /* 친구요청리스트 호출 */
	function showNavFriendApplyList(currentUserMno){
		friendService.getFriendApplyList(currentUserMno, function(list){
		if(list == null || list.length ==0){
			$("#navFriendApply").html("<li class='py-1'>검색된 회원이 없습니다.</li>");
			return ;
		}
		var str = '';
		for(var i=0; i<5; i++){
			if(list[i]){
				str += '<li class="py-1 border-bottom mb-2"><div class="d-flex">' ;
				str += '<a href="/member/mypage?mno='+list[i].mno+ '" class="d-block mr-3">' ;
				str += '<img src="/upload/display?fileName=' +list[i].profimg.replace('/profile/','/profile/s_') + '" class="alarm-icon"></a>' ;
				str += '<div class="align-self-center mr-auto"><a href="/member/mypage?mno='+list[i].mno+ '" class="d-block mb-1">' + list[i].name +'</a>';
				if(list[i].address != null){
					str += '<p class="m-0 text-muted small">'+list[i].address+'</p>';
				}
				str += '</div><div class="align-self-center small"><button class="mx-2 btn btn-primary btn-sm add-friend-btn">친구추가</button>';
				str += '<input type="hidden" value="'+list[i].mno+'">';
				str += '<button class="mx-2 btn btn-danger btn-sm remove-apply-btn">삭제</button></div>';
				str += '</div></div></li>' ;
			}
		}
		$("#navFriendApply").html(str) ;
		},function(){
			alert('요청실패');
		})
	} 
	

	function showNavMayKnownList(currentUserMno){
		friendService.getMayKnownList(currentUserMno, 5 ,function(list){
			if(list == null || list.length ==0){
				$("#navMayKnown").html("<li class='py-1'>검색된 회원이 없습니다.</li>");
				return ;
			}
			var str = '';
			for(var i in list){
				if(list[i]){
					str += '<li class="py-1 border-bottom mb-2"><div class="d-flex">' ;
					str += '<a href="/member/mypage?mno='+list[i].mno+ '" class="d-block mr-3">' ;
					str += '<img src="/upload/display?fileName=' +list[i].profimg.replace('/profile/','/profile/s_') + '" class="alarm-icon"></a>' ;
					str += '<div class="mr-auto align-self-center">';
					str += '<a href="/member/mypage?mno='+list[i].mno+ '" class="d-block mb-1">'+list[i].name +'</a>';
					str += '<p class="text-muted small m-0">함께 아는 친구 '+ list[i].count+'명</p></div>';
					str += '<div class="small align-self-center">';
					str += '<a href="/member/mypage?mno='+list[i].mno+ '" class="btn btn-sm btn-primary small">방문하기</a>';
					str += '</div></div></li>';
				}
			}
			$("#navMayKnown").html(str);				
		});
	}
	
	
	
	
	
	
	
	
	$(function(){
		var currentUserMno = "${currentUser.mno}"
		
		// 최근 접속 시간 갱신 (5분마다)
       function updateRecdate(mno){
			 console.log("sidebar.jsp updateRecdate")
			 memberService.updateRecdate(mno,function(data){
				 console.log(data)
			 })
				 
		 }
		 
		 updateRecdate(currentUserMno)
		 // 5분마다 접속 시간 갱신
		 function repeatUpdateRecdate(mno){
			 setInterval(function(){
				 updateRecdate(mno,function(data){
					 console.log(data)
				 })
			 },300000)
		 }
		 
		 repeatUpdateRecdate(currentUserMno)
		
		 // 창 닫을 시 접속 시간 갱신
		$(window).bind("beforeunload",function(){
			return updateRecdate(currentUserMno)
		})
		
		$(window).bind("unload",function(){
			return updateRecdate(currentUserMno)
		})
		
		
		
		 
	/* ----------------------------------------------------------------------------------- */
		 /* 친구요청리스트에서 친구추가 버튼을 누를시 친구요청후 리스트갱신 */
			$("#navFriendApply").on("click", ".add-friend-btn",function(){
				var applicant = $(this).next().val();
				console.log(applicant);
				friendService.addFriend(currentUserMno, applicant,function(data){
					showFriendApplyList(currentUserMno);
				},function(er){
					alert('친구추가 실패');
				});
			});
			
			/* 친구요청리스트에서 삭제버튼 누를시 친구요청삭제후 리스트갱신 */
			$("#navFriendApply").on("click", ".remove-apply-btn",function(){
				var applicant = $(this).prev().val();
				friendService.removeApply(applicant, currentUserMno,function(data){
					showFriendApplyList(currentUserMno);
				},function(){
					alert("친구요청삭제 실패");
				});
			});
			
		/*-------------------------------------------------------------------------------*/
		// 알림
		// 알림 목록 불러오기
		function getAlarmList(mno){
			alarmService.getAlarmList(mno,function(data){
				var today = dayjs()
				str = '';
				if(data.length == 0){
					str += '<tr><td><p class="m-0 p-2">새로운 알림이 없습니다.</p></td></tr>'
					$("#alarmTable").html(str)
					return false;
				}
				for(var i = 0 ; i < (data.length || 0); i ++){
					var day = dayjs(data[i].regdate);
					var time = dayjs(today).valueOf() - dayjs(day).valueOf();
					// 메시지 알림
					if(data[i].category == 1){
						str +='<tr class="row m-0">';
						str +='<td class="col-2">';
						str +='<a href="/member/mypage?mno=' + data[i].applicant + '" class="m-0 block d-block  ml-1">';
						str +='<img src="/upload/display?fileName=' +data[i].profimg.replace('/profile/','/profile/s_') + '" class="rounded-circle alarm-icon" alt="프로필사진">';
						str +='</a>';
						str +='</td>';
						str +='<td class="col-10">';
						str += '<div>'
						/* str +='<a href="#" class="d-block">'; */
						str +='<a href="/member/mypage?mno=' + data[i].mno + '" class="m-0 font-weight-bold">'+ data[i].name + '</a>';
						str +='<a href="/messenger/messenger">님이 회원님에게 메시지를 보냈습니다.</a>';
						str += '</div><div>'
						str +='<img src="/images/alarm/chat.png" alt="채팅아이콘" title="사진">';
						if(time < 60000){
							str +='<small><span>방금</span></small>';
						}
						else if(time < 3600000){
							str +='<small><span>' + dayjs(time).format('mm분전') + '</span></small>';
						}
						else if(time < 864000000){
							str +='<small><span>' + dayjs(time).format('HH') + '시간 전</span></small>';
						}else if(time < 25920000000){
							str +='<small><span>' + (today.day() - day.day()) + '일 전</span></small>';
						} 
						else if(time < 315360000000){
							str +='<small><span>' + (today.month() - day.month()) + '달 전</span></small>';
						}else{
							str +='<small><span>' + (today.year() - day.year()) + '년 전</span></small>';
						}
						/* str +='</a>'; */
						str += '</div>'
						str +='</td></tr>';
					}
					
					// 게시글 알림
					else if(data[i].category == 2){
						str +='<tr class="row m-0">';
						str +='<td class="col-2">';
						str +='<a href="/member/mypage?mno=' + data[i].mno + '" class="m-0 block d-block ml-1">';
						str +='<img src="/upload/display?fileName=' +data[i].profimg.replace('/profile/','/profile/s_') + '" class="rounded-circle alarm-icon"  alt="프로필사진">';
						str +='</a>';
						str +='</td>';
						str +='<td class="col-10">';
						str +='<div>'
						/* str +='<a href="#" class="d-block">'; */
						str +='<a href="/member/mypage?mno=' + data[i].mno + '" class="d-inline m-0 font-weight-bold">' + data[i].name + '</a>';
						str +='<a href="/member/mypage?mno=' + data[i].mno + '" class="d-line-block ">님이 새로운 게시글을 작성했습니다.</a>'
						str += '</div><div>'
						str +='<img src="/images/alarm/addimage.gif" alt="사진아이콘">';
						if(time < 60000){
							str +='<small><span>방금</span></small>';
						}
						else if(time < 3600000){
							str +='<small><span>' + dayjs(time).format('mm분전') + '</span></small>';
						}
						else if(time < 864000000){
							str +='<small><span>' + dayjs(time).format('HH') + '시간 전</span></small>';
						}else if(time < 25920000000){
							str +='<small><span>' + (today.day() - day.day()) + '일 전</span></small>';
						} 
						else if(time < 315360000000){
							str +='<small><span>' + (today.month() - day.month()) + '달 전</span></small>';
						}else{
							str +='<small><span>' + (today.year() - day.year()) + '년 전</span></small>';
						}
						/* str +='</a>'; */
						str += '</div>'
						str +='</td></tr>';
					}
					// 댓글 알림
					else {
						str +='<tr class="row m-0">';
						str +='<td class="col-2">';
						str +='<a href="/member/mypage?mno=' + data[i].mno + '" class="m-0 block d-block  ml-1">';
						str +='<img src="/upload/display?fileName=' +data[i].profimg.replace('/profile/','/profile/s_') + '" class="rounded-circle alarm-icon" alt="프로필사진">';
						str +='</a>';
						str +='</td>';
						str +='<td class="col-10">';
						str += '<div>'
						/* str +='<a href="#" class="d-block">'; */
						str +='<a href="/member/mypage?mno=' + data[i].mno +'" class="m-0 font-weight-bold">' + data[i].name + '</a>';
						str +='<a href="/member/mypage?mno=' + currentUserMno + '" >님이 회원님의 게시물에 댓글을 남겼습니다.</a>';
						str += '</div><div>'
						str +='<img src="/images/alarm/addreply.png" alt="리플아이콘" title="리플">';
						if(time < 60000){
							str +='<small><span>방금</span></small>';
						}
						else if(time < 3600000){
							str +='<small><span>' + dayjs(time).format('mm분전') + '</span></small>';
						}
						else if(time < 864000000){
							str +='<small><span>' + dayjs(time).format('HH') + '시간 전</span></small>';
						}else if(time < 25920000000){
							str +='<small><span>' + (today.day() - day.day()) + '일 전</span></small>';
						} 
						else if(time < 315360000000){
							str +='<small><span>' + (today.month() - day.month()) + '달 전</span></small>';
						}else{
							str +='<small><span>' + (today.year() - day.year()) + '년 전</span></small>';
						}
						/* str +='</a>'; */
						str += '</div>'
						str +='</td></tr>';
						
					}
				
				
				}
				
				$("#alarmTable").html(str)
			})
		}
		
		
		// 메시지 알림 목록 불러오기 
		function getMessageAlarmList(mno){
			alarmService.getMessageAlarmList(mno, function(data){
				var str = '';
				if(data.length == 0){
					str += '<tr><td><p class="p-2 m-0">새로운 메시지가 없습니다.</p></td></tr>'
				}
				for(var i = 0 ; i < (data.length || 0); i ++){
					str += '<tr class="row m-0 position-relative">';
					str += '<td class="col-2 d-flex align-content-center pl-2">';
					str += '<a href="/member/mypage?mno' + data[i].mno + '" class="m-0 block d-block align-self-center">';
					str += '<img src="/upload/display?fileName=' +data[i].profimg.replace('/profile/','/profile/s_') + '" class="rounded-circle alarm-icon" alt="프로필사진">';
					str += '</a>';
					str += '</td>';
					str += '<td class="col-10">';
					str += '<div>';
					str += '<a href="/messenger/messenger" class="d-block">';
					str += '<span class="small font-weight-bold">' + data[i].name + '</span><br>';
					str += '<span class="small">' + data[i].name + '님으로 부터 메시지가 왔습니다.</span>';
					str += '</a>';
					str += '</div>';
					str += '<div class=" small position-absolute right top pt-1 pr-2">';
					str += '<span class="font-muted">19. 10. 04</span>';
					str += '</div>';
					str += '</td>';
					str += '</tr>';
				}
				$("#messageTable").html(str)
			})
		}
		getMessageAlarmList(currentUserMno);
		/*--------------------------------------------------------------------------------*/
		/* NAV 친구관련 알림 불러오기 */
		$("#friendToggleBtn").click(function(){
			/* nav에 친구요청리스트 불러오기*/
			showNavFriendApplyList(currentUserMno);
			/* nav에 알수도있는사람리스트 불러오기*/
			showNavMayKnownList(currentUserMno);
		})
		
		getAlarmList(currentUserMno);
		
	})
</script>
</head>
<body>
<header class="fixed-top p-0">
	<div class="container">
		<nav class="navbar navbar-expand p-0">
			<a href="/post/time" class="navbar-brand">
				<img src="/images/logo/F-logo-white.png" class="nav-icon" alt="사이트로고" title="킹왕짱페스타">
			</a>
			<!--                검색바                                           -->
			<form action="/member/searchUser" class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 w-50 navbar-search small">
				<div class="input-group w-100">
					<input type="text" name="keyword" class="form-control border-0 my-auto h-auto" placeholder="검색할 회원의 이름을 입력하세요" aria-label="Search" aria-describedby="basic-addon2">
					<div class="input-group-append">
					<button class="btn btn-dark">
						<i class="fas fa-search"></i>
					</button>
					</div>
				</div>
			</form>
			<ul class="navbar-nav ml-auto">
				<!--작아졌을떄 나오는 검색아이콘 -->
				<li class="nav-item no-arrow d-sm-none">
					<a class="nav-link dropdown-toggle text-white" id="searchDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-search fa-fw"></i>
					</a>
					<!--  그아이콘 누르면 나오는 검색바  -->
					<div class="dropdown-menu p-1 w-100 shadow animated--grow-in" aria-labelledby="searchDropdown">
						<form class="form-inline mr-auto w-100" action="/member/searchUser">
						<div class="input-group">
							<input type="text" name="keyword" class="form-control border-0 small" placeholder="검색할 회원의 이름을 입력하세요" aria-label="Search" aria-describedby="basic-addon2">
							<div class="input-group-append">
							<button class="btn btn-primary text-white" type="button">
								<i class="fas fa-search fa-sm"></i>
							</button>
							</div>
						</div>
						</form>
					</div>
				</li>
				
				<!-- NAV 프로필사진과 이름  -->
				<li class="nav-item ">
				<c:set var="currentUserProfimg" value="${fn:replace(currentUser.profimg,'/profile/', '/profile/s_') }"></c:set>
					<a href="/member/mypage?mno=${currentUser.mno}" class="nav-link">
						<img src="/upload/display?fileName=${currentUserProfimg}" class="nav-icon rounded-circle" alt="프로필사진">
						<span class="mr-2 d-none d-lg-inline small text-white">${currentUser.name}</span>
					</a>
				</li>
				
<!------------------------------------- NAV 친구요청 알림(추후 알림창 높이도 고정해서 내부에서 세로스크롤 생기게해야함) ---------------------------------->
				<li class="nav-item dropdown">
					<a id="friendToggleBtn" class="nav-link dropdown-toggle d-none d-md-block" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-user-friends fa-lg pt-2" title="친구요청"></i>
					</a>
					<!-- md 이하사이즈일떄 나오는 아이콘으로 추후 친구요청페이지로 이동하게 링크해야함 -->
					<a href="/alarm/friendApply" class="nav-link d-block d-md-none text-white">
						<i class="fas fa-user-friends fa-lg pt-2" title="친구요청"></i>
					</a>
					<!-- 알림창세부 -->
					<div class="dropdown-menu dropdown-menu-right alarm-box p-2 header-alarm-window">
<!--------------------------------------------------- 친구요청--------------------------------------- -->
		                <div class="card-head border-bottom">
		                    <a href="/alarm/friendApply" class="text-body small text-muted">친구 요청</a>
		                </div>
		                
		                <div class="card-body p-1">
		                	<ul class="p-0" id="navFriendApply">
		                	</ul>
	                    </div>
<!-------------------------------------알수도 있는 사람------------------------------------  -->
		                <div class="card-head border-bottom">
		                    <a class="text-body small text-muted">알 수도 있는 사람</a>
		                </div>
		                <div class="card-body p-1"> 
		                	<ul class="p-0" id="navMayKnown">
		                	
		                	</ul>
		                </div>
		                <div class="text-center">
		                    <a href="/alarm/friendApply" class="mx-auto card-link cursor small text-muted">모두 보기</a>
		                </div>
					</div>
					
				</li>
				
				
				
<!---------------------------------------- NAV 메시지 관련 알림-------------------------------------- -->
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle d-none d-md-block" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fab fa-facebook-messenger fa-lg pt-2" title="메시지"></i>
					</a>
					<!-- 추후 메시지 관련 알림창으로 이동하거나 함 링크추가해야함 -->
					<a href="/messenger/messenger" class="nav-link d-block d-md-none text-white">
						<i class="fab fa-facebook-messenger fa-lg pt-2" title="메시지"></i>
					</a>
					
					<div class="dropdown-menu dropdown-menu-right alarm-box p-0 header-alarm-window">
            			<div class="card show-this">
                			<div class="card-head p-1 m-0 clear-fix border border-top-0 border-left-0 border-right-0">
			                    <p class="card-link mr-2 m-0 p-0">메시지</p>
             			   </div>
							<div class="card-body p-0 ">
								<div class="border border-left-0 border-right-0 border-top-0">
									<table class="table table-sm table-borderless" id="messageTable">
										<!-- <tr class="row m-0 position-relative">
			                                <td class="col-2 d-flex align-content-center pl-2">
			                                    <a href="#" class="m-0 block d-block align-self-center">
			                                        <img src="/images/alarm/friend.png" class="rounded-circle alarm-icon" alt="프로필사진">
			                                    </a>
			                                </td>
			                                <td class="col-10">
						                        <div>
						                            <a href="#" class="d-block">
						                            	<span class="small font-weight-bold">곽철용</span><br>
						                            	<span class="small">새로운 Festargram 친구인 아무개님에게 인사를 건네보세요.</span>
						                            </a>
						                        </div>
				                                <div class=" small position-absolute right top pt-1 pr-2">
				                                	<span class="font-muted">19. 10. 04</span>
				                                </div>
			                                </td>
			                            </tr>
										<tr class="row m-0 position-relative">
			                                <td class="col-2 d-flex align-content-center pl-2">
			                                    <a href="#" class="m-0 block d-block align-self-center">
			                                        <img src="/images/alarm/friend.png" class="rounded-circle alarm-icon" alt="프로필사진">
			                                    </a>
			                                </td>
			                                <td class="col-10">
						                        <div>
						                            <a href="#" class="d-block">
						                            	<span class="small font-weight-bold">곽철용</span><br>
						                            	<span class="small">새로운 Festargram 친구인 아무개님에게 인사를 건네보세요.</span>
						                            </a>
						                        </div>
				                                <div class=" small position-absolute right top pt-1 pr-2">
				                                	<span class="font-muted">19. 10. 04</span>
				                                </div> 
			                                </td>
			                            </tr> -->
	        		                </table>
								</div>
							</div>
	                		<div class="card-footer p-1">
	                    		<a href="/messenger/messenger" class="card-link"><small>message에서 모두 보기</small></a>
	                		</div>
            			</div>    
        			</div>
				</li>

<!-------------------------------------모든알림----------------------------------------------  -->				
				<li class="nav-item">
					<a class="nav-link dropdown-toggle d-none d-md-block" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-bell fa-lg pt-2" title="알림"></i>
					</a>	 
					<a href="/alarm/alarm" class="nav-link d-block d-md-none text-white">
						<i class="fas fa-bell fa-lg pt-2" title="알림"></i>
					</a>
						
					<div class="dropdown-menu dropdown-menu-right alarm-box p-0 header-alarm-window">
						<div class="card show-this">
						
						
			                <div class="card-head p-1 clear-fix border border-top-0 border-left-0 border-right-0">
			                    <a href="/alarm/alarm" class="text-body ml-2"><small>알림</small></a>
			                </div>
			                
			                
			                <div class="card-body p-0 ">
		                        <table class="table table-sm table-borderless" id="alarmTable">
		                            <!-- <tr class="row m-0">
		                                <td class="col-2">
		                                    <a href="#" class="m-0 block d-block">
		                                        <img src="/images/alarm/friend.png" class="rounded-circle alarm-icon" alt="프로필사진">
		                                    </a>
		                                </td>
		                                <td class="col-10">
		                                	<a href="#" class="d-block">
			                                	<p class="small m-0"><span class="font-weight-bold">아무개</span>님이 사진을 추가했습니다.</p>
			                                	<img src="/images/alarm/addimage.gif" alt="사진아이콘" title="사진">
												<small><span>4일</span></small>
											</a>
		                                </td>
		                            </tr>
		                            <tr class="row m-0">
		                                <td class="col-2">
		                                    <a href="#" class="m-0 block d-block">
		                                        <img src="/images/alarm/friend.png" class="rounded-circle alarm-icon"  alt="프로필사진">
		                                    </a>
		                                </td>
		                                <td class="col-10">
			                                <a href="#" class="d-block">
			                                	<p class="small m-0">새로운 친구 추천이 있습니다.<span class="font-weight-bold">아무개</span></p>
			                                	<img src="/images/alarm/recomfriend.png" alt="친구추천">
												<small><span>4일</span></small>
											</a>
		                                </td>
		                            </tr>
		                            <tr class="row m-0">
		                                <td class="col-2">
		                                    <a href="#" class="m-0 block d-block">
		                                        <img src="/images/alarm/friend.png" class="rounded-circle alarm-icon" alt="프로필사진">
		                                    </a>
		                                </td>
		                                <td class="col-10">
			                                <a href="#" class="d-block">
			                                	<p class="small m-0"><span class="font-weight-bold">아무개</span>님이 회원님의 게시물에 댓글을 남겼습니다.</p>
			                                	<img src="/images/alarm/addreply.png" alt="리플아이콘" title="리플">
												<small><span>4일</span></small>
											</a>
		                                </td>
		                            </tr> -->
		                        </table>
							</div>
			                <div class="card-footer p-1">
			                    <a href="/alarm/alarm" class="card-link mx-auto d-flex justify-content-center"><small>모두 보기</small></a>
			                </div>
			            </div>    
			        </div>
				</li>
<!------------------------------------------더보기 ---------------------------------------------- -->
				
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<i class="fas fa-caret-down fa-lg pt-2" title="더보기"></i>
					</a>
					<div class="dropdown-menu dropdown-menu-right">
						<a href="/member/modifyBaseInfo" class="dropdown-item">내정보관리</a>
						<a href="/cs/home" class="dropdown-item">고객센터</a>
						<form action="/logout" method="post">
							<button class="dropdown-item">로그아웃</button>
						</form>
					</div>
				</li>
			</ul>
		</nav>	
	</div>
</header>