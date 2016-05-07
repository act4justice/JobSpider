<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>INSPINIA | Newspeed</title>
	<style>
	html, body {
		margin: 0;
		padding: 0;
		width: 100%;
		height: 100%;
		background-color: #F4F4F4;
	}
	
	/* canvas {
		background-color: #ffffff;
	}
	 */
	.paint {
		margin: 0;
		padding: 0;
	}
	
	.paintTools {
		margin: 0;
		padding: 0;
	}
	</style>
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/font-awesome/css/font-awesome.css" rel="stylesheet">

	<link rel="Stylesheet" href="" />

	<!-- CSS -->
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <!-- Toastr style -->
    <link href="resources/css/plugins/toastr/toastr.min.css" rel="stylesheet">

    <!-- Gritter -->
    <link href="resources/js/plugins/gritter/jquery.gritter.css" rel="stylesheet">

    <link href="resources/css/animate.css" rel="stylesheet">
    <link href="resources/css/style.css" rel="stylesheet">
<!-- Js -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/html2canvas.js"></script>
<script type="text/javascript">
	$(function() {
		// Canvas 객체를 추출합니다
		var canvas = document.getElementById('canvas');
		var context = canvas.getContext('2d');
		loadImg(context);

		//loadImg(context);

		// 변수를 선언합니다.
		var width = 5; //라인 굵기
		var color = '#ffffff'; //색상
		var isDown = false;
		var newPoint, oldPoint;
		var START_EV = 'mousedown';
		var MOVE_EV = 'mousemove';
		var END_EV = 'mouseup';
		var BSTART_EV = 'mouseover';
		var color = $("div input:eq(0)").css("background-color");

		// 모바일 웹 스크롤 막기
		$("body").bind('touchmove', function(e) {
			e.preventDefault()
		});

		// 그림판 크기를 지정합니다.
		window.addEventListener('resize', resizeCanvas, false);
		resizeCanvas();

		//그림 도구 설정
		$("#pencil").click(function(event) {
			color = "#000000";
		});
		$("#eraser").click(function(event) {
			color = "#ffffff";
		});
		$("#refresh").click(function(event) {
			alert("bbbb");

			$('.container').css('display', 'block');
			html2canvas(document.querySelector(".container"), {
				canvas : canvas
			}).then(function(canvas) {
				$('.container').css('display', 'none');
				$('canvas').css('display', 'block');
				$('#capt').css('display', 'none');

				var img = new Image();
				img.src = canvas.toDataURL();
				context.drawImage(img, 0, 0);
			});
			resizeCanvas();
		});

		$(".test").click(function(event) {
			color = $(this).css("background-color");
		});
		$("#download").click(function() {
			downloadCanvas(this, 'canvas', 'practice.png');
			location.href = "demo.html"
		});

		// 이벤트 객체를 연결합니다.
		canvas.addEventListener(START_EV, function(event) {
			isDown = true;
			oldPoint = new Point(event, this);
		});
		canvas.addEventListener(END_EV, function(event) {
			isDown = false;
		});
		canvas.addEventListener(BSTART_EV, function(event) {
			isDown = false;
		});
		canvas.addEventListener(MOVE_EV, function(event) {
			context.strokeStyle = color;
			context.lineWidth = width;
			if (isDown) {
				newPoint = new Point(event, this);
				context.lineWidth = width;
				context.strokeStyle = color;
				context.beginPath();
				context.moveTo(oldPoint.x-240, oldPoint.y-170);
				context.lineTo(newPoint.x-240, newPoint.y-170);
				context.stroke();
				oldPoint = newPoint;
			}
		});
	});

	// Point 생성자 함수를 생성합니다.
	function Point(event, target) {
		this.x = event.pageX - $(target).position().left;
		this.y = event.pageY - $(target).position().top;
	}

	// 그림판 크기를 브라우저 창 사이즈로 지정합니다.
	function resizeCanvas() {
		canvas.width = $('.paint').width();
		canvas.height = $('.container').height();
		//canvas.width = window.innerWidth;
		//canvas.height = window.innerHeight-20;
	}

	function loadImg(context) {

		document.querySelector("#capt").addEventListener("click", function() {
			alert("aaaa");
			html2canvas(document.querySelector(".container"), {canvas : canvas}).then(function(canvas) {
				$('.container').css('display', 'none');
				$('canvas').css('display', 'block');
				$('#capt').css('display', 'none');
				$('.photoshop').css('display', 'block');

				var img = new Image();
				img.src = canvas.toDataURL();
				context.drawImage(img, 0, 0);
			});
		}, false);
	}

	// 작업 이미지 로컬 다운로드(.PNG)
	function downloadCanvas(link, canvasId, filename) {
		link.href = document.getElementById(canvasId).toDataURL();
		link.download = filename;
	}
