<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/option.css">
	<script src="<%=request.getContextPath()%>/js/option/option.js"></script>
	<script src="<%=request.getContextPath()%>/js/option/reportType.js"></script>
	<script src="<%=request.getContextPath()%>/js/option/colorCode.js"></script>
	<jsp:include page="/cmn/admin/top.do" flush="false" />

<script>
	var menuList = new Array();
	var authSlt;
	var chgFlg;
	
	function addAuthBtn(idx,i){
		//console.log(idx);
		var contAll='<div class="auth-btn-div">';
		var contEnd='</div>';
		var contMiddle='';
		//마지막 td에 123 생성하는 부분
		if(idx==1){
			contMiddle += 
				 '<input type="hidden" name="atList['+i+'].useYn" value="1"/>'
				+'<div class="auth1 select">1</div>'
				+'<div class="auth2">2</div>'
				+'<div class="auth3">3</div>';
		}else if(idx==2){
			contMiddle += 
				 '<input type="hidden" name="atList['+i+'].useYn" value="2"/>'
				+'<div class="auth1">1</div>'
				+'<div class="auth2 select">2</div>'
				+'<div class="auth3">3</div>';
		}else{
			contMiddle += 
				 '<input type="hidden" name="atList['+i+'].useYn" value="3"/>'
				+'<div class="auth1">1</div>'
				+'<div class="auth2">2</div>'
				+'<div class="auth3 select">3</div>';
		}
		contAll += contMiddle + contEnd;
		return contAll;
	}
	
	$(document).ready(function(){
		console.log("권한 관리");
		//테이블 기본설정 세팅
		dtTbSetting();
		iidx = 3;
		console.log("권한관리 목록 화면 진입");
		var colCnt=0;
		var idxTb =0;
		$('input:checkbox[name="chk"]').trigger('click');
		var selectVal = $("#AUTH_DIV").val();
		var tb2=$("#tableList").DataTable({
			ajax : {
	            "url":"/admin/auth/auth/authList.ajax?authCode="+selectVal,
	            "type":"GET",
	            "dataType": "json",
	        },  
	        columns: [
	            {data:"authUrlName1",
	            	"render": function (data, type, row, meta) {
	                    return '<input type="hidden" name="atList['+meta.row+'].idx" value="'+row.idx+'"/><input type="hidden" name="atList['+meta.row+'].authUrlName1" value="'+data+'"/><span>'+data+'</span>';
	                },
	            },
	            {
	            	data:"authUrlName2",
	           		"render": function (data, type, row, meta) {
	                    return '<input type="hidden" name="atList['+meta.row+'].authCode" value="'+row.authCode+'"/><input type="hidden" name="atList['+meta.row+'].authUrlName2" value="'+data+'"/><span>'+data+'</span>';
	                },
	            },
	            {
	        		data:   "useYn",
	            	"render": function (data, type, row, meta) {
	            		//console.log(meta.row+"	/	"+meta.col+"	/	"+row);
	                    return addAuthBtn(data,meta.row);
	                },
	            },
	        ],
	        //"lengthMenu": [ [5, 10, 20], [5, 10, 20] ],
	        //"pageLength": 20,
	        //pagingType : "full_numbers",
	        columnDefs: [ 
	        	{ orderable: false, targets: [0] }//특정 열(인덱스번호)에 대한 정렬 비활성화
	        	,{className: "dt-center",targets: "_all"} 
	        ],
	        select: {
	            style:    'multi',
	            selector: 'td:first-child'
	        }
	        //,order: [[ 1, 'desc' ]]
	        ,ordering: false
	        ,responsive: true
	       ,language : lang_kor // //or lang_eng
		});
		
		//불필요 항목 히든처리
		$("#tableList_length").hide();
		$("#tableList_paginate").hide();
		
		//테이블 액션에 대한 설정
		tbAction("tableList");
		
		//계정사용자 별 권한 선택 시
		$("#AUTH_DIV").on("change",function(e){
			var frm = {"authCode":$(this).val()};
			var tagUrl="/admin/auth/auth/authList.ajax";
			tbSearch("tableList",tagUrl,frm); 
		});
		
		//권한수정 버튼 클릭
		/* $("#btnInsert").on("click",function(e){
			var frm = $("#acDetailFrm").serialize();
			ajaxMethod("/admin/auth/auth/updateAuth.do",frm);
		}); */
		$("#acDetailFrm").submit(function(e){
			var frm = $("#acDetailFrm").serialize();
			authAjax("/admin/auth/auth/updateAuth.do",frm);
		});
		
	});
	/* 동적 요소에 이벤트 바인딩 */
	$(document).on("click",".auth-btn-div > div" , function(){
		//var tt= $(this).attr('class');
		
		$(this).parent().children().each(function(i,list){
			$(list).removeClass("select");
		});
		
		$(this).toggleClass("select");
		var selectVal = $(this).text();
		$(this).parent().find("input").val(selectVal);
	});
	
