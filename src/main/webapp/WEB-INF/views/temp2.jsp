<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<style>
	.seleted:hover .selectedDiv{
		border-radius:30px; 
		background-color:#1ab394; 
	}
	.seleted:hover i{
		color:#ffffff;
	}
	.seleted:hover .selectedH2{
		color:#ffffff;
	}
</style>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>B1PROJECT | Search</title>

    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/font-awesome/css/font-awesome.css" rel="stylesheet">
    <link href="resources/css/animate.css" rel="stylesheet">
    <link href="resources/css/style.css" rel="stylesheet">
   <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.0-beta.1/themes/smoothness/jquery-ui.css">
</head>

<body class="gray-bg">

   <div class="row border-bottom">
        <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
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

      <div style="width:70%; margin: 0 auto; text-align: center;"> 
          <div style="margin: 0 auto;">
              <h1 class="logo-name" style="font-size: 100px; color:#cccccc;">${com.com_name}</h1><br />
          </div>
          <h3 style="font-size: 30px;">Welcome to B1_PROJECT</h3>
          <br /><br />
		
         <div style="margin:0 auto;">
           <a class="seleted" href="employInfoList_com" style="color:#676A6C;">
              <div class="selectedDiv" style="float:left; width:25%; height:250px; margin-left:6.5%;">
                 <br /><i class="fa fa-list" style="font-size:150px;"></i>
                 <h2 class="selectedH2" style="font-weight: bold;">채용정보리스트</h2>
              </div>
           </a> 
           
           <a class="seleted" href="goEmploymentReg" style="color:#676A6C;">
              <div class="selectedDiv" style="float:left; width:25%; height:250px; margin-left:6.5%;">
                 <br /><i class="fa fa-clipboard" style="font-size:150px;"></i>
                 <h2 class="selectedH2" style="font-weight: bold;">채용정보 등록</h2>
              </div> 
           </a>
           
           <a class="seleted" href="applyStatusForm" style="color:#676A6C;">
              <div class="selectedDiv" style="float:left; width:25%; height:250px; margin-left:6.5%;">
                 <br /><i class="fa fa-group" style="font-size:150px;"></i>
                 <h2 class="selectedH2" style="font-weight: bold;">지원현황</h2>
              </div>
           </a>
           <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /> 
           
           <a class="seleted" href="updateComInfo_form" style="color:#676A6C;">
              <div class="selectedDiv" style="float:left; width:25%; height:250px; margin-left:6.5%;">
                 <br /><i class="fa fa-wrench" style="font-size:150px;"></i>
                 <h2 class="selectedH2" style="font-weight: bold;">기업정보관리</h2>
              </div> 
           </a>
           
           <a class="seleted" href="calendar" style="color:#676A6C;">
              <div class="selectedDiv" style="float:left; width:25%; height:250px; margin-left:6.5%;">
                 <br /><i class="fa fa-calendar" style="font-size:150px;"></i>
                 <h2 class="selectedH2" style="font-weight: bold;">공채일정 캘린더</h2>
              </div>
           </a>
           
           <a class="seleted" href="pinboard" style="color:#676A6C;"> 
              <div class="selectedDiv" style="float:left; width:25%; height:250px; margin-left:6.5%;">
                 <br /><i class="fa fa-edit" style="font-size:150px; margin-left: 30px;"></i>
                 <h2 class="selectedH2" style="font-weight: bold;">메모지</h2>
              </div>
           </a>            
            </div>
      </div>
      

    <!-- Mainly scripts -->
    <script src="resources/js/jquery-2.1.1.js"></script>
    <script src="resources/js/bootstrap.min.js"></script>
   <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script>
       
    </script>
</body>

</html>
    