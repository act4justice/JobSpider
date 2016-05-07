<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date"%>
<%@ page trimDirectiveWhitespaces="true" %>
<% Date now = new Date(); %>
<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<title>INSPINIA | PINBOARD</title>

<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/font-awesome/css/font-awesome.css" rel="stylesheet">

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
	                    <li>
	                        <a href="calendar"><i class="fa fa-calendar"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">공채일정캘린더</span>
	                        </a>
	                    </li>
	                    <li class="active">
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
	                    <li>
	                        <a href="calendar"><i class="fa fa-calendar"></i> 
	                        	<span class="nav-label" style="font-size:17px; font-weight:bold;">공채일정캘린더</span>
	                        </a>
	                    </li>
	                    <li class="active">
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
                 	 메모지 <small>Pin-Board</small>
               </h2>
            </div>
         </div>
		
		
		<c:if test="${not empty per_loginId }">
		<!-- board반복시작 -->
         <div class="row">
            <div class="col-lg-9">
                <div class="wrapper wrapper-content animated fadeInUp">
                    <ul class="notes">
                        <c:forEach items="${pinboardList }" var="p">
	                        <li>
	                            <div>
	                                <small>${p.pin_date }</small>
	                                <h4>${p.pin_title }</h4>
	                                <pre style="font-weight:bold; background-color:#ffc; border:none; font-size:15px; font-family:inherit; ">${p.pin_contents }</pre>
	                                <a href="deletePinboard?pin_index=${p.pin_index}"><i class="fa fa-trash-o "></i></a>
	                            </div>
	                        </li>
	                     </c:forEach>
                    </ul>
                </div>
            </div>
            
            
            <!-- pinboard 등록폼 -->
            <div class="col-lg-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-content mailbox-content">
                        <div class="file-manager">
                            <div class="space-25"></div>
                            <h5>메모 저장하기</h5>
                            <form action="insertPinboard" method="post">
                               	<div class="hr-line-dashed"></div>
                               	<div class="form-group"><label class="col-sm-2 control-label">Date</label>
                                    <div class="col-sm-10">
                                    <%java.util.Calendar cal = java.util.Calendar.getInstance(); %>
                                   		<p class="form-control-static">
											<%= cal.get(java.util.Calendar.YEAR) %>년
											<%= cal.get(java.util.Calendar.MONTH)+1 %>월
											<%= cal.get(java.util.Calendar.DATE) %>일
											<%= now.getHours() %>:<%= now.getMinutes() %>
										</p>
                                    </div>
                              		</div><br />
                               
                               	<div class="hr-line-dashed"></div>
                               	<div class="form-group"><label class="col-sm-2 control-label">Title</label>
                                   <div class="col-sm-10"><input type="text" name="pin_title" class="form-control"></div>
                              		</div><br />
                              		
                              		<div class="hr-line-dashed"></div>
                               	<div class="form-group"><label class="col-sm-2 control-label">Contents</label>
                                   <div class="ibox-content no-padding">
                                      <textarea placeholder="100자 이내로 입력하세요." name="pin_contents" class="contents" contenteditable="true" style=" width:100%; height:250px;"></textarea>
                                   </div>
                              	</div>
                            <br />
                            <input type="hidden" name="pin_date" value="<%= cal.get(java.util.Calendar.YEAR) %>-<%= cal.get(java.util.Calendar.MONTH)+1 %>-<%= cal.get(java.util.Calendar.DATE) %>&nbsp;<%= now.getHours() %>:<%= now.getMinutes() %>:<%= now.getSeconds() %>"/>
							<Button type="submit" class="btn btn-block btn-primary">메모 등록</Button>
                        	</form>
                        </div>
                    </div>
                </div>
                </c:if>
                
                
                
                
                
                
                
                
                <c:if test="${not empty com_loginId }">
				<!-- board반복시작 -->
		         <div class="row">
		            <div class="col-lg-9">
		                <div class="wrapper wrapper-content animated fadeInUp">
		                    <ul class="notes">
		                        <c:forEach items="${pinboardList_com }" var="p">
			                        <li>
			                            <div>
			                                <small>${p.pin_date }</small>
			                                <h4>${p.pin_title }</h4>
			                                <pre style="font-weight:bold; background-color:#ffc; border:none; font-size:15px; font-family:inherit; ">${p.pin_contents }</pre>
			                                <a href="deletePinboard?pin_index=${p.pin_index}"><i class="fa fa-trash-o "></i></a>
			                            </div>
			                        </li>
			                     </c:forEach>
		                    </ul>
		                </div>
		            </div>
		            
		            
		            <!-- pinboard 등록폼 -->
		            <div class="col-lg-3">
		                <div class="ibox float-e-margins">
		                    <div class="ibox-content mailbox-content">
		                        <div class="file-manager">
		                            <div class="space-25"></div>
		                            <h5>메모 저장하기</h5>
		                            <form action="insertPinboard" method="post">
		                               	<div class="hr-line-dashed"></div>
		                               	<div class="form-group"><label class="col-sm-2 control-label">Date</label>
		                                    <div class="col-sm-10">
		                                    <%java.util.Calendar cal = java.util.Calendar.getInstance(); %>
		                                   		<p class="form-control-static">
													<%= cal.get(java.util.Calendar.YEAR) %>년
													<%= cal.get(java.util.Calendar.MONTH)+1 %>월
													<%= cal.get(java.util.Calendar.DATE) %>일
													<%= now.getHours() %>:<%= now.getMinutes() %>
												</p>
		                                    </div>
		                              		</div><br />
		                               
		                               	<div class="hr-line-dashed"></div>
		                               	<div class="form-group"><label class="col-sm-2 control-label">Title</label>
		                                   <div class="col-sm-10"><input type="text" name="pin_title" class="form-control"></div>
		                              		</div><br />
		                              		
		                              		<div class="hr-line-dashed"></div>
		                               	<div class="form-group"><label class="col-sm-2 control-label">Contents</label>
		                                   <div class="ibox-content no-padding">
		                                      <textarea placeholder="100자 이내로 입력하세요." name="pin_contents" class="contents" contenteditable="true" style=" width:100%; height:250px;"></textarea>
		                                   </div>
		                              	</div>
		                            <br />
		                            <input type="hidden" name="pin_date" value="<%= cal.get(java.util.Calendar.YEAR) %>-<%= cal.get(java.util.Calendar.MONTH)+1 %>-<%= cal.get(java.util.Calendar.DATE) %>&nbsp;<%= now.getHours() %>:<%= now.getMinutes() %>:<%= now.getSeconds() %>"/>
									<Button type="submit" class="btn btn-block btn-primary">메모 등록</Button>
		                        	</form>
		                        </div>
		                    </div>
		                </div>
		                </c:if>
                
                
                
                
                
                
                
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

</body>
</html>