</script>
<style>

</style>
</head>
<body class="open">
    <!-- lnb Start ------------------>
    <aside id="lnb" class="lnb">
        <a class="lnb-control" title="메뉴 펼침/닫침"><span class="menu-toggle">메뉴 펼침/닫침</span></a>
        <nav id="navbar" class="navbar navbar-expand-sm navbar-default"></nav>
    </aside>
    <!-- lnb End ------------------>

    <!-- container Start ------------------>
    <div id="container" class="container-wrap">
		<!-- header Start ------------------>
		<div id="header" class="header-wrap">
		</div>
		<!-- header End ------------------>
		<!-- title start -->
		<div id="title" class="title-wrap">
			<div class="title-inner">
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap list_page">
                <!-- search_box Start -->
				<div class="search_box">
	                <select class="table_sel2" id="AUTH_DIV" name="AUTH_DIV">
				        <c:forEach var="authInfo" items="${authList}">
				            <option value="${authInfo.authCode}"><c:out value="${authInfo.authName}"/></option>
				        </c:forEach>
				    </select>
				    
				    <div class="auth-btn-div">
						<div class="auth1 select">1</div><span> : 모든 권한 허용(읽기/쓰기)</span>
						<div class="auth2 select">2</div><span> : 조회만 가능(읽기)</span>
						<div class="auth3 select">3</div><span> : 권한 허용 안함</span>
					</div>
				    
				</div>
                <!-- search_box End -->
	            <!-- grid_box Start -->
	            <form name="insertForm" id="acDetailFrm" method="post" onsubmit="return false"  enctype="multipart/form-data">
					<div class="datatable-list-01">
						<div class="page-description">
							<div class="rows">
								<table id="tableList" class="table table-bordered" style="width: 100%;">
									<thead>
										<tr>
											<th>대분류</th>
											<th>중분류</th>
											<th>허용 기능</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
						
						<div id="footer" class="footer-wrap">
					        <div id="footer-inner" class="footer-inner">
					            <!-- btn_box Start -->
					            <div class="btn_box">
					                <div class="right">
					                    <button type="submit" class="btn btn_primary" style="" id="btnInsert" data-term="L.등록" title="등록"><span class="langSpan">저장</span></button>
					                    <!-- <button class="btn" style="" id="btnUpdate" data-term="L.등록" title="등록" onclick='tbUpdate(this,updUrl,"COMPANY_ID")'><span class="langSpan">수정</span></button>
					                    <button class="btn" style="" id="btnDelete" data-term="L.등록" title="등록" onclick='tbDelete(this,delUrl,delbak)'><span class="langSpan">삭제</span></button> -->
					                </div>
					            </div>
					        </div>
					    </div>
		            <!-- btn_box End -->
					</div>
				</form>
				<!-- grid_box End -->
            </div>
			<!-- work End -->
        </div>
		<!-- contents End ------------------>
    </div>
    <!-- container End ------------------>
</body>
</html>