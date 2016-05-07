<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>INSPINIA | UpdateResume</title>

<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/font-awesome/css/font-awesome.css" rel="stylesheet">

<!-- Toastr style -->
<link href="resources/css/plugins/toastr/toastr.min.css" rel="stylesheet">

<!-- Gritter -->
<link href="resources/js/plugins/gritter/jquery.gritter.css" rel="stylesheet">

<link href="resources/css/plugins/summernote/summernote.css" rel="stylesheet">
<link href="resources/css/plugins/summernote/summernote-bs3.css" rel="stylesheet">

<link href="resources/css/plugins/datapicker/datepicker3.css" rel="stylesheet">

<link href="resources/css/animate.css" rel="stylesheet">
<link href="resources/css/style.css" rel="stylesheet">

<script src="resources/js/jquery-2.2.2.min.js"></script>

<script>
	
		$(function() {
			
			/* $('canvas').css('display', 'none'); */
			
			//이력서 사진 뿌리기
			document.getElementById("loadingImg").addEventListener("change", loadImg, false);
			canvas = document.getElementById("canvas");
			context = canvas.getContext("2d");
			
			//자기 소개서 update
            $('#updateOfCoverLetter').on('click', function() {
               var array = [];
               for (var i = 0; i < $('.title').length; i++) {
                  var title = $('.title')[i].value;
                  var contents = $('.contents')[i].value;
                  if(title.length != 0 && contents.length != 0){
                     array.push({"intro_title" : title, "intro_contents" : contents});
                  }
               }

               var data = JSON.stringify({"data" : {'Introduce' : array}});

               $.ajax({
                  method : 'post',
                  data : data,
                  url : 'updateOfCoverLetter',
                  headers: { 
                	  		'Accept': 'application/json',
                	  		'Content-Type': 'application/json' 
                	  		},
                  contentType : "application/json;charset=UTF-8",
                  success : function(resp) {
                	  location.href="goTemp";
                  }
               });
            });
			
			//날짜 선택(datepicker)
			$('.input-group.date').datepicker({
				todayBtn : "linked",
				keyboardNavigation : false,
				forceParse : false,
				calendarWeeks : false,
				autoclose : true
			});

			/* 학력사항 */
			var html_edu = '';
			html_edu+="<tr class='edu_classTr'>";
			html_edu+="	<td>";
			html_edu+="		<div class='input-group date'>";
			html_edu+="			<span class='input-group-addon'><i class='fa fa-calendar'></i></span>"; 
			html_edu+="			<input type='text' name='edu_startdate' class='form-control edu_startdate' style='width: 98%;'>";
			html_edu+="		</div>&nbsp;~<br />";
			html_edu+="		<div class='input-group date'>";
			html_edu+="			<span class='input-group-addon'><i class='fa fa-calendar'></i></span>"; 
			html_edu+="			<input type='text' name='edu_endadate' class='form-control edu_enddate' style='width: 98%;'>";
			html_edu+="		</div>";
			html_edu+="	</td>";
			html_edu+="	<td style='vertical-align: middle; text-align: center;'><input type='text' class='edu_scname' name='edu_scname'></td>";
			html_edu+="	<td style='vertical-align: middle; text-align: center;'><input type='text' class='edu_major' name='edu_major'></td>";
			html_edu+="	<td style='vertical-align: middle; text-align: center;'><input type='text' class='edu_graduation' name='edu_graduation'></td>";
			html_edu+="</tr>";
			
			$('#edu_add').click(function() {
				$('.edu_addTr').append(html_edu);
				$('.input-group.date').datepicker({
					todayBtn : "linked",
					keyboardNavigation : false,
					forceParse : false,
					calendarWeeks : false,
					autoclose : true
				});
			});
			$('#edu_delete').click(function() {
				$('.edu_classTr:last').remove();
			});

			/* 경력사항 */
			var html_car = '';
			html_car+="<tr class='car_classTr'>";
			html_car+="	<td>";
			html_car+="		<div class='input-group date'>";
			html_car+="			<span class='input-group-addon'><i class='fa fa-calendar'></i></span>";
			html_car+="			<input type='text' name='car_startdate' class='form-control car_startdate' style='width: 98%;'>";
			html_car+="		</div>&nbsp;~<br />";
			html_car+="		<div class='input-group date'>";
			html_car+="			<span class='input-group-addon'><i class='fa fa-calendar'></i></span>"; 
			html_car+="			<input type='text' name='car_endadate' class='form-control car_enddate' style='width: 98%;'>";
			html_car+="		</div>";
			html_car+="	</td>";
			html_car+="	<td style='vertical-align: middle; text-align: center;'><input type='text' class='car_comname' name='car_comname'></td>";
			html_car+="	<td style='vertical-align: middle; text-align: center;'><input type='text' class='car_department' name='car_department'></td>";
			html_car+="	<td style='vertical-align: middle; text-align: center;'><input type='text' class='car_duty' name='car_duty'></td>";
			html_car+="</tr>";
			$('#car_add').click(function() {
				$('.car_addTr').append(html_car);
				$('.input-group.date').datepicker({
					todayBtn : "linked",
					keyboardNavigation : false,
					forceParse : false,
					calendarWeeks : false,
					autoclose : true
				});
			});
			$('#car_delete').click(function() {
				$('.car_classTr:last').remove();
			});

			/* 자격증/면허증 */
			var html_cer = '';
			html_cer+="<tr class='cer_classTr'>";
			html_cer+="	<td	style='vertical-align: middle; text-align: center;'><input type='text' class='cer_cername' name='cer_cername'></td>";
			html_cer+="	<td><div class='input-group date'>";
			html_cer+="		<span class='input-group-addon'>";
			html_cer+="		<i class='fa fa-calendar'></i></span>"; 
			html_cer+="		<input type='text' class='cer_date' name='cer_date' class='form-control' style='width: 98%;'>";
			html_cer+="	</div></td>";
			html_cer+="	<td><input type='text' class='cer_grade' name='cer_grade'></td></tr>";
			$('#cer_add').click(function() {
				$('.cer_addTr').append(html_cer);
				$('.input-group.date').datepicker({
					todayBtn : "linked",
					keyboardNavigation : false,
					forceParse : false,
					calendarWeeks : false,
					autoclose : true
				});
			});
			$('#cer_delete').click(function() {
				$('.cer_classTr:last').remove();
			});

			/* 수상내역/공모전 */
			var html_awa ='';
				html_awa+="<tr class='awa_classTr'>";
				html_awa+="		<td style='vertical-align: middle; text-align: center;'>";
				html_awa+="			<input type='text' class='awa_name' name='awa_name'>";
				html_awa+="		</td>";
				html_awa+="		<td style='vertical-align: middle; text-align: center;'>";
				html_awa+="			<input type='text' class='awa_detail' name='awa_detail'>";
				html_awa+="		</td>";
				html_awa+="		<td>";
				html_awa+="			<div class='input-group date'>";
				html_awa+="				<span class='input-group-addon'><i class='fa fa-calendar'></i></span> ";
				html_awa+="				<input type='text' class='awa_date' name='awa_date' class='form-control' style='width: 98%;'>";
				html_awa+="			</div>";
				html_awa+="		</td>";
				html_awa+="	</tr>";
			$('#awa_add').click(function() {
				$('.awa_addTr').append(html_awa);
				$('.input-group.date').datepicker({
					todayBtn : "linked",
					keyboardNavigation : false,
					forceParse : false,
					calendarWeeks : false,
					autoclose : true
				});
			});
			$('#awa_delete').click(function() {
				$('.awa_classTr:last').remove();
			});
			
			/* 자기 소개서 */
	         var html_intro = '';
	         html_intro+="    <div class='addIntroFormInner'>";
	         html_intro+="       <div class='ibox-title'>";
	         html_intro+="          <input class='title' style='width:100%;border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;'/>";
	         html_intro+="       </div>";
	         html_intro+="       <div class='ibox-content no-padding'>";
	         html_intro+="          <textarea class='contents' contenteditable='true' style='width:100%; height:250px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;'></textarea>";
	         html_intro+="       </div>";
	         html_intro+="    </div>";
	         $('#intro_add').click(function() {
	            $('.addIntroForm').append(html_intro);
	         });
	         $('#intro_delete').click(function() {
	            $('.addIntroFormInner:last').remove();
	         });
			
			
			//이력서 등록 폼 보내기
			$("#goModify").on("click", function(){
				//학력사항 리스트
				var snd_edu = [];
				for(var i=0; i<$('.edu_startdate').length; i++){
					var edu_startdate = $('.edu_startdate')[i].value;
					var edu_enddate = $('.edu_enddate')[i].value;
					var edu_scname= $('.edu_scname')[i].value;
					var edu_major= $('.edu_major')[i].value;
					var edu_graduation= $('.edu_graduation')[i].value;
					if(edu_startdate.length !=0 && edu_enddate.length !=0 && edu_scname.length !=0 && edu_major.length !=0 &&edu_graduation.length !=0 ){
						snd_edu.push({'edu_startdate':edu_startdate, 'edu_enddate':edu_enddate, 'edu_scname':edu_scname, 'edu_major':edu_major, 'edu_graduation':edu_graduation});
					}
				}
				
				//경력사항 리스트
				var snd_car = [];
				for(var i=0; i<$('.car_startdate').length; i++){
					var car_startdate = $('.car_startdate')[i].value;
					var car_enddate = $('.car_enddate')[i].value;
					var car_comname= $('.car_comname')[i].value;
					var car_department= $('.car_department')[i].value;
					var car_duty= $('.car_duty')[i].value;
					if(car_startdate.length !=0 && car_enddate.length !=0 && car_comname.length !=0 && car_department.length !=0 &&car_duty.length !=0 ){
						snd_car.push({'car_startdate':car_startdate, 'car_enddate':car_enddate, 'car_comname':car_comname, 'car_department':car_department, 'car_duty':car_duty});
					}
				}
				
				//자격증&면허증리스트
				var snd_cer = [];
				for(var i=0; i<$('.cer_cername').length; i++){
					var cer_cername = $('.cer_cername')[i].value;
					var cer_date = $('.cer_date')[i].value;
					var cer_grade = $('.cer_grade')[i].value;
					if(cer_cername.length !=0 && cer_date.length !=0 && cer_grade.length !=0){
						snd_cer.push({'cer_cername':cer_cername, 'cer_date':cer_date, 'cer_grade':cer_grade});
					}
				}
				
				//수상경력리스트
				var snd_awa = [];
				for(var i=0; i<$('.awa_name').length; i++){
					var awa_name = $('.awa_name')[i].value;
					var awa_detail = $('.awa_detail')[i].value;
					var awa_date = $('.awa_date')[i].value;
					if(awa_name.length !=0 && awa_detail.length !=0 && awa_date.length !=0){
						snd_awa.push({'awa_name':awa_name, 'awa_detail':awa_detail, 'awa_date':awa_date});
					}
				}
				
				
				var snd_all = JSON.stringify({"data" :{'education':snd_edu , 'career':snd_car , 'certificate': snd_cer , 'award': snd_awa}}); 
				$('#submitForm').submit();
				//submitForm.submit();
				$.ajax({
					url : 'updateOfResume',
					contentType : 'application/json; charset=UTF-8',
					method : 'post',
					dataType : 'json',
					data : snd_all,
					success : function(data){
						var submitForm = document.getElementById("submitForm");
						submitForm.submit();	
					}
				});
			});
			
			$('#intro_add').on("click", function(){
				
				var divTest = [];
				for(var i=0; i<$('.introTest').length; i++){
					var test = $('.introTest')[i].value;
					var test2 = $('.introTest2')[i].value;
					divTest.push({'test':test, 'test2':test2});
				}
			});
		});
		
		function loadImg(e) {
			$('canvas').css('display', 'block');
			$('#personImg').css('display', 'none');
			var file = e.target.files[0];
			var fileReader = new FileReader();
			fileReader.readAsDataURL(file);
			fileReader.onload = function() {
				var output = new Image();
				context.clearRect(0, 0, canvas.width, canvas.height);
				output.src = fileReader.result;
				context.drawImage(output, 0, 0, 230, 300);
				context.stroke();
			};
		}
		
	</script>

