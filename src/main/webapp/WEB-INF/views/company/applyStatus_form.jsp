<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>INSPINIA | ApplyStatus</title>

<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="resources/css/plugins/iCheck/custom.css" rel="stylesheet">
<link href="resources/css/animate.css" rel="stylesheet">
<link href="resources/css/style.css" rel="stylesheet">

<link href="resources/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">

<script src="resources/js/jquery-2.2.2.min.js"></script>

   <script>
      $(function() {         
         // 지원자들에게 email
         $('#btn-email').on('click', function(){
            var loadingImg = document.getElementById("loadingImg");
              var divLoadBody = document.getElementById("divLoadBody");
              loadingImg.style.display = "";
              divLoadBody.style.display = "none"; 
            var list = [];
            for(var i=0; i<"${applyList.size()}"; i++) {
               if($("#c"+i).is(":checked")){
                  list.push({"per_id":$("#c"+i).val(), "rec_index":$("#c"+i).attr('recIndex')});
               }
            }
            
            var data = JSON.stringify({"data" : {'list' : list}});
            
            $.ajax({
               method : 'post',
               url : 'sendEmailToApplicants',
               data : data,
               contentType : "application/json;charset=UTF-8",
               success : function(resp) {
                  
               },
               error: function(){
                  loadingImg.style.display = "none";
                  divLoadBody.style.display = "";  
               }
            });
         });
         
         
         $(".resumeView").on("click",function(){
            var per_id = $(this).attr('perId');
            $.ajax({
               method :'get',
               url : 'applyStatusResume',
               data : "per_id="+per_id,
               dataType : 'json',
               contentType: "application/json;charset=utf-8",
               success : function(resp){
                  $("#result_per_name").html(resp.personal.per_name+"님의 이력서/자기소개서");
                  $("#result_image").attr("src", "upload2/"+resp.personal.per_savedfile);
                  $("#result_per_name2").html(resp.personal.per_name);
                  $("#result_address").html("우편번호- "+resp.personal.per_zipcode+"<br>상세주소- "+resp.personal.per_address);
                  $("#result_per_phone").html(resp.personal.per_phone);
                  $("#result_per_email").html(resp.personal.per_email);
                  
                  var result_edu="";
                  if(resp.eduList.length != 0){
                     for(var i=0; i<resp.eduList.length; i++){
                        result_edu +="<tr class='edu_classTr'>";
                        result_edu +="<td>";
                        result_edu +="   <div class='input-group date'>";
                        result_edu +="      <i class='fa fa-calendar'>&nbsp&nbsp</i>"+resp.eduList[i].edu_startdate+"&nbsp~&nbsp"+resp.eduList[i].edu_enddate;
                        result_edu +="   </div>";
                        result_edu +="</td>";
                        result_edu +="<td style='vertical-align: middle; text-align: center;'>";
                        result_edu +=   resp.eduList[i].edu_scname;
                        result_edu +="</td>";
                        result_edu +="<td style='vertical-align: middle; text-align: center;'>";
                        result_edu += resp.eduList[i].edu_major;
                        result_edu +="</td>";
                        result_edu +="<td style='vertical-align: middle; text-align: center;'>";
                        result_edu += resp.eduList[i].edu_graduation;
                        result_edu +="</td>";
                        result_edu +="</tr>";
                     }
                  }
                  $("#result_edu").html(result_edu);
                  
                  var result_car="";
                  if(resp.carList.length != 0){
                     for(var i=0; i<resp.carList.length; i++){
                        result_car +="<tr class='car_classTr'>";
                        result_car +="<td>";
                        result_car +="   <div class='input-group date'>";
                        result_car +="      <i class='fa fa-calendar'>&nbsp&nbsp</i>"+resp.carList[i].car_startdate+"&nbsp~&nbsp"+resp.carList[i].car_enddate;
                        result_car +="   </div>";
                        result_car +="</td>";
                        result_car +="<td style='vertical-align: middle; text-align: center;'>"+resp.carList[i].car_comname+"</td>";
                        result_car +="<td style='vertical-align: middle; text-align: center;'>"+resp.carList[i].car_department+"</td>";
                        result_car +="<td style='vertical-align: middle; text-align: center;'>"+resp.carList[i].car_duty+"</td>";
                        result_car +="</tr>";
                     }
                  }
                  $("#result_car").html(result_car);
                  
                  var result_cer="";
                  if(resp.cerList.length != 0){
                     for(var i=0; i<resp.cerList.length; i++){
                        result_cer +="<tr class='cer_classTr'>";
                        result_cer +="<td style='vertical-align: middle; text-align: center;'>"+resp.cerList[i].cer_cername+"</td>";
                        result_cer +="<td>";
                        result_cer +="   <div class='input-group date'>";
                        result_cer +="      <i class='fa fa-calendar'>&nbsp&nbsp</i>"+resp.cerList[i].cer_date;
                        result_cer +="   </div>";
                        result_cer +="</td>";
                        result_cer +="<td style='vertical-align: middle; text-align: center;'>"+resp.cerList[i].cer_grade+"</td>";
                        result_cer +="</tr>";
                     }
                  }
                  $("#result_cer").html(result_cer);
                  
                  var result_awa="";
                  if(resp.awaList.length != 0){
                     for(var i=0; i<resp.awaList.length; i++){
                        result_awa +="<tr class='awa_classTr'>";
                        result_awa +="<td style='vertical-align: middle; text-align: center;'>"+resp.awaList[i].awa_name;
                        result_awa +="</td>";
                        result_awa +="<td style='vertical-align: middle; text-align: center;'>"+resp.awaList[i].awa_detail
                        result_awa +="</td>";
                        result_awa +="<td>";
                        result_awa +="<div class='input-group date'>";
                        result_awa +="   <i class='fa fa-calendar'>&nbsp&nbsp</i>"+resp.awaList[i].awa_date;
                        result_awa +="</div>";
                        result_awa +="</td>";
                        result_awa +="</tr>";
                     }
                  }
                  $("#result_awa").html(result_awa);
                  
                  var result_intro="";
                  if(resp.introduceList.length != 0){
                     for(var i=0; i<resp.introduceList.length; i++){
                        result_intro +="<div class='ibox-title'>"+resp.introduceList[i].intro_title;
                        result_intro +="</div>";
                        result_intro +="<div class='ibox-content no-padding'>";
                        result_intro +="    <pre style='width:100%; height:auto; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;'>"+resp.introduceList[i].intro_contents+"</pre>";
                        result_intro +="</div>";
                     }
                  }
                  $("#result_intro").html(result_intro);
               }, 
               error : function(request,status,error){
                       alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                    }
            });   
         }); 
      });       
   </script>

