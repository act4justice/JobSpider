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
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.0-beta.1/themes/smoothness/jquery-ui.css">
    
    <script src="resources/js/jquery-2.2.2.min.js"></script>
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
   <style>
   	i:hover{
   		cursor: pointer;
   	}
   </style> 
    
    
   <script>
      $(document).ready(function() {
    	  
    	//자동완성
          var availableTags = [];
          <c:forEach items="${comList}" var="comName">
              availableTags.push('${comName}');
           </c:forEach>
           
           $( "#tf_interestcom" ).autocomplete({ 
              source : availableTags,
              autoFocus: true,
              focus : function(){
                 return false;
              },
              minLength : 1
            });
           
           $( "#comname" ).autocomplete({ 
               source : availableTags,
               autoFocus: true,
               focus : function(){
                  return false;
               },
               minLength : 1
             }); 
    	  
          //사업보고서 버튼, 자동완성 if문 추가
    	  $('.bizReportBtn').on('click',function(){
              var comname = $('#comname').val();
       		  if($.inArray(comname, availableTags) != -1){
         	   	 $.ajax({
           	   		method: 'post',
           	     	url: 'selectDartCode',
					data: "comname="+comname,
           	  		success:function(resp){
              	
              		var url = 'https://dart.fss.or.kr/dsaf001/main.do?rcpNo='+resp;
                   	window.open(url, "_blank", "top=500,left=500");
              		}
				});
    			} else{
              	   alert("없는 기업입니다.");
                }
          });
    	  
         $('.scrap_button').on("click", function() {
            var url = $(this).attr('scrapurl');
            var data = {
               'url' : url
            }
            $.ajax({
               method : 'post',
               url : 'insertScrap',
               data : data,
               success : function(resp) {
				
               }
            });

         })         
         
         //관심기업 추가 버튼, 자동완성 if문 추가
         $('#addInterestcom').on('click',function(){
               var newInterestcom = $('#tf_interestcom').val();
               if($.inArray(newInterestcom, availableTags) != -1){
            	 var loadingImg = document.getElementById("loadingImg");
              	 var divLoadBody = document.getElementById("divLoadBody");
              	 loadingImg.style.display = "";
              	 divLoadBody.style.display = "none";  
              	 var data = 'newInterestcom='+newInterestcom;
             	  $.ajax({
              	    method : 'post',
               	   url : 'addInterestcom',
               	   data : data,
               	   success: function(resp){
               	      location.href='goTemp';
               	   },
               	   error : function(){
               			 loadingImg.style.display = "none";
                 		 divLoadBody.style.display = "";  
                	     alert('이미 존재하는 기업입니다.');
                  	}                  
               	});
               } else{
            	    loadingImg.style.display = "none";
           			divLoadBody.style.display = "";  
            	    alert("없는 기업입니다.");
               }
            });
      
         $('.interestcomBtn').on('click',function(){
            var per_interestcomBtn = $(this).val();
            var data = 'per_interestcomBtn='+per_interestcomBtn;
                  $.ajax({
                     method : 'get',
                     url : 'changeTempView',
                     data : data,
                     success: function(resp){
                      location.href = "goTemp";
					}
				});            
         });
         
         $('.icon').on('click', function(){
             var comName = $(this).attr('value');
             $.ajax({
                  method : 'post',
                  url : 'deleteInterestCom',
                  data : "comName=" + comName,
                  success: function(resp){
                     location.href = "goTemp";
	             }
	          });  
          });
         
         
      });
   </script>

</head>

<body>
<div id="loadingImg" style="display:none; position:absolute; top:0; left:0; width:100%; height:100%; text-align:center; margin:0 auto; z-index:100000;">
		<table width="100%" height="100%" border="0" bgcolor="#000000">
			<tr>
				<td align="center">
			 		<div style="text-align:center;"><IMG SRC="resources/img/logo.png"></div>
			 		<div style="margin-top:20px; color:#FFF; text-align:center; font-weight:bold;"><img alt="loading" src="resources/img/loading.gif"> </div>
			 		<div style="margin-top:20px; color:#FFF; text-align:center; font-weight:bold;">L o a d i n g . . .</div>
				</td>
			</tr>
		</table>
	</div>
