<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

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

<body class="gray-bg" style="background:#233645; height: 80%">
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

    <div style="border-radius:50%; max-width:660px; width:660px; height:660px; 
       padding-top:0px; margin-top: 100px; z-index:3; background-color: #f3f3f4;" 
       class="middle-box text-center loginscreen animated fadeInDown">
         <img src="resources/img/logo.png" style ="margin-left: 500px; margin-top: -100px; z-index: 5;" >
        <div style="height:600px; margin-top: 20px;"> 
            <div style="margin-top: -150px;">
                <h1 class="logo-name" style="font-size: 130px; color:#66696b;">JOB <br/>SPIDER</h1>

            </div>
            
            <form class="m-t" role="form" id="searchForm" action="before_join" method="post" onsubmit="return false">
                <div class="form-group">
                <table style="margin:0 auto;">
                   <tr>
                      <td style="width:460px;">
                         <input type="text" style="width:450px; height:40px; font-size:20px; margin-right:5px; "
                             name="per_interestcom" id="tags" class="form-control" placeholder="관심있는 기업이름을 입력해주세요">
                      </td>
                      <td>
                         <!-- <button type="button" style="margin-top:13px; width:65px; height:50px; font-size:20px;" 
                            class="btn btn-primary block m-b ladda-button ladda-button-demo" data-style="expand-up">검색</button>
                           -->
                          <button type="button" style="margin-top:13px; width:65px; height:50px; font-size:20px;"  
                                class="ladda-button btn btn-primary block m-b" data-style="expand-up">
                          <span class="ladda-label">검색</span>
                          <span class="ladda-spinner"></span>
                          <div class="ladda-progress" style="width: 0px;"></div></button>
                          
                           
                      </td>
                   </tr>
                   <tr>
                      <td colspan="2">
                         <a class="btn btn-sm btn-white btn-block" style="margin:0 auto;width:70%;height:40px; font-size: 20px;" href="login">L&nbsp;o&nbsp;g&nbsp;i&nbsp;n</a>
                      </td>
                   </tr>
                </table>
                    
                   
                </div>
                
                
            </form>
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
   <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
   
   <!-- Ladda -->
    <script src="resources/js/plugins/ladda/spin.min.js"></script>
    <script src="resources/js/plugins/ladda/ladda.min.js"></script>
    <script src="resources/js/plugins/ladda/ladda.jquery.min.js"></script>
   
    <script>
    
    
    
       $(function(){
          
          var availableTags = [];
          <c:forEach items="${comList}" var="comName">
             availableTags.push('${comName}');
          </c:forEach>
          
          $( "#tags" ).autocomplete({ 
             source : availableTags,
             autoFocus: true,
             focus : function(){
                return false;
             },
             minLength : 1
           });
          
          $(".btn-primary").on("click", function(){
             var comName = $("#tags").val();
             var loadingImg = document.getElementById("loadingImg");
        	 var divLoadBody = document.getElementById("divLoadBody");
             if($.inArray(comName, availableTags) != -1){
            	 
            	 loadingImg.style.display = "";
            	 divLoadBody.style.display = "none";  
            	 var form1 = document.getElementById("searchForm");
                form1.submit();
             } else{
            	 loadingImg.style.display = "none";
            	 divLoadBody.style.display = ""; 
                return false;
             }
          });
          
       });
  
    </script>
</body>

</html>
    