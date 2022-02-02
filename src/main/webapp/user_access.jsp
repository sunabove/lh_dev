<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="100_common.jsp" />

<c:if test="${ empty sessionScope.login_user_id }">
	<c:redirect url="index.jsp" />
</c:if>

<c:set scope="request" var="page_title" value="사용자 정보" />

<c:if test="${ ! empty param.url_id && ! empty param.url_access }" >
	<sql:update dataSource="${db}" var="upNo" > 
		INSERT INTO user_access( user_id, user_url_id, url_access )
		SELECT ?, CAST( ? AS INTEGER ), CAST( ? AS INTEGER ) 
		FROM USER_ACCESS
		WHERE ( select COALESCE( count(*), 0 ) from user_access where user_id = ? and user_url_id = CAST( ? AS INTEGER) ) = 0 
		
		<sql:param value="${ sessionScope.login_user_id }" />
		<sql:param value="${ param.url_id }" />
		<sql:param value="${ param.url_access }" /> 
		<sql:param value="${ sessionScope.login_user_id }" />
		<sql:param value="${ param.url_id }" />
	</sql:update>
	
	<sql:update dataSource="${db}" var="upNo" >
		UPDATE user_access SET
		user_url_id =  CAST( ? AS INTEGER )
		, url_access = CAST( ? AS INTEGER )
		WHERE user_id = ? and user_url_id = CAST( ? AS INTEGER )
		<sql:param value="${ param.url_id }" />
		<sql:param value="${ param.url_access }" />
		<sql:param value="${ sessionScope.login_user_id }" />
		<sql:param value="${ param.url_id }" />
	</sql:update>
</c:if>

<sql:query dataSource="${db}" var="result">
	SELECT url_id, url_text, url_desc, user_id, COALESCE( url_access, 1 ) url_access
	FROM access_url 
	LEFT JOIN user_access ON ( url_id = user_url_id AND user_id = ? )
	ORDER BY url_id
	<sql:param value="${ param.user_id }" />
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
			<li class="nav-item"><a class="nav-link" href="user_info.jsp?user_id=${param.user_id}"> <i class="far fa-user"></i>&nbsp;
					사용자 정보
			</a></li>
			<li class="nav-item"><a class="nav-link active" href="user_access.jsp?user_id=${param.user_id}"> <i
					class="fas fa-user-tag"></i> 메뉴 관리
			</a></li>

			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<li class="nav-item"><a class="nav-link" href="user_list.jsp?user_id=${param.user_id}"><i class="fas fa-list"></i>&nbsp;
					목록</a></li>
		</ul>

		<br/>
		
		<table class="table table-hover table-stripped">
			<thead>
				<tr class="text-center">
					<th>메뉴 (URL)</th>
					<th>사용 가능</th>
					<th>설명</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="rowNo" value="${ 0 }" />
				<c:forEach var="row" items="${result.rows}">
					<c:set var="rowNo" value="${ rowNo + 1 }" />
					<tr>
						<td class="text-center">${ row.url_text }</td>
						<td class="text-center">
							<input type="checkbox" ${ row.url_access == 1 ? 'checked' : '' } onchange="change_access( ${row.url_id}, this);"/>
						</td>
						<td>${ row.url_desc}</td>
					</tr>
				</c:forEach>
				<c:forEach var="i" begin="${ rowNo }" end="9">
					<tr>
						<td colspan="100%">&nbsp;</td>
					</tr>
				</c:forEach> 
			</tbody>


		</table>

		<form id="myForm">
			<input type="hidden" name="url_id" id="url_id"/> 
			<input type="hidden" name="url_access" id="url_access" />
		</form>
		<script>
			function change_access( url_id, f ) {
				checked = f.checked ? 1 : 0 
				console.log( url_id, checked );
				$( "#url_id" ).val( url_id );
				$( "#url_access" ).val( checked );
				console.log( "url_access = ", $( "#url_access" ).val() );
				$( "#myForm" ).submit();
			}
		</script>
	</div>

	<jsp:include page="220_footer.jsp" />

</body>
</html>
