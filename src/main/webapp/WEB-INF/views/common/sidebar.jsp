<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<sec:authentication property="principal.member" var="currentUser"/>
    <style>
        .bg-gray{background: #ddd;}
        .more-menu{display: none;}
        textarea{resize: none}
        #timelineMessenger{display: none}
        .message-card{width:300px;height:350px;}
    </style>
<script>
	
	$(function(){
		$(".mess").hover(function(){
            $(this).children().children().children("button").show()
               
        },function(){
            $(this).children().children().children("button").hide()
               
        })
        
        // 현재 로그인 유저 정보
        var currentUserEmail = "${currentUser.email}" 
        var currentUserMno = "${currentUser.mno}"
        // 함수 호출 시 사용할 사용자 정보와 대상 정보
        var email = {sender:currentUserEmail,receiver:null};
        // 친구의 정보 담을 변수
        var userName = null;
        var userEmail
        var userMno = null;
		// 메시지 리로드 할때 사용할 변수
		var countMessage = null;
        var timer = null;
        // 메시지 불러온 후 화면 출력
        function messageLoad(email){
			messageService.messageLoad(email, function(data){
				if(countMessage == data.length){
					return false;
				}else{
					countMessage = data.length
					var str = '';
					/* str += '<li class="list-group-item border-0 p-0 m-0"><p class="m-0 text-center"><small class="text-center"><span class="text-muted">(금) 오후 5:50</span></small></p></li>'; */
					for(var i = 0 ; data[i] && (i < 20); i ++){
						if(data[i].type == 1){
			                str += '<li class="list-group-item border-0 p-0 m-0 message">';
			               	str += '<ul class="list-group list-group-horizontal m-0 p-0 list-group-flush">';
			          		str += '<li class="list-group-item border-0 p-0 ml-2">';
			       			str += '<a href="#"><img src="/images/alarm/friend.png" class="rounded-circle"></a>';
			   				str += '</li>';
							str += '<li class="list-group-item border-0 p-0 ml-2 my-auto ">';
							str += '<ul class="list-group list-group-flush list-group-horizontal your-mess-content">';
							str += '<li class="list-group-item border-0 p-0 ">';
							str += '<p class="m-0 p-1 bg-gray rounded">' + data[i].content + '</p>';
							str += '</li>';
							if(dayjs(data[i].regdate) >= 86,400,000){
								str += '<li class="list-group-item border-0 p-0 ">';
								str += '<p class="m-0 p-1 small rounded">' + dayjs(data[i].regdate).format('MM월DD일HH시') + '</p>';
								str += '</li>';	
							}else{
								str += '<li class="list-group-item border-0 p-0 ">';
								str += '<p class="m-0 p-1 small rounded">' + dayjs(data[i].regdate).format('HH:mm') + '</p>';
								str += '</li>';	
							}
							str += '<li class="list-group-item border-0 p-0 ">';
							str += '<button type="button" class="more-menu btn dropdown-toggle p-0 ml-2" data-toggle="dropdown"><i class="fas fa-ellipsis-h"></i></button>';
							str += '<div class="dropdown-menu p-0">';
							str += '<button class="btn btn-sm message-dropdown-item dropdown-item p-2 d-inline-block" value=' + data[i].messno +'><small>삭제</small></button>';
							str += '</div></li></ul></li></ul></li>';
						}else{
							str += '<li class="list-group-item border-0 message">';
							str += '<ul class="list-group list-group-flash my-mess-content list-group-horizontal float-right">';
							str += '<li class="list-group-item border-0 p-0 mr-2 more">';
							str += '<button type="button" class="more-menu btn dropdown-toggle p-0" data-toggle="dropdown"><i class="fas fa-ellipsis-h"></i></button>';
							str += '<div class="dropdown-menu p-0">';
							str += '<button class="btn btn-sm message-dropdown-item dropdown-item p-2" value=' + data[i].messno +'><small>삭제</small></button>';
							str += '</div></li>';
							if(dayjs(data[i].regdate) >= 86,400,000){
								str += '<li class="list-group-item p-0 m-0 border-0 ">';
								str += '<p class="m-0 p-1 rounded small">' + dayjs(data[i].regdate).format('MM월DD일HH시') + '</p></li>';
							}else{
								str += '<li class="list-group-item p-0 m-0 border-0 ">';
								str += '<p class="m-0 p-1 rounded small">' + dayjs(data[i].regdate).format('HH:mm') + '</p></li>';
							}
							str += '<li class="list-group-item p-0 m-0 border-0 ">';
							str += '<p class="m-0 p-1 float-right bg-gray rounded">' + data[i].content + '</p>';
							str += '</li></ul></li>';
						}
					}
					$("#messageBody").html(str);
					$("#messageCardBody").scrollTop($("#messageCardBody")[0].scrollHeight);
				}
				
			})
			
		}
        // 메시지 전부 삭제
        function removeAllMessage(email){
     	   
     	   messageService.removeAllMessage(email, function(data){
     		   if(data == "success"){
     			   alert('메시지가 모두 삭제되었습니다.')
     			   messageLoad(email);
     		   }
     	   })
        }
        
    	 // 메시지 리로딩
		function messageReload(email){
			timer = setInterval(function(){
				messageLoad(email); 
			},1000)
		}
		 
		 // 메시지 갱신 중지
		function messageReloadStop(){
			if(timer != null){
				clearInterval(timer)
			}
		}
		
		 // 친구 목록 접속일순서로 불러온 후 출력
		 function getFriendListOrderRecdate(mno){
			 friendService.getFriendListOrderRecdate(mno,function(data){
				 var str = '';
				 for(var i = 0 ; i < (data.length || 0 );i ++){
					 str += '<li class="clearfix">';
					 str += '<a class="nav-link overflow-auto friend" href="#" data-mno="' + data[i].mno + '" data-profimg="/upload/display?fileName=' + data[i].profimg.replace('/profile/','/profile/s_') + '">';
					 str += '<input type="hidden" value="' + data[i].email + '">';
					 str += '<input type="hidden" value="' + data[i].name + '">';
					 str += '<input type="hidden" value="' + data[i].mno + '">';
					 str += '<div class="float-left w-25 mr-lg-n2 mr-xl-n4">';
					 str += '<img src="/upload/display?fileName=' +data[i].profimg.replace('/profile/','/profile/s_') + '" class="nav-icon rounded-circle">';
					 str += '</div>';
					 str += '<div class="float-left w-75 ml-n3 ml-md-n1">';
					 str += '<span class="d-block text-truncate">' + data[i].name + '</span>';
					 str += '</div></a></li>';
				 }
				 $(".friendList").html(str)
				 
			 })
		 }
		 
		 getFriendListOrderRecdate(currentUserMno)
		 
		
		 


		 // 친구 클릭했을때 
		$(".friendList").on("click",'a',function(){
			event.preventDefault();
			messageReloadStop();
			email.receiver = $(this).children("input[type=hidden]:nth-child(1)").val();
			userName = $(this).children("input[type=hidden]:nth-child(2)").val();
			userMno = $(this).children("input[type=hidden]:nth-child(3)").val();
			var mno = $(this).data("mno")
			var profImg = $(this).data("profimg");
			$("#userName").text(userName);
			$("#timelineMessenger").show();
			var str = ''
			str += '<a href="/member/mypage?mno=' + mno + '"><img class="reply-icon my-2" src="' + profImg + '"></a>';
            str += '<small class="ml-2"><a href="/member/mypage?mno=' + mno + '" id="userName">' + userName +'</a></small>';
       		str += '<button type="button" class="close text-primary btn btn-lg my-2 mr-2 closeMessenger">&times;</button>';
   			str += '<div class="d-inline-block float-right">';
			str += '<button type="button" class="float-right btn btn-lg p-0 my-1 mr-2 dropdown-toggle" data-toggle="dropdown">';
			str += '<i class="fas fa-chevron-down"></i>';
			str += '</button>';
			str += '<div class="dropdown-menu p-0">';
            str += '<button class="btn btn-sm dropdown-item p-2" id="removeAllMessage"><small>메시지 전체 삭제</small></button>';
           	str += '</div>';
      		str += '</div>';
            
            $("#message-card-header").html(str);
			messageReload(email);
		})
		
		// 메시지 삭제 버튼 눌렀을 때 
		$("#message-card-header").on("click","button#removeAllMessage",function(){
        	   messageReloadStop()
        	   if($("#messageBody li").length == 0){
        		   alert("삭제할 메시지가 없습니다.")
        		   return false;
        	   }
        	   if(!confirm(userName + "님과 대화를 모두 삭제하시겠습니까?")){
        		   return false;
        	   }
        	   removeAllMessage(email);
        	   messageReload(email);
		})
           
		// 엔터키로 메시지 전송
		$("#content").keypress(function(event){
			messageReloadStop()
			
     	   var message = {
	       			   sender : currentUserEmail,
	       			   receiver : email.receiver,
	       			   content : entityReplace($("#content").val())
	       	   };
     	   if(($.trim($("#content").val()) == '') && (event.keyCode == 13)){
     		   return false;
     	   }
	 		if(event.keyCode == 13){
	 			messageService.sendMessage(message);	
	 			messageLoad(email)
	 			messageReload(email)
	 			$("#content").val("");
	 			event.preventDefault()
	 		}	 	  
        })
         // 메시지창 닫기
         $("#message-card-header").on("click","button.closeMessenger",function(){
        	 messageReloadStop();
        	 $("#timelineMessenger").hide();
        	 email.receiver = null;
         })
         /* $(".closeMessenger").click(function(){
        	 messageReloadStop();
        	 $("#timelineMessenger").hide();
        	 email.receiver = null;
         }) */
      // 메시지 하나 삭제
         function removeMessage(messno){
      	   if(!confirm("메시지를 삭제하시겠습니까?")){
      		   return false
      	   }
      	   messageService.removeMessage(messno,function(data){
					if(data == "success"){
						messageLoad(email)
					}else{
						alert("메시지 삭제 실패했어요 ㅋ")
					}
      	   })
         }
         // 메시지 하나 제거 부분
         $("#messageBody")
           	.on("click", "button.message-dropdown-item", function() {
           		
           		removeMessage($(this).val())
           	})
           	.on("mouseenter", "li.message",function(){
           		$(this).find("button.more-menu").show()
           	})
           	.on("mouseleave", "li.message", function(){
           		$(this).find("button.more-menu").attr("aria-expanded","false").hide()
           		$(this).find("div.message-dropdown-menu").removeClass("show")
           })
         
	})
</script>
<aside class="d-none d-md-block position-fixed z-index-fixed" id="left-sidebar">
	<div>
		<nav >
			<ul class="p-0 text-truncate" >
				<li class="mb-3 mt-2 small px-2 px-lg-4 ">
					<div class="small bg-secondary rounded">
						<form class="form-inline">
							<div class="input-group">
								<div class="input-group-prepend px-2">
									<button class="btn px-md-1 NotImplemented" type="button" title="검색">
										<i class="fas fa-search fa-sm"></i>
									</button>
								</div>
								<input type="text" class="form-control border-0 p-1 w-50 bg-transparent white-placeholder text-white" placeholder="검색">
								<input type="text" class="d-none">
								<div class="input-group-append">
									<button type=button class="bg-transparent border-0 mx-xl-2 NotImplemented" title="새메시지">
										<i class="fas fa-edit"></i>
									</button>
									<button type=button class="bg-transparent border-0 mx-xl-2 NotImplemented" title="설정">		
										<i class="fas fa-cog"></i>
									</button>
								</div>
							</div>
						</form>
					</div>
				</li>
				<li>
					<ul class="p-0 m-0 mw-100 text-truncate friendList">
					</ul>
				</li>
				<!-- <li class="clearfix">
					<a class="nav-link overflow-auto friend" href="#">
						<input type="hidden" value="test2@test.test">
						<input type="hidden" value="테스터2">
						<div class="float-left w-25 mr-lg-n2 mr-xl-n4">
							<img src="/images/logo2.png" class="nav-icon rounded-circle">
						</div>
						<div class="float-left w-75 ml-n3 ml-md-n1">
							<span class="d-block text-truncate">친구1</span>
						</div>
					</a>
				</li> -->
			</ul>
		</nav>
	</div>
</aside>
<div class="d-none d-md-block col-md-3 sidebar-box" id="sidebar-box"></div>

<div class="position-absolute " id="timelineMessenger">
<div class="position-fixed message-card-position" >
            <div class="card message-card show-this" >
                <div class="card-head p-0 m-0 ml-2 clear-fix border border-top-0 border-left-0 border-right-0" id="message-card-header">
                   <!-- <a href="/member/mypage?mno="><img src="/images/alarm/friend.png"></a>
                    <small><a href="/member/mypage?mno=" id="userName"></a></small> 
                    <button type="button" class="close text-primary btn btn-lg my-2 mr-2 closeMessenger">&times;</button>
                    <div class="d-inline-block float-right">
                        <button type="button" class="float-right btn btn-lg p-0 my-1 mr-2 dropdown-toggle" data-toggle="dropdown">
                        	<i class="fas fa-chevron-down"></i>
                        </button>
                        <div class="dropdown-menu p-0">
                            <button class="btn btn-sm dropdown-item p-2"><small>차단</small></button>
                            <button class="btn btn-sm dropdown-item p-2"><small>메시지 무시</small></button>
                            <button class="btn btn-sm dropdown-item p-2" id="removeAllMessage"><small>메시지 전체 삭제</small></button>
                        </div>
                    </div> -->
                </div>

                <div class="card-body p-0 overflow-auto" id="messageCardBody">
                    <ul class="list-group list-group-flush overflow-auto" id="messageBody">
                        
                    </ul>
                </div>
                <div class="card-footer p-1 input-group-sm">
                    <form class="form-group p-0 m-0">
                        <textarea id="content" class="form-control" placeholder="메시지를 입력하세요."></textarea>
                    </form>
                </div>
            </div>    
        </div>
      </div> 
