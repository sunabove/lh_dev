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
<c:set scope="request" var="page_title" value="사용자 정보" />

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="200_html_head.jsp" />
</head>

<body>

	<jsp:include page="210_header.jsp" />

	<div class="container">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link"
				href="user_info.jsp?user_id=${param.user_id}">사용자 정보</a></li>
			<li class="nav-item"><a class="nav-link  active"
				href="user_access.jsp?user_id=${param.user_id}">접근 관리</a></li>

			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<li class="nav-item"><a class="nav-link"
				href="user_list.jsp?user_id=${param.user_id}">목록</a></li>
		</ul>

		<br />
		<sql:query dataSource="${db}" var="result">
			SELECT "MGR_ID", "MGR_GRADE", "MGR_NAME", "MGR_PW", "MOD_DATE" 
			FROM "MA_ADMIN_MGR"
			WHERE "MGR_ID" = ? 
			LIMIT 1
			<sql:param value="${ param.user_id }" />
		</sql:query>

		<table class="table table-hover table-stripped">
			<thead>
				<tr>
					<th>메뉴 (URL)</th>
					<th>사용 가능</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>John</td>
					<td><input type="checkbox"></td>
				</tr>
				<tr>
					<td>Mary</td>
					<td><input type="checkbox"></td>
				</tr>
				<tr>
					<td>July</td>
					<td><input type="checkbox"></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td colspan="100%">
						<button type="submit" class="btn btn-primary">저장</button>
					</td>
					<td>&nbsp;</td>
				</tr>
			</tfoot>
		</table>
		<br/><br/><br/><br/>
	</div>

	<jsp:include page="220_footer.jsp" />

</body>
</html>
