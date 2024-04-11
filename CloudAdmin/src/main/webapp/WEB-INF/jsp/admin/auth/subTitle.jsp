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
	<button id="user_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/auth/user/userList.do'">사용자 계정 관리</button>
	<button id="auth_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/auth/auth/authList.do'">접근권한관리</button>
</div>
