<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="100_common.jsp" /> 

<c:if test="${ empty sessionScope.login_user_id }" >
	<c:redirect url="index.jsp" />
</c:if>

<c:set var="a" value="1,2354" />
<c:set scope="request" var="page_title" value="모델 관리" />

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
				href="model_manage.jsp"><i class="fas fa-list"></i>&nbsp; 모델 목록</a></li>
		</ul>		
		<br/>
		
		<sql:query dataSource="${db}" var="result">
			SELECT ROW_NUMBER () OVER (ORDER BY data_id) AS rno , 
			data_id, org_file, dest_loc, data_src, file_fmt, file_usage
			, TO_CHAR( get_date, 'YY-MM-DD HH:MI:SS') get_date
			, TO_CHAR( upload_date, 'YY-MM-DD HH:MI:SS') upload_date
			, TO_CHAR( model_apply_date, 'YY-MM-DD HH:MI:SS') model_apply_date
			, model_apply_user_id
			FROM meta_data
			WHERE file_fmt = 'XLS'
			ORDER BY data_id
			LIMIT 10
		</sql:query>
		
		<table class="table table-hover table-stripped text-nowrap text-center">
			<thead>
				<tr>
					<th>No.</th>
					<th><i class="fas fa-hotel"></i>&nbsp; 원본 파일명</th>
					<th><i class="fas fa-folder"></i> 모델 위치</th>
					<th> 데이터 출처</th>
					<th><i class="fas fa-file-excel"></i> 모델 포맷</th>
					
					<th>파일 용도</th>
					<th><i class="fas fa-clock"></i> 모델 적용 시간</th> 
				</tr>
			</thead>
			<tbody>
				<c:set var="rowNo" value="${ 0 }" />
				<c:forEach var="row" items="${result.rows}">
					<c:set var="rowNo" value="${ rowNo + 1 }" />
					<tr>
						<td><a href="model_info.jsp?data_id=${row.data_id}">${ row.rno }</a></td>
						<td class="text-left"><a href="model_info.jsp?data_id=${row.data_id}">${ row.org_file }</a></td>
						<td class="text-left">${ row.dest_loc }</td>
						<td>${ row.data_src }</td>
						<td>${ row.file_fmt }</td>
						
						<td class="text-left">${ row.file_usage }</td>
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
							<li class="page-item"><a class="page-link" href="#">Prev</a></li>
							<li class="page-item active"><a class="page-link" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="#">2</a></li>
							<li class="page-item"><a class="page-link" href="#">3</a></li>
							<li class="page-item"><a class="page-link" href="#">4</a></li>
							<li class="page-item"><a class="page-link" href="#">5</a></li>
							<li class="page-item"><a class="page-link" href="#">6</a></li>
							<li class="page-item"><a class="page-link" href="#">7</a></li>
							<li class="page-item"><a class="page-link" href="#">8</a></li>
							<li class="page-item"><a class="page-link" href="#">9</a></li>
							<li class="page-item"><a class="page-link" href="#">Next</a></li>
						</ul>
					</td>
					<td>&nbsp;</td>
				</tr>
			</tfoot>
		</table>
	</div>

	<jsp:include page="220_footer.jsp" />

</body>
</html>