</head>

<body>
<div id="loadingImg" style="position:absolute; top:0; left:0; width:100%; height:100%; text-align:center; margin:0 auto; z-index:100000;">
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
<div id="divLoadBody" style="display:none;">


   <div id="wrapper">
      <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
            
               <!-- Personal회원 메뉴 -->
               <c:if test="${not empty per_loginId }">
                   <ul class="nav metismenu" id="side-menu">
                       <li class="nav-header">
                           <div class="dropdown profile-element"> 
                              <span><img alt="image" class="img-circle" src="resources/img/profile_small.jpg" /></span>
                               <a href="toTemp"><span class="clear"> 
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
                           <ul class="nav nav-second-level">
                               <li style="font-size:15px;"><a href="employInfoList_com">채용정보리스트</a></li>
                              <li style="font-size:15px;"><a href="goEmploymentReg">채용정보등록</a></li>
                           </ul>
                       </li>
                       <li class="active">
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
                    <h2><strong>지원형황 리스트</strong> <small>Apply Status List.</small></h2>
                </div>
                <div class="col-lg-2">

                </div>
            </div><br />
         
   
         <!-- 지원현황 리스트 시작 -->   
         <div class="wrapper wrapper-content animated fadeInRight">
              <div class="row">
              
                 <!-- 반복되는 부분  -->
                 <c:forEach items="${applyList}" var="a" varStatus="status">
                     <div class="col-lg-4">
                         <div class="contact-box">
                            <div class="i-checks">
                               <label class=""> 
                                  <div class="icheckbox_square-green" style="position: relative;">
                                     <input type="checkbox" id="c${status.index}" class="c${status.index}" value="${a.per_id}" recIndex="${a.rec_index}" style="position: absolute; opacity: 0;">
                                     <ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; 
                                     display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; border: 0px; 
                                     opacity: 0; background: rgb(255, 255, 255);">
                                     </ins>
                                  </div><i></i>
                               </label>
                            </div>
                            
                            
                            <!-- 
                            <div class="checkbox checkbox-info checkbox-circle">
                                 <input id="c${status.index}" class="c${status.index}" type="checkbox" value="${a.per_id}" recIndex="${a.rec_index}"> 
                                 <label for="checkbox8"></label>
                             </div>
                             -->
                            
                            
                            
                             <div class="col-sm-4">
                                  <div class="text-center">
                                   <img class="img-circle m-t-xs img-responsive" src="upload2/${a.per_savedfile}" />
                                </div>   
                             </div>
                             <div class="col-sm-4">
                                 <h3><strong>지원자 - ${a.per_name}</strong></h3>
                                 <p>지원업무 - ${a.rec_duty }</p>
                                 <%-- <a class="btn btn-primary resumeView" perId="${a.per_id }" data-toggle="modal" data-target="#resumeModal">이력서 보기</a> --%> 
                             </div>
                             <div class="col-sm-4">
                                <a class="btn btn-primary resumeView" perId="${a.per_id }" data-toggle="modal" data-target="#resumeModal"><i class="fa fa-file-text"></i>&nbsp;&nbsp;이력서 보기</a>
                             </div>
                             <div class="clearfix"></div>
                         </div>
                     </div>
                  </c:forEach>
                  <!-- 반복되는 부분  끝 -->
              </div>
          </div>
                  
                  <!-- email button -->
                  <div class="text-center">
                     <button id="btn-email" class="btn btn-primary btn-lg" type="button"><i class="fa fa-envelope"></i>&nbsp;&nbsp;E-Mail</button>
                  </div>
                  
                  <!-- 이력서 자개소개서 모달  -->
                 <div class="modal inmodal fade" id="resumeModal" tabindex="-1" role="dialog"  aria-hidden="true">
                     <div class="modal-dialog modal-lg" style="width:900px;">
                         <div class="modal-content">
                             <div class="modal-header">
                                 <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                 <h4 class="modal-title" id="result_per_name"></h4>
                             </div>
                             <div class="modal-body">
                                
                                 <div class="ibox float-e-margins">
                              <div class="ibox-title">
                                 <h5>기본정보</h5>
                              </div>
                              <div class="ibox-content">
         
                                 <table class="table table-bordered">
                                    <tr>
                                       <td rowspan="4" width="230px" height="300px" style="text-ailgn: center; vertical-align: bottom; padding: 25px;">
                                          <img style="width:230px;" id="result_image" src="" />
                                       </td>
                                       <th style="vertical-align: middle; text-align: center; background-color: #F5F5F6; width: 15%;">이 름</th>
                                       <td style="vertical-align: middle; width: 65%;" id="result_per_name2"></td>
                                    </tr>
                                    <tr>
                                       <th style="vertical-align: middle; text-align: center; background-color: #F5F5F6;">주 소</th>
                                       <td  style="vertical-align: middle;" id="result_address"></td>
                                    </tr>
                                    <tr>
                                       <th style="vertical-align: middle; text-align: center; background-color: #F5F5F6;">휴 대 폰</th>
                                       <td style="vertical-align: middle;" id="result_per_phone"></td>
                                    </tr>
                                    <tr>
                                       <th style="vertical-align: middle; text-align: center; background-color: #F5F5F6;">이 메 일</th>
                                       <td style="vertical-align: middle;" id="result_per_email"></td>
                                    </tr>
                                 </table>
                              </div>
                           </div>
                           
                           <!-- 학력사항 -->
                           <div class="ibox float-e-margins">
                              <div class="ibox-title">
                                 <h5>학력사항</h5>
                              </div>
                              <div class="ibox-content">
         
                                 <table class="table table-bordered">
                                    <thead>
                                       <tr>
                                          <td style="width: 30%; vertical-align: middle; text-align: center;">재학기간</td>
                                          <td style="vertical-align: middle; text-align: center;">학교명</td>
                                          <td style="vertical-align: middle; text-align: center;">전공</td>
                                          <td style="vertical-align: middle; text-align: center;">졸업여부</td>
                                       </tr>
                                    </thead>
                                    <tbody class="edu_addTr" id="result_edu">
                                       <!-- 학력사항 List 뿌려주기 -->
                                    </tbody>
                                 </table>
                              </div>
                           </div>
                           <!-- 학력사항 -->
                           
                           <!-- 경력사항 -->
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
                                    <tbody class="car_addTr" id="result_car">
                                       <!-- 경력사항 List뿌려주기 -->
                                    </tbody>
                                 </table>
                              </div>
                           </div>
                           <!-- 경력사항 -->
                           
                           <!-- 자격증/면허증 -->
                           <div class="ibox float-e-margins">
                              <div class="ibox-title">
                                 <h5>자격증/면허증</h5>
                              </div>
                              <div class="ibox-content">

                                 <table class="table table-bordered">
                                    <thead>
                                       <tr>
                                          <td style="vertical-align: middle; text-align: center;">자격증/면허증</td>
                                          <td style="vertical-align: middle; text-align: center;">취득일</td>
                                          <td style="vertical-align: middle; text-align: center;">점수/등급</td>
                                       </tr>
                                    </thead>
                                    <tbody class="cer_addTr" id="result_cer">
                                       <!-- 자격증 List뿌려주기 -->
                                    </tbody>
                                 </table>
                              </div>
                           </div>
                           <!-- 자격증/면허증 -->
                           
                           <!-- 수상내역/공모전 -->
                           <div class="ibox float-e-margins">
                              <div class="ibox-title">
                                 <h5>수상내역/공모전</h5>
                              </div>
                              <div class="ibox-content">
                              
                                 <table class="table table-bordered">
                                    <thead>
                                       <tr>
                                          <td style="width: 30%; vertical-align: middle; text-align: center;">수상내역/공모전</td>
                                          <td style="vertical-align: middle; text-align: center;">상세내용</td>
                                          <td style="vertical-align: middle; text-align: center;">수상일</td>
                                       </tr>
                                    </thead>
                                    <tbody class="awa_addTr" id="result_awa">
                                       <!-- 수상내역 공모전 List뿌려주기 -->
                                    </tbody>
                                 
                                 </table>
                              </div>
                           </div>
                           <!-- 수상내역/공모전 -->
                           
                           <!-- 자기소개서 -->
                           <div class="ibox float-e-margins">
                              <div class="ibox-title">
                                 <h5>자기소개서</h5>
                              </div>
                              <div class="ibox-content">
                                             <div id="result_intro">
                                             
                                             </div>
                                         </div>
                                    </div>
                                    <!-- 자기소개서 -->
                             </div>
                             <div class="modal-footer">
                                 <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
                             </div>
                         </div>
                     </div>
                 </div>
                 <!-- 이력서 자개소개서 모달 테스트 -->
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

    <!-- Custom and plugin javascript -->
    <script src="resources/js/inspinia.js"></script>
    <script src="resources/js/plugins/pace/pace.min.js"></script>
   
   <!-- SUMMERNOTE -->
   <script src="resources/js/plugins/summernote/summernote.min.js"></script>

   <!-- Data picker -->
   <script src="resources/js/plugins/datapicker/bootstrap-datepicker.js"></script>
   
   <!-- iCheck -->
   <script src="resources/js/plugins/iCheck/icheck.min.js"></script>
   <script>
       $(document).ready(function () {
           $('.i-checks').iCheck({
               checkboxClass: 'icheckbox_square-green',
               radioClass: 'iradio_square-green',
           });
       });
   </script>
</body>
</html>