console.log("findPWD module");

$(function(){
	$("#submit").click(function(){
		var email = $(this).parent().parent().first().find($("input[name=FindEmail]")).val();
		console.log(email);
		var member = {
				email : email
		}
		mailService.check(member, function(result){
			console.log(result);
		});
		return false;
	})
})




var mailService = (function(){
	function check(member, callback, error){ 
		console.log("IDCHECK")
		
		$.ajax({
			type : 'post',
			url : "/sendMail/checkID",
			data : JSON.stringify(member),
			dataType : 'string',
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
		check:check
	};
})();