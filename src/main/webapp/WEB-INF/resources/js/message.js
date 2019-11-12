var messageService = (function (){
	// 메시지 리스트 불러오기
	function messageList(email, callback, error){
		$.ajax({
			type : "post",
			url : "/message/messageList",
			contentTyep : "application:json; charset=utf-8",
			data : email,
			success : function(data){
				if(callback){
					callback(data)
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er)
				}
			}
		});
	};
	
	//메시지 보내기
	function sendMessage(message, callback, error){
		$.ajax({
			type:"post",
			url:"/message/new",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(message),
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
	};
	
	//메시지 하나 삭제
	function removeMessage(messno, callback, error){
		$.ajax({
			type:"post",
			url: "/message/remove/" + messno,
			success : function(data){
				console.log(data)
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		});
	};
	
	// 상대와 메시지 로딩
	function messageLoad(email, callback, error){
		$.ajax({
			type : "post",
			url : "/message/messageLoad",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(email),
			success : function(data){
				if(callback){
					callback(data)
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		});
	}
	
	// 메시지 모두 삭제
	function removeAllMessage(email, callback, error){
		$.ajax({
			type : "delete",
			url : "/message/removeAll",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(email),
			success : function(data){
				if(callback){
					callback(data)
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er);
				}
			}
		})
	}
	// 메시지 하나 삭제
	function removeMessage(messno, callback, error){
		$.ajax({
			type : "delete",
			url : "/message/remove/" + messno,
			success : function(data){
				if(callback){
					callback(data)
				}
			},
			error : function(xhr, stat, er){
				if(error){
					error(er)
				}
			}
		})
	}
	
	
	
	return {messageList : messageList,
		sendMessage : sendMessage,
		messageLoad : messageLoad,
		removeAllMessage : removeAllMessage,
		removeMessage : removeMessage
		};
})()