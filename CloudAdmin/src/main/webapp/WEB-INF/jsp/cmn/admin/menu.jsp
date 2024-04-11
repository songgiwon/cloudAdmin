<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<script>
	$(document).ready(function() {
		console.log("메뉴 화면");
		$(".menu-inner > .menu-item a").on('click',function(){
			console.log("소메뉴 확장을 위한 메뉴 클릭");
			//메뉴확장이 된 경우
			if($("body").attr("class")!="open"){
				//서브메뉴가 활성화 된 경우 -> 비활성화
				if($(this).parent().attr("class").indexOf("open")!=-1){
					$(this).parent().removeClass("open");
				//서브메뉴 비활성일경우 -> 서브메뉴 표출 및 기존 활성화 제거
				}else{
					$(this).parent().parent().children().each(function(i,list){
						$(list).parent().removeClass("open");
					});
					$(this).parent().addClass("open");
				}
				
				//주소 이동
				if($(this).parent().find("ul").length==0){
					if($(this).attr("id")!==''){
						location.href=$(this).attr("id");
					}
				}
				
			}else{
				if($(this).attr("id")!==''){
					location.href=$(this).attr("id");
				}
			}
		});
	});
</script>
<ul class="menu-inner">
	<li class="menu-item">
		<a id="/admin/client/company/companyList.do" class="menu-link menu-toggle"><i class="menu-icon n09"></i><div>고객관리</div></a>
		<ul class="menu-sub"><!-- /admin/client/charge/list.do --><!-- /admin/client/charge/send.do -->
			<li class="menu-item"><a id="/admin/client/company/companyList.do" class="menu-link"><div>계약 현황</div></a></li>
			<li class="menu-item"><a id="/admin/client/charge/chargeList.do" class="menu-link"><div>과금 현황</div></a></li>
		</ul>
	</li>
	<li class="menu-item">
		<a id="/admin/support/notice/noticeList.do" class="menu-link menu-toggle"><i class="menu-icon n02"></i><div>고객지원</div></a>
		<ul class="menu-sub">
			<li class="menu-item"><a id="/admin/support/notice/noticeList.do" class="menu-link"><div>공지사항</div></a></li>
			<li class="menu-item"><a id="/admin/support/request/reqList.do" class="menu-link"><div>문의관리</div></a></li>
			<li class="menu-item"><a id="/admin/support/faq/faqList.do" class="menu-link"><div>FAQ관리</div></a></li>
		</ul><!-- /admin/support/faq/faqList.do -->
	</li>
	<li class="menu-item"><!-- /admin/report/rptList.do -->
		<a id="/admin/report/reportList.do"  class="menu-link"><i class="menu-icon n06"></i><div>보고서관리</div></a>
	</li>
	<li class="menu-item">
		<a id="/admin/auth/user/userList.do" class="menu-link menu-toggle"><i class="menu-icon n08"></i><div>권한관리</div></a>
		<ul class="menu-sub">
			<li class="menu-item"><a id="/admin/auth/user/userList.do" class="menu-link"><div>사용자 계정 관리</div></a></li>
			<li class="menu-item"><a id="/admin/auth/auth/authList.do" class="menu-link"><div>접근권한관리</div></a></li>
		</ul>
	</li>
	<li class="menu-item">
		<a id=/admin/opr/oprList.do class="menu-link"><i class="menu-icon n01"></i><div>운영지표</div></a>
	</li>
	<li class="menu-item">
		<a id="/admin/edit/content/content.do" class="menu-link menu-toggle"><i class="menu-icon n10"></i><div>Editor</div></a>
		<ul class="menu-sub"><!-- /admin/edit/client.do -->
			<li class="menu-item"><a id="/admin/edit/content/content.do" class="menu-link"><div>컨텐츠 관리 현황</div></a></li>
			<li class="menu-item"><a id="/admin/edit/partner/client.do" class="menu-link"><div>고객사 관리현황</div></a></li>
			<li class="menu-item"><a id="/admin/edit/bill/bill.do" class="menu-link"><div>청구서양식 관리현황</div></a></li>
			<!-- /admin/edit/bill.do -->
		</ul>
	</li>
</ul>	
