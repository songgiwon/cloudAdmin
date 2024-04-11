<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>

$(document).ready(function() {
	var nowUrl=location.href;
	console.log(nowUrl);
	nowUrl= nowUrl.split("/")[nowUrl.split("/").length-2].split(".do")[0];
	
	$(".title_segments button").each(function(i,list){
		if($(list).attr('id').replace("_menu","")==nowUrl){
			$(this).toggleClass("active");
		}
	});
	
});

</script>
<!-- 타이틀 텝 구성 -->
<div class="title_segments" role="tablist">
	<button id="content_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/edit/content/content.do'">컨텐츠 관리 현황</button>
	<button id="partner_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/edit/partner/client.do'">고객사 관리현황</button>
	<button id="bill_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/edit/bill/bill.do'">청구서양식 관리현황</button>
</div>
