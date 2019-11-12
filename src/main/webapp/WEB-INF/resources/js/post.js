/*------------------------------------------------함수-----------------------------------*/
// 업로드시 썸네일이미지생성
function showUploadFile(uploadResultArr,cate){
	var str = '' ;
	$(uploadResultArr).each(function(){
		str += '<li class="mx-1 p-1 d-inline-block" ';
		str += 'data-uuid="'+this.uuid + '" ';
		str += 'data-uploadPath="'+this.uploadPath + '" ';
		str += 'data-mimeType="'+this.mimeType + '" ';
		str += 'data-fileSize="'+this.fileSize + '" ';
		str += 'data-fileName="'+this.fileName + '" ';
		str += '>' ;
		str += '<div class="position-relative">';
		str += '<img src="/upload/display?fileName='+ encodeURIComponent(this.fullThumbName) + '" class="register-thumbnail-image img-thumbnail">' ;
		str += '<i class="far fa-times-circle fa-lg position-absolute right top mt-2 mr-2 remove-thumb" data-file="'+encodeURIComponent(this.fullThumbName) + '"></i>' ;
		str += '</div>';
		str += '</li>' ;
	})
	if(cate == 'reg'){
		$("#tumbnail-area ul").append(str);
	}
	if(cate =='modify'){
		$("#modifyTumbnailArea ul").append(str);
	}
}

//파일 사이즈 체크
function checkExtension(fileSize){
	var maxSize = 1024 * 1024 * 5 ;
	if(fileSize >= maxSize) {
		alert('5MB 이상은 업로드 할 수 없습니다.') ;
		return false ;
	}
	return true ;
}
// 타임라인 문자열조합
function getAddPostStr(postno, writer, writerName, regdate, content, attachList, replyCnt, thcount, profimg ,isGood, frn, fisEnd){
	var str = '';
	str += '<li class="mb-3 border">';
	str += '<div class="bg-white rounded post" data-postno="'+postno + '"><div><div class="py-2 px-3 position-relative"><div class="mt-n2 position-absolute right left">' ;
	// 게시글 수정 삭제 --- 버튼
	if(writer == currentUserMno){
		str += '<div class="position-absolute mt-2 mr-2 right cursor dropdown dropright">';
		str += '<i class="fas fa-ellipsis-h dropdown-toggle" data-toggle="dropdown"></i>';
		str += '<div class="dropdown-menu"><a class="dropdown-item cursor post-modify-btn" data-toggle="modal" data-target="#postModifyModal">게시글 수정</a><a class="dropdown-item cursor post-remove-btn">게시글 삭제</a></div>'
		str += '</div>' ;
	}
	// -----------------------------------------------------------------
	str += '</div>' ;
	str += '<div><div class="clearfix"><div class="mr-2 float-left">' ;
	//글작성자 프로필아이콘 추후 프로필이미지 폴더 생기면 작성자프로필로 변경
	str += '<a href="/member/mypage?mno='+writer+ '"><img src="/upload/display?fileName=' +profimg.replace('/profile/','/profile/s_') + '" class="rounded-circle alarm-icon post-profile-icon" alt="프로필사진"></a>	</div>' ;
	str += '<div class="float-left">' ;
	str += '<h6 class="m-0"><a href="/member/mypage?mno=' +writer +'">' + writerName + '</a></h6>' ;
	str += '<span class="small">' + regdate + '</span></div></div></div>' ;
	str += '<div><div class="p-2 pre-line">'+ content + '</div>  </div><div>' ;
	/* <textarea class="w-100 border-0" style="resize: none" readonly="readonly">' +data[i].content + '</textarea> */
	//첨부파일영역(임시)
	str += '<div>';
	if(attachList != null && attachList.length > 0){
		for(var j=0; j< attachList.length; j++){
			str += '<img src="/upload/display?fileName='+ encodeURIComponent(attachList[j].fullThumbName) + '" data-fullname="'+ attachList[j].fullName +'" class="register-thumbnail-image img-thumbnail cursor post-thumbnail-image btn-slider">' ;
		}
	}
	str += '</div>' ;
	//
	
	str += '<div class="reply-point"><div class=""><div class="py-2 mx-3 d-flex justify-content-between border-bottom">' ;
	str += '<div><i class="fas fa-thumbs-up text-primary mr-2"></i>' ;
	
	str += '<span class="small">' + '<span class="thcount-area">' + thcount +'</span></div>';
	str += '<div>' ;
	str += '<div class="d-inline mx-2 small text-dark showReplies">댓글 <span>' + replyCnt +'</span>개</div>' ;
	// 공유하기 카운트 나중에생각
	str += '<div class="d-inline mx-2 small text-dark ">공유 <span>0</span>회</div></div></div></div>' ;
	str += '<div class="border-bottom"><div class="m-0 text-center px-3 py-2 row justify-content-between">';
	//좋아요
	if(isGood == 1){
		str += '<div class="col-4 cursor hover-light-box good-area text-primary"><i class="far fa-thumbs-up"></i><span>좋아요</span></div>';
	}else if(isGood == 0){
		str += '<div class="col-4 cursor hover-light-box good-area"><i class="far fa-thumbs-up"></i><span>좋아요</span></div>';
	}else{
		str += '<div class="col-4 cursor hover-light-box good-area"><i class="far fa-thumbs-up"></i><span>좋아요</span></div>';
	}
	// 댓글 버튼 두석이 댓글버튼이벤트 아이디로 걸려있는거 수정해야함
	str += '<div class="col-4 cursor showReplies"><i class="far fa-comment-alt"></i><span class="reply-show-btn">댓글</span></div>';
	// 공유하기버튼
	str += '<div class="col-4 cursor NotImplemented"><i class="fas fa-share"></i><span>공유</span></div></div></div></div>';
	// 댓글작성폼 위치인듯
	str += '<div class="px-2 pt-2"><div class="reply-update-area row m-0 mb-2"></div>';
	str += '<div class="reply-list-area"><ul class="reply-area p-0"></ul>';
	str += '<button type="button" class="more-view d-none btn btn-block btn-primary">더보기</button>';
	str += '</div>';
	str += '</div></div></div></div></div>';
	str += '</li>';
	
	if(frn){
		postRn = frn ;
	}
	if(fisEnd){
		isEnd = fisEnd ;
	}
	posts.push({no : postno});
	
	return str ;
}