</head>

<body>
	<div id="wrapper">
		<nav class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
            
            	<!-- Personal회원 메뉴 -->
            	<c:if test="${not empty per_loginId }">
	                <ul class="nav metismenu" id="side-menu">
	                    <li class="nav-header">
	                        <div class="dropdown profile-element"> 
	                        	<a href="goTemp"><span><img alt="image" class="img" src="resources/img/logo_temp.png" /></span>
	                            <span class="clear"> 
	                            	<br /><span style="font-size: 18px;" class="block m-t-xs"> <strong class="font-bold">${per.per_name}</strong></span>  
	                            </span></a>
	                        </div>
	                        <div class="logo-element">
	                            B1
	                        </div>
	                    </li>
	                    <li>
	                        <a href="goTemp"><i class="fa fa-newspaper-o"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">뉴스프레이</span>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="updatePerInfo_form"><i class="fa fa-user"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">개인정보관리 </span>
	                        </a>
	                    </li>
	                    <li class="active">
	                        <a href="#"><i class="fa fa-file-text"></i> 
	                        	<span class="nav-label" style="font-size:15px; font-weight:bold;">이력서/자기소개서</span> 
	                        	<span class="fa arrow"></span> 
	                        </a>
	                        <ul class="nav nav-second-level">
	                            <li style="font-size:15px;"><a href="goInsertResumeForm">이력서/자소서 등록</a></li>
		                        <li class="active" style="font-size:15px;"><a href="updateOfResume_form">이력서/자소서 수정</a></li>
	                        </ul>
	                    </li>
	                    <li>
	                        <a href="scrapList"><i class="fa fa-th-large"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">스크랩모아보기</span>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="#"><i class="fa fa-list-ul"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">채용정보</span>  
	                        	<span class="fa arrow"></span>
	                        </a>
	                        <ul class="nav nav-second-level collapse">
	                            <li style="font-size:15px;"><a href="employInfoList_per">채용정보리스트</a></li>
		                        <li style="font-size:15px;"><a href="myInterestRec">관심채용정보</a></li>
	                        </ul>
	                    </li>
	                    <li>
	                        <a href="calendarㄴ"><i class="fa fa-calendar"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">공채일정캘린더</span>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="pinboard"><i class="fa fa-square-o"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">메모지</span>
	                        </a>
	                    </li>
	                </ul>
                </c:if>
				<!-- Personal회원 메뉴 끝 -->
				
				
				<!-- Company회원 메뉴 -->
            	<c:if test="${not empty com_loginId }">
	                <ul class="nav metismenu" id="side-menu">
	                    <li class="nav-header">
	                        <div class="dropdown profile-element"> 
	                        	<a href="goTemp2"><span><img alt="image" class="img" src="resources/img/logo_temp.png" /></span>
	                            <span class="clear"> 
	                            	<br /><span style="font-size: 18px;" class="block m-t-xs"> <strong class="font-bold">${com.com_name}</strong></span>  
	                            </span></a>
	                        </div>
	                        <div class="logo-element">
	                            B1
	                        </div>
	                    </li>
	                    <li>
	                        <a href="#"><i class="fa fa-group"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">채용정보</span>  
	                        </a>
	                        <ul class="nav nav-second-level collapse">
	                            <li style="font-size:15px;"><a href="employInfoList_com">채용정보리스트</a></li>
		                        <li style="font-size:15px;"><a href="goEmploymentReg">채용정보등록</a></li>
	                        </ul>
	                    </li>
	                    <li>
	                        <a href="applyStatusForm"><i class="fa fa-user"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">지원현황 </span>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="updateComInfo_form"><i class="fa fa-pencil-square-o"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">기업정보관리 </span>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="calendar"><i class="fa fa-calendar"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">공채일정캘린더</span>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="pinboard"><i class="fa fa-square-o"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">메모지</span>
	                        </a>
	                    </li>
	                </ul>
                </c:if>
				<!-- Company회원 메뉴 끝 -->
				
            </div>
        </nav>

		<div id="page-wrapper" class="gray-bg dashbard-1">
			<div class="row border-bottom">
				<nav class="navbar navbar-static-top" role="navigation"
					style="margin-bottom: 0">
					<div class="navbar-header">
						<a class="navbar-minimalize minimalize-styl-2 btn btn-primary "
							href="#"><i class="fa fa-bars"></i> </a>
					</div>
					<ul class="nav navbar-top-links navbar-right">
		                <li>
		                    <span style="font-size: 18px; font-weight: bold;" class="m-r-sm text-muted welcome-message">${per_loginId}${com_loginId} 님</span>
		                </li>
		
		                <li>
		                    <a style="font-size: 18px;" href="logout">
		                        <i class="fa fa-sign-out" style="font-size: 18px;"></i> Log out
		                    </a>
		                </li>
		            </ul>

				</nav>
			</div>

			<div class="row wrapper border-bottom white-bg page-heading">
				<div class="col-lg-10">
					<h2>
						이력서|자기소개서 수정<small>&nbsp;&nbsp;Resume|Cover Letter  Modification</small>
					</h2>

				</div>
				<div class="col-lg-2"></div>
			</div>

			<div class="wrapper wrapper-content  animated fadeInRight">

				<div class="row">
					<div class="col-lg-12">
						<div class="tabs-container">
							<ul class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#tab-1">Resume</a></li>
								<li class=""><a data-toggle="tab" href="#tab-2">Cover
										Letter</a></li>
							</ul>
							<div class="tab-content">
								<div id="tab-1" class="tab-pane active">
									<div class="panel-body">

										<form id="submitForm" name ="submitForm" action="updatePerImage" method="post" enctype="multipart/form-data">
											<fieldset class="form-horizontal">
												<div class="form-group">
													<!-- 기본 정보 -->
													<div class="col-lg-6">
														<div class="ibox float-e-margins">
															<div class="ibox-title">
																<h5>기본정보</h5>
															</div>
															<div class="ibox-content">

																<table class="table table-bordered">
																	<tr>
																		<td rowspan="4" width="230px" height="300px" style="text-ailgn: center; vertical-align: bottom; padding: 25px;">
																			<canvas id="canvas" width="230px" height="300px" style="display:none;"></canvas>
																			<img id="personImg" style="width:230px;" src="upload2/${personal.per_savedfile}" />
																			
																			<input type="file" id="loadingImg" name="file" accept="image/*" />
																		</td>
																		<th style="vertical-align: middle; text-align: center; background-color: #F5F5F6; width: 15%;">이 름</th>
																		<td style="vertical-align: middle; width: 65%;">${personal.per_name }
																			<input type="hidden" name="per_name" value="${personal.per_name }"/>
																		</td>
																	</tr>
																	<tr>
																		<th style="vertical-align: middle; text-align: center; background-color: #F5F5F6;">주 소</th>
																		<td style="vertical-align: middle;">우편번호- ${personal.per_zipcode }<br>상세주소- ${personal.per_address }
																			<input type="hidden" name="per_zipcode" value="${personal.per_zipcode }"/>
                                                         					<input type="hidden" name="per_address" value="${personal.per_address }"/>      
																		</td>
																	</tr>
																	<tr>
																		<th style="vertical-align: middle; text-align: center; background-color: #F5F5F6;">휴 대 폰</th>
																		<td style="vertical-align: middle;">${personal.per_phone }
																			<input type="hidden" name="per_phone" value="${personal.per_phone }"/>
																		</td>
																	</tr>
																	<tr>
																		<th style="vertical-align: middle; text-align: center; background-color: #F5F5F6;">이 메 일</th>
																		<td style="vertical-align: middle;">${personal.per_email }
																			<input type="hidden" name="per_email" value="${personal.per_email }"/>
																		</td>
																	</tr>
																</table>

															</div>
														</div>
													</div>
													<!-- 기본 정보 -->

													<!-- 학력사항  -->
													<div class="col-lg-6">
														<div class="ibox float-e-margins">
															<div class="ibox-title">
																<h5>학력사항</h5>
															</div>
															<div class="ibox-content">

																<table class="table table-bordered">
																	<thead>
																		<tr>
																			<td
																				style="width: 30%; vertical-align: middle; text-align: center;">재학기간</td>
																			<td
																				style="vertical-align: middle; text-align: center;">학교명</td>
																			<td
																				style="vertical-align: middle; text-align: center;">전공</td>
																			<td
																				style="vertical-align: middle; text-align: center;">졸업여부</td>
																		</tr>
																	</thead>
																	<tbody class="edu_addTr">
																	<!-- 학력사항 List뿌려주기 -->
																	<c:forEach items="${eduList }" var="edu">
																		<tr class="edu_classTr">
																			<td>
																				<div class="input-group date">
																					<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
																					<input type="text" name="edu_startdate" class="form-control edu_startdate" style="width: 98%;" value="${edu.edu_startdate }">
																				</div>&nbsp;~<br />
																				<div class="input-group date">
																					<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
																					<input type="text" name="edu_endadate" class="form-control edu_enddate" style="width: 98%;" value="${edu.edu_enddate }">
																				</div>
																			</td>
																			<td style="vertical-align: middle; text-align: center;">
																				<input type="text" class="edu_scname" name="edu_scname" value="${edu.edu_scname }">
																			</td>
																			<td style="vertical-align: middle; text-align: center;">
																				<input type="text" class="edu_major" name="edu_major" value="${edu.edu_major }">
																			</td>
																			<td style="vertical-align: middle; text-align: center;">
																				<input type="text" class="edu_graduation" name="edu_graduation" value="${edu.edu_graduation }">
																			</td>
																		</tr>
																	</c:forEach>
																	</tbody>
																</table>

																<div style="text-align: right;">
																	<input id="edu_add" type="button"
																		class="btn btn-success btn-rounded btn-outline" value="추가" /> <input
																		id="edu_delete" type="button"
																		class="btn btn-success btn-rounded btn-outline" value="삭제" />
																</div>
															</div>
														</div>
													</div>
													<!-- 학력사항 -->

													<!-- 경력사항 -->
													<div class="col-lg-6">
														<div class="ibox float-e-margins">
															<div class="ibox-title">
																<h5>경력사항</h5>
															</div>
															<div class="ibox-content">

																<table class="table table-bordered">
																	<thead>
																		<tr>
																			<td style="width: 30%; vertical-align: middle; text-align: center;">근무기간</td>
																			<td style="vertical-align: middle; text-align: center;">회사명</td>
																			<td style="vertical-align: middle; text-align: center;">부서</td>
																			<td style="vertical-align: middle; text-align: center;">담당업무</td>
																		</tr>
																	</thead>
																	<tbody class="car_addTr">
																	
																		<!-- 경력사항 List뿌려주기 -->
																		<c:forEach items="${carList }" var="car">
																			<tr class="car_classTr">
																				<td>
																					<div class="input-group date">
																						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
																						<input type="text" name="car_startdate" class="form-control car_startdate" style="width: 98%;" value="${car.car_startdate }">
																					</div>&nbsp;~<br />
																					<div class="input-group date">
																						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
																						<input type="text" name="car_endadate" class="form-control car_enddate" style="width: 98%;" value="${car.car_enddate }">
																					</div>
																				</td>
																				<td style="vertical-align: middle; text-align: center;"><input type="text" class="car_comname" name="car_comname" value="${car.car_comname }"></td>
																				<td style="vertical-align: middle; text-align: center;"><input type="text" class="car_department" name="car_department" value="${car.car_department }"></td>
																				<td style="vertical-align: middle; text-align: center;"><input type="text" class="car_duty" name="car_duty" value="${car.car_duty }"></td>
																			</tr>
																		</c:forEach>
																	</tbody>
																</table>

																<div style="text-align: right;">
																	<input id="car_add" type="button"
																		class="btn btn-success btn-rounded btn-outline" value="추가" /> <input
																		id="car_delete" type="button"
																		class="btn btn-success btn-rounded btn-outline" value="삭제" />
																</div>
															</div>
														</div>
													</div>
													<!-- 경력사항 -->

													<!-- 자격증/면허증 -->
													<div class="col-lg-6">
														<div class="ibox float-e-margins">
															<div class="ibox-title">
																<h5>자격증/면허증</h5>
															</div>
															<div class="ibox-content">

																<table class="table table-bordered">
																	<thead>
																		<tr>
																			<td
																				style="vertical-align: middle; text-align: center;">자격증/면허증
																			</td>
																			<td
																				style="vertical-align: middle; text-align: center;">취득일</td>
																			<td
																				style="vertical-align: middle; text-align: center;">점수/등급</td>
																		</tr>
																	</thead>
																	<tbody class="cer_addTr">
																	
																		<!-- 자격증 List뿌려주기 -->
																		<c:forEach items="${cerList }" var="cer">
																			<tr class="cer_classTr">
																				<td	style="vertical-align: middle; text-align: center;">
																					<input type="text" class="cer_cername" name="cer_cername" value="${cer.cer_cername }">
																				</td>
																				<td>
																					<div class="input-group date">
																						<span class="input-group-addon">
																						<i class="fa fa-calendar"></i></span> 
																						<input type="text" class="cer_date" name="cer_date" class="form-control" style="width: 98%;" value="${cer.cer_date }">
																					</div>
																				</td>
																				<td><input type="text" class="cer_grade" name="cer_grade" value="${cer.cer_grade }"></td>
																			</tr>
																		</c:forEach>
																	</tbody>
																</table>

																<div style="text-align: right;">
																	<input id="cer_add" type="button"
																		class="btn btn-success btn-rounded btn-outline" value="추가" /> <input
																		id="cer_delete" type="button"
																		class="btn btn-success btn-rounded btn-outline" value="삭제" />
																</div>
															</div>
														</div>
													</div>
													<!-- 자격증/면허증 -->
													<!-- 수상내역/공모전 -->
													<div class="col-lg-6">
														<div class="ibox float-e-margins">
															<div class="ibox-title">
																<h5>수상내역/공모전</h5>
															</div>
															<div class="ibox-content">
															
																<table class="table table-bordered">
																	<thead>
																		<tr>
																			<td
																				style="width: 30%; vertical-align: middle; text-align: center;">수상내역/공모전</td>
																			<td
																				style="vertical-align: middle; text-align: center;">상세내용</td>
																			<td
																				style="vertical-align: middle; text-align: center;">수상일</td>
																		</tr>
																	</thead>
																	<tbody class="awa_addTr">
																		<!-- 수상내역 공모전 List뿌려주기 -->
																		<c:forEach items="${awaList }" var="awa">
																			<tr class="awa_classTr">
																				<td style="vertical-align: middle; text-align: center;">
																					<input type="text" class="awa_name" id="awa_name" name="awa_name" value="${awa.awa_name }">
																				</td>
																				<td style="vertical-align: middle; text-align: center;">
																					<input type="text" class="awa_detail" id="awa_detail" name="awa_detail" value="${awa.awa_detail }">
																				</td>
																				<td>
																					<div class="input-group date">
																						<span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
																						<input type="text" class="awa_date" id="awa_date" name="awa_date" class="form-control" style="width: 98%;" value="${awa.awa_date }">
																					</div>
																				</td>
																			</tr>
																		</c:forEach>
																	</tbody>
																
																</table>

																<div style="text-align: right;">
																	<input id="awa_add" type="button" class="btn btn-success btn-rounded btn-outline" value="추가" /> 
																	<input id="awa_delete" type="button" class="btn btn-success btn-rounded btn-outline" value="삭제" />
																</div>
															</div>
														</div>
													</div>
													<!-- 수상내역/공모전 -->
												</div>
											</fieldset>
											<div style="text-align: center;">
												<button type="button" class="btn btn-success btn-rounded btn-lg" id="goModify">수정</button>&nbsp;
												<a href="goTemp"><button type="button" class="btn btn-success btn-rounded btn-lg" id="goMain">메인</button></a>
											</div>
										</form>
									</div>

								</div>
								
								<!-- 자기소개Tab 시작 -->
                              <div id="tab-2" class="tab-pane">
                                 <div class="panel-body">
                                    <div class="form-group">
                                       <div class="col-lg-12">
                                          <div class="ibox float-e-margins">
      
                                             <form id="insertOfCoverLetter" name="insertOfCoverLetter" action="insertOfCoverLetter" method="post">
                                                <!-- 자기 소개서 -->
                                                <div class="col-lg-12">
                                                   <div class="ibox float-e-margins">
      
                                                      <!-- 자기 소개서 loop -->
                                                      <c:forEach items="${introduceList }" var="intro">
                                                         <div class='addIntroFormInner'>
                                                            <div class="ibox-title">
                                                               <input class="title" value="${intro.intro_title}" style="width:100%;border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;"/>
                                                            </div>
                                                            <div class="ibox-content no-padding">
                                                               <textarea class="contents" contenteditable="true" style=" width:100%; height:250px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;">${intro.intro_contents}</textarea>
                                                            </div>
                                                        </div>
                                                     </c:forEach>
                                                      <!-- 자기 소개서 loop -->
                                                      
                                                      <div class="addIntroForm">
                                                         <div class="addIntroFormInner">
                                                            <div class="ibox-title">
                                                               <input class="title" placeholder="제목을 입력해 주세요." style="width:100%;border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;"/>
                                                            </div>
                                                            <div class="ibox-content no-padding">
                                                               <textarea class="contents" placeholder="내용을 입력해 주세요." contenteditable="true" style=" width:100%; height:250px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;"></textarea>
                                                            </div>
                                                       </div>
                                                    </div>
      
                                                      <!-- 추가/삭제 button -->
                                                      <div style="text-align: right;">
                                                         <input id="intro_add" type="button"
                                                            class="btn btn-success btn-rounded btn-outline"
                                                            value="추가" /> <input id="intro_delete" type="button"
                                                            class="btn btn-success btn-rounded btn-outline"
                                                            value="삭제" />
                                                      </div>
      
                                                      <!-- save button -->
                                                      <div style="text-align: center;">
                                                      <c:if test="${empty introduceList}">
                                                      	<button type="button" class="btn btn-success btn-rounded btn-lg text-center" id="updateOfCoverLetter">등록</button>
                                                      </c:if>
                                                      <c:if test="${!empty introduceList }">
                                                         <button type="button" class="btn btn-success btn-rounded btn-lg text-center" id="updateOfCoverLetter">수정</button>
                                                      </c:if>
                                                         <a href="goTemp"><button type="button" class="btn btn-success btn-rounded btn-lg" id="goMain">메인</button></a>
                                                      </div>
                                                      </div>
                                                   </div>
	                                             </form>
                                                </div>
                                             <!-- 자기 소개서 -->
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <!-- 자기소개 Tab끝  -->
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	
	<!-- Mainly scripts -->
	<script src="resources/js/jquery-2.1.1.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/plugins/metisMenu/jquery.metisMenu.js"></script>
	<script src="resources/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

	<!-- Custom and plugin javascript -->
	<script src="resources/js/inspinia.js"></script>
	<script src="resources/js/plugins/pace/pace.min.js"></script>

	<!-- Peity -->
	<script src="resources/js/plugins/peity/jquery.peity.min.js"></script>

	<!-- jqGrid -->
	<script src="resources/js/plugins/jqGrid/i18n/grid.locale-en.js"></script>
	<script src="resources/js/plugins/jqGrid/jquery.jqGrid.min.js"></script>

	<!-- SUMMERNOTE -->
	<script src="resources/js/plugins/summernote/summernote.min.js"></script>

	<!-- Data picker -->
	<script src="resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>

	
</body>
</html>