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
<c:set scope="request" var="page_title" value="모델 관리" />

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="200_html_head.jsp" />
</head>

<c:if test="${ param.cmd == 'delete' }" >
	<sql:update dataSource="${ db }" var="upNo" >
		UPDATE meta_data 
		SET is_deleted = 1 , model_apply_date = NULL
		WHERE data_id = ?	
		<sql:param value="${ param.data_id }" />	
	</sql:update>
</c:if>
<c:if test="${ param.cmd == 'apply' }" >
	<sql:update dataSource="${ db }" var="upNo" >
		UPDATE meta_data 
		SET is_deleted = 0 , model_apply_date = NOW()
		WHERE data_id = ?	
		<sql:param value="${ param.data_id }" />	
	</sql:update>
</c:if>


<sql:query dataSource="${db}" var="result">
	SELECT ROW_NUMBER () OVER (ORDER BY data_id) AS rno , 
	data_id, org_file, dest_loc, data_src, file_fmt, file_usage
	, TO_CHAR( get_date, 'YYYY-MM-DD HH:MI:SS') get_date
	, TO_CHAR( upload_date, 'YYYY-MM-DD HH:MI:SS') upload_date
	, TO_CHAR( model_apply_date, 'YYYY-MM-DD HH:MI:SS') model_apply_date
	, model_apply_user_id
	FROM meta_data
	WHERE data_id = ?
	ORDER BY data_id
	LIMIT 10
	<sql:param value="${ param.data_id }" />
</sql:query>

<body>

	<jsp:include page="210_header.jsp" />
	
		<div class="container">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link " href="model_manage.jsp"><i
					class="fas fa-list"></i>&nbsp; 모델 목록</a></li>
			<li class="nav-item"><a class="nav-link active"
				href="model_info.jsp?data_id=${param.data_id}"><i class="fas fa-hotel"></i>&nbsp;
					모델 정보</a></li>
		</ul>
		<br />		

		<c:forEach var="row" items="${result.rows}">
			<div class="row">
				<div class="col">
					<div class="input-group mb-1">
						<div class="input-group-append">
							<span class="input-group-text" style="width: 160px;"><i
								class="fas fa-file-alt"></i>&nbsp; 모델 파일명</span>
						</div>
						<input type="text" class="form-control" value="${ row.org_file }">
					</div>
					<div class="input-group mb-1">
						<div class="input-group-append">
							<span class="input-group-text" style="width: 160px;"><i
								class="fas fa-folder"></i>&nbsp; 모델 위치</span>
						</div>
						<input type="text" class="form-control" value="${ row.dest_loc }">
					</div>
					<div class="input-group mb-1">
						<div class="input-group-append">
							<span class="input-group-text" style="width: 160px;"><i class="fas fa-table"></i>&nbsp;
								모델 출처</span>
						</div>
						<input type="text" class="form-control" value="${ row.data_src }">
					</div>
					<div class="input-group mb-1">
						<div class="input-group-append">
							<span class="input-group-text" style="width: 160px;"><i
								class="fas fa-file-excel"></i>&nbsp; 모델 포맷</span>
						</div>
						<input type="text" class="form-control" value="${ row.file_fmt }">
					</div>
					<div class="input-group mb-1">
						<div class="input-group-append">
							<span class="input-group-text" style="width: 160px;"><i
								class="fas fa-info-circle"></i>&nbsp; 모델 용도</span>
						</div>
						<input type="text" class="form-control" value="${ row.file_usage }">
					</div>
					<div class="input-group mb-1">
						<div class="input-group-append">
							<span class="input-group-text" style="width: 160px;"><i class="fas fa-clock"></i>&nbsp;
								획득 시간</span>
						</div>
						<input type="text" class="form-control" value="${ row.get_date }">
					</div>
					<div class="input-group mb-1">
						<div class="input-group-append">
							<span class="input-group-text" style="width: 160px;"><i class="fas fa-clock"></i>&nbsp;
								적재 시간</span>
						</div>
						<input type="text" class="form-control" value="${ row.upload_date }">
					</div>
					<div class="input-group mb-1">
						<div class="input-group-append">
							<span class="input-group-text" style="width: 160px;"><i class="fas fa-clock"></i>&nbsp;
								모델 적용 시간</span>
						</div>
						<input type="text" class="form-control" value="${ row.model_apply_date }">
					</div>
					
					<br/>
					
					<button type="button" class="btn btn-primary" onclick="doCmd( 'apply' );" >모델 적용</button>
					<button type="button" class="btn btn-secondary" onclick="doCmd( 'delete' )" >모델 삭제</button>
					
					<!-- 
					&nbsp;
					<button type="button" class="btn btn-info disabled">진행</button>
					<button type="button" class="btn btn-danger disabled">실패</button>
					<button type="button" class="btn btn-dark disabled">에러</button>
					 -->
					
					<br/><br/>
					
					<form id="myForm">
						<input type="hidden" name="data_id" id="data_id" value="${ param.data_id }" />
						<input type="hidden" name="cmd" id="cmd" />
					</form>
					
					<script>
						function doCmd( cmd ) {
							$( "#cmd" ).val( cmd )
							$( "#myForm" ).submit()
						}
					</script>
				</div>
			</div>
		</c:forEach>

		<jsp:include page="220_footer.jsp" />
</body>
</html>
