<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
      $(function() {
         $(".selectedInfo").on("click",function(){
            var rec_index = $(this).attr('recidx');
            var data = "rec_index="+rec_index;
            $.ajax({
               method :'get',
               url : 'EmployInfoDetail',
               data : data,
               dataType : 'json',
               success : function(resp){
                  $("#result_img").attr("src", "upload/"+resp.rec_savedfile);
                  $("#result_comname").html(resp.com_name);
                  $("#result_comname2").html(resp.com_name+"의 채용정보 입니다.");
                  $("#result_duty").html(resp.rec_duty);
                  $("#result_requirement").html(resp.rec_requirement);
                  $("#result_memnum").html(resp.rec_memnum);
                  $("#result_location").html(resp.rec_location);
                  $("#result_day").html(resp.rec_day);
                  $("#result_position").html(resp.rec_department+" / "+resp.rec_position);
                  $("#result_salary").html(resp.rec_salary);
                  $("#result_welfare").html(resp.rec_welfare);
                  $("#result_procedure").html(resp.rec_procedure);
                  $("#result_docs").html(resp.rec_docs);
                  $("#result_submitway").html(resp.rec_submitway);
                  $("#result_date").html(resp.rec_startdate+" ~ "+resp.rec_enddate);
                  
               }
            });
            
         });
      });       
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
                              <span class="fa arrow"></span>  
                           </a>
                           <ul class="nav nav-second-level">
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

         <!-- 채용정보리스트 -->
         <div class="row wrapper border-bottom white-bg page-heading">
                <div class="col-lg-10">
                    <h2><strong>채용정보 리스트</strong> <small>Employment Information List.</small></h2>
                    
                </div>
                <div class="col-lg-2">

                </div>
            </div><br />
         
   
   <!-- 채용정보 리스트 시작 -->   
   <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
           
           
         <!-- 반복되는 부분 -->
         <c:forEach items="${recruitList }" var="r">
           <c:if test="${r.dday > 0 }">
            <div class="col-lg-3">
                <div class="contact-box center-version">
                    <a href="profile.html" style="padding: 0px">

                        <img style="width: 300px; margin-top: 0px; height: 110px;" src="upload/${r.rec_savedfile }" />


                        <h2 class="m-b-xs" style="margin-top: 5px;"><strong>${r.com_name }</strong></h2>

                        <address class="m-t-md">
                            <strong>${r.rec_duty }</strong><br>
                                  ${r.rec_location }<br>
                        </address>

                    </a>
                    <div class="contact-box-footer">
                        <div class="m-t-xs btn-group">
                            <a class="btn btn-white" style="font-size: 15px;"><i class="fa fa-calendar"></i> D-${r.dday }</a>
                            <a class="btn btn-white selectedInfo" style="font-size: 15px;" recidx="${r.rec_index}" data-toggle="modal" data-target="#myModal5"><i class="fa fa-file-text-o"></i> 자세히</a>
                            <c:set var="com_id" value="${r.com_id}"></c:set>
                            <c:set var="com_loginId" value="${com_loginId}"></c:set>
                            <c:if test="${com_id eq com_loginId}">
                               <a class="btn btn-white" style="font-size: 15px;" href="updateEmployInfo_form?rec_index=${r.rec_index}"><i class="fa fa-star-o"></i> 수정</a>
                             </c:if>
                        </div>
                    </div>

                </div>
            </div>
               
           </c:if>
         </c:forEach>
            
            
            
        </div>
        </div>
      

      </div>
   </div>
   

   <!-- 자세히보기(modal창) -->
   <div class="modal inmodal fade" id="myModal5" tabindex="-1" role="dialog"  aria-hidden="true">
       <div class="modal-dialog modal-lg" style="width: 900px;">
           <div class="modal-content">
               <div class="modal-header">
                   <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                   <img style="width:190px;" id="result_img" src="" />
                   <h4 class="modal-title" id="result_comname"></h4>
                   <h4 id="result_comname2"></h4>
               </div>
               <div class="modal-body">
                   <div class="ibox-content">

                        <table class="table table-striped">
                            <tr>
                               <th style="border-top: 1px solid #182028; width:20%;" rowspan="3">모집부분</th>
                                <th style="border-top: 1px solid #182028; width:20%;">담당업무</th>
                                <td style="border-top: 1px solid #182028;" id="result_duty"></td>
                            </tr>
                            <tr>
                               <th style="border-top: 1px solid #182028;">자격요건</th>
                                <td style="border-top: 1px solid #182028;" id="result_requirement"></td>
                            </tr>
                            <tr>
                               <th style="border-top: 1px solid #182028;">모집인원</th>
                                <td style="border-top: 1px solid #182028;" id="result_memnum"></td>
                            </tr>
                            <tr>
                               <th style="border-top: 1px solid #182028;" rowspan="5">근무조건</th>
                               <th style="border-top: 1px solid #182028;">근무지역</th>
                                <td style="border-top: 1px solid #182028;" id="result_location"></td>
                            </tr>
                            <tr>
                               <th style="border-top: 1px solid #182028;">근무요일</th>
                                <td style="border-top: 1px solid #182028;" id="result_day"></td>
                            </tr>
                            <tr>
                               <th style="border-top: 1px solid #182028;">근무부서 / 직급</th>
                                <td style="border-top: 1px solid #182028;" id="result_position"></td>
                            </tr>
                            <tr>
                               <th style="border-top: 1px solid #182028;">급여</th>
                                <td style="border-top: 1px solid #182028;" id="result_salary"></td>
                            </tr>
                            <tr>
                               <th style="border-top: 1px solid #182028;">복리후생</th>
                                <td style="border-top: 1px solid #182028;" >
                                   <pre id="result_welfare" style="color:#676A6C; background-color:#fff; border:0px; font-family: 'open sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;"></pre>
                                </td>
                            </tr>
                            <tr>
                               <th style="border-top: 1px solid #182028;border-bottom: 1px solid #182028;" rowspan="4">기타채용정보</th>
                                <th style="border-top: 1px solid #182028;">전형절차</th>
                                <td style="border-top: 1px solid #182028;" id="result_procedure"></td>
                            </tr>
                            <tr>
                               <th style="border-top: 1px solid #182028;">제출서류</th>
                                <td style="border-top: 1px solid #182028;" id="result_docs"></td>
                            </tr>
                            <tr>
                               <th style="border-top: 1px solid #182028;">접수방법</th>
                                <td style="border-top: 1px solid #182028;" id="result_submitway"></td>
                            </tr>
                            <tr>
                               <th style="border-top: 1px solid #182028;border-bottom: 1px solid #182028;">접수기간</th>
                                <td style="border-top: 1px solid #182028;border-bottom: 1px solid #182028;" id="result_date"></td>
                            </tr>
                        </table>
                          </div>
               </div>
   
               <div class="modal-footer">
                   <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
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
   
   <!-- SUMMERNOTE -->
   <script src="resources/js/plugins/summernote/summernote.min.js"></script>

   <!-- Data picker -->
   <script src="resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>
   

</body>
</html>