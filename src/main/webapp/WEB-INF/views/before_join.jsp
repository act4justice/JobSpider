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

<title>INSPINIA | Dashboard</title>

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

<!-- Ladda style -->
<link href="resources/css/plugins/ladda/ladda-themeless.min.css" rel="stylesheet">

<script src="resources/js/jquery-2.2.2.min.js"></script>

<script>

//비밀번호 영문숫자혼용체크
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

//아이디 영문숫자혼용체크
function CheckId(uid){
    if(!/^[a-zA-Z0-9]{4,15}$/.test(uid)){ 
        return "error";
    }
    var chk_num = uid.search(/[0-9]/g); 
    var chk_eng = uid.search(/[a-z]/ig); 

    if(chk_num < 0 || chk_eng < 0){ 
        return "error";
    }
    return "confirm";
} 

        $(document).ready(function(){
        	
        	//개인 회원가입
            $('#per_register').on('click', function(){
				var per_id = $('#per_id').val();
				var per_pwd = $('#per_pwd').val();
				var per_pwd_check = $('#per_pwd_check').val();
				var per_name = $('#per_name').val();
				var per_phone = $('#per_phone').val();
				var per_email = $('#per_email').val();
				var per_zipcode = $('#per_zipcode').val();
				var per_address = $('#per_address').val();
				var message = "";
				var checkpwd = CheckPassword(per_pwd);
				var checkId = CheckId(per_id);
				
				if(per_id.trim().length == 0 || per_id.length>15 || per_id.length<4 || checkId=="error"){
					message = "아이디는 4~15자로<br /> 영문숫자 혼용하여 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
				
				else if(per_pwd.trim().length == 0 || per_pwd.length>16 || per_pwd.length<6 || checkpwd=="error"){
					message = "비밀번호는 6~16자로<br /> 영문숫자 혼용하여 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
				
				else if(per_pwd != per_pwd_check){
					message = "비밀번호가 일치하지 않습니다.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
				
				else if(per_name.trim().length == 0 || per_name.length>15 || per_name.length<2){
					message = "이름은 2~15자로 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
				
				else if(per_phone.trim().length == 0){
					message = "전화번호를 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
				
				else if(per_email.trim().length == 0){
					message = "이메일을 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
				
				else if(per_zipcode.trim().length == 0){
					message = "우편번호를 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
				
				else if(per_address.trim().length == 0){
					message = "주소를 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
				
				$.ajax({
	               method: 'post',
	               url: 'per_idCheck',
	               data: "per_id="+per_id,
	               success: function(resp){
	                  if(resp=='success'){
	                     register.submit();
	                  }else{
	                     message = "이미 존재하는 아이디입니다.";
	                     $('.check').html(message);
	                     $('#errorModal').modal('toggle');
	                     return;
	                  }   
	               }
	            });
            });
            
            //기업 회원가입
            $('#com_register').on('click', function(){
            	var com_id = $('#com_id').val();
            	var com_pwd = $('#com_pwd').val();
            	var com_pwd_check = $('#com_pwd_check').val();
            	var com_num = $('#com_num').val();
            	var com_name = $('#com_name').val();
            	var com_mgrName = $('#com_mgrName').val();
            	var com_zipcode = $('#com_zipcode').val();
            	var com_address = $('#com_address').val();
            	var com_phone = $('#com_phone').val();
            	var com_email = $('#com_email').val();
            	var message = "";
            	var checkpwd = CheckPassword(com_pwd);
				var checkId = CheckId(com_id);
            	
            	if(com_id.trim().length == 0 || com_id.length>15 || com_id.length<4 || checkId=="error"){
					message = "아이디는 4~15자로<br /> 영문숫자 혼용하여 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
            	
            	else if(com_pwd.trim().length == 0 || com_pwd.length>16 || com_pwd.length<6 || checkpwd=="error"){
					message = "비밀번호는 6~16자로<br /> 영문숫자 혼용하여 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
            	
            	else if(com_pwd != com_pwd_check){
					message = "비밀번호가 일치하지 않습니다.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
				
				else if(com_num.trim().length == 0 || com_num.length != 5 || isNaN(com_num)){
					message = "사업자 등록번호는 숫자5자리로 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
            	
				else if(com_name.trim().length == 0){
					message = "회사명을 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
            	
				else if(com_mgrName.trim().length == 0){
					message = "담당자를 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
            	
				else if(com_zipcode.trim().length == 0){
					message = "우편번호를 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
            	
				else if(com_address.trim().length == 0){
					message = "상세주소을 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
            	
				else if(com_phone.trim().length == 0){
					message = "전화번호를 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
            	
				else if(com_email.trim().length == 0){
					message = "이메일을 입력해 주세요.";
					$('.check').html(message);
					$('#errorModal').modal('toggle');
					return;
				}
            	$.ajax({
                    method: 'post',
                    url: 'com_idCheck',
                    data: "com_id="+com_id,
                    success: function(resp){
                       if(resp=='success'){
                          register2.submit();
                       }else{
                          message = "이미 존재하는 아이디입니다.";
                          $('.check').html(message);
                          $('#errorModal').modal('toggle');
                          return;
                       }   
                    }
                 });
            });
         
            
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
            
        });
        
    </script>

</head>

	

<body>
<div id="loadingBar" style="position:absolute; top:0; left:0; width:100%; height:100%; text-align:center; margin:0 auto; z-index:100000;">
<table width="100%" height="100%" border="0" bgcolor="#000000">
<tr><td align="center">
 	 <div style="text-align:center;"><IMG SRC="resources/img/logo.png"></div>
 	 <div style="margin-top:20px; color:#FFF; text-align:center; font-weight:bold;"><img alt="loading" src="resources/img/loading.gif"> </div>
 	 <div style="margin-top:20px; color:#FFF; text-align:center; font-weight:bold;">L o a d i n g . . .</div>
</td></tr>
</table>
</TABLE>    
</div>
<!-- Loading Image -->
<div id="divLoadBody" style="display:none;">

   <div id="wrapper">
      <nav class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
            
            	<!-- Personal회원 메뉴 -->
	                <ul class="nav metismenu" id="side-menu">
	                    <li class="nav-header">
	                        <div class="dropdown profile-element"> 
	                            <a class="dropdown-toggle" href="#"  data-toggle="modal" data-target="#registerModal"><span class="clear"> 
	                            	<br /><span style="font-size: 18px;" class="block m-t-xs"> <strong class="font-bold">GUEST</strong></span>  
	                            </span></a>
	                        </div>
	                        <div class="logo-element">
	                            B1
	                        </div>
	                    </li>
	                    <li>
	                        <a href="#" data-toggle="modal" data-target="#registerModal"><i class="fa fa-newspaper-o"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">뉴스프레이</span>
	                        </a>
	                    </li>
	                    <li>
                           <a href="#" data-toggle="modal" data-target="#registerModal"><i class="fa fa-user"></i> 
                              <span class="nav-label" style="font-size:17px; font-weight:bold;">개인정보관리 </span>
                           </a>
                       </li>
	                    <li>
	                        <a href="#"><i class="fa fa-file-text"></i> 
	                        	<span class="nav-label" style="font-size:15px; font-weight:bold;">이력서/자기소개서</span>
	                        	<span class="fa arrow"></span>  
	                        </a>
	                        <ul class="nav nav-second-level collapse">
	                            <li style="font-size:15px;"><a href="#" data-toggle="modal" data-target="#registerModal">이력서/자소서 등록</a></li>
		                        <li style="font-size:15px;"><a href="#" data-toggle="modal" data-target="#registerModal">이력서/자소서 수정</a></li>
	                        </ul>
	                    </li>
	                    <li>
	                        <a href="#" data-toggle="modal" data-target="#registerModal"><i class="fa fa-th-large"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">스크랩모아보기</span>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="#"><i class="fa fa-list-ul"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">채용정보</span>  
	                        	<span class="fa arrow"></span>
	                        </a>
	                        <ul class="nav nav-second-level collapse">
	                            <li style="font-size:15px;"><a href="#" data-toggle="modal" data-target="#registerModal">채용정보리스트</a></li>
		                        <li style="font-size:15px;"><a href="#" data-toggle="modal" data-target="#registerModal">관심채용정보</a></li>
	                        </ul>
	                    </li>
	                    <li>
	                        <a href="#" data-toggle="modal" data-target="#registerModal"><i class="fa fa-calendar"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">공채일정캘린더</span>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="#" data-toggle="modal" data-target="#registerModal"><i class="fa fa-square-o"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">메모지</span>
	                        </a>
	                    </li>
	                </ul>
				<!-- Personal회원 메뉴 끝 -->
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
	
					<li><a style="font-size: 18px;" href="main"> <i class="fa fa-home"></i>HOME</a></li>
               		<li><a style="font-size: 18px;" href="login"> <i class="fa fa-sign-out"></i>LOGIN</a></li>
               </ul>

            </nav>
         </div>
         
         <!-- 뉴스프레이 -->
		 <div class="row wrapper border-bottom white-bg page-heading">
              <div class="col-lg-10">
                  <h2><strong>뉴스프레이</strong> <small>NEWSPREY</small></h2>
                  
              </div>
              <div class="col-lg-2">

              </div>
          </div><br />

         <div class="wrapper wrapper-content  animated fadeInRight blog">
            <div class="row animated fadeInDown">
               
               
               <!--뉴스프레이  -->
               <div class="col-lg-9">
               <c:forEach items="${newsfeedList}" var="newsfeed">
                  <div class="ibox">
                     <div class="ibox-content">
                        <a href="#" class="btn-link" data-toggle="modal" data-target="#registerModal">
                           <h2>${newsfeed.nf_title}</h2>
                           <h3>${newsfeed.nf_subtitle}</h3>
                           
                        </a>
                        <div class="small m-b-xs">
                           <!-- <strong>Adam Novak</strong>  --><span class="text-muted"><i
                              class="fa fa-clock-o"></i>${newsfeed.nf_date}</span>
                        </div>
                        <p>${newsfeed.nf_content}</p>
                     </div>
                  </div><!-- ibox -->
                  </c:forEach>
               </div>
               
               
            </div>

         </div>



      </div>
   </div>


   <div class="modal inmodal" id="registerModal" tabindex="-1"
      role="dialog" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content animated bounceInRight"
            style="width: 650px;">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal">
                  <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
               </button>
               <i class="fa fa-laptop modal-icon"></i>
               <h4 class="modal-title">회원가입</h4>
            </div>
            <div class="modal-body"></div>
            <div class="modal-footer">
               <div class="col-lg-6">
                  <div class="tabs-container" style="width: 600px;">
                     <ul class="nav nav-tabs">
                        <li class="active"><a data-toggle="tab" href="#tab-1">개인회원</a></li>
                        <li class=""><a data-toggle="tab" href="#tab-2">기업회원</a></li>
                     </ul>
                     <div class="tab-content" style="width: 600px;">
                        <div id="tab-1" class="tab-pane active">
                           <div class="panel-body">

                              <form id="register" class="m-t" role="form" action="per_register" method="post">
                                 <table style="width: 100%;">
                                    <tr>
                                       <td colspan="2">
                                          <div class="form-group">
                                             <input type="text" name="per_id" class="form-control" id="per_id"
                                                placeholder="아이디">
                                          </div>
                                       </td>
                                    </tr>

                                    <tr>
                                       <td colspan="2">
                                          <div class="form-group">
                                             <input type="password" name="per_pwd" class="form-control" id="per_pwd"
                                                placeholder="비밀번호">
                                          </div>
                                       </td>
                                    </tr>

                                    <tr>
                                       <td colspan="2">
                                          <div class="form-group">
                                             <input type="password" class="form-control" id="per_pwd_check" placeholder="비밀번호 재확인">
                                          </div>
                                       </td>
                                    </tr>

                                    <tr>
                                       <td colspan="2">
                                          <div class="form-group">
                                             <input type="text" name="per_name" class="form-control" id="per_name" placeholder="이름">
                                          </div>
                                       </td>
                                    </tr>
                                    
                                    <tr>
                                       <td colspan="2">
                                          <div class="form-group">
                                             <input type="text" name="per_phone" class="form-control" id="per_phone" placeholder="전화번호">
                                          </div>
                                       </td>
                                    </tr>

                                    <tr>
                                       <td colspan="2">
                                          <div class="form-group">
                                             <input type="email" name="per_email" class="form-control" id="per_email" placeholder="이메일">
                                          </div>
                                       </td>
                                    </tr>

                                    <tr>
                                       <td style="width: 500px;">
                                          <div class="form-group">
                                             <input style="width: 430px;" type="text"
                                                name="per_zipcode" data-toggle="modal"
                                             data-target="#searchOfZipcode" class="form-control" id="per_zipcode" placeholder="우편번호 ">
                                          </div>
                                       </td>
                                       <td align="right">
                                          <button type="button" class="btn btn-primary" style="margin-top: -15px;" data-toggle="modal"
                                             data-target="#searchOfZipcode">우편번호 검색</button>
                                       </td>
                                    </tr>

                                    <tr>
                                       <td colspan="2">
                                          <div class="form-group">
                                             <input type="text" name="per_address" class="form-control" id="per_address" placeholder="상세주소">
                                          </div>
                                       </td>
                                    </tr>
                                 </table>
                                 <input type="hidden" value="${per_interestcom}">
                                 
                                 <button type="button" class="btn btn-primary block full-width m-b" id="per_register">Register</button>
                                 <a class="btn btn-sm btn-white btn-block" href="login">Login</a>
                              </form>
                           </div>
                        </div>




                        <div id="tab-2" class="tab-pane">
                           <div class="panel-body">
                              <div id="join_company_table">
                                 <form id="register2" class="m-t" role="form" action="com_register" method="post">
                                    <table style="width: 100%;">
                                       <tr>
                                          <td colspan="2">
                                             <div class="form-group">
                                                <input type="text" class="form-control" name="com_id" id="com_id" placeholder="아이디">
                                             </div>
                                          </td>
                                       </tr>

                                       <tr>
                                          <td colspan="2">
                                             <div class="form-group">
                                                <input type="password" class="form-control" name="com_pwd" id="com_pwd" placeholder="비밀번호">
                                             </div>
                                          </td>
                                       </tr>

                                       <tr>
                                          <td colspan="2">
                                             <div class="form-group">
                                                <input type="password" class="form-control" id="com_pwd_check" placeholder="비밀번호 재확인">
                                             </div>
                                          </td>
                                       </tr>

                                       <tr>
                                          <td style="width: 530px;">
                                             <div class="form-group">
                                                <input type="number" min=10000 max=99999 class="form-control" data-toggle="modal" data-target="#searchOfCompany" 
                                                	name="com_num" id="com_num" placeholder="사업자 등록 번호">
                                             </div>
                                          </td>
                                          <td align="right">
                                             <button type="button" class="btn btn-primary"
                                                style="margin-top: -15px; width: 100px;"
                                                data-toggle="modal" data-target="#searchOfCompany"
                                                style="width:100px;">인증 확인</button>
                                          </td>
                                       </tr>

                                       <tr>
                                          <td colspan="2">
                                             <div class="form-group">
                                                <input type="text" class="form-control" name="com_name" id="com_name" placeholder="회사명">
                                             </div>
                                          </td>
                                       </tr>

                                       <tr>
                                          <td colspan="2">
                                             <div class="form-group">
                                                <input type="text" class="form-control" name="com_mgrName" id="com_mgrName" placeholder="대표자명">
                                             </div>
                                          </td>
                                       </tr>

                                       <tr>
                                          <td style="width: 500px;">
                                             <div class="form-group">
                                                <input style="width: 430px;" type="text"
                                                   class="form-control" name="com_zipcode" id="com_zipcode" data-toggle="modal"
                                                data-target="#searchOfZipcode"
                                                   placeholder="우편번호 / 회사주소">
                                             </div>
                                          </td>
                                          <td align="right">
                                             <button type="button" class="btn btn-primary"
                                                style="margin-top: -15px;" data-toggle="modal"
                                                data-target="#searchOfZipcode">우편번호 검색</button>
                                          </td>
                                       </tr>

                                       <tr>
                                          <td colspan="2">
                                             <div class="form-group">
                                                <input type="text" class="form-control" name="com_address" id="com_address" placeholder="상세주소">
                                             </div>
                                          </td>
                                       </tr>

                                       <tr>
                                          <td colspan="2">
                                             <div class="form-group">
                                                <input type="text" class="form-control" name="com_phone" id="com_phone" placeholder="전화번호">
                                             </div>
                                          </td>
                                       </tr>

                                       <tr>
                                          <td colspan="2">
                                             <div class="form-group">
                                                <input type="email" class="form-control" name="com_email" id="com_email" placeholder="이메일">
                                             </div>
                                          </td>
                                       </tr>
                                    </table>
                                    <br> <br>
                                    <button type="button" class="btn btn-primary block full-width m-b" id="com_register">Register</button>
                                    <a class="btn btn-sm btn-white btn-block" href="login">Login</a>
                                 </form>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <br /> <br /> <br /> <br />
               </div>
            </div>
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
                    	<input type="number" min=10000 max=99999 id="comnum_keyword" placeholder="사업자 등록 번호" class="form-control">
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



   <!-- 우편번호 검색 -->
   <div class="modal inmodal" id="searchOfZipcode" tabindex="-1"
      role="dialog" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content animated bounceInRight">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal">
                  <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
               </button>
               <i class="fa fa-laptop modal-icon"></i>
               <h4 class="modal-title">우편번호 검색</h4>
            </div>
            <div class="modal-body">
               <div class="form-group">
                  <label>ex)삼성2동</label> <input type="text" id="zipcode_keyword"
                     placeholder="동이름 검색" class="form-control">
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
   
   <!-- error modal -->
   <div class="modal inmodal" id="errorModal" tabindex="-1" role="dialog" aria-hidden="true">
       <div class="modal-dialog">
       <div class="modal-content animated bounceInRight">
               <div class="modal-header">
                   <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                   <i class="fa fa-times-circle-o modal-icon"></i>
                   <h4 class="modal-title check">비밀번호를 다시 확인하세요</h4>
               </div>
               <div class="modal-footer">
                   <button type="button" class="btn btn-danger btn-lg" data-dismiss="modal">OK</button>
               </div>
           </div>
       </div>
   </div>
</div>
<script>
	var loadingBar = document.getElementById("loadingBar");
	var divLoadBody = document.getElementById("divLoadBody");
	loadingBar.style.display = "none";
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

</body>
</html>