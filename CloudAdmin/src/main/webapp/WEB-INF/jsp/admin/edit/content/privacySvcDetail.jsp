<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
	<jsp:include page="/cmn/admin/top.do" flush="false" />
<script>

	$(document).ready( function() {
		console.log("이용약관 상세 페이지");
		var tagId=${data.DOCUMENT_ID};
		$("#btnList").on("click",function(){
			console.log("이용약관 저장");
			location.href='/admin/edit/content/privacySvcList.do';
		});
		$("#btnDelete").on("click",function(){
			console.log("이용약관 삭제");
			ajaxMethod('/admin/edit/content/privacySvcDelete.do',{"DOCUMENT_ID":tagId},'/admin/edit/content/privacySvcList.do','삭제되었습니다');
		});
	});
	
</script>
</head>
<body class="open">
    <!-- lnb Start ------------------>
    <aside id="lnb" class="lnb">
        <a class="lnb-control" title="메뉴 펼침/닫침"><span class="menu-toggle">메뉴 펼침/닫침</span></a>
        <nav id="navbar" class="navbar navbar-expand-sm navbar-default">
            <ul class="menu-inner"></ul>
        </nav>
    </aside>
    <!-- lnb End ------------------>

    <!-- container Start ------------------>
    <div id="container" class="container-wrap">
		<!-- header Start ------------------>
		<div id="header" class="header-wrap"></div>
		
		<div id="title" class="title-wrap">
			<div class="title-inner">
			</div>
		</div>
		<!-- title end -->
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap">
			<!-- work Start -->
			<div id="work" class="work-wrap">
	<div class="title">
		<h3>개인정보처리방침 ${data.DOCUMENT_ID}</h3>
	</div>
	<div>
		<textarea id="TEXT_VAL" class="long-cont" style="width: 75vw;height: 55vh;resize:none;" readonly>${data.TEXT_VAL}</textarea>
		
		<div id="footer" class="footer-wrap">
	        <div id="footer-inner" class="footer-inner">
	            <!-- btn_box Start -->
	            <div class="btn_box">
	                <div class="right">
	                    <button class="btn" style="" id="btnList" ><span class="langSpan">목록으로</span></button>
	                    <button class="btn" style="" id="btnDelete" ><span class="langSpan">삭제</span></button>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
           </div>
			<!-- work End -->
        </div>
		<!-- contents End ------------------>
    </div>
    <!-- container End ------------------>
</body>
</html>