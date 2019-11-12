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
        .clickable{cursor: pointer;}
    </style>
</head>
<body>
    <div class="row">
        <div class="col-2"></div>
        <div class="col">
            <div class="card w-50 show-this">
                <div class="card-head p-1 clear-fix border border-top-0 border-left-0 border-right-0">
                    <a href="#" class="text-body ml-2"><small>최근 (<span>11</span>)</small></a>
                    <a href="#" class="card-link float-right mr-2"><small>새 메시지</small></a>
                </div>
                <div class="card-body p-0 ">
                    <div class="row p-0 m-0 w-100 border border-left-0 border-right-0 border-top-0 clickable">
                        <table class="table table-sm p-0 m-1 ml-1 col-1 table-borderless">
                            <tr>
                                <td class="w-100">
                                    <a href="#" class="m-0 block d-block">
                                        <img src="images/alarm/friend.png" class="rounded-circle">
                                    </a>
                                </td>
                            </tr>
                        </table>
                        <table class="table table-borderless col my-1 ">
                                <tr>
                                    <td class="p-0 m-0"><span><small class="font-weight-bold">아무개</small></span></td>
                                    <td class="p-0 m-0 text-right"><small class="mr-3"><span class="font-muted">19. 10. 04</span></small></td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="p-0 m-0">
                                        <small><span>ㅎㅇㅎㅇ</span></small>
                                    </td>
                                </tr>
                            </table>
                    </div>
                    <div class="row p-0 m-0 w-100 border border-left-0 border-right-0 border-top-0 clickable">
                        <table class="table table-sm p-0 m-1 ml-1 col-1 table-borderless ">
                            <tr>
                                <td class="w-100">
                                    <a href="#" class="m-0 block d-block">
                                        <img src="images/alarm/friend.png" class="rounded-circle">
                                    </a>
                                </td>
                            </tr>
                        </table>
                        <table class="table table-borderless col my-1 w-100 ">
                                <tr>
                                    <td class="p-0 m-0"><span><small class="font-weight-bold">아무개</small></span></td>
                                    <td class="p-0 m-0 text-right"><small class="mr-3"><span class="font-muted">19. 10. 04</span></small></td>
                                </tr>
                                <tr>
                                    <td colspan="2" class="p-0 m-0">
                                        <small><span>새로운 Festargram 친구인 아무개님에게 인사를 건네보세요.</span></small>
                                    </td>
                                </tr>
                            </table>
                    </div>
                <div class="card-footer p-1">
                    <a href="#" class="card-link"><small>message에서 모두 보기</small></a>
                </div>
            </div>    
        </div>
        </div>
    </div>
</body>
</html>