<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>B1PROJECT | Login</title>

<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/bootstrap.css" rel="stylesheet">
<link href="resources/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="resources/css/plugins/iCheck/custom.css" rel="stylesheet">
<link href="resources/css/animate.css" rel="stylesheet">
<link href="resources/css/style.css" rel="stylesheet">

<script src="resources/js/jquery-2.2.2.min.js"></script>

<script>
	$(document).ready(function(){
		//personal로그인
		$('#loginBtn_per').on('click',function(){
			var per_id = $('#per_id').val();
			var per_pwd = $('#per_pwd').val();
			
			$.ajax({
				method:'post',
				url: 'per_login',
				data: 'per_id='+per_id+'&per_pwd='+per_pwd,
				success: function(resp){
					if(resp==='success'){
						location.href="goTemp";
                     }else{
                    	var message = "존재하지 않는 ID/Password 입니다.<br />다시 확인하고 입력해주세요.";
                    	$('.check').html(message);
                        $('#errorModal').modal('toggle');
                        return;
                     }   
				}
					
			});
		});
		
		
		//Company로그인
		$('#loginBtn_com').on('click',function(){
			var com_id = $('#com_id').val();
			var com_pwd = $('#com_pwd').val();
			
			$.ajax({
				method:'post',
				url: 'com_login',
				data: 'com_id='+com_id+'&com_pwd='+com_pwd,
				success: function(resp){
					if(resp==='success'){
						location.href="goTemp2";
                     }else{
                    	var message = "존재하지 않는 ID/Password 입니다.<br />다시 확인하고 입력해주세요.";
                    	$('.check').html(message);
                        $('#errorModal').modal('toggle');
                        return;
                     }   
				}
					
			});
		});
		
		
		
		
	});

</script>

</head>

<body class="gray-bg">
	<div class="middle-box text-center loginscreen animated fadeInDown">
		<div style="width: 600px;">
			<div>
				<h1 class="logo-name" style="font-size: 130px; color:#66696b;">JOB<br />SPIDER</h1><br />
			</div>
			<div class="col-lg-6">
				<div class="tabs-container" style="width: 620px;">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#tab-1">개인회원</a></li>
						<li class=""><a data-toggle="tab" href="#tab-2">기업회원</a></li>
					</ul>
					<div class="tab-content" style="width: 600px;">
						<div id="tab-1" class="tab-pane active">
							<div class="panel-body">
								<form class="m-t" role="form" action="per_login" method="post">
									<div class="form-group">
										<input id="per_id" type="text" name="id" class="form-control" placeholder="UserId">
									</div>
									<div class="form-group">
										<input id="per_pwd" type="password" name="pwd" class="form-control" placeholder="Password">
									</div>
									<button id="loginBtn_per" type="button" style="margin:0 auto;height:40px; font-size: 20px;" class="btn btn-primary block full-width m-b">Login</button>
								</form>
							</div>
						</div>

						<div id="tab-2" class="tab-pane">
							<div class="panel-body">
								<form class="m-t" role="form" action="com_login" method="post">
									<div class="form-group">
										<input id="com_id" type="text" name="id" class="form-control" placeholder="CompanyID">
									</div>
									<div class="form-group">
										<input id="com_pwd" type="password" name="pwd" class="form-control" placeholder="Password">
									</div>
									<button id="loginBtn_com" type="button" style="margin:0 auto;height:40px; font-size: 20px;" class="btn btn-primary block full-width m-b">Login</button>
								</form>
							</div>
						</div>
						<p class="text-muted text-center">
							<small>Do not have an account?</small>
						</p>
						<a class="btn btn-sm btn-white btn-block" style="margin:0 auto;height:40px; font-size: 20px;" href="findView">Forgot ID / password?</a><br/>
						<a class="btn btn-sm btn-white btn-block" style="margin:0 auto;height:40px; font-size: 20px;" href="main">메인으로 가기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- error modal -->
	   <div class="modal inmodal" id="errorModal" tabindex="-1" role="dialog" aria-hidden="true">
	       <div class="modal-dialog">
	       <div class="modal-content animated bounceInRight">
	               <div class="modal-header">
	                   <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	                   <i class="fa fa-times-circle-o modal-icon"></i>
	                   <h4 class="modal-title check"></h4>
	               </div>
	               <div class="modal-footer">
	                   <button type="button" class="btn btn-danger btn-lg" data-dismiss="modal">OK</button>
	               </div>
	           </div>
	       </div>
	   </div>

	<!-- Mainly scripts -->
	<script src="resources/js/jquery-2.1.1.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>

	<!-- Custom and plugin javascript -->
	<script src="resources/js/inspinia.js"></script>
	<script src="resources/js/plugins/pace/pace.min.js"></script>
</body>

</html>
