
$(function(){
	// 프로필변경 input change
	$("#profileImgUploadForm").change(function(){
		var files = $(this).get(0).files ;
		var formData = new FormData();
		
		for(var i = 0 ; i < files.length ; i++){
			if(!checkExtension(files[i].size)){
				return false;
			} 
			//console.log(files[i]);
			formData.append('uploadFile', files[i]);
		}
		$.ajax({
			type : 'post',
			url : '/upload/file/1',
			enctype: 'multipart/form-data',
			contentType : false, //multipart/form-data" 로 전송이 되게 false 로 넣어준다
			processData : false, // data 파라미터로 전달된 데이터를 jQuery 내부적으로 query string 으로 만드는데, 파일 전송의 경우 이를 하지 않아야 하고 이를 설정하는 것이 processData: false 이다.
			data : formData,
			dataType : 'json',
			success:function(data){
				var proStr = '<img src="/upload/display?fileName=' +encodeURIComponent(data[0].fullName) + '" class="rounded-circle border rounded-lg profile-photo-img mb-3" data-fullname="'+data[0].fullName + '">';
				$("#profileThumbNailArea").html(proStr);
			},
			error: function(error){
				alert("이미지 파일이 아닙니다.");
			}
		});
	});
	
	
	$("#profileImgSave").click(function(){
		var profileImg = $("#profileThumbNailArea img").data("fullname");
		var mno = owner ;
		var member = {mno : mno , profimg : profileImg} ;
		$.ajax({
			type: 'post',
			url : '/member/modifyProfileImg',
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(member),
			success : function(data){
				alert(data);
				$("#profileImgModify").modal("toggle");
				var proStr = '<img src="/upload/display?fileName=' +encodeURIComponent(profileImg) + '" class="rounded-circle border rounded-lg profile-photo-img mb-3" data-fullname="'+profileImg + '">';
				$("#profileThumbNailArea").html(proStr);
				$(".profile-photo img").attr("src", "/upload/display?fileName=" +encodeURIComponent(profileImg)+"");
				
				
			},
			error : function(xhr, stat, er){
				console.log(er);
			}
		});
	})
	
	// 프로필 커버이미지 변경 input change
	$("#profileCoverImgUploadForm").change(function(){
		var files = $(this).get(0).files ;
		var formData = new FormData();
		
		for(var i = 0 ; i < files.length ; i++){
			if(!checkExtension(files[i].size)){
				console.log("사이즈 초과");
				return false;
			} 
			//console.log(files[i]);
			formData.append('uploadFile', files[i]);
		}
		$.ajax({
			type : 'post',
			url : '/upload/file/1',
			enctype: 'multipart/form-data',
			contentType : false, 
			processData : false, 
			data : formData,
			dataType : 'json',
			success:function(data){
				console.log("success data :: " , data);
				var proStr = '<img src="/upload/display?fileName=' + encodeURIComponent(data[0].fullName) + '" class="w-100 h-100" data-fullname="'+data[0].fullName +'">';
				$("#profileCoverThumbNailArea").html(proStr);
			},
			error: function(error){
				alert("이미지 파일이 아닙니다.");
			}
		});
	});
	
	$("#profileCoverImgSave").click(function(){
		var profileCoverImg = $("#profileCoverThumbNailArea img").data("fullname");
		var mno = owner ;
		var member = {mno : mno , coverimg : profileCoverImg} ;
		
		$.ajax({
			type: 'post',
			url : '/member/modifyProfileCoverImg',
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(member),
			success : function(data){
				alert(data);
				$("#profileCoverImgModify").modal("toggle");
				var proStr = '<img src="/upload/display?fileName=' +encodeURIComponent(profileCoverImg) + '" class="w-100 h-100" data-fullname="'+profileCoverImg + '">';
				$("#profileCoverThumbNailArea").html(proStr);
				$(".profile-cover-image img").attr("src", "/upload/display?fileName=" +encodeURIComponent(profileCoverImg)+"");
				
				
			},
			error : function(xhr, stat, er){
				console.log(er);
			}
		});
		
	})
	
	

});