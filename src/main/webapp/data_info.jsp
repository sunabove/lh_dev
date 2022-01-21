<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="100_common.jsp" />

<c:if test="${ empty sessionScope.login_user_id }">
	<c:redirect url="index.jsp" />
</c:if>

<c:set var="a" value="1,2354" />
<c:set scope="request" var="page_title" value="데이터 관리" />

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
				href="data_info.jsp?data_id=${param.data_id}"><i class="fas fa-file-excel"></i>&nbsp;
					데이터 정보</a></li>
			<li class="nav-item"><a class="nav-link " href="data_manage.jsp"><i
					class="fas fa-list"></i>&nbsp; 데이터 목록</a></li>
		</ul>
		<br />

		<sql:query dataSource="${db}" var="result">
			SELECT ROW_NUMBER () OVER (ORDER BY data_id) AS rno , 
			data_id, org_file, dest_loc, data_src, file_fmt, file_usage
			, TO_CHAR( get_date, 'YY-MM-DD HH:MI:SS') get_date
			, TO_CHAR( upload_date, 'YY-MM-DD HH:MI:SS') upload_date
			, TO_CHAR( model_apply_date, 'YY-MM-DD HH:MI:SS') model_apply_date
			, model_apply_user_id
			FROM meta_data
			WHERE data_id = CAST( ? AS INTEGER)
			ORDER BY data_id
			LIMIT 10
			<sql:param value="${ param.data_id }" />
		</sql:query>

		<c:forEach var="row" items="${result.rows}">
			<div class="row">
				<div class="col">
					<div class="input-group mb-1">
						<div class="input-group-append">
							<span class="input-group-text">원본 파일명</span>
						</div>
						<input type="text" class="form-control" value="${ row.org_file }">
					</div>
					<div class="input-group mb-1">
						<div class="input-group-append">
							<span class="input-group-text">원본 파일명</span>
						</div>
						<input type="text" class="form-control" value="${ row.org_file }">
					</div>
				</div>
			</div>
		</c:forEach>

		<jsp:include page="220_footer.jsp" />
</body>
</html>