// 마이페이지 타임라인불러오기
function getMyPagePost(hostMno){
	postService.getMyPagePost(hostMno, postRn,currentUserMno , function(data){
		var str = '';
		for(var i in data){
			console.log("data[i].isEnd :::::::::" + data[i].isEnd);
			str += getAddPostStr(data[i].postno, data[i].writer, data[i].writerName, data[i].regdate, data[i].content, data[i].attachList, data[i].replyCnt, data[i].thcount, data[i].profimg, data[i].isGood ,data[i].rn, data[i].isEnd);
			}
		
		$("#post-list-area").append(str);
		$(".dropdown-toggle").dropdown();
			
    	},function(error){
    		console.log(error);
    	}
	)
}

// 뉴스피드 호출 함수
function getNewsfeed(){
	var str = '';
	postService.getNewsfeed(currentUserMno, postRn,function(data){
		console.log(data);
		for(var i in data){
			str += getAddPostStr(data[i].postno, data[i].writer, data[i].writerName, data[i].regdate, data[i].content, data[i].attachList, data[i].replyCnt, data[i].thcount, data[i].profimg , data[i].isGood, data[i].rn, data[i].isEnd);
		}
		$("#post-list-area").append(str);
		$(".dropdown-toggle").dropdown();
	},function(error){
		console.log(error);
	});
}

