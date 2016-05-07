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

<title>INSPINIA | Calendar</title>

<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/font-awesome/css/font-awesome.css" rel="stylesheet">

<link href="resources/css/plugins/iCheck/custom.css" rel="stylesheet">

<link href="resources/css/plugins/fullcalendar/fullcalendar.css" rel="stylesheet">
<link href="resources/css/plugins/fullcalendar/fullcalendar.print.css" rel='stylesheet' media='print'>

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
                       <li class="active">
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
                           <a href="updateComInfo_form"><i class="fa fa-pencil-square-o"></i> 
                              <span class="nav-label" style="font-size:17px; font-weight:bold;">기업정보관리 </span>
                           </a>
                       </li>
                       <li class="active">
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
            <div class="col-lg-9">
               <h2>
                  채용정보 캘린더 <small>Calendar</small>
               </h2>
            </div>
         </div>

         <div class="wrapper wrapper-content">
            <div class="row animated fadeInDown">
               <div class="col-lg-9">
                  <div class="ibox float-e-margins">
                     <div class="ibox-title">
                        <h5>Schedule</h5>
                     </div>
                     <div class="ibox-content">
                        <div id="calendar"></div>
                     </div>
                  </div>
               </div>
               
               
               <div class="col-lg-3">
                <div class="wrapper wrapper-content project-manager">
                    <h3>채용정보 캘린더</h4>
                    <hr style="border-top:1px solid #989191;"/>
                    <p>
                    <table>
                    <tr>
                       <td><div style="width:150px; height:30px; border:1px solid #1ab394; border-radius:3px;"></div></td>
                       <td>&nbsp; 공채일정 시작<br /></td>
                    </tr>
                    <tr>
                       <td>&nbsp;</td>
                       <td>&nbsp;</td>
                    </tr>
                    <tr>
                       <td><div style="width:150px; height:30px; border:1px solid #f8ac59; border-radius:3px;"></div></td>
                       <td>&nbsp; 공채일정 마감</td>
                    </tr>
                    </table>
                    </p>
                </div>
            </div>
            </div>
         </div>





      </div>
   </div>



   <!-- Mainly scripts -->
   <script src="resources/js/plugins/fullcalendar/moment.min.js"></script>
   <script src="resources/js/jquery-2.1.1.js"></script>
   <script src="resources/js/bootstrap.min.js"></script>
   <script src="resources/js/plugins/metisMenu/jquery.metisMenu.js"></script>
   <script src="resources/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
   
   <!-- Custom and plugin javascript -->
   <script src="resources/js/inspinia.js"></script>
   <script src="resources/js/plugins/pace/pace.min.js"></script>

   <!-- jQuery UI custom -->
   <script src="resources/js/jquery-ui.custom.min.js"></script>

   <!-- iCheck -->
   <script src="resources/js/plugins/iCheck/icheck.min.js"></script>

   <!-- Full Calendar -->
   <script src="resources/js/plugins/fullcalendar/fullcalendar.min.js"></script>

   <script>
    $(document).ready(function() {
      
        $('#external-events div.external-event').each(function() {

            // store data so the calendar knows to render an event upon drop
            $(this).data('event', {
                title: $.trim($(this).text()), // use the element's text as the event title
                stick: true // maintain when user navigates (see docs on the renderEvent method)
            });

            // make the event draggable using jQuery UI
            $(this).draggable({
                zIndex: 1111999,
                revert: true,      // will cause the event to go back to its
                revertDuration: 0  //  original position after the drag
            });

        });


        /* initialize the calendar
         -----------------------------------------------------------------*/
      
      var date = new Date();
      var d = date.getDate();
      var m = date.getMonth();
      var y = date.getFullYear();
      
      $('.fc-title').css('font-weight','bold');
      $('.fc-event').css('background','#ffffff');
      $('.fc-time').html('');
      $('.fc-title').css('color','#676a6c');
      $('.fc-title').css('font-size','15px');
      
      $('#calendar').fullCalendar({
         
         
         header : {
            left : 'prev,next today',
            center : 'title',
            right : ''
         },
         editable : false,
         droppable : true, // this allows things to be dropped onto the calendar
         drop : function() {
            // is the "remove after drop" checkbox checked?
            if ($('#drop-remove').is(':checked')) {
               // if so, remove the element from the "Draggable Events" list
               $(this).remove();
            }
         },
         events : [
            <c:forEach items="${recruitList}" var="list">
            <c:set var="date" value="${list.rec_startdate}"/>
            
               {                     
                  title: '${list.com_name} : ${list.rec_duty}', 
                  start: new Date("${fn:substring(date,0,4)}",parseInt("${fn:substring(date,5,7)}")-1, parseInt("${fn:substring(date,8,10)}")),
                  color: '#1ab394',
                  backgroundColor: '#ffffff',
                  textColor: '#676a6c',
                  fontSize: '15px',
                  fontWeight: 'bold'
               },
            </c:forEach>
               
            <c:forEach items="${recruitList}" var="list">
            <c:set var="date2" value="${list.rec_enddate}"/>
            
               {            
                  
                  title: '${list.com_name} : ${list.rec_duty}', 
                  start: new Date("${fn:substring(date2,0,4)}",parseInt("${fn:substring(date2,5,7)}")-1, parseInt("${fn:substring(date2,8,10)}")),
                  color: '#f8ac59',
                  backgroundColor: '#ffffff',
                  textColor: '#676a6c',
                  fontSize: '15px'
               },
            </c:forEach>
         ],
         
         
      });
      
            $('.fc-title').css('font-weight','bold');
            $('.fc-event').css('background','#ffffff');
            $('.fc-time').html('');
            $('.fc-title').css('color','#676a6c');
            $('.fc-title').css('font-size','15px');
      
   });
</script>

</body>
</html>