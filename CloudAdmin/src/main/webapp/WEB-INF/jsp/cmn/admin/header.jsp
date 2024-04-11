<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<div style="display: flex; align-items: center; height: 100%;">
	<h1 class='logo'>
		<a href="/">logo</a>
	</h1>
</div>
<div class="header_util">
	<div class="username">
		<c:choose>
			<c:when test="${login.USER_NAME != null}">
				<ul class="nav-icons" style="margin-top: 0px;">
					<li style="display: flex;">
						<i class="ion-person"></i>
						<div style="margin-left: 10px;">${login.USER_NAME}님 환영합니다.</div>
						<a href="/login/logoutAdmin.do" style="margin-left: 10px;">logout</a>
					</li>
				</ul>
			</c:when>
			<c:otherwise>
				<ul class="nav-icons" style="margin-top: 0px;">
					<li style="display: flex;">
						<a href="/login/loginAdmin.do" style="margin-left: 10px;">login</a>
					</li>
				</ul>
			</c:otherwise>
		</c:choose>
	</div>
</div>