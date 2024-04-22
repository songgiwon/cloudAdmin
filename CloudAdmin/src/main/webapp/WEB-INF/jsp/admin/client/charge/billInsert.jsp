<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CLOUD 24 365 관리자 페이지</title>

<script>

	$(document).ready( function() {
		
		console.log("수동청구서 등록");
		
		//데이트타임피커
		//최대일과 현재일이 같을 경우 발생할수 있는 문제에 대해 최대일에 +1초 
		//먼저 변수 선언
		var maxD = moment().add(1, 'seconds').format("YYYY-MM-DD");
		var defaultD  = moment().format("YYYY-MM-DD");
		$('#datetimepicker3').datetimepicker({
			 format:"YYYY-MM-DD", 
			 minDate : defaultD,
			 defaultDate: defaultD
		 });
		
		$("#btnSave").on("click",function(){
			console.log("수동청구서 등록 시도");
			let frm = $("#acDetailFrm").serialize();
		    var options = {
	            url:'/admin/client/charge/insertBill.ajax',
	            type:"post",
	            dataType: "json",
	            data : frm,
	            success: function(res){
	                if(res.cnt > 0){
	                    alert("저장되었습니다.");
	                    location.href="/admin/client/charge/billList.do"
	                } else {
	                	if(res.badFileType != null){
	                		alert("사진파일 첨부는 이미지 파일만 가능합니다.");
	                	} else if(typeof res.createFileError !== "undefined" && res.createFileError) {
	                	    alert("사진파일 저장에 실패했습니다.");
	                	} else if(typeof res.msg !== "undefined" && res.msg != null) {
	                		alert(res.msg);
	                	} else {
	                		alert("저장에 실패했습니다.");
	                	}
	                }
	            } ,
	            error: function(res,error){
	                alert("에러가 발생했습니다."+error);
	            }
		    };
		    $('#acDetailFrm').ajaxSubmit(options);
		});
	});
	
</script>
</head>
	<form name="insertForm" id="acDetailFrm" method="post" enctype="multipart/form-data">
		<div class="ctn_tbl_row">
			<div class="ctn_tbl_th fm_rep">발송일</div>
			<div class="ctn_tbl_td">
				<div class='input-group date' id='datetimepicker3'>
					<input type='text' style="width:100%;" class="form-control" name="SND_DT" id="SND_DT" onkeyup="valiChkAll(this,1)" required/>
					<span class="input-group-addon">
						<span class="glyphicon glyphicon-calendar"></span>
					</span>
				</div>
			</div>
		</div>
       
       <div class="ctn_tbl_row">
           <div class="ctn_tbl_th">청구액</div>
           <div class="ctn_tbl_td">
           		<input type="text" class="form-control" onkeyup="valiChkAll(this,1);" name="BILL_PRICE"/>
           </div>
       </div>
       
		<div class="ctn_tbl_row">
			<div class="ctn_tbl_th">고객사</div>
			<div class="ctn_tbl_td">
				<select class="form-control mw_50"  style="width:120px;" id="areaCodeSel" name="COMPANY_ID">
				    <c:forEach var="cVo" items="${companyList}">
						<option value="${cVo.COMPANY_ID}">${cVo.COMPANY_NAME}</option>
				    </c:forEach>
				</select>
			</div>
		</div>
        
        <div class="ctn_tbl_row">
			<div class="ctn_tbl_th">청구서양식</div>
			<div class="ctn_tbl_td">
				<a href="/download.ajax?FILE_ID=${file.FILE_ID}">${file.FILE_NAME}</a>
			</div>
		</div>
           
		<!-- btn_box Start -->
		<div class="btn_box" style=" margin-top: 30px;">
			<div class="right">
				<button class="btn btn_primary" style="" id="btnSave" data-term="L.등록" title="등록">
					<span class="langSpan">등록</span>
				</button>
			</div>
		</div>
		<!-- btn_box End -->
	</form>
</html>