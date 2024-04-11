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
	<button id="company_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/client/company/companyList.do'">계약 현황</button>
	<button id="charge_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/client/charge/chargeList.do'">고객 과금</button>
</div>
