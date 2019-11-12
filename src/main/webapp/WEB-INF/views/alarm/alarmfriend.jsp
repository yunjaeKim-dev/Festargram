<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Page Title</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link href="css/webstyles.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <style>
        .close{display:none;}
        .x-button{right:3px;}
    </style>
    <script>
        $(function(){
            $("#friend").hover(function(){
                $(this)
                    .children(".close").css("display","block")
                .parent()

            },function(){
                $(this)
                    .children(".close").css("display","none")
            }
            )


        })
    </script>
</head>
<body>
    <div class="row">
        <div class="col-2"></div>
        <div class="col">
            <div class="card w-50 show-this">
                <div class="card-head p-1 clear-fix border border-top-0 border-left-0 border-right-0">
                    <a href="#" class="text-body ml-2"><small>친구 요청</small></a>
                    <a href="#" class="card-link float-right mr-2"><small>친구 찾기</small></a>
                </div>
                <div class="card-body p-0 ">
                    <div class="row p-0 m-0 w-100 border border-left-0 border-right-0 border-top-0">
                        <table class="table table-sm p-0 m-1 ml-1 col-1 table-borderless">
                            <tr>
                                <td class="w-100">
                                    <a href="#" class="m-0 block d-block">
                                        <img src="images/alarm/friend.png" class="rounded-circle">
                                    </a>
                                </td>
                            </tr>
                        </table>
                        <div  class="col my-auto p-0">
                            <a href="#"><small >아무개</small></a>
                        </div>
                        <button class="btn btn-sm btn-primary p-1 h-25  my-auto" class="col-2">확인</button>
                        <button class="btn btn-sm btn-danger p-1 h-25 mx-2 my-auto" class="col-2">요청 삭제</button>
                    </div>
                <div class="card-head p-1 border border-left-0 border-right-0">
                    <a class="text-body ml-2 "><small>승인된 요청</small></a>
                </div>
                <div class="card-body p-0" >
                    <div class="border border-left-0 border-right-0 border-top-0">
                        <a href="#" class="border border-bottom-0 border-left-0 border-right-0" id="friend">
                            <button type="button" class="close position-absolute x-button" >&times;</button>
                            <div class="row my-2">
                                <table class="table table-sm p-0 m-0 ml-3 float-left col-1 table-borderless">
                                    <tr>
                                        <td>
                                            <img src="images/alarm/alarm/friend.png" class="rounded-circle">
                                        </td>
                                    </tr>
                                </table>
                                <table class="table table-sm p-0 m-0 float-right col table-borderless ml-1">
                                    <tr>
                                        <td class="p-0"><small><span class="font-weight-bold">백동현</span>님이 회원님의 친구 요청을 수락했습니다.</small></td>
                                    </tr>
                                    <tr>
                                        <td class="p-0"><small>지난 금요일</small></td>
                                    </tr>
                                </table>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="card-head p-1 clear-fix border border-left-0 border-right-0 ">
                    <a class="text-body ml-2 "><small>알 수도 있는 사람</small></a>
                </div>
                <div class="card-body p-0 my-1">
                    <div class="row p-0 w-100 m-0">
                        <table class="table table-sm p-0 m-1 ml-1 col-1 table-borderless">
                            <tr>
                                <td class="w-100">
                                    <a href="#" class="m-0 block d-block">
                                        <img src="images/alarm/friend.png" class="rounded-circle">
                                    </a>
                                </td>
                            </tr>
                        </table>
                        <table class="table table-borderless col my-1">
                            <tr>
                                <td class="p-0 m-0"><span><small class="font-weight-bold">아무개</small></span></td>
                            </tr>
                            <tr>
                                <td class="p-0 m-0"><small class="text-muted"><span>백동현</span>님을 함께 알고 있습니다.</small></td>
                            </tr>
                        </table>
                        <button class="btn btn-sm btn-primary p-1 h-25  my-auto" class="col-2">친구 추가</button>
                        <button class="btn btn-sm btn-danger p-1 h-25 mx-2 my-auto" class="col-2">삭제</button>
                    </div>
                   
                </div>
                <div class="card-footer p-1">
                    <a href="#" class="card-link mx-auto d-flex justify-content-center"><small>모두 보기</small></a>
                </div>
            </div>    
        </div>
        </div>
        </div>
</body>
</html>