<!-- Loading Image -->
<div id="divLoadBody" style="display:'';">

    <div id="wrapper">
        <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
            
            	<!-- Personal회원 메뉴 -->
            	<c:if test="${not empty per_loginId }">
	                <ul class="nav metismenu" id="side-menu">
	                    <li class="nav-header">
	                        <div class="dropdown profile-element"> 
	                        	<a href="goTemp"><span><img alt="image" class="img" src="resources/img/logo_temp.png"/></span>
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
	                        	<span><img alt="image" class="img-circle" src="resources/img/logo_temp.png" /></span>
	                            <a href="goTemp2"><span class="clear"> 
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
           
           
			
		<!-- 뉴스프레이 -->
 		<div class="row wrapper border-bottom white-bg page-heading">
            <div class="col-lg-10">
                <h2 class="pageTitle">
                   <strong>뉴스프레이</strong> <small>NEWSPREY</small>
                </h2>
            </div>
            <div class="col-lg-2">

            </div>
        </div><br />	
        
        
        <div class="row">
            <div class="col-lg-8">
               	<div class="row animated fadeInDown">
	               <!--뉴스프레이  -->
	              <c:if test="${not empty per_loginId }">
	               <c:forEach items="${newsfeedList}" var="newsfeed">
	                  <div class="ibox" style="margin-left: 20px;">
	                     <div class="ibox-content" style="padding:30px;">
	                        <a href="" class="btn-link" data-toggle="modal"
	                           data-target="#registerModal">
	                           <h2>${newsfeed.nf_title}</h2>
	                           <h3>${newsfeed.nf_subtitle}</h3>
	                        </a>
	                        <div class="small m-b-xs">
	                           <span class="text-muted"><i class="fa fa-clock-o"></i>${newsfeed.nf_date}</span>
	                        </div>
	                        <p>${newsfeed.nf_content}</p>
	                        <div class="row" style="text-align:right;">
                           	  <button class="btn btn-primary btn-rounded scrap_button" data-toggle="modal" data-target="#successModal" type="button" scrapurl="${newsfeed.nf_url}">
                           	  <i class="fa fa-thumbs-o-up"></i>&nbsp;&nbsp;스크랩</button>
	                        </div>
	                     </div>
	                  </div><!-- ibox -->
	                 </c:forEach>
	               </c:if>
	               
	            </div>
            </div>
            
            
            
            <!-- 관심기업 입력칸 -->
            <div class="col-lg-4">
	            <div class="ibox float-e-margins">
	                <div class="ibox-title">
	                    <h5>Search</h5>
	                    <div class="ibox-tools">
	                        <a class="collapse-link">
	                            <i class="fa fa-chevron-up"></i>
	                        </a>
	                    </div>
	                </div>
	                <div class="ibox-content">
	                    <div id='external-events'>
	                        <h2>기업 사업보고서 검색&nbsp;&nbsp;(DART)</h2><br />
	                        <div class="input-group">
	                        	<input type="text" id="comname" placeholder="기업명" class="form-control"> 
	                        	<span class="input-group-btn"> 
	                        		<button type="button" class="btn btn-primary bizReportBtn">검색</button>
	                        	</span>
	                        </div><br /><br /><hr />
	                        
	                        <h2>관심기업추가</h2><br />
	                        <div class="input-group">
	                        	<input type="text" id="tf_interestcom" placeholder="기업명" class="form-control"> 
	                        	<span class="input-group-btn"> 
	                        		<button type="button" class="btn btn-primary" id="addInterestcom">추가</button>
	                        	</span>
	                        </div><br />
	                        
	                        <c:forEach items="${interestcomList}" var="i">
		                       <div class="comBtn${i }">
			                       <input type="button" value="${i}" style="margin-bottom:10px;" class="interestcomBtn btn btn-outline btn-primary">
			                       <i class="fa fa-times icon" value="${i}"></i>
			                       <br />
			                   </div>
		                    </c:forEach>
	                        
	                    </div>
	                </div>
	            </div>
	        </div>
            <!-- 관심기업 입력칸 -->
            
            <!-- 스크랩확인 modal -->
		   <div class="modal inmodal" id="successModal" tabindex="-1" role="dialog" aria-hidden="true">
		       <div class="modal-dialog">
		       <div class="modal-content animated bounceInRight">
		               <div class="modal-header">
		                   <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
		                   <i class="fa fa-angellist modal-icon"></i>
		                   <h4 class="modal-title check">스크랩이 완료되었습니다.</h4>
		               </div>
		               <div class="modal-footer">
		                   <button type="button" class="btn btn-danger btn-lg" data-dismiss="modal">OK</button>
		               </div>
		           </div>
		       </div>
		   </div>
            
            
            
        </div>

        </div>
        
        
    </div>
  </div>
  <script>
	var loadingImg = document.getElementById("loadingImg");
	var divLoadBody = document.getElementById("divLoadBody");
	loadingImg.style.display = "none";
	divLoadBody.style.display = "";  
	</script>  
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

</body>
</html>
