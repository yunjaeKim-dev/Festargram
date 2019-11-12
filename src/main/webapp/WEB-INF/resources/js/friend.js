console.log("friend module loading...")
var code;
var friendService = (function(){
	
	/*친구리스트 (String리스트 email 값만있음)*/
	function getFriendList(mno, callback, error){
		console.log('getFriendList....:::' + mno);
		var url = '/friend/friendList/' + mno ;
		$.getJSON(url,function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr, stat, er){
			if(error){
				error(er);
			}
		});
	}
	
	// 친구 리스트 접속일 순서
	function getFriendListOrderRecdate(mno, callback, error){
		console.log("friend.js getFriendListOrderRecdate");
		var url = "/friend/friendListOrderRecdate/" + mno;
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
	
	// owner의 친구리스트
	function getOwnerFriendList(ownerno, currentno, callback, error){
		console.log("friend.js getOwnerFriendList");
		var url = '/friend/getOwnerFriendList/' + ownerno + '/' + currentno;
		
		$.getJSON(url, function(data){
			if(callback){
				callback(data);
			}
		}).fail(function(xhr,stat, er){
			if(error){
				error(er);
			}
		})
	}
	
	
	//친구요청리스트
	function getFriendApplyList(mno, callback, error){
		console.log('getFriendApplyList...' + mno) ;
		var url = '/friend/applyList/' + mno ;
		$.getJSON(url,function(data){
			if(callback){
				callback(data) ;
			}
		}).fail(function(xhr, stat, er){
			if(error){
				error(er);
			}
		});
	}
	
	/*친구인지 여부확인*/
	function isFriend(f1, f2,callback,error){
		console.log('isFriend......f1::' + f1 + "f2 :: " + f2);
		$.ajax({
			url:"/friend/isFriend/" + f1 + "/" + f2,
			success : function(data){
				if(callback){
					callback(data) ;
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	/*   친구신청     */
	
	function friendApply(applicant, target, callback, error){
		console.log('friendApply...js') ;
		$.ajax({
			type:'put',
			url:'/friend/friendApply/' +applicant + '/' + target ,
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
		}) ;
		
	}
	/*친구요청삭제*/
	function removeApply(applicant, target, callback, error){
		console.log("removeApply...js") ;
		$.ajax({
			type:"delete",
			url: '/friend/friendApply/' +applicant + '/' + target ,
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
	
	
	/*친구요청중인지 boolean 반환*/
	function isApply(applicant, target, callback, error){
		console.log('isApply ...js')
		$.ajax({
			url:'/friend/isApply' +applicant + '/' + target ,
			success : function(data){
				if(callback){
					callback(data) ;
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function addFriend(target, applicant, callback, error){
		console.log('addFriend ...js') ;
		$.ajax({
			type:'post',
			url:'/friend/addFriend/' + target + '/' + applicant,
			success : function(data){
				if(callback){
					callback(data) ;
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	function removeFriend(f1, f2 , callback, error){
		console.log('removeFriend......js') ;
		$.ajax({
			type:'delete',
			url : '/friend/removeFriend/' + f1 + '/' + f2,
			success : function(data){
				if(callback){
					callback(data) ;
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	
	function getRelationCode(applicant, target,callback){
		console.log("getRelationCode....js");
		
		$.ajax({ // scope
			url : '/friend/relation/' + applicant + '/' +target,
			asysc :false,
			success : function(data){
				if(callback){
					callback(data);
				}
			}
		});
	}
	
	
	function getMayKnownList(mno, amount , callback, error){
		console.log("getMayKnowList..js");
		var url = '/friend/getMayKnow/'+ mno;
		var cri = {amount : amount};
		$.ajax({
			type : 'post',
			url : url,
			contentType : 'application/json; chartset=utf-8',
			data : JSON.stringify(cri),
			dataType : 'json',
			success : function(data){
				if(callback){
					callback(data);
				}
			},
			error : function(xhr, er, stat){
				if(error){
					error(er);
				}
			}
		});
	}
	
	return{
		getFriendList:getFriendList,
		getFriendApplyList:getFriendApplyList,
		friendApply:friendApply,
		removeApply:removeApply,
		addFriend:addFriend,
		removeFriend:removeFriend,
		getRelationCode:getRelationCode,
		getFriendListOrderRecdate : getFriendListOrderRecdate,
		getMayKnownList:getMayKnownList,
		getOwnerFriendList:getOwnerFriendList
	}
})();
