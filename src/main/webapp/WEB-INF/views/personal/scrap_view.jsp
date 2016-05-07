<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>INSPINIA | Newsfeed</title>

    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/font-awesome/css/font-awesome.css" rel="stylesheet">

    <!-- Toastr style -->
    <link href="resources/css/plugins/toastr/toastr.min.css" rel="stylesheet">

    <!-- Gritter -->
    <link href="resources/js/plugins/gritter/jquery.gritter.css" rel="stylesheet">

    <link href="resources/css/animate.css" rel="stylesheet">
    <link href="resources/css/style.css" rel="stylesheet">

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
	                        	<span class="fa arrow"></span>
	                        </a>
	                        <ul class="nav nav-second-level collapse">
	                            <li style="font-size:15px;"><a href="goInsertResumeForm">이력서/자소서 등록</a></li>
		                        <li style="font-size:15px;"><a href="updateOfResume_form">이력서/자소서 수정</a></li>
	                        </ul>
	                    </li>
	                    <li class="active">
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
	                    <li>
	                        <a href="#"><i class="fa fa-group"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">채용정보</span> 
	                        	<span class="fa arrow"></span> 
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
	                        <a href="#"><i class="fa fa-pencil-square-o"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">기업정보관리 </span>
	                        	<span class="fa arrow"></span>
	                        </a>
		                        <ul class="nav nav-second-level collapse">
		                            <li style="font-size:15px;"><a href="goTemp">기업정보수정</a></li>
		                            <li style="font-size:15px;"><a href="goTemp">비밀번호변경</a></li>
		                            <li style="font-size:15px;"><a href="goTemp">메일수신설정</a></li>
		                            <li style="font-size:15px;"><a href="goTemp">회원탈퇴</a></li>
		                        </ul>
	                    </li>
	                    <li>
	                        <a href="calendar"><i class="fa fa-calendar"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">공채일정캘린더</span>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="goTemp"><i class="fa fa-square-o"></i> 
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
        <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <a class="navbar-minimalize minimalize-styl-2 btn btn-primary " href="#"><i class="fa fa-bars"></i> </a>
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
           
           
			
			<!-- 뉴스프레이 -->
		 	<div class="row wrapper border-bottom white-bg page-heading">
              <div class="col-lg-10">
                  <h2><strong>스크랩북</strong> <small>SCRAPBOOK</small></h2>
                  
              </div>
              <div class="col-lg-2">

              </div>
          	</div><br />

        
        	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
        
        
        
        
        <c:forEach items="${scrapList}" var="scrap">
            <div class="col-lg-3">
                <div class="contact-box center-version scrapVal${scrap.scr_seq }" style="height:200px;">

                    <a href="scrapDetail?scr_seq=${scrap.scr_seq}">

                        <h3 class="m-b-xs"><strong>${scrap.scr_title}</strong></h3>

                        <div class="font-bold">${scrap.scr_subtitle}</div>
                       

                    </a>
                    <div class="contact-box-footer">
                        <div class="m-t-xs btn-group">
                            <a class="btn deletebtn btn-danger btn-outline" value="${scrap.scr_seq }">
                            <i style="font-size:20px;" class="fa fa-trash"></i>&nbsp;&nbsp;삭제</a>
                        </div>
                    </div>

                </div>
            </div>
        </c:forEach>
            
            
            
            
        </div>
        </div>

        </div>
        
        
    </div>

    <!-- Mainly scripts -->
    <script src="resources/js/jquery-2.1.1.js"></script>
    <script src="resources/js/bootstrap.min.js"></script>
    <script src="resources/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="resources/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

    <!-- Flot -->
    <script src="resources/js/plugins/flot/jquery.flot.js"></script>
    <script src="resources/js/plugins/flot/jquery.flot.tooltip.min.js"></script>
    <script src="resources/js/plugins/flot/jquery.flot.spline.js"></script>
    <script src="resources/js/plugins/flot/jquery.flot.resize.js"></script>
    <script src="resources/js/plugins/flot/jquery.flot.pie.js"></script>

    <!-- Peity -->
    <script src="resources/js/plugins/peity/jquery.peity.min.js"></script>
    <script src="resources/js/demo/peity-demo.js"></script>

    <!-- Custom and plugin javascript -->
    <script src="resources/js/inspinia.js"></script>
    <script src="resources/js/plugins/pace/pace.min.js"></script>

    <!-- jQuery UI -->
    <script src="resources/js/plugins/jquery-ui/jquery-ui.min.js"></script>

    <!-- GITTER -->
    <script src="resources/js/plugins/gritter/jquery.gritter.min.js"></script>

    <!-- Sparkline -->
    <script src="resources/js/plugins/sparkline/jquery.sparkline.min.js"></script>

    <!-- Sparkline demo data  -->
    <script src="resources/js/demo/sparkline-demo.js"></script>

    <!-- ChartJS-->
    <script src="resources/js/plugins/chartJs/Chart.min.js"></script>

    <!-- Toastr -->
    <script src="resources/js/plugins/toastr/toastr.min.js"></script>


	<script>
		$(document).ready(function() {
			$('.scrap_button').on("click", function() {
				alert("aaa");
				var url = $(this).attr('scrapurl');
				var data = {
					'url' : url
				}
				alert(url);
				$.ajax({
					method : 'post',
					url : 'insertScrap',
					data : data,
					success : function(resp) {
						alert("성공");
					}
				});

			});
			
			$('.deletebtn').on('click', function(){
	            var scr_seq = $(this).attr('value');
	            $.ajax({
	               method : 'post',
	               url : 'deleteScrap',
	               data : "scr_seq="+scr_seq,
	               success : function(resp) {                  
	                  location.href = "scrapList";
	               }
	            });
	         });
			

		});
	</script>
</body>
</html>
