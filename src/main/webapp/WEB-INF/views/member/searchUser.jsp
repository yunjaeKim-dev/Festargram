<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<c:import url="../common/timelineHeader.jsp"/>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.member.mno" var="sessionMno"/>
</sec:authorize>

<script src="/js/common.js"></script>
<script src="/js/friend.js"></script>
<script src="/js/member.js"></script>
<script>
	$(function(){
		sidebarResize(); 
		$(window).resize(function(){
			sidebarResize();
		});
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		  
		$(document).ajaxSend(function(e, xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		})
		
		
		var currentUserMno = ${sessionMno} ;
		var flag = true ;
		var keyword = '${keyword}' ;
		var sinceID = $("#member-list-area li").length ;
		console.log('SINCEID ::::::::::' + sinceID) ;
		getUserListWithPaging(keyword, 10, sinceID);
		
		
		
		
		function getUserListWithPaging(keyword, amount, sinceID){
			memberService.getUserListWithPaging(keyword, amount, sinceID,function(data){
				console.log('---------------------------------');
				console.log(data);
				console.log('data길이::' +Object.keys(data).length )
				if(Object.keys(data).length==0){
					flag = false ;
					if(sinceID == 0){
						$("#member-list-area").html("<li><h5>검색된 회원이 없습니다.</h5><li>");
					}
				}
				var str = '';
				for(var i in data){
					str += '<li class="py-3 border-bottom">' ;
					str += '<div class="d-flex">' ;
					str += '<div class="mr-3 align-self-center">' ;
					str += '<a href="/member/mypage?mno=' +data[i].mno +'"><img src="/upload/display?fileName=' +data[i].profimg.replace('/profile/','/profile/s_') + '" class="apply-icon"></a></div>';
					str += '<div class="align-self-center mr-auto">' ;
					str += '<a href="/member/mypage?mno=' +data[i].mno +'" class="d-block mb-1">'+ data[i].name +'</a>' ;
					if(data[i].address != null){
						str += '<p class="m-0 text-muted small">'+data[i].address +'</p>';
					}
					if(data[i].school != null){
						str += '<p class="m-0 text-muted small">'+ data[i].school +'</p>';
					}
					if(data[i].job !=null){
						str += '<p class="m-0 text-muted small">'+data[i].job +'</p>';
					}
					str += '</div><div class="align-self-center mr-3 mr-lg-5">';
					str += '<a href="/member/mypage?mno='+data[i].mno+ '" class="btn btn-primary" >방문하기</a>';
					str += '</div></div></li>';
					
				}
				$("#member-list-area").append(str);
			},function(er){
				console.log(er);
			})
		}
		
		
		$(document).scroll(function(){
			if(!flag){
				return ;
			}
			var maxHeight = $(document).height();
		    var currentScroll = $(window).scrollTop() + $(window).height();
		    
		    var sinceID = $("#member-list-area li").length ;
		    console.log('SCROLLL:::::::::' + sinceID);
			if(maxHeight <= currentScroll){
				setTimeout(function(){
					getUserListWithPaging(keyword, 5, sinceID);
	        	},800);
			}
		})
		
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
					<div class="card bg-white">
						<div class="card-header">
							<p class="m-0 mb-1">사람</p>
						</div>
						<div class="card-body pt-2">
							<ul class="p-0" id="member-list-area">
							</ul>
						</div>
					</div>
				</div>				
			</div>
		</div>
	</main>
</body>
</html>