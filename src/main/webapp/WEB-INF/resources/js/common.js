

/*왼쪽 쪽지기능할 친구목록 사이드바 리사이즈 반응형에필수*/
function sidebarResize(){
		$("#left-sidebar").css("width",$("#sidebar-box").css("width"))
		$("#left-sidebar").css("height",$(window).height())
  	}
  	
function textareaResize(obj){
	var fontsize = parseInt($(obj).css("font-size"));
	
	if($(obj).prop('scrollHeight') < (fontsize * 3.5)){
		return false;
	}
	$(obj).height(1).height($(obj).prop('scrollHeight')+fontsize) ;
	
}

function entityReplace(content){ // <, >, " html 엔티티변경 (xss방지)
	return content.replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\"/g,"&quot;");
}

function switchContext(content){ // <, >, " html 엔티티변경 (xss방지)
	return content.replace( /&lt;/g,"<").replace(/&gt;/g,">");
}

$(function(){
	$(".NotImplemented").click(function(){
		alert('미구현 기능입니다.');
	})
	
	$("#post-list-area").on("click",".NotImplemented",function(){
		alert('미구현 기능입니다.');
	});
})