</script>
</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false">
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

        </div>
           
           
			
			<div class="wrapper wrapper-content  animated fadeInRight article">
            <div class="row">
                <div class="col-lg-10 col-lg-offset-1">
                    <div class="ibox">
                        <div class="ibox-content">                            
                            <div class="text-center article-title">
                               <div id="title">
                           <h1>${scrap.scr_title}</h1>
                           <h3>${scrap.scr_subtitle }</h3>
                        </div>   
                                 <span class="text-muted"><i class="fa fa-clock-o">${scrap.scr_date}</i></span>
                              <p style="text-align: justify;">
                                 
                              </p>
                            </div>
                            ${scrap.scr_content}
                            <hr>
                            
                            <div class="row">
                                <div class="col-lg-12">
									
									<div class="text-right">
                                       <a href="scrapList"><i class="fa fa-bars"></i>목록으로</a>
                                    </div><br />  
									
                                    <h2>Comments:</h2>
                                    <div class="input-group">
                                       <textarea rows="3" class="reply_content" cols="130"></textarea>
                                       <div class="input-group-btn">
                                            <button type="button" class="btn btn-primary" style="height:55px">등록</button>
                                         </div>
                                    </div>
                                    <div class="addReply">
                              <c:forEach items="${replyList }" var="r">
                                 <div class="social-feed-box${r.reply_index }">
                                    <div class="social-avatar">
                                          <img alt="image" class="pull-left" src="upload2/${r.per_savedfile}">  
                                       <c:choose>
                                       		<c:when test = "${r.per_id == scrap.per_id }">
                                       			<a href="#" class="pull-right" value="${r.reply_index }">삭제</a>
                                       		</c:when>
                                       </c:choose>
                                       <div class="media-body">
                                          ${r.per_name }
                                          <small class="text-muted">${r.reply_date }</small>
                                       </div>
                                       <a></a>
                                    </div>
                                    <div class="social-body">
                                       ${r.reply_content }
                                    </div>
                                    <input type="hidden" class="reply_index" value="${r.reply_index }">
                                 </div>
                              </c:forEach>
                           </div>
                           <input type="hidden" class="scrap_title" value="${scrap.scr_title }">
                        </div>
                            </div>
                        </div>
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
    
    <script type="text/javascript">
	   $(function(){
	      $('.btn-primary').on('click', function(){
	         var content = $('.reply_content').val();
	         var scr_title = $('.scrap_title').val();
	         var data = "reply_content=" + content + "&scr_title=" +scr_title;
	         $.ajax({
	                method : 'get',
	                data : data,
	                url : 'insertReply',
	                success : function(resp) {
	                   $('.reply_content').val('');
	                   var output ='';
	                   output += '<div class="social-feed-box'+ resp.reply_index + '">';
	                   output += '   <div class="social-avatar">';
	                   output += '      <img alt="image" class="pull-left" src="upload2/'+resp.per_savedfile+'">';
	                   output += '      <a href="#" class="pull-right" value="' + resp.reply_index +'">삭제</a>';
	                   output += '      <div class="media-body">';
	                   output += resp.per_name 
	                   output += '         <small class="text-muted">'+ resp.reply_date+'</small>';
	                   output += '      </div>';
	                   output += '      <a></a>';
	                   output += '   </div>';
	                   output += '   <div class="social-body">';
	                   output +=    resp.reply_content 
	                   output += '   </div>';
	                   output += '   <input type="hidden" class="reply_index" value="' + resp.reply_index + '">';
	                   output += '</div>';
	
	                $('.addReply').append(output);
	                }
	             });
	         
	      })   
	      
	      $('body').on('click','.pull-right' ,function(){
	         var a = $(this).attr('value');
	         $.ajax({
	                method : 'post',
	                data : "reply_index=" + a,
	                url : 'deleteReply',
	                success : function(resp) {
	                   $('.social-feed-box'+a).remove();
	               
	                }
	             });
	      })
	   
	   });
   </script>

</body>
</html>
