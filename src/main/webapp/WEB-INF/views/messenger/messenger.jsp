<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
	<jsp:include page="../common/timelineHeader.jsp"/>
  <style>
    .bg-gray{background: #ddd;}
    .more-menu{display: none;}
    textarea{resize: none}
    .message-name{font-size: 28px;}
  </style>
<sec:authentication property="principal.member" var="currentUser"/>
<script type="text/javascript" src="/js/message.js"></script>
<script type="text/javascript" src="/js/friend.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.8.16/dayjs.min.js"></script>
	<script>
	    // 높이 초기화 및 윈도우 크기 변경시 main 높이 조절
        function heightinit(){
			$("main")
				.css("height", ($(window).height()))
				.css("padding-top","42px")
            $("main")
                .children("div:nth-child(2)")
                .css("height",$(window).height() - ($("header").height()+$("main").children("div:nth-child(1)").height() + 2))
        }
	    // 메시지 출력창 크기 조절 및 윈도우 크기 변경시 높이 조절
		function messageBoardResize(){
            $("#messages")
            	.css("height",
            		$(window).height() 
            			- ($("header").height() + $("main").children("div:nth-child(1)").height() 
            					+ $("#messages").parent().next().height() + 2)
            	)
		}        
	    // 친구창 크기 조절
		function sideResize(){
			$("#friends")
				.css("height",
						$(window).height()
						- ($("header").height() + $("main").children("div:nth-child(1)").height()))
			
		}
        
        
        
        $(function(){
			var currentUser = "${currentUser}";
			var currentUserName = "${currentUser.name}";
			var currentUserEmail = "${currentUser.email}";
			var currentUserMno = "${currentUser.mno}";
			/* console.log("currentuser :: " + currentUser)
			console.log("currentUserName :: " + currentUserName)
			console.log("currentUserEmail :: " + currentUserEmail)
			console.log("currentUserMno :: " + currentUserMno) */
			
			var countMessage = null;
			
			var emil = null;
			var userName = null;
			
			
			
			
			
			messageBoardResize()
           	sideResize()
            $(window).resize(function(){
            	heightinit()
            	messageBoardResize()
            	sideResize()
        	})
            heightinit()
			$("header").css("position","absolute")        	
            /* 친구 목록 불러오기 */
			function friendList(mno){
				/* console.log("messenger.jsp 친구 목록 불러오는 중....") */
				friendService.getFriendListOrderRecdate(mno, function(data){
					var str = '';
					for(var i = 0 ; i < (data.length || 0) ; i ++){
						str += '<li class="clearfix">';
						str += '<input type="hidden" value="' + data[i].name +'">';
						str += '<input type="hidden" value="' + data[i].email +'">';
						str += '<button type="button" class="btn overflow-auto w-100 friend" value="' + data[i].mno + '">';
						str += '<div class="float-left w-25 mr-lg-n2 mr-xl-n4">';
						str += '<img src="/upload/display?fileName=' +data[i].profimg.replace('/profile/','/profile/s_') + '" class="nav-icon rounded-circle"> ';
						str += '</div>';
						str += '<div class="float-left w-75 ml-n3 ml-md-n1">';
						str += '<span class="d-block text-truncate friend">' + data[i].name + '</span>';
						str += '</div>';
						str += '</button>';
						str += '</li>';
					}
					
					$("#friends").html(str)
					if(data.length == 0){
						return false;
					} else{
		        	   	/* str = '<li class="list-item m-2"><img src="/upload/display?fileName=' +data[0].profimg.replace('/profile/','/profile/s_') + '" height="50" width="50"></li>'; */
		                str = '<li class="list-item my-auto"><a href="/member/mypage?mno=' + data[0].mno + '" class="message-name">' + data[0].name + '</a></li>';
		               /*  str += '<li class="list-item my-auto "><span class="fas fa-cog text-blue"></span></li>'; */
		                $("#user").html(str);
		                str = '<h2 class="ml-2 p-0 m-0" >' + data[0].name + '</h2>'; 
		                $("#user-name").html(str);
		                
						user_email = data[0].email;
						email = {sender : currentUserEmail, receiver : user_email};
						console.log(email)
		        	   	messageLoad(email);
		                messageReloadStop();
						messageReload(email);
						
					}
				});
				sideResize();
			}            
			friendList(currentUserMno);

			
			/* 메시지 불러오기 */   
            function messageLoad(email){
            	/* console.log("messenger.jsp 메시지 is comming"); */
            	messageBoardResize();
            	messageService.messageLoad(email, function(data){
            		if(countMessage == data.length){
            			return false;
            		}else {
	            		countMessage = data.length
	           			var str = '';
						for(var i = 0 ; i < (data.length || 0); i ++){
							/* console.log(data[i].regdate)
							console.log(data.length) */
							/* str += '<p class="list-group-item border-0 p-0 m-0"><p class="m-0 text-center"><small class="text-center"><span class="text-muted">' + dayjs().format(data[i].regdate) + '</span></small></p></p>' */
							if(data[i].type == 1 ){
								console.log("~~~~~~~~~~~~~~~~~~~~")
								console.log(data[i].profimg)
								str += '<li class="list-group-item border-0 p-0 m-0 my-2 message">';
									str += '<ul class="list-group list-group-horizontal m-0 p-0">';
										str += '<li class="list-group-item border-0 p-0 ml-2">';
											str += '<a href="/member/mypage?mno=' + data[i].mno + '"><img class="post-profile-icon " src="/upload/display?fileName=' +data[i].profimg.replace('/profile/','/profile/s_') + '" class="rounded-circle"></a>';
										str += '</li>';
										str += '<li class="list-group-item border-0 p-0 ml-2 my-auto">';
											str += '<p class="m-0 p-1 bg-gray rounded">' + data[i].content + '</p>';
										str += '</li>';
										if(dayjs(data[i].regdate) >= 86,400,000){
											str += '<li class="list-group-item border-0 p-0 my-auto">';
											str += '<p class="m-0 p-1 rounded small my-auto">' + dayjs(data[i].regdate).format('MM월DD일HH시') + '</p>';
											str += '</li>';	
										}else{
											str += '<li class="list-group-item border-0 p-0 my-auto">';
											str += '<p class="m-0 p-1 rounded small my-auto">' + dayjs(data[i].regdate).format('HH:mm') + '</p>';
											str += '</li>';	
										}
										str += '<li class="list-group-item border-0 p-0 ">';
											str += '<button type="button" class="more-menu btn dropdown-toggle p-0 ml-2" data-toggle="dropdown"><i class="fas fa-ellipsis-h"></i></button>';
												str += '<div class="dropdown-menu message-dropdown-menu p-0">';
													str += '<button class="btn btn-sm dropdown-item message-dropdown-item p-2 d-inline-block" value=' + data[i].messno +'><small>삭제</small></button>';
											str += '</div>';
										str += '</li>';
									str += '</ul>';
								str += '</li>';
							} else{
								str += '<li class="list-group-item border-0 message">';
								str += '<ul class="list-group list-group-flash my-mess-content list-group-horizontal float-right">';
								str += '<li class="list-group-item border-0 p-0 mr-2 more">';
								str += '<button type="button" class="more-menu btn dropdown-toggle p-0" data-toggle="dropdown"><i class="fas fa-ellipsis-h"></i></button>';
								str += '<div class="dropdown-menu message-dropdown-menu p-0">';
								str += '<button class="btn btn-sm dropdown-item message-dropdown-item p-2" value=' + data[i].messno +'><small>삭제</small></button>';
								str += '</div></li>';
								if(dayjs(data[i].regdate) >= 86,400,000){
									str += '<li class="list-group-item p-0 m-0 border-0 ">';
									str += '<p class="m-0 p-1 rounded small">' + dayjs(data[i].regdate).format('MM월DD일HH시') + '</p></li>';
								}else{
									str += '<li class="list-group-item p-0 m-0 border-0 ">';
									str += '<p class="m-0 p-1 rounded small">' + dayjs(data[i].regdate).format('HH:mm') + '</p></li>';
								}
								str += '<li class="list-group-item p-0 m-0 border-0 ">';
								str += '<p class="m-0 p-1 bg-gray rounded">' + data[i].content + '</p></li></ul></li>';
							}
						}
						$("#messages").html(str)
						$("#messages").scrollTop($("#messages")[0].scrollHeight);
            		}
					
            	})
            	
            }
            /* 친구 누르면 해당 친구와 대화를 불러옴 */
			$("#friends").on("click","button",function(e){
        	   	e.preventDefault()
        	   	/* console.log("상대방 회원번호 :: " + $(this).val())
        	   	console.log("상대방 이메일 :: " + $(this).prev().val())
        	   	console.log("상대방 이름 :: " + $(this).prev().prev().val()) */
        	   	var targetMno = $(this).val();
        	   	var targetEmail = $(this).prev().val();
        	   	var targetName = $(this).prev().prev().val()
				user_email = targetEmail;
				userName = targetName;
				email = {sender : currentUserEmail, receiver : user_email};
        	   	messageLoad(email);
        	 	// 대화 상대 정보 출력 
        		var str = ''; 
        	   	/* str += '<li class="list-item m-2"><img src="/upload/display?fileName=' +data[i].profimg.replace('/profile/','/profile/s_') + '" height="50" width="50"></li>'; */
                str += '<li class="list-item my-auto my-auto"><a href="/member/mypage?mno=' + targetMno + '" class="message-name">' + targetName + '</a></li>';
                /* str += '<li class="list-item my-auto "><span class="fas fa-cog text-blue"></span></li>'; */
                $("#user").html(str);
                str = '<h2 class="ml-2 p-0 m-0" >' + targetName + '</h2>'; 
                $("#user-name").html(str);
                heightinit()
            	messageBoardResize()
            	sideResize()
                messageReloadStop();
				messageReload(email);
           });
           
           /* 메시지 보내기 */
           $("#sendBtn").click(function(){
	       	   var message = {
	       			   sender : currentUserEmail,
	       			   receiver : user_email,
	       			   content : entityReplace($("#content").val())
	       	   };
        	   if($.trim($("#content").val()) == ''){
        		   return false;
        	   }
        		messageService.sendMessage(message)   
        		$("#content").val("")
       			messageLoad(email);
           });
           // 키보드 엔터로 보내기!
           $("#content").keypress(function(event){
        	   var message = {
	       			   sender : currentUserEmail,
	       			   receiver : user_email,
	       			   content : entityReplace($("#content").val())
	       	   };
        	   if(($.trim($("#content").val()) == '') && (event.keyCode == 13)){
        		   return false;
        	   }
		 		if(event.keyCode == 13){
		 			messageService.sendMessage(message);	
		 			$("#content").val("");
		 			event.preventDefault()
		 		}
		 		messageLoad(email);
           })
           
           
           // 상대와 메시지 모두 삭제 
           function removeAllMessage(email){
        	   /* console.log("messenger.jsp 상대와 메시지 모두 삭제중...") */
        	   
        	   messageService.removeAllMessage(email, function(data){
        		   if(data == "success"){
        			   alert('메시지가 모두 삭제되었습니다.')
        			   messageLoad(email);
        		   }
        	   })
           }
           
           // 메시지 모두 삭제
           $("#removeAllMessage").click(function(){
        	   /* console.log($("#messages li").length) */
        	   if($("#messages li").length == 0){
        		   alert("삭제할 메시지가 없습니다.")
        		   return false;
        	   }
        	   if(!confirm(userName + "님과 대화를 모두 삭제하시겠습니까?")){
        		   return false;
        	   }
        	   removeAllMessage(email);
        	   messageReload(email);
           })         
           
		var timer = null;
        // 1초 마다 메시지 불러오기
           function messageReload(email){
        	timer = setInterval(function(){
        			console.log("메시지 자동 갱신")
           			messageLoad(email); 
            },1000)
           }
           
           // 메시지 갱신 중지
           function messageReloadStop(){
        	   if(timer != null){
	        	   clearInterval(timer)
        	    }
        	   }
        
           // 메시지 하나 삭제
           function removeMessage(messno){
        	   /* console.log(messno) */
        	   if(!confirm("메시지를 삭제하시겠습니까?")){
        		   return false
        	   }
        	   messageService.removeMessage(messno,function(data){
					/* console.log("~~~~~~~~~~"+data) */
					if(data == "success"){
						messageLoad(email)
					}else{
						alert("메시지 삭제 실패했어요 ㅋ")
					}
        	   })
           }
           
           $("#messages")
           	.on("click", "button.message-dropdown-item", function() {
           		/* console.log("~~~~~~~~" + $(this).val()) */
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
    <main class="container-fluid m-0 main-top-padding pl-0 pr-0 pb-0">
        <div class="row border border-left-0 border-right-0 border-top-0 o-0 m-0 bg-secondary">
            <div class="d-none d-md-block col-md-3 text-center p-0 m-0 border border-bottom-0 border-left-0">
                <h4 class="d-inline-block mt-2" id="asdfinid">Messenger</h4>
                <!-- <button class="btn d-block float-right btn-sm p-0 px-1 mt-3 mb-3 mr-2">
                    <i class="fas fa-cog"></i>
                </button> -->
            </div>
            <div class="col-md-9  p-0 m-0 my-auto">
                <div class="row my-auto p-0 m-0" id="user-name">
					
                </div>
            </div>
        </div>
        <div class="row w-100 m-0">
            <div class="d-none d-sm-block col-sm-3 p-0 m-0">
		        <div class="overflow-auto ">
		            <div>
	                    <ul class="p-0 text-truncate overflow-auto m-0" id="friends">
	                        
	                    </ul>
		            </div>
	            </div>
            </div>
            <div class="col-12 col-sm-9 col-md-6 p-0 overflow-auto">
                <div class="card h-100 m-0 p-0">
                    <!-- 메시지 출력창 -->
                        <div class="card-body message_board p-0 m-0">
                            <ul class="list-group list-group-flush overflow-auto" id="messages">
                            </ul>
                        </div>
                            <!-- 메시지 입력창 -->
                        <div class="card-footer m-0 p-0">
                            <div class="position-relative">
                                <div class="row p-0 m-0">
                                	<form class="col-12 m-0 p-0 ">
                                    	<textarea class="w-100" name="content" id="content" rows="2" placeholder="메시지를 입력하세요..."></textarea>
                                    	<input type="hidden" value="${user_email}" id="user_email" class="p-0">
                                    	<button type="button" id="sendBtn" class="py-0 ml-2 my-2">보내기</button>
                                    	<!-- <button type="button" class="btn btn-sm p-0 m-0 px-1 btn-lg"><i class="far fa-image"></i></button>
                                    	<button type="button" class="btn btn-sm p-0 m-0 px-1"><i class="far fa-thumbs-up"></i></button> -->
                                    </form>
                                </div>
                                <!-- <div>
                                    <table class="table table-borderless table-row p-0 m-0">
                                        <tr class="col-12 p-0 m-0">
                                            <td class="float-left p-0 m-0 ml-2"><button type="button" class="btn btn-sm p-0 m-0 px-1 btn-lg"><i class="far fa-image"></i></button></td>
                                            <td class="float-right p-0 m-0 mr-2"><button type="button" class="btn btn-sm p-0 m-0 px-1"><i class="far fa-thumbs-up"></i></button></td>
                                        </tr>
                                    </table>
                                </div> -->
                            </div>
                        </div>
                </div>
            </div>
            <!-- 오른쪽 차단 버튼, 메시지 삭제 버튼 등등 -->
            <div class="d-none d-md-inline-block col-sm-3 p-0 m-0 message-info bg-whitegray">
                <div class=" m-0 p-0">
                    <div class="m-0 p-0 ">
                        <ul class="list-group list-group-flash list-group-horizontal my-auto m-0 p-2 bg-whitegray" id="user">
                            
                        </ul>
                    </div>
                    <div class="m-0 p-0">
                        <ul class="list-group list-group-flush m-0 p-0 bg-whitegray">
                            <!-- <li class="list-group-item border-0 p-0" >
                                <button type="button" class="btn p-0 m-1">
                                    <i class="fas fa-times"></i>
                                    <span class="ml-2">차단하기</span>
                                </button>
                            </li> -->
                            <li class="list-group-item border-0 p-0 bg-whitegray">
                                <button type="button" class="btn p-0 m-1 bg-whitegray" id="removeAllMessage">
                                    <i class="far fa-trash-alt"></i>
                                    <span class="ml-2">메시지 전체 삭제</span>
                                </button>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
</html>