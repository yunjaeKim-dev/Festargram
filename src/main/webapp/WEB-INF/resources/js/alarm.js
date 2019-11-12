var alarmService = (function (){

	// 알림 목록 불러오기 
	function getAlarmList(mno, callback, error){
		$.ajax({
			type : 'get',
			url : '/alarmRest/alarmList/' + mno,
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
	
	// 게시글 알림 추가
	function addPostAlarm(postno, mno, callback, error){
		$.ajax({
			type: "post",
			url : "/alarmRest/addPostAlarm/" + postno + "/" + mno,
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
	
	// 댓글 알림 추가
	function addReplyAlarm(replyno, mno, callback, error){
		$.ajax({
			type: "post",
			url : "/alarmRest/addReplyAlarm/" + replyno + "/" + mno,
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
	
	// 메시지 알림 추가
	function addMessageAlarm(applicant, target, callback, error){
		$.ajax({
			type:"post",
			url : "/alarmRest/addMessagAlarm/" + applicant + "/" + target,
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
	
	// 메시지 알림 갱신
	function modifyMessageAlarm(applicant, target, callback, error){
		$.ajax({
			type : "put",
			url : "/alarmRest/modifyMessagAlarm/" + applicant + "/" + target,
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
	
	// 메시지 알림 목록 불러오기
	function getMessageAlarmList(mno, callback, error){
		$.ajax({
			type : 'get',
			url : "/alarmRest/messageAlarmList/" + mno,
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
	// 리턴
	return {
		getAlarmList : getAlarmList,
		addPostAlarm : addPostAlarm,
		addReplyAlarmm : addReplyAlarm,
		addMessageAlarm : addMessageAlarm,
		modifyMessageAlarm : modifyMessageAlarm,
		getMessageAlarmList : getMessageAlarmList
	}
})()