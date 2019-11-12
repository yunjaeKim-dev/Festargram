<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../common/timelineHeader.jsp"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.8.16/dayjs.min.js"></script>
<sec:authentication property="principal.member" var="currentUser"/>
		<div class="container h-100">
			<div class="row">
<%-- 				<jsp:include page="../common/sidebar.jsp"/> --%>
				<div class="border border-dark col-xl-9 col-lg-9 col-md-12 col-sm-12">
					<div>
						<p>내 알림</p>
					</div>
					<div>
						<ul class="list-group m-0 p-0 list-group-flush ">
							<c:forEach items="${alarmList}" var="list">
							<c:set var="currentUserProfimg" value="${fn:replace(list.profimg,'/profile/', '/profile/s_') }"></c:set>
							<c:choose>
								<c:when test="${list.category == 1 }">
									<li class="list-group-item border-bottom-1 p-2 align-middle ">
											<a href="/member/mypage?mno=${list.mno}"><img src="/upload/display?fileName=${currentUserProfimg}" class="d-inline-block align-baseline my-auto right-side-icon"></a>
											<ul class="list-group d-inline-block list-group-flush ml-2 ">
												<li class="list-group-item p-0 m-0 border-0">
													<a href="/member/mypage?mno=${list.mno}" class="m-0 p-0">${list.name}</a><a href="#" class="m-0 p-0">가 회원님에게 메시지를 작성했습니다.</a>
												</li>
												<li class="list-group-item p-0 m-0 border-0">
													<img src="/images/alarm/chat.png">
													<span>${list.regdate }</span>
												</li>
											</ul>
									</li>
								</c:when>
								<c:when test="${list.category == 2 }">
									<li class="list-group-item border-bottom-1 p-2 align-middle ">
											<a href="/member/mypage?mno=${list.mno}"><img src="/upload/display?fileName=${currentUserProfimg}" class="d-inline-block align-baseline my-auto right-side-icon" ></a>
											<ul class="list-group d-inline-block list-group-flush ml-2 ">
												<li class="list-group-item p-0 m-0 border-0">
													<a href="/member/mypage?mno=${list.mno}" class="m-0 p-0">${list.name }</a><a href="#">가 새로운 게시물을 작성했습니다.</a>
												</li>
												<li class="list-group-item p-0 m-0 border-0">
													<img src="/images/alarm/addimage.gif">
													<span>${list.regdate }</span>
												</li>
											</ul>
									</li>
								</c:when>
								<c:otherwise>
									<li class="list-group-item border-bottom-1 p-2 align-middle ">
											<a href="/member/mypage?mno=${list.mno}"><img src="/upload/display?fileName=${currentUserProfimg}" class="d-inline-block align-baseline my-auto right-side-icon"></a>
											<ul class="list-group d-inline-block list-group-flush ml-2 ">
												<li class="list-group-item p-0 m-0 border-0">
													<a href="/member/mypage?mno=${list.mno}" class="m-0 p-0">${list.name }</a><a href="#" class="m-0 p-0">가 새로운 댓글을 달았습니다.</a>
												</li>
												<li class="list-group-item p-0 m-0 border-0">
													<img src="/images/alarm/addreply.png">
													<span>${list.regdate }</span>
												</li>
											</ul>
									</li>
								</c:otherwise>
							</c:choose>
							</c:forEach>
							
						</ul>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
</html>