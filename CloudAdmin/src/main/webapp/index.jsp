<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>ADMIN 24 365</title>
	<!-- Custom style -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

	<!-- JS -->
	<script src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.migrate.js"></script>
	<script src="<%=request.getContextPath()%>/js/demo.js"></script>

	<!-- 로그인 시큐어코딩 관련 -->
	<script src="<%=request.getContextPath()%>/js/loginSC/login.js"></script>
	<!-- <script src="<%=request.getContextPath()%>/js/common/validation.js"></script> -->
 
	<script>
		var rkFlag = false;//로드/언로드 플래그
		//var c3TagId="";//기준 일시 또는 연, 월
		console.log("최초 화면 admin");
		$(document).ready(function() {
			console.log("최초 화면 admin");
			//alert("최초 화면");
			var sessionVo = '${login.USER_ID}'
			console.log("세션체크 : "+sessionVo);
			//로그인(세션) 여부를 판별하여 화면전환 (로그인/메인화면)
			stMainIdx(sessionVo,location.href); 
		});
	</script>
</head>
<body>
</body>
</html>