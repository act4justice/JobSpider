<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>B1PROJECT | Find ID</title>

<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/bootstrap.css" rel="stylesheet">
<link href="resources/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="resources/css/plugins/iCheck/custom.css" rel="stylesheet">
<link href="resources/css/animate.css" rel="stylesheet">
<link href="resources/css/style.css" rel="stylesheet">

</head>

<body class="gray-bg">
	<div class="middle-box text-center loginscreen animated fadeInDown">
		<div style="width: 600px;">
			<div>
				<h1 class="logo-name" style="font-size: 130px; color:#66696b;">JOB<br />SPIDER</h1><br />
			</div>
			<div class="col-lg-6">
				<div class="tabs-container" style="width: 600px;">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#tab-1">개인회원</a></li>
						<li class=""><a data-toggle="tab" href="#tab-2">기업회원</a></li>
					</ul>
					<div class="tab-content" style="width: 600px;">
						<div id="tab-1" class="tab-pane active">
							<div class="panel-body">
								<input type="radio" id="person_id" name="per_radio" checked="checked" />아이디찾기
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<input type="radio" id="person_pwd" name="per_radio" />비밀번호찾기
							</div>
							<div class="panel-body" id="person_findid" style="display: block">
								<form class="m-t" role="form">
									<table style="width: 100%;">
										<tr>
											<td colspan="2">
												<div class="form-group">
													<input type="text" class="form-control per_name" placeholder="이름">
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="form-group">
													<input type="email" class="form-control per_email"
														placeholder="이메일">
												</div>
											</td>
										</tr>
									</table>
									<br /> <br />
									<button type="button" style="margin:0 auto;height:40px; font-size: 20px;" class="btn btn-primary block full-width m-b per_finder">조회</button><br />
									<a class="btn btn-sm btn-white btn-block" style="margin:0 auto;height:40px; font-size: 20px;" href="login">Login</a>
								</form>
							</div>
							<div class="panel-body" id="person_findpw" style="display: none">
								<form class="m-t" role="form">
									<table style="width: 100%;">
										<tr>
											<td colspan="2">
												<div class="form-group">
													<input type="text" class="form-control per_id" placeholder="아이디">
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="form-group">
													<input type="text" class="form-control per_name2" placeholder="이름">
												</div>
											</td>
										</tr>
										<tr>
											<td style="width: 530px;">
												<div class="form-group">
													<input type="email" class="form-control per_email2"	placeholder="이메일">
												</div>
											</td>
										</tr>
									</table>
									<br> <br>
									<button type="button" style="margin:0 auto;height:40px; font-size: 20px;" class="btn btn-primary block full-width m-b per_finder">조회</button><br />
									<a class="btn btn-sm btn-white btn-block" style="margin:0 auto;height:40px; font-size: 20px;" href="login">Login</a>
								</form>
							</div>
						</div>
						<div id="tab-2" class="tab-pane">
							<div class="panel-body">
								<input type="radio" id="company_id" name="com_radio" checked="checked" />아이디찾기
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
								<input type="radio" id="company_pwd" name="com_radio" />비밀번호찾기
							</div>
							<div class="panel-body" id="company_findid"	style="display: block">
								<form class="m-t" role="form">
									<table style="width: 100%;">
										<tr>
											<td colspan="2">
												<div class="form-group">
													<input type="text" class="form-control com_name" placeholder="회사명">
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="form-group">
													<input type="text" class="form-control com_num"	placeholder="사업자 등록 번호">
												</div>
											</td>
										</tr>
									</table>
									<br /> <br />

									<button type="button" class="btn btn-primary block full-width m-b com_finder">조회</button>
									<a class="btn btn-sm btn-white btn-block" href="login">Login</a>
								</form>
							</div>
							<div class="panel-body" id="company_findpw" style="display: none">
								<form class="m-t" role="form">
									<table style="width: 100%;">
										<tr>
											<td colspan="2">
												<div class="form-group">
													<input type="text" class="form-control com_id" placeholder="아이디">
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<div class="form-group">
													<input type="text" class="form-control com_name2" placeholder="회사명">
												</div>
											</td>
										</tr>
										<tr>
											<td style="width: 530px;">
												<div class="form-group">
													<input type="text" class="form-control com_num2" placeholder="사업자 등록 번호">
												</div>
											</td>
										</tr>
									</table>
									<br />
									<br />
									<button type="button" class="btn btn-primary block full-width m-b com_finder">조회</button>
									<a class="btn btn-sm btn-white btn-block" href="login">Login</a>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<br /> <br /> <br /> <br />
	</div>

	<!-- 검색결과 modal -->
	<div class="modal inmodal" id="result" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content animated fadeIn">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<i class="fa fa-clock-o modal-icon"></i>
					<h4 class="modal-title">검색 결과</h4>
					>
				</div>
				<div class="modal-body" style="text-align: center">
					<p>
						<strong id="resultData" style="font-size: 15pt; color: blue;"></strong>
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-white" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Mainly scripts -->
	<script src="resources/js/jquery-2.1.1.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	<!-- iCheck -->
	<script src="resources/js/plugins/iCheck/icheck.min.js"></script>
	<script>
		$(document).ready(function() {

			/* 개인회원 ID/PW 검색 */
			$('.per_finder').on('click', function() {
				var per_id = $('.per_id').val();
				var per_name = $('.per_name').val();
				var per_email = $('.per_email').val();

				if (per_id.length > 0) {
					per_name = $('.per_name2').val();
					per_email = $('.per_email2').val();
				}

				var params = {
					"per_id" : per_id,
					"per_name" : per_name,
					"per_email" : per_email
				};

				params = JSON.stringify(params);
				$.ajax({
					method : 'post',
					url : 'per_finder',
					data : params,
					dataType : 'json',
					contentType : 'application/json;charset=utf-8',
					success : function(resp) {
						var output = '';
						if (resp.per_id == null) {
							output += "아이디가 존재하지 않습니다.";
						} else {
							if (resp.per_pwd == null) {
								if (resp.per_email == null) {
									output += "없는 정보입니다.";
								} else {
									output += "'" + resp.per_name;
									output += "'님의 id는 ";
									output += resp.per_id + "입니다.";
								}
							} else {
								output += "'" + resp.per_name;
								output += "'님의 비밀번호는 ";
								output += resp.per_pwd + "입니다.";
							}
						}
						$('#result').modal();
						$('#resultData').html(output);
					},
					error : function() {
						alert("err");
					}
				});
			});
			/* 개인회원 ID/PW 검색 끝  */

			/* 기업회원 ID/PW 검색 */
			$('.com_finder').on('click', function() {
				alert("bbbb")
				var com_id = $('.com_id').val();
				var com_name = $('.com_name').val();
				var com_num = $('.com_num').val();

				if (com_id.length > 0) {
					com_name = $('.com_name2').val();
					com_num = $('.com_num2').val();
				}

				var params = {
					"com_id" : com_id,
					"com_name" : com_name,
					"com_num" : com_num
				};

				params = JSON.stringify(params);
				alert(params);
				$.ajax({
					method : 'post',
					url : 'com_finder',
					data : params,
					dataType : 'json',
					contentType : 'application/json;charset=utf-8',
					success : function(resp) {
						var output = '';
						if (resp.com_id == null) {
							output += "아이디가 존재하지 않습니다.";
						} else {
							if (resp.com_pwd == null) {
								if (resp.com_num == 0) {
									output += "없는 정보입니다.";
								} else {
									output += "'" + resp.com_name;
									output += "'님의 id는 ";
									output += resp.com_id + "입니다.";
								}
							} else {
								output += "'" + resp.com_name;
								output += "'님의 비밀번호는 ";
								output += resp.com_pwd + "입니다.";
							}
						}
						$('#result').modal();
						$('#resultData').html(output);
					},
					error : function() {
						alert("err");
					}
				});
			});
			/* 기업회원 ID/PW 검색 끝  */

			/* 창전환 */
			$('#person_id').on('click', function() {
				var p_id = document.getElementById('person_findid');
				var p_pw = document.getElementById('person_findpw');
				p_id.style.display = 'block';
				p_pw.style.display = 'none';
			});

			$('#person_pwd').on('click', function() {
				var p_id = document.getElementById('person_findid');
				var p_pw = document.getElementById('person_findpw');
				p_id.style.display = 'none';
				p_pw.style.display = 'block';
			});

			$('#company_id').on('click', function() {
				var c_id = document.getElementById('company_findid');
				var c_pw = document.getElementById('company_findpw');
				c_id.style.display = 'block';
				c_pw.style.display = 'none';
			});

			$('#company_pwd').on('click', function() {
				var c_id = document.getElementById('company_findid');
				var c_pw = document.getElementById('company_findpw');
				c_id.style.display = 'none';
				c_pw.style.display = 'block';
			});
		});
	</script>

	<!-- Mainly scripts -->
	<script src="resources/js/plugins/metisMenu/jquery.metisMenu.js"></script>
	<script src="resources/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

	<!-- Custom and plugin javascript -->
	<script src="resources/js/inspinia.js"></script>
	<script src="resources/js/plugins/pace/pace.min.js"></script>
</body>

</html>
