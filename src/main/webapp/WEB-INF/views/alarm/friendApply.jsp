<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<jsp:include page="../common/timelineHeader.jsp"/>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.member.mno" var="sessionMno"/>
</sec:authorize>
<script>
	$(function(){
		var currentUserMno = ${sessionMno} ;
		console.log(currentUserMno);
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		  
		$(document).ajaxSend(function(e, xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		})
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
        })
        
        /* 친구요청리스트 호출 */
        function showFriendApplyList(currentUserMno){
			friendService.getFriendApplyList(currentUserMno, function(list){
			if(list == null || list.length ==0){
				$("#friend-apply-area").html('');
				$("#apply-list-size").html('0');
				return ;
			}
			$("#apply-list-size").html(list.length);
			
			var str = '';
			for(var i in list){
				str += '<li class="py-1 border-bottom"><div class="d-flex">' ;
				str += '<a href="/member/mypage?mno='+list[i].mno+ '" class="d-block mr-3">' ;
				str += '<img src="/upload/display?fileName=' +list[i].profimg.replace('/profile/','/profile/s_') + '" class="apply-icon"></a>' ;
				str += '<div class="align-self-center mr-auto"><a href="/member/mypage?mno='+list[i].mno+ '" class="d-block mb-1">' + list[i].name +'</a>';
				if(list[i].address != null){
					str += '<p class="m-0 text-muted small">'+list[i].address+'</p>';
				}
				if(list[i].school != null){
					str += '<p class="m-0 text-muted small">'+list[i].school+'</p>';
				}
				if(list[i].job != null){
					str += '<p class="m-0 text-muted small">'+list[i].job+'</p>';
				}
				str += '</div><div class="align-self-center"><button class="mx-2 btn btn-primary btn-sm add-friend-btn">친구추가</button>';
				str += '<input type="hidden" value="'+list[i].mno+'">';
				str += '<button class="mx-2 btn btn-danger btn-sm remove-apply-btn">삭제</button></div>';
				str += '</div></div></li>' ;
			}
			$("#friend-apply-area").html(str) ;
				
			},function(){
				alert('요청실패');
			})
		} 
		/* 알수도있는사람 리스트 */
		function showMayKnownList(currentUserMno){
			friendService.getMayKnownList(currentUserMno,null , function(list){
				if(list == null || list.length ==0){
					$("#friend-apply-area").html('');
					return ;
				}
				var str = '';
				for(var i in list){
					str += '<li class="py-1 border-bottom"><div class="d-flex">' ;
					str += '<a href="/member/mypage?mno='+list[i].mno+ '" class="d-block mr-3">' ;
					str += '<img src="/upload/display?fileName=' +list[i].profimg.replace('/profile/','/profile/s_') + '" class="apply-icon"></a>' ;
					str += '<div class="align-self-center mr-auto"><a href="/member/mypage?mno='+list[i].mno+ '" class="d-block mb-1">' + list[i].name +'</a>';
					str += '<p class="m-0 text-muted small">함께 아는 친구'+ list[i].count + '명</p>';
					if(list[i].address != null){
						str += '<p class="m-0 text-muted small">'+list[i].address+'</p>';
					}
					if(list[i].school != null){
						str += '<p class="m-0 text-muted small">'+list[i].school+'</p>';
					}
					if(list[i].job != null){
						str += '<p class="m-0 text-muted small">'+list[i].job+'</p>';
					}
					str += '</div><div class="align-self-center">' ;
					if(list[i].isapply == 1){
						str += '<button class="mx-2 btn btn-danger btn-sm remove-apply-btn">요청삭제</button>';
					}else if(list[i].isapply ==0){
						str += '<button class="mx-2 btn btn-primary btn-sm add-friend-btn">친구신청</button>';
					}
					str += '<input type="hidden" value="'+list[i].mno+'">';
					str += '</div>';
					str += '</div></div></li>' ;
				}
				$("#mayKnowArea").html(str) ;
			})
		}
		
		
		/* 친구요청리스트에서 친구추가 버튼을 누를시 친구요청후 리스트갱신 */
		$("#friend-apply-area").on("click", ".add-friend-btn",function(){
			var applicant = $(this).next().val();
			console.log(applicant);
			friendService.addFriend(currentUserMno, applicant,function(data){
				showFriendApplyList(currentUserMno);
			},function(er){
				alert('친구추가 실패');
			});
		});
		
		/* 친구요청리스트에서 삭제버튼 누를시 친구요청삭제후 리스트갱신 */
		$("#friend-apply-area").on("click", ".remove-apply-btn",function(){
			var applicant = $(this).prev().val();
			friendService.removeApply(applicant, currentUserMno,function(data){
				showFriendApplyList(currentUserMno);
			},function(){
				alert("친구요청삭제 실패");
			});
		});
		
		/* 알수도있는사람에서 친구추가누를시 이벤트 */
		$("#mayKnowArea").on("click", ".add-friend-btn" ,function(){
			var target = $(this).next().val();
			console.log(target);
			var $btn = $(this);
			friendService.friendApply(currentUserMno, target ,function(data){
				showMayKnownList(currentUserMno);		
			},function(er){
				alert('친구추가 실패');
			});
		})
		/* 알수도있는사람 요청삭제누를시 이벤트 */
		$("#mayKnowArea").on("click",".remove-apply-btn",function(){
			var target = $(this).next().val();
			friendService.removeApply(currentUserMno, target,function(data){
				showMayKnownList(currentUserMno);
			},function(){
				alert("친구요청삭제 실패");
			});
		})
		
		
        showFriendApplyList(currentUserMno) ;
        showMayKnownList(currentUserMno);
	
	})
  </script>
  <style>
  	main{min-height:1000px;}/* 추후지울것 */
  </style>
<body>
	<main class="main-top-padding">
		<div class="container pt-2">
			<div class="row">
			<!---------좌측사이드바 --------->
				<jsp:include page="../common/sidebar.jsp"/>
				<div class="col-md-9 rounded mt-2">
					<!-- 친구요청목록 -->
					<div class="bg-white mb-3">
						<div class="border-bottom py-2 px-3">
							<p class="m-0 mb-2"><span id="apply-list-size"></span>개의 친구 요청에 답하기</p>
						</div>
						<div class="py-2 px-3">
							<ul class="p-0" id="friend-apply-area">
								
							</ul>
						</div>
					</div>
					
					
					<!-- 추후 할 알수도 있는 사람 -->
					<div class="bg-white">
						<div class="border-bottom py-2 px-3">
							<p class="m-0 mb-2">알 수 도있는 사람</p>
						</div>
						<div class="py-2 px-3">
							<ul class="p-0" id="mayKnowArea">
								
							</ul>
						</div>
					</div>
				</div>				
			</div>
		</div>
	</main>
</body>
</html>