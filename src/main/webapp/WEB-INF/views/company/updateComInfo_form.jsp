<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>INSPINIA | Newspeed</title>

<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/font-awesome/css/font-awesome.css"
	rel="stylesheet">

<!-- Toastr style -->
<link href="resources/css/plugins/toastr/toastr.min.css"
	rel="stylesheet">

<!-- Gritter -->
<link href="resources/js/plugins/gritter/jquery.gritter.css"
	rel="stylesheet">

<link href="resources/css/animate.css" rel="stylesheet">
<link href="resources/css/style.css" rel="stylesheet">

<script src="resources/js/jquery-2.2.2.min.js"></script>

<script>
   function CheckPassword(upw){
       if(!/^[a-zA-Z0-9]{6,16}$/.test(upw)){ 
           return "error";
       }
       var chk_num = upw.search(/[0-9]/g); 
       var chk_eng = upw.search(/[a-z]/ig); 

       if(chk_num < 0 || chk_eng < 0){ 
           return "error";
       }
       return "confirm";
   } 
   
      $(document).ready(function() {
         /* save change button */
         $('#formCheck').on('click', function(){
            var message = "";
            var checkpwd = CheckPassword($('#pw').val());
            
            if($('#pw').val().trim().length == 0 || $('#pw').val().length>16 || $('#pw').val().length<6 ||checkpwd=='error'){
               message = "비밀번호는 6~16자로<br /> 영문숫자 혼용하여 입력해 주세요.";
               $('.error').html(message);
               $('#errorModal').modal('toggle');
               return;
            }
            
            else if($('#pw').val() != $('#pwCheck').val()){
               message = "비밀번호가 일치하지 않습니다.";
               $('.error').html(message);
               $('#errorModal').modal('toggle');
               return;
            }
            else if ($('#com_num').val().trim().length == 0 || $('#com_num').val().length != 5 || isNaN($('#com_num').val())) {
               message = "사업자 번호를 입력하세요.";
               $('.error').html(message);
               $('#errorModal').modal('toggle');
               return;
            }
            else if ($('#com_name').val().trim().length == 0) {
               message = "회사명을 입력하세요.";
               $('.error').html(message);
               $('#errorModal').modal('toggle');
               return;
            }
            else if ($('#com_mgrName').val().trim().length == 0) {
               message = "담당자를 입력하세요.";
               $('.error').html(message);
               $('#errorModal').modal('toggle');
               return;
            }
            else if ($('#com_phone').val().trim().length == 0) {
               message = "연락처를 입력하세요.";
               $('.error').html(message);
               $('#errorModal').modal('toggle');
               return;
            }
            else if ($('#com_zipcode').val().trim().length == 0) {
               message = "우편 번호를 입력하세요.";
               $('.error').html(message);
               $('#errorModal').modal('toggle');
               return;
            }
            else if ($('#com_address').val().trim().length == 0) {
               message = "주소를 입력하세요.";
               $('.error').html(message);
               $('#errorModal').modal('toggle');
               return;
            }
            else if ($('#com_email').val().trim().length == 0) {
               message = "email을 입력하세요.";
               $('.error').html(message);
               $('#errorModal').modal('toggle');
               return;
            }
            else {
               $('#update').submit();
            }
         });  
         
         /* 탈퇴 modal confirm */
         $('#confirm').on('click', function(){
            var pwd = $('#pwd').val();
            pwd = "pwd="+pwd;
            $.ajax({
               method : "get",
               url : "secede",
               data : pwd , 
               success : function(){
                  location.href = "main";
               },
               error : function(){
                  $('#errorModal').modal('toggle');
               }
            }); 
         });
         
         /* 우편번호 검색 처리 */
            $('#zipcode_search').on('click', function(){
                var keyword = $('#zipcode_keyword').val();
                if(keyword.trim().length == 0) {
                   $('#zipcode_keyword').attr('placeholder','검색할 동 이름을 입력 후 Search버튼 클릭');
                   return;
                }
                var data = "keyword="+keyword;
                $.ajax({
                   method : "get",
                   url : "searchZipcode",
                   data : data,
                   dataType : 'json',
                   success : function(resp) {
                      var output = '';
                      var list = resp;
                      if(list.length != 0){
                          output += '<table class="table table-striped" style="margin-left:25px;"><tr>';
                          output += '<th align="center" style="width: 50px;">선택</th>';   
                          output += '<th align="center" style="width: 150px;">우편번호</th>';   
                         output += '<th align="center" style="width: 350px;">주소</th></tr>';
                          
                         for(var i=0; i<list.length; i++){
                            output += '<tr>';
                            output += '<td><input type="radio" id="selected_zipcode'+i+'" name="selected_zipcode" zipcode="'+list[i].zipcode+'" address="'+list[i].area1+' '+list[i].area2+' '+list[i].area3+' '+list[i].area4+'"/></td>';
                            output += '<td align="left">'+list[i].zipcode+'</td>';
                            output += '<td align="left">'+list[i].area1+' '+list[i].area2+' '+list[i].area3+' '+list[i].area4+'</td>';
                            output += '</tr>';
                           }
                      }else{
                         output += '';
                      }
                      output += '</table>';
                      output += '<div class="mldal-dialog" style="margin-left:40px;">'
                      output += '<div class="modal-footer">'
                      output += '<button id="zipcode_select" type="button" class="btn btn-primary" data-dismiss="modal">Select</button>';
                      output += '</div></div>'
                      
                      $('#postResult').html(output);
                      $('#zipcode_select').on('click', function(){
                        var radio = document.getElementsByName('selected_zipcode');
                         for(var a in radio){
                            if(radio[a].checked==true){
                               var zip = $('#selected_zipcode'+a).attr('zipcode');
                               var addr = $('#selected_zipcode'+a).attr('address');
                               $('#com_zipcode').attr('value',zip);
                               $('#com_address').attr('value',addr);
                               $('#per_zipcode').attr('value',zip);
                               $('#per_address').attr('value',addr);
                            }
                         }
                      });
                   }
                });
             });
            /* 우편번호 검색 처리 끝 */
            
            /* 사업자번호 인증 처리 */
            $('#comnum_search').on('click', function(){
               var keyword = $('#comnum_keyword').val();
               if(keyword.trim().length == 0) {
                    $('#comnum_keyword').attr('placeholder','인증할 등록번호를 입력 후 인증버튼 클릭');
                    return;
                 }
               var data = "keyword="+keyword;
               $.ajax({
                    method : "get",
                    url : "searchComnum",
                    data : data,
                    dataType : 'text',
                    success : function(resp){
                       var output = '';
                       if(resp === "success"){
                          var comnum = keyword;
                          output += '<button comnum="'+comnum+'" id="comnum_ok" type="button" class="btn btn-primary" style="margin-left:305px" data-dismiss="modal">인증완료</button>';
                      $('#comnum_result').html("사업자 등록번호 인증완료"+output).css('color','#ff3333');
                   } else if(resp === "fail"){
                     $('#comnum_keyword').focus();
                     $('#comnum_result').html("등록된 사업자 인증번호가 없습니다.").css('color','#ff3333');
                   }
                       $('#comnum_ok').on('click', function(){
                           var comnum = $(this).attr('comnum');
                           $('#com_num').attr('value',comnum);
                        });
                       
                    }
                  });
                  
            });
            /* 사업자번호 인증 처리 끝 */
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
	                    <li>
	                        <a href="applyStatusForm"><i class="fa fa-user"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">지원현황 </span>
	                        </a>
	                    </li>
	                    <li class="active">
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
			</div>
			
			<div class="row wrapper border-bottom white-bg page-heading">
				<div class="col-lg-10">
					<h2>
						기업 정보 수정<small>&nbsp;&nbsp;Account Settings</small>
					</h2>

				</div>
				<div class="col-lg-2"></div>
			</div>

			<!-- 기업 정보 수정 시작 -->
			<div class="wrapper wrapper-content animated fadeInRight">
				<div class="row">
					<div class="col-lg-6">
						<div class="ibox float-e-margins">
							<div class="ibox-content">

								<form id="update" action="updateComInfo" method="post"
		                           class="form-horizontal">
		
		                           <!-- Id 시작 -->
		                           <div class="form-group">
		                              <label class="col-sm-3 control-label">ID</label>
		
		                              <div class="col-sm-9">
		                                 <input type="text" readonly class="form-control"
		                                    name="com_id" value="${company.com_id}">
		                              </div>
		                           </div>
		                           <div class="hr-line-dashed"></div>
		                           <!-- Id 끝 -->
		
		                           <!-- pw 시작 -->
		                           <div class="form-group">
		                              <label class="col-sm-3 control-label">Password</label>
		
		                              <div class="col-sm-9">
		                                 <input id="pw" type="password" class="form-control"
		                                    name="com_pwd">
		                              </div>
		                           </div>
		                           <div class="hr-line-dashed"></div>
		                           <!-- pw 끝 -->
		
		                           <!-- pw 재확인 시작 -->
		                           <div class="form-group">
		                              <label class="col-sm-3 control-label">Password Check</label>
		
		                              <div class="col-sm-9">
		                                 <input id="pwCheck" type="password" class="form-control">
		                              </div>
		                           </div>
		                           <div class="hr-line-dashed"></div>
		                           <!-- pw 재확인 끝 -->
		
		                           <!-- 사업자 번호 시작 -->
		                           <div class="form-group">
		                              <label class="col-sm-3 control-label">Employer
		                                 Identification Number</label>
		
		                              <div class="col-sm-4">
		                                 <input id="com_num" type="text" class="form-control" data-toggle="modal" data-target="#searchOfCompany"
		                                    name="com_num" value="${company.com_num}">
		                              </div>
		                              <button type="button" class="btn btn-primary btn-rounded btn-outline"
		                                 data-toggle="modal" data-target="#searchOfCompany"
		                                 style="width: 100px;">인증 확인</button>
		                           </div>
		                           <div class="hr-line-dashed"></div>
		                           <!-- 사업자 번호 끝 -->
		
		                           <!-- name 시작 -->
		                           <div class="form-group">
		                              <label class="col-sm-3 control-label">Name</label>
		
		                              <div class="col-sm-9">
		                                 <input id="com_name" type="text" class="form-control" name="com_name"
		                                    value="${company.com_name}">
		                              </div>
		                           </div>
		                           <div class="hr-line-dashed"></div>
		                           <!-- name 끝 -->
		
		                           <!-- 담당자 시작 -->
		                           <div class="form-group">
		                              <label class="col-sm-3 control-label">The person in
		                                 charge</label>
		
		                              <div class="col-sm-9">
		                                 <input id="com_mgrName" type="text" class="form-control" name="com_mgrName"
		                                    value="${company.com_mgrName}">
		                              </div>
		                           </div>
		                           <div class="hr-line-dashed"></div>
		                           <!-- 담장자 끝 -->
		
		                           <!-- phone 시작 -->
		                           <div class="form-group">
		                              <label class="col-sm-3 control-label">Phone</label>
		
		                              <div class="col-sm-9">
		                                 <input id="com_phone" type="text" class="form-control" name="com_phone"
		                                    value="${company.com_phone}">
		                              </div>
		                           </div>
		                           <div class="hr-line-dashed"></div>
		                           <!-- phone 끝 -->
		
		                           <!-- 우편번호 시작 -->
		                           <div class="form-group">
		                              <label class="col-sm-3 control-label">Zipcode</label>
		
		                              <div class="col-sm-4">
		                                 <input id="com_zipcode" type="text" class="form-control" data-toggle="modal" data-target="#searchOfZipcode"
		                                    name="com_zipcode" value="${company.com_zipcode}">
		                              </div>
		                              <button type="button" class="btn btn-primary btn-rounded btn-outline"
		                                 data-toggle="modal" data-target="#searchOfZipcode">
		                               	  우편번호 검색</button>
		                           </div>
		                           <div class="hr-line-dashed"></div>
		                           <!-- 우편번호 끝 -->
		
		                           <!-- address 시작 -->
		                           <div class="form-group">
		                              <label class="col-sm-3 control-label">Address</label>
		
		                              <div class="col-sm-9">
		                                 <input id="com_address" type="text" class="form-control"
		                                    name="com_address" value="${company.com_address}">
		                              </div>
		                           </div>
		                           <div class="hr-line-dashed"></div>
		                           <!-- address 끝 -->
		
		                           <!-- email 시작 -->
		                           <div class="form-group">
		                              <label class="col-sm-3 control-label">Email</label>
		
		                              <div class="col-sm-9">
		                                 <input id="com_email" type="text" class="form-control" name="com_email"
		                                    value="${company.com_email}">
		                              </div>
		                           </div>
		                           <div class="hr-line-dashed"></div>
		                           </form><br />
		                           <!-- email 끝 --><br />
		                           <div class="form-group text-center">
			                           <a href="goTemp2"><button class="btn btn-primary btn-rounded btn-outline btn-lg">취소</button></a>
			                           <button id="formCheck" class="btn btn-primary btn-rounded btn-lg">저장</button>
			                           <button class="btn btn-danger btn-rounded btn-outline btn-lg" data-toggle="modal" data-target="#confirmModal">탈퇴</button>
	                        		</div>
	                           
							</div>
						</div>
						
						
						
					</div>
				</div>
			</div>
			<!-- 기업 정보 수정 끝 -->
		</div>
	</div>
	
	<!-- 우편번호 검색 -->
       <div class="modal inmodal" id="searchOfZipcode" tabindex="-1" role="dialog" aria-hidden="true">
           <div class="modal-dialog">
           <div class="modal-content animated bounceInRight">
                   <div class="modal-header">
                       <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                       <i class="fa fa-laptop modal-icon"></i>
                       <h4 class="modal-title">우편번호 검색</h4>
                   </div>
                   <div class="modal-body">
                       <div class="form-group">
                       	<label>ex)삼성2동</label> 
                       	<input type="text" id="zipcode_keyword" placeholder="동이름 검색" class="form-control">
                       </div>
                   </div>
                   <div class="modal-footer">
                       <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
                       <button id="zipcode_search" type="button" class="btn btn-primary">Search</button>
                   </div>
                   
                   <div id="postResult" style="width: 550px;"></div>
               </div>
           </div>
       </div>
       
       <!-- 사업자 등록번호 검색 -->
	<div class="modal inmodal" id="searchOfCompany" tabindex="-1" role="dialog" aria-hidden="true">
              <div class="modal-dialog">
              <div class="modal-content animated bounceInRight">
                      <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                          <i class="fa fa-laptop modal-icon"></i>
                          <h4 class="modal-title">사업자 등록 번호 인증</h4>
                          <small class="font-bold">corporate registration number authentication.</small>
                      </div>
                      <div class="modal-body">
                          <div class="form-group">
                          	<label>인증할 사업자 등록번호를 작성해 주세요.</label> 
                          	<input type="text" id="comnum_keyword" placeholder="사업자 등록 번호" class="form-control">
                          </div>
                          <div class="form-group">
                          	<label id="comnum_result"></label>
                          </div>
                      </div>
                      <div class="modal-footer">
                          <button type="button" class="btn btn-white" data-dismiss="modal">닫기</button>
                          <button id="comnum_search" type="button" class="btn btn-primary">인증</button>
                      </div>
                  </div>
              </div>
          </div>
          
          <!-- 탈퇴 확인 modal -->
          <div class="modal inmodal" id="confirmModal" tabindex="-1" role="dialog" aria-hidden="true">
              <div class="modal-dialog">
              <div class="modal-content animated bounceInRight">
                      <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                          <!-- <i class="fa fa-laptop modal-icon"></i> -->
                          <i class="fa fa-check-circle modal-icon"></i>
                          <h4 class="modal-title">정말 탈퇴하시겠습니까?</h4>
                      </div>
                      <div class="modal-body">
                       <div class="form-group">
                       	<input type="password" id="pwd" placeholder="비밀 번호를 입력하세요." class="form-control">
                       </div>
                   </div>
                      <div class="modal-footer">
                          <button type="button" class="btn btn-white" data-dismiss="modal">cancel</button>
                          <button id="confirm" type="button" class="btn btn-primary" data-dismiss="modal">confirm</button>
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
                      <h4 class="modal-title error">비밀번호를 다시 확인하세요</h4>
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