var memberService = (function(){
	function getUserListWithPaging(keyword, amount, sinceID,callback, error){
		var keyword = keyword ;
		var amount = amount ;
		var sinceID = sinceID ;
		var cri = {amount,sinceID} ;
		var dto = {cri,keyword};
 		$.ajax({
			type : 'post',
			url : '/member/searchUser',
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(dto),
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
	
	function updateRecdate(mno, callback, error){
		var url = "/member/updateRecdate/" + mno
		$.getJSON(url, function(data){
			if(callback){
				callback(data)
			}
		}).fail(function(xhr, stat, er){
			if(error){
				error(er)
			}
		})
	}
	
	function modifySelfintro(mno, selfintro, callback,error){
		var member = {mno : mno , selfintro : selfintro}; 
		$.ajax({
			type : 'post',
			url : '/member/modifySelfintro',
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(member),
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
	
	function modifyExtraInfo(member, callback, error){
		$.ajax({
			type: 'post',
			url : '/member/modifyExtraInfo',
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(member),
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
		getUserListWithPaging : getUserListWithPaging,
		updateRecdate : updateRecdate,
		modifySelfintro : modifySelfintro,
		modifyExtraInfo : modifyExtraInfo
	} ;
})();