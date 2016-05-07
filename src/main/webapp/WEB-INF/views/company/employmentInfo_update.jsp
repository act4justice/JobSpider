<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>INSPINIA | EmploymentInfo</title>

<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/font-awesome/css/font-awesome.css"
	rel="stylesheet">

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
	                    <li>
	                        <a href="#"><i class="fa fa-file-text"></i> 
	                        	<span class="nav-label" style="font-size:15px; font-weight:bold;">이력서/자기소개서</span>  
	                        	<!-- <span class="pull-right label label-primary">SPECIAL</span> -->
	                        </a>
	                        <ul class="nav nav-second-level collapse">
	                            <li style="font-size:15px;"><a href="goInsertResumeForm">이력서/자소서 등록</a></li>
		                        <li style="font-size:15px;"><a href="updateOfResume_form">이력서/자소서 수정</a></li>
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
	                        </a>
	                        <ul class="nav nav-second-level collapse">
	                            <li style="font-size:15px;"><a href="employInfoList_per">채용정보리스트</a></li>
		                        <li style="font-size:15px;"><a href="myInterestRec">관심채용정보</a></li>
	                        </ul>
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
	                    <li class="active">
	                        <a href="#"><i class="fa fa-group"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">채용정보</span>  
	                        </a>
	                        <ul class="nav nav-second-level collapse">
	                            <li class="active" style="font-size:15px;"><a href="employInfoList_com">채용정보리스트</a></li>
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

			<!-- 채용정보 -->
			<div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-10">
                    <h2>채용정보 수정 <small>Update Employment Information.</small></h2>
                    
                </div>
                <div class="col-lg-2">

                </div>
            </div><br />
			
		
		<form method="post" action="updateEmployInfo" enctype="multipart/form-data">	
		<!-- form1 _모집부분 --><!-- 담당업부/자격요건/모집인원 -->
		<div class="row">
			<div class="col-lg-12">
                    <div class="ibox float-e-margins" style="width:70%;">
                        <div class="ibox-title">
                            <h5>모집 부분<small>Recruiting part</small></h5>
                            <input type="hidden" name="rec_index" value="${recruit.rec_index }"/>
                        </div>
                        <div class="ibox-content">
                            <div class="form-horizontal">
                           		<div class="form-group"><label class="col-sm-2 control-label">로고등록<br />
                                	<small class="text-navy">3.5:4.5비율이 적절</small></label>
                                    <div class="col-sm-10">
                                    	<canvas id="canvas" width="190px" height="82.53px" style="display:none;"></canvas>
                                    	<img id="imgLogo" style="width:190px;" src="upload/${recruit.rec_savedfile }"/>
                                    	<input type="file" id="loadingImg" name="file" accept="image/*"/>
										<span class="help-block m-b-none" style="color:red;">10M이하의 포스터만 허용됩니다.</span>
                                    </div>
                                </div>
                                <div class="form-group"><label class="col-sm-2 control-label">담당업무<br /></label>
                                    <div class="col-sm-10"><input type="text" name="rec_duty" class="form-control" value="${recruit.rec_duty }"></div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">자격요건</label>
                                    <div class="col-sm-10"><input type="text" name="rec_requirement" class="form-control " value="${recruit.rec_requirement }"> 
                                    </div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">모집인원</label>

                                    <div class="col-sm-10"><input type="number" min="0" name="rec_memnum" placeholder="placeholder" class="form-control" value="${recruit.rec_memnum }"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
			
			
			
		<!-- form2 _근무조건 --><!-- 지역/요일/부서/급여/직급 -->
		<div class="row">
			<div class="col-lg-12">
                    <div class="ibox float-e-margins" style="width:70%;">
                        <div class="ibox-title">
                            <h5>근무조건 <small>Working conditions</small></h5>
                        </div>
                        <div class="ibox-content"><!-- 지역/요일/부서/급여/직급 -->
                            <div class="form-horizontal">
                                <div class="form-group"><label class="col-sm-2 control-label">근무지역</label>
                                    <div class="col-sm-10"><input type="text" name="rec_location" class="form-control" value="${recruit.rec_location }"></div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">근무요일</label>
                                    <div class="col-sm-10"><input type="text" name="rec_day" class="form-control" value="${recruit.rec_day }"></div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">근무부서</label>
                                    <div class="col-sm-10"><input type="text" name="rec_department" class="form-control" value="${recruit.rec_department }"> 
                                    </div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">직급</label>
                                    <div class="col-sm-10"><input type="text" name="rec_position" class="form-control" value="${recruit.rec_position }"></div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">급여</label>
                                    <div class="col-sm-10"><input type="text" name="rec_salary" class="form-control"  value="${recruit.rec_salary }"></div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">복리후생<br />
                                	<small class="text-navy">Employee welfare and services</small></label>
                                    <div class="col-sm-10"><textarea rows="10" name="rec_welfare" class="form-control">${recruit.rec_welfare }</textarea></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
			</div>
			
			
			
		<!-- form3 _기타 채용정보 --><!-- 전형절차/제출서류/접수방법/접수기간 -->
		<div class="row">
			<div class="col-lg-12">
                    <div class="ibox float-e-margins" style="width:70%;">
                        <div class="ibox-title">
                            <h5>기타 채용 정보 <small>Employment information</small></h5>
                        </div>
                        <div class="ibox-content">
                            <div class="form-horizontal">
                                <div class="form-group"><label class="col-sm-2 control-label">전형절차</label>
                                    <div class="col-sm-10"><input type="text" name="rec_procedure" class="form-control" value="${recruit.rec_procedure }"></div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">제출서류</label>
                                    <div class="col-sm-10"><input type="text" name="rec_docs" class="form-control" value="${recruit.rec_docs }"></div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">접수방법</label>
                                    <div class="col-sm-10"><input type="text" name="rec_submitway" class="form-control" value="${recruit.rec_submitway }"></div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label" >접수 시작일</label>
                                	<div class="input-group date">
                                    	<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    	<input type="text" name="rec_startdate" class="form-control" style="width:98%;" value="${recruit.rec_startdate }">
                                    </div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                <div class="form-group"><label class="col-sm-2 control-label">접수 마감일</label>
                                    <div class="input-group date">
                                    	<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                                    	<input type="text" name="rec_enddate" class="form-control" style="width:98%;" value="${recruit.rec_enddate }">
                                    </div>
                                </div>
                                <div class="hr-line-dashed"></div>
                                
	                                <div class="form-group">
		                              <div class="text-center">
		                                 <button class="btn btn-primary btn-rounded btn-lg btn-outline" type="submit">취소</button>
		                                 <button class="btn btn-primary btn-rounded btn-lg" type="submit">등록</button>
		                              </div>
		                           </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
			</div>
			
			</form>

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
	
	<!-- SUMMERNOTE -->
	<script src="resources/js/plugins/summernote/summernote.min.js"></script>

	<!-- Data picker -->
	<script src="resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>

	<script>
    
	$(document).ready(function(){
		
		document.getElementById("loadingImg").addEventListener("change", loadImg, false);
		canvas = document.getElementById("canvas");
		context = canvas.getContext("2d");

        $('.summernote').summernote();

        $('.input-group.date').datepicker({
            todayBtn: "linked",
            keyboardNavigation: false,
            forceParse: false,
            calendarWeeks: false,
            autoclose: true
        });       

    });
	
	function loadImg(e) {
		$('canvas').css('display', 'block');
		$('#imgLogo').css('display', 'none');
		var file = e.target.files[0];
		var fileReader = new FileReader();
		fileReader.readAsDataURL(file);
		fileReader.onload = function() {
			var output = new Image();
			context.clearRect(0, 0, canvas.width, canvas.height);
			output.src = fileReader.result;
			context.drawImage(output, 0, 0, 190, 82.53);
			context.stroke();
		};
	}
	</script>

</body>
</html>
