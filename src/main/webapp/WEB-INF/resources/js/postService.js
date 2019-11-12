var postService = (function(){
	// 게시글등록
	function postRegister(post, callback, error ){
		$.ajax({
			type : 'post',
			url : '/postrest/new' ,
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(post),
			dataType : 'json',
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
		});
	} 
	// 게시글 수정
	function modifyPost(post, callback, error){
		$.ajax({
			type : 'put',
			url : '/postrest/modifyPost',
			data : JSON.stringify(post),
			dataType : 'json',
			contentType : 'application/json; charset=utf-8',
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
		});
	}
	
	
	// 게시글삭제
	function removePost(postno, callback, error){
		var url = '/postrest/remove/' + postno ;
		
		$.ajax({
			type : 'delete',
			url : url,
			success : function(data){
				callback(data);
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		});
		
	}
	
	// 마이페이지 타임라인리스트 페이징포함
	function getMyPagePost(hostMno, postRn, currentUserMno ,callback,error){
		var url = '/postrest/myPageList/' + hostMno +'/'+ postRn +  '/' + currentUserMno ;
		$.getJSON(url,function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, stat, er){
			if(error){
				error(er);
			}
		})
	}
	
	//뉴스피드 
	function getNewsfeed(mno, postRn, callback, error){
		var url = '/postrest/newsFeed/' + mno + '/' + postRn ;
		$.getJSON(url,function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, stat, er){
			if(error){
				error(er);
			}
		})
	}
	// 좋아요변경
	function updateThcount(mno, postno, callback, erorr){
		var url = '/postrest/updateGood/' + postno + '/' + mno ;
		$.ajax({
			type : 'post',
			url : url,
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
		});
	}
	return {
		postRegister:postRegister,
		getMyPagePost:getMyPagePost,
		removePost:removePost,
		modifyPost:modifyPost,
		getNewsfeed:getNewsfeed,
		updateThcount:updateThcount
	};
})();