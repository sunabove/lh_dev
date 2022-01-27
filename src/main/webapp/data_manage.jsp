<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="100_common.jsp" /> 

<c:if test="${ empty sessionScope.login_user_id }" >
	<c:redirect url="user_login.jsp" />
</c:if>

<c:set scope="request" var="page_title" value="데이터 관리" />

<c:set var="page_no" value="${ empty param.page_no ? 0 : param.page_no }" /> 

<c:set var="record_count" value="${ 0 }" />
<c:set var="page_count" value="${ 1 }" />

<sql:query dataSource="${db}" var="result">
	SELECT 
	  COALESCE( count(*), 0 ) AS cnt
	, CEIL( COALESCE( count(*), 0 )/10.0 ) AS page_cnt
	FROM meta_data
</sql:query>

<c:forEach var="row" items="${result.rows}">
	<c:set var="record_count" value="${ row.cnt }" />
	<c:set var="page_count" value="${ row.page_cnt }" />
</c:forEach>

<sql:query dataSource="${db}" var="result">
	SELECT ROW_NUMBER () OVER (ORDER BY data_id) AS rno , 
	data_id, org_file, dest_loc, data_src, file_fmt, file_usage
	, TO_CHAR( get_date, 'YY-MM-DD HH:MI:SS') get_date
	, TO_CHAR( upload_date, 'YY-MM-DD HH:MI:SS') upload_date
	, TO_CHAR( model_apply_date, 'YY-MM-DD HH:MI:SS') model_apply_date
	, model_apply_user_id
	FROM meta_data
	ORDER BY data_id
	LIMIT 10 OFFSET CAST( ? AS INTEGER )*10
	<sql:param value="${ param.page_no }" />
</sql:query> 

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="200_html_head.jsp" /> 
</head>

<body>

	<jsp:include page="210_header.jsp" />

	<div class="container">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active"
				href="data_manage.jsp"><i class="fas fa-list"></i>&nbsp; 데이터 목록</a></li>
		</ul>		
		<br/>
		
		<table class="table table-hover table-stripped text-nowrap text-center">
			<thead>
				<tr>
					<th>No.</th>
					<th><i class="fas fa-file-alt"></i>&nbsp; 원본 파일명</th>
					<th><i class="fas fa-folder"></i> 적재 위치</th>
					<th> 데이터 출처</th>
					<th><i class="fas fa-file-excel"></i> 파일 포맷</th>
					
					<th>파일 용도</th>
					<th><i class="fas fa-clock"></i> 획득 시간</th>
					<th><i class="fas fa-clock"></i> 적재 시간</th>
					<th><i class="fas fa-clock"></i> 모델 적용 시간</th> 
				</tr>
			</thead>
			<tbody>
				<c:set var="rowNo" value="${ 0 }" />
				<c:forEach var="row" items="${result.rows}">
					<c:set var="rowNo" value="${ rowNo + 1 }" />
					<tr>
						<td><a href="data_info.jsp?data_id=${row.data_id}">${ row.rno }</a></td>
						<td class="text-left"><a href="data_info.jsp?data_id=${row.data_id}">${ row.org_file }</a></td>
						<td class="text-left">${ row.dest_loc }</td>
						<td>${ row.data_src }</td>
						<td>${ row.file_fmt }</td>
						
						<td class="text-left">${ row.file_usage }</td>
						<td>${ row.get_date }</td>
						<td>${ row.upload_date }</td>
						<td>${ row.model_apply_date }</td>
					</tr>
				</c:forEach>
				<c:forEach var="i" begin="${ rowNo }" end="9">
					<tr><td colspan="100%">&nbsp;</td></tr>
				</c:forEach>
			</tbody>
			<tfoot> 
				<tr>
					<td>&nbsp;</td>					
					<td colspan="100%">
						<ul class="pagination">
							<li class="page-item">
								<a class="page-link" href="#" onclick="goto_page(0);" >Prev</a>
							</li>
							<c:forEach var="i" begin="${ 0 }" end="${ page_count - 1 }">
								<li class="page-item ${ page_no eq i ? ' active' : '' } ">
									<a class="page-link" href="#" onclick="goto_page( ${i} );">${ i + 1 }</a>
								</li>
							</c:forEach>
							<li class="page-item">
								<a class="page-link" href="#" onclick="goto_page( ${page_count} );">Next</a>
							</li>
						</ul>
					</td>
					<td>&nbsp;</td>
				</tr>
			</tfoot>
		</table>
		
		<form id="myForm">
			<input type="hidden" name="page_no" id="page_no" value="0" />
		</form>
		
		<script>
			function goto_page( page_no ) {
				$( "#page_no" ).val( page_no ); 
				$( "#myForm" ).submit();
			}
		</script>
	</div>

	<jsp:include page="220_footer.jsp" />

</body>
</html>
