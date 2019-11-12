console.log("reply module");

$(function(){


/* -------------------------------------댓글관련 함수 영역 ----------------------------------------- */



function showReplyForm(postno, parentno, name, modrno, content){ // 댓글 입력창 동적 생성
	var str = '';
	if(parentno || modrno){ // 대댓글 작성이거나 댓글 수정이면
		str += '<div class="reReply-write-area row">';
	}
    str += '<div class="col-2 col-sm-1 col-md-2 col-lg-1 p-0 text-center">';
       str += '<img alt="로그인된유저 아이콘" src="/upload/display?fileName=' +currentUserProfimg.replace('/profile/','/profile/s_') + '" class="reply-icon rounded-circle">';
    str += '</div>';
    	str += '<div class="col-10 col-sm-11 col-md-10 col-lg-11 p-0">';
	    if(modrno){ // 수정폼이면
	        str += '<form class="form-group moddiv">';
	    }else if(!name){// 대댓글작성이 아니면(일반댓글이면)
	        str += '<form class="form-group">';
	    }else{ // 대댓글작성이면
	    	str += '<form class="form-group rerediv">';
	    }
            str += '<div class="position-relative form-group">';
                str += '<div>';
                if(modrno){ // 수정이면
                	str += '<textarea rows="1" class="replyContent reply-radius pr-5 pl-3 py-2 small border d-block w-100 reply-modify-textarea" name="replyContent" style="resize:none">'+content+'</textarea>';
                }
                else if(!name){ // 대댓글작성이 아니면(일반댓글)
                    str += '<textarea rows="1" placeholder="댓글을 입력하세요" class="replyContent reply-radius pr-5 pl-3 py-2 small border d-block w-100 reply-register-textarea" name="replyContent" style="resize:none"></textarea>';
                }else{ // 대댓글 작성 이면
                	str += '<textarea rows="1" placeholder="' + name +'님에게 답글쓰기' + '" class="replyContent reply-radius pr-5 pl-3 py-2 small border d-block w-100 reReply-register-textarea" name="replyContent" style="resize:none"></textarea>';
                }
                str += '</div>';
                str += '<div class="position-absolute bottom right">';
                if(modrno){ // 댓글 수정이면
                    str += '<label for="mdbtn'+modrno+'" class="m-0 mr-3 px-3 py-1 pb-2 cursor" title="댓글수정">';
                }else if(!parentno){ // 댓글 작성이면
                    str += '<label for="replySubm" class="m-0 mr-3 px-3 py-1 pb-2 cursor" title="댓글등록">';
                }else{ // 대댓글 작성이면
                    str += '<label for="reReplybtn'+parentno+'" class="m-0 mr-3 px-3 py-1 pb-2 cursor" title="대댓글등록">';
                }
                        str += '<i class="fas fa-reply text-secondary"></i>';
                    str += '</label>';
                str += '</div>';
            str += '</div>';
        str += '</form>';
        if(modrno){ // 댓글 수정이면
        	str += '<button type="button" id="mdbtn'+modrno+'" class="d-none modSubmit" data-modrno="'+modrno+'">댓글수정</button>';
        	str += '<a class="mod-cnsl cursor">취소</a>';
        }
        else if(!parentno){ // 댓글 작성이면
            str += '<button type="button" id="replySubm" class="d-none regBtn">댓글테스트</button>';
        }else{ // 대댓글 작성이면
        	str += '<button type="button" id="reReplybtn'+parentno+'" class="d-none reRegBtn" data-parentno="'+parentno+'">대댓글테스트</button>';
        }
    str += '</div>';
    if(modrno){ // 댓글 수정이면
    	str +='</div>';
    	//console.log($("[data-rno="+modrno+"]").html());
    	$("[data-rno="+modrno+"]").first().append(str);
    	//console.log($("[data-rno="+modrno+"]").first().html());
    	//console.log($("[data-rno="+modrno+"]").children().first().html());
    	$("[data-rno="+modrno+"]").children().first().remove();
    	
    }
    else if(!parentno){ // 답글입력버튼이 아니면 원래 위치에 입력창생성
    	$("[data-postno="+postno+"]").find(".reply-update-area").html(str);
    }else{ // 답글입력버튼이면 답글을 작성할 li 안에 생성
    	str +='</div>';
    	if(!$("[data-rno="+parentno+"]").find("form").length){ // 대댓글 입력창이 없으면 입력창생성
    		$("[data-rno="+parentno+"]").first().append(str);
    	}else{ // 대댓글 입력창이 있으면 입력창삭제
    		$("[data-rno="+parentno+"]").find(".reReply-write-area").remove();
    	}
    }
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
				str += '<li class="mb-2 pl-3" data-rno="'+list[i].replyno+'">';
			}
			else{
				str += '<li class="mb-2" data-rno="'+list[i].replyno+'">';
			}
			    str += '<div class="row m-0">';
			        str += '<div class="col-1 p-0 text-center">';
			            str += '<img alt="로그인된유저 아이콘"src="/upload/display?fileName='+ list[i].profimg.replace('/profile/','/profile/s_') + '" class="reply-icon rounded-circle">';
			        str += '</div>';
			        str += '<div class="col-10 p-0">';
			            str += '<div class="d-inline-block bg-snowgray m-0 py-1 px-2 small pre-line reply-radius"><a href="/member/mypage?mno='+list[i].mno+'" class="mr-2 font-weight-bold reply-writer-name">'+list[i].name+'</a>'+list[i].content+'</div>';
			            
			            str += '<div class="small">';
			                str += '<ul class="nav">';
			                    str += '<li class="nav-item">';
			                        str += '<a class="px-1 mx-1 cursor reply-thumb" id="'+'th'+list[i].replyno+'" data-rno="'+list[i].replyno+'">좋아요</a>';
			                        str += '<div class="d-inline">';
			                            str += '<label for="th'+list[i].replyno+'"><i class="fas fa-thumbs-up text-primary small cursor"></i>';
			                            str += '<span class="small">'+list[i].thcount+'</span></label>';
			                        str += '</div>';
			                    str += '</li>';
			                    str += '<li class="nav-item">';
			                        str += '<span>&nbsp;·&nbsp;</span>';
			                    str += '</li>';
			                    if(list[i].parentno == list[i].replyno){
				                    str += '<li class="nav-item">';
			                        str += '<a class="px-1 mx-1 reReply-register cursor" data-writer="'+list[i].name+'" data-rno="'+list[i].replyno+'">답글달기</a>';
				                    str += '</li>';
			                    }
			                    str += '<li class="nav-item">';
			                    if(!list[i].moddate){ // 수정하지 않았으면
			                    	str += '<a class="px-1 mx-1">'+list[i].regdate+'</a>';
			                    }else{
			                        str += '<a class="px-1 mx-1">'+list[i].moddate+'(수정)</a>';
			                    }
			                    str += '</li>';
			                str += '</ul>';
			            str += '</div>';
			        str += '</div>';
			        //작성자 일때 댓글 수정,삭제 버튼 생성
			       	if(writer == list[i].writer){
				        str += '<div class="col-1 p-0 text-center dropdown">';
				            str += '<i class="fas fa-ellipsis-h cursor dropdown-toggle" data-toggle="dropdown"></i>';
				            str += '<div class="dropdown-menu dropdown-menu-right">';
				                str += '<a class="dropdown-item cursor modBtn" data-modrno="'+list[i].replyno+'" data-content="'+list[i].content+'">수정</a>';
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
/*------------------------------------- 댓글좋아요--------------------------------------- */      

$("#post-list-area").on("click", ".reply-thumb",function(){  // 좋아요 클릭시 좋아요추가
	var postno =$(this).closest('.post').data("postno");
	var replyno = $(this).data("rno");
	var reply = {
		replyno : replyno,
		writer : writer
	}
	console.log("좋아요누른 댓글번호와 누른사람::");
	console.log(reply);
	replyService.modiThumb(reply, function(result){ // result는 문자열타입임
		console.log(result)
		showReplyForm(postno);
		showList(postno, true);
	}); 
});





/*------------------------------------- 댓글리스트--------------------------------------- */            
$("#post-list-area").on("click", ".showReplies",function(){  // 댓글 클릭시 댓글입력창,댓글리스트 호출
var postno =$(this).closest('.post').data("postno");
showReplyForm(postno, false, false);
showList(postno,true);
$(".reply-register-textarea").focus();
});



/*------------------------------------- 댓글삭제--------------------------------------- */	
$("#post-list-area").on("click", ".reply-area .rmBtn", function(){// 댓글 삭제  (대댓글이 있는 댓글은 삭제가 안됨)
var replyno = $(this).data("rno");
var postno =$(this).closest('.post').data("postno");
replyService.remove({replyno:replyno, writer:writer}, function(result){ // result는 문자열타입임
	console.log(result);
	showReplyForm(postno, false, false);
	showList(postno,true);
});
});





/*------------------------------------- 댓글등록--------------------------------------- */
$("#post-list-area").on("click", ".reply-update-area .regBtn",function(){  // 댓글입력 버튼 클릭시 ~
var postno =$(this).closest('.post').data("postno");
var content = $(this).prev().find("textarea").val();
content = entityReplace(content);
if(content.trim().length == 0){
	alert("내용을 입력해주세요.");
}else{
	var reply = {
		postno : postno,
		writer : writer,
		content : content
	};
	console.log(reply);
	replyService.add(reply, function(result){
		console.log(result)
		showReplyForm(postno);
		showList(postno, true);
	})
};
}).on("keydown",".reply-update-area .reply-register-textarea", function(key){ // 엔터키 누르면 그냥댓글등록
if(key.keyCode == 13){
	var postno = $(this).closest('.post').data("postno");
	var content = $(this).val();
	content = entityReplace(content);
	if(content.trim().length == 0){
		alert("내용을 입력해주세요.");
		key.preventDefault();
	}else{
		var reply = {
			postno : postno,
			writer : writer,
			content : content
		};
		replyService.add(reply, function(result){
			console.log("나는걍댓글엔터맨")
			showReplyForm(postno);
			showList(postno, true);
		});
		key.preventDefault();
	}
}});



$("#post-list-area").on("click", ".reRegBtn",function(){  // 대댓글등록 버튼 클릭시 ~(진짜등록)
var postno =$(this).closest('.post').data("postno");
var parentno = $(this).data("parentno");
var content = $(this).parent().first().first().first().find("textarea").val();
console.log(content);
content = entityReplace(content);
var reply = {
	postno : postno,
	writer : writer,
	parentno : parentno,
	content : content
};
if(content.trim().length == 0){
	alert("내용을 입력해주세요.");
}else{
	replyService.add(reply, function(result){
		console.log(result)
		showReplyForm(postno);
		showList(postno, true);
	});
}
}).on("keydown",".reReply-write-area .rerediv", function(key){ // 엔터키 누르면 대댓글 등록
if(key.keyCode == 13){
	var postno =$(this).closest('.post').data("postno");
	var parentno = $(this).parent().parent().parent().parent().find(".reRegBtn").data("parentno");
	var content = $(this).find("textarea").val();
	content = entityReplace(content);
	if(content.trim().length == 0){
		alert("내용을 입력해주세요.");
		key.preventDefault();
	}else{
		var reply = {
			postno : postno,
			writer : writer,
			parentno : parentno,
			content : content
		};
		replyService.add(reply, function(result){
			console.log("나는대댓글엔터맨")
			showReplyForm(postno);
			showList(postno, true);
		});
		key.preventDefault();
	}}
});

$("#post-list-area").on("click", ".reply-list-area .reply-area .reReply-register",function(){  // 대댓글입력 버튼 클릭시 대댓글 입력폼생성
var postno =$(this).closest('.post').data("postno");
var parentno = $(this).data("rno");
var name = $(this).data("writer");
var reply = {
	postno : postno,
	writer : writer,
	parentno : parentno,
	content : $(this).prev().find("textarea").val()
};
showReplyForm(postno,parentno,name);
$(".reReply-register-textarea").focus();
});

//댓글 더보기 버튼
$("#post-list-area").on("click",".more-view", function(){ // 댓글 클릭시 댓글입력창,댓글리스트 호출
var postno =$(this).closest('.post').data("postno");
/* showList(postno); */
showList(postno);
});
/*------------------------------------- 댓글수정 --------------------------------------- */
$("#post-list-area").on("click", ".reply-area .modBtn",function(){  // 댓글수정 버튼 클릭시 수정입력폼생성 및 기존 댓글 지우기
	var modrno =$(this).data("modrno");
	var content =$(this).data("content");
	content = entityReplace(content);
	var reply = {
		replyno : modrno,
		content : content,
	};
	console.log(reply);
	showReplyForm(false,false,false,modrno,content);
	var $area = $(".reply-modify-textarea");
	$area.focus().get(0).setSelectionRange(0, $area.val().length);
}).on("click", ".reply-area .modSubmit",function(){  // 댓글수정 등록버튼 클릭시 수정
	var modrno =$(this).data("modrno");
	var content =$(this).prev().find("textarea").val();
	var postno = $(this).closest('.post').data("postno")
	content = entityReplace(content);
	var reply = {
		replyno : modrno,
		content : content,
		writer : writer
	};
	if(content.trim().length == 0){
		alert("내용을 입력해주세요.");
	}else{
		replyService.update(reply, function(result){
			console.log(result)
			showReplyForm(postno);
			showList(postno, true);
		});
	}
}).on("keydown",".reReply-write-area .moddiv .reply-modify-textarea", function(key){ // 엔터키 누르면 댓글 수정
	if(key.keyCode == 13){
		var postno =$(this).closest('.post').data("postno");
		var modrno =$(this).parent().parent().parent().next().data("modrno");
		var content =$(this).val();
		content = entityReplace(content);
		var reply = {
				replyno : modrno,
				content : content,
				writer : writer
			};
		console.log("나는수정엔터맨도입부");
		console.log(reply);
		if(content.trim().length == 0){
			alert("내용을 입력해주세요.");
			key.preventDefault();
		}else{
			replyService.update(reply, function(result){
				console.log("나는수정엔터맨실행된맨");
				showReplyForm(postno);
				showList(postno, true);
			});
			key.preventDefault();
		}}
	});


$("#post-list-area").on("click", ".reply-area .mod-cnsl",function(){  // 댓글수정취소버튼 클릭시
	var postno = $(this).closest('.post').data("postno")
	showReplyForm(postno);
	showList(postno, true);
});

/* ------------------------------------------------------------------------------------------- */


});



var replyService = (function(){
	// 
	function add(reply, callback, error){ //댓글 추가 메서드
		console.log("reply add")
		
		$.ajax({
			type : 'post',
			url : "/reply/new",
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(data){
				if(callback){
					callback(data);
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		})
	};
	
	function getList(param, callback, error){ // 댓글 조회 메서드
		console.log("getList...");
		console.log(param);
		var postno = param.postno;
		var rn = param.rn || 0;
		var url = '/reply/getList/' + postno + '/' + rn;
		$.getJSON(url, function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, stat, er){
			if(error){
				error(er);
			}
		})
	};
	
	function remove(reply, callback, error){ // 댓글 삭제 메서드
		console.log("remove");
		console.log(reply);
		
		$.ajax({
			type : 'delete',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			url : "/reply/" + reply.replyno,
			success : function(data){
				if(callback){
					callback(data);
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		})
	}
	
	function update(reply, callback, error){ // 댓글 수정 메서드
		console.log("reply update");
		console.log(reply);
		
		$.ajax({
			type : 'put',
			url : "/reply/" + reply.replyno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(data){
				if(callback){
					callback(data);
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		})
	};
	
	function modiThumb(reply, callback, error){ // 댓글 좋아요 증감 메서드
		console.log("reply modiThumb")
		
		$.ajax({
			type : 'post',
			url : "/reply/thumb",
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(data){
				if(callback){
					callback(data);
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		})
	};
	
	return {
		add:add,
		getList:getList,
		remove:remove,
		update:update,
		modiThumb:modiThumb
	};
})();