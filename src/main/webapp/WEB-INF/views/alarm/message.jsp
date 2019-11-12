<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <style>
        .bg-gray{background: #ddd;}
        .more-menu{display: none;}
    </style>
    <script>
        $(function(){
            $(".mess").hover(function(){
                $(this).children().children().children("button").show()
                   
            },function(){
                $(this).children().children().children("button").hide()
                   
            })
        })
    </script>
    <div class="row">
        <div class="col-2"></div>
        <div class="col">
            <div class="card w-50 show-this">
                <div class="card-head p-0 m-0 ml-2 clear-fix border border-top-0 border-left-0 border-right-0">
                    <a href="#"><img src="images/alarm/friend.png"></a>
                    <small><a href="#">아무개</a></small>
                    <button type="button" class="close text-primary btn btn-lg my-2">&times;</button>
                    <div class="d-inline-block float-right">
                        <button type="button" class="float-right btn btn-lg p-0 my-1 mr-2 dropdown-toggle" data-toggle="dropdown"></button>
                        <div class="dropdown-menu p-0">
                            <a href="#" class="dropdown-item p-2"><small>차단</small></a>
                            <a href="#" class="dropdown-item p-2"><small>메시지 무시</small></a>
                        </div>
                    </div>
                </div>

                <div class="card-body p-0 ">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item border-0 p-0 m-0"><p class="m-0 text-center"><small class="text-center"><span class="text-muted">(금) 오후 5:50</span></small></p></li>
                        <li class="list-group-item border-0 p-0 m-0">
                            <ul class="list-group list-group-horizontal m-0 p-0 list-group-flush">
                                <li class="list-group-item border-0 p-0 ml-2">
                                    <a href="#"><img src="images/alarm/friend.png" class="rounded-circle"></a>
                                </li>
                                <li class="list-group-item border-0 p-0 ml-2 my-auto mess">
                                    <ul class="list-group list-group-flush list-group-horizontal your-mess-content">
                                        <li class="list-group-item border-0 p-0 ">
                                            <pre class="m-0 p-1 bg-gray rounded">안녕하세요</pre>
                                        </li>
                                        <li class="list-group-item border-0 p-0 ">
                                            <button type="button" class="more-menu btn dropdown-toggle p-0 ml-2" data-toggle="dropdown"></button>
                                            <div class="dropdown-menu p-0">
                                                <a href="#" class="dropdown-item p-2 d-inline-block"><small>삭제</small></a>
                                            </div>
                                        </li>
                                        
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        
                        
                        <li class="list-group-item border-0 mess">
                            <ul class="list-group list-group-flash my-mess-content list-group-horizontal float-right">
                                <li class="list-group-item border-0 p-0 mr-2 more">
                                    <button type="button" class="more-menu btn dropdown-toggle p-0" data-toggle="dropdown"></button>
                                    <div class="dropdown-menu p-0">
                                        <a href="#" class="dropdown-item p-2"><small>삭제</small></a>
                                    </div>
                                </li>
                                <li class="list-group-item p-0 m-0 border-0 ">
                                    <pre class="m-0 p-1 float-right bg-gray rounded">하이요</pre>
                                </li>
                            </ul>
                            
                        </li>

                    </ul>
                </div>
                <div class="card-footer p-1 input-group-sm">
                    <form class="form-group p-0 m-0">
                        <input type="text" id="content" class="form-control" placeholder="메시지를 입력하세요.">
                        <img src="images/alarm/picture.png" class="m-2 ">
                        <img src="images/alarm/thumbs-up.png" class="m-2">
                    </form>
                </div>
            </div>    
        </div>
      </div> 
</body>
</html>