/*---------------------------------------------------- 이벤트----------------------------------------------- */
/* 게시글작성 */
$(function(){
	$("#post-register-btn").click(function(){
		var content = $(".post-register-textarea");
		var contentVal = content.val();
		if(contentVal.length ==0){
			alert("글 내용을 입력해주세요!");
			return false;
		}
		contentVal = entityReplace(contentVal);
		var attachList = [];
		
		$("#tumbnail-area ul li").each(function(){
			var attach = {uuid : $(this).data("uuid"), uploadPath : $(this).data("uploadpath"),
					mimeType : $(this).data("mimetype"), fileSize : $(this).data("filesize"),
					fileName : $(this).data("filename")};
			attachList.push(attach);
		});
		
		console.log(attachList);
		var post = {
			writer : currentUserMno,
			owner : owner,
			content : contentVal,
			attachList : attachList
			
		}
		postService.postRegister(post,function(data){
			console.log("글작성완료 후 넘어온 data :: ");
			console.log(data);
			alert("글작성이 완료되었습니다.");
			content.val("");
			$("#tumbnail-area ul li").remove();
			textareaResize(content);
			var addStr = '';
			addStr += getAddPostStr(data.postno, data.writer, data.writerName, data.regdate, data.content, data.attachList, data.replyCnt, data.thcount, currentUserProfimg);
			
			$("#post-list-area").prepend(addStr);
	
			
			
		},function(er){
			console.log(er) ;
		})
		
	})
	
	/* textarea 본문textarea 개행시 높이자동조절*/
	$("#timeLine-area, #postModifyModal").on("keydown keyup", "[class$='register-textarea']",function(){
		textareaResize(this) ;
	})
	
	/*파일 업로드시 물리데이터파일저장*/
	$(".uploadFileInput").change(function(){
		console.log(this);
		var files1 = $(this).get(0).files ;
		console.log(files1);
		var cate = $(this).data("cate") ;
		console.log('cate ::::::: ' + cate);
		var formData = new FormData();
		
		for(var i = 0 ; i < files1.length ; i++){
			if(!checkExtension(files1[i].size)){
				console.log("사이즈 초과");
				return false;
			} 
			console.log('파일반복문안 -----------');
			console.log(files1[i]);
			formData.append('uploadFile', files1[i]);
		}
		
		$.ajax({
			type : 'post',
			url : '/upload/file/0',
			enctype: 'multipart/form-data',
			contentType : false, //multipart/form-data" 로 전송이 되게 false 로 넣어준다
			processData : false, // data 파라미터로 전달된 데이터를 jQuery 내부적으로 query string 으로 만드는데, 파일 전송의 경우 이를 하지 않아야 하고 이를 설정하는 것이 processData: false 이다.
			data : formData,
			dataType : 'json',
			success:function(data){
				console.log("success data :: " , data);
				showUploadFile(data,cate);
			},
			error: function(error){
				alert("이미지 파일이 아닙니다.");
			}
		});
	});
	/* ---------------첨부된 파일 삭제   --------              */
	$("#tumbnail-area ul, #modifyTumbnailArea ul").on("click", ".remove-thumb", function(){
		var target = $(this).data("file");
		console.log(target);
		var $li = $(this).closest("li");
		$.ajax({
			url : "/upload/delete",
			data : {fileName : target},
			dataType : "text",
			type : "post",
			success : function(data){
				$li.remove();
				console.log(data);
			},
			error: function(error){
				alert('삭제실패');
			}
		}); 
	});
	
	
	
	// 게시글삭제
	$("#post-list-area").on("click",".post-remove-btn",function(){
		if(confirm('삭제하시겠습니까?')){
			var postno = $(this).closest(".post").data("postno") ;
			var $postli = $(this).closest("li");
			postService.removePost(postno, function(data){
				alert(data);
				$postli.remove();
			},function(error){
				console.log(error);
			})
		}
	});
	
	
	//게시글 수정하기 버튼클릭시 ajax요청해서 수정modal에 첨부파일,게시글내용 넣어줌
	$("#post-list-area").on("click", ".post-modify-btn",function(){
		var content = $("#postModifyModal textarea") ;
		//모달초기화
		content.val("");
		$("#modifyTumbnailArea ul").html("");
		
		var postno = $(this).closest(".post").data("postno");
		
		var url = '/postrest/getPost/' + postno ;
		$("#postModifyModal").data("postno", postno);
		
		$.getJSON(url,function(data){
			
			//textarea content 삽입
			content.val(switchContext(data.content));
			
			//첨부파일 썸네일 삽입
			var list = data.attachList; 
			thumbStr = '';
			if(list != null && list.length > 0){
				for(var i=0; i< list.length; i++){
					thumbStr += '<li class="mx-1 p-1 d-inline-block" ';
					thumbStr += 'data-uuid="'+list[i].uuid + '" ';
					thumbStr += 'data-uploadPath="'+list[i].uploadPath + '" ';
					thumbStr += 'data-mimeType="'+list[i].mimeType + '" ';
					thumbStr += 'data-fileSize="'+list[i].fileSize + '" ';
					thumbStr += 'data-fileName="'+list[i].fileName + '" ';
					thumbStr += '>' ;
					thumbStr += '<div class="position-relative">';
					thumbStr += '<img src="/upload/display?fileName='+ encodeURIComponent(list[i].fullThumbName) + '" class="register-thumbnail-image img-thumbnail">' ;
					thumbStr += '<i class="far fa-times-circle fa-lg position-absolute right top mt-2 mr-2 modify-remove-thumb" data-file="'+encodeURIComponent(list[i].fullThumbName) + '"></i>' ;
					thumbStr += '</div>';
					thumbStr += '</li>' ;
				}
			}
			
			$("#modifyTumbnailArea ul").append(thumbStr) ;
		})
	});
	
	$("#modifyTumbnailArea ul").on("click",".modify-remove-thumb", function(){
		$(this).closest("li").remove();
	})
	
	
	// 게시글수정버튼 
	$("#postModifyBtn").click(function(){
		var content = $("#postModifyModal textarea");
		var attachList = [];
		var postno = $("#postModifyModal").data("postno");
		var contentVal = content.val();
		if(contentVal.length ==0){
			alert("글 내용을 입력해주세요!");
			return false;
		}
		contentVal = entityReplace(contentVal);
		$("#modifyTumbnailArea ul li").each(function(){
			var attach = {uuid : $(this).data("uuid"), uploadPath : $(this).data("uploadpath"),
					mimeType : $(this).data("mimetype"), fileSize : $(this).data("filesize"),
					fileName : $(this).data("filename")};
			attachList.push(attach);
		});
		
		var post = {
				postno : postno,
				writer : currentUserMno,
				owner : owner,
				content : contentVal,
				attachList : attachList
		}
		
		postService.modifyPost(post,function(data){
			console.log(data);
			alert('수정이 완료되었습니다.');
			content.val("");
			$("#modifyTumbnailArea ul li").remove();
			textareaResize(content);
			var modifyStr = '';
			modifyStr += getAddPostStr(data.postno, data.writer, data.writerName, data.regdate, data.content, data.attachList, data.replyCnt, data.thcount, currentUserProfimg);
			$("[data-postno="+postno+"]").closest("li").after(modifyStr).remove();
			$("#postModifyModal").modal("toggle");
			
		},function(er){
			console.log(er);
		})
	})
	// 좋아요 버튼
	$("#post-list-area").on("click", ".good-area",function(){
		var $goodarea = $(this);
		var postno = $(this).closest(".post").data("postno") ;
		var $thcount = $(this).parent().parent().prev().find(".thcount-area") ;
		postService.updateThcount(currentUserMno, postno ,function(data){
			if(data == 'minus'){
				$goodarea.removeClass('text-primary');
				console.log(data);
				$thcount.text($thcount.text()-1);
			}else if(data =='plus'){
				$goodarea.addClass('text-primary');
				console.log(data);
				$thcount.text($thcount.text()*1+1);
			}
			
		},function(error){
			console.log(error);
		})
	})
	
    // post들의 썸네일 이미지클릭시 원본이미지가 슬라이더형식으로 모달창으로 띄워짐
	$("#post-list-area").on("click", ".post-thumbnail-image", function(){
		$("#myModal .modal-body").empty();
		var strimg = '<div id="slider">';
		
		$(this).parent().find("img").each(function(){
			var bxfullname = $(this).data("fullname") ;
			strimg += '<div><div class="wrap-flex" style="height:500px" >';
			strimg += '<img src="/upload/display?fileName=' +encodeURIComponent(bxfullname) + ' ">';
			strimg += '</div></div>';
		})
		strimg += '</div>';
		
		$("#myModal .modal-body").html(strimg); //.height($(window).height() - 200);
		var height = 0;
		$("#myModal").modal("show");
	
		$("#slider img").each(function() {
			
			console.dir(this);
		});
		$("#slider").bxSlider();
	})
     $(window).on("resize", function() {
          var imgHeight = $(".bx-wrapper *[aria-hidden='false'] img").height() ;
          var resizedWindowHeight = $(window).height() - 100;
          if(resizedWindowHeight > imgHeight){
          	$(".wrap-flex").height(resizedWindowHeight);
          } 
     }); 
	
	
	
})