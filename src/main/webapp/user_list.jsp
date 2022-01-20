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
<c:set scope="request" var="page_title" value="사용자 관리" />

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="200_html_head.jsp" />
</head>

<body>

	<jsp:include page="210_header.jsp" />

	<div class="container">
		<sql:query dataSource="${db}" var="result">
				SELECT "MGR_ID", "MGR_GRADE", "MGR_NAME", "MGR_PW", "MOD_DATE" 
				FROM "MA_ADMIN_MGR"
				ORDER BY "MGR_ID"
				LIMIT 20
			</sql:query>

		<h3>
			사용자 목록 <br/>
		</h3>

		<table class="table table-hover text-center">
			<thead>
				<tr>
					<th>아이디</th>
					<th>등급</th>
					<th>이름</th>
					<th>수정일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="row" items="${result.rows}">					
					<tr>
						<td><a href="user_info.jsp?user_id=${row.mgr_id}" >${ row.mgr_id }</a></td>
						<td>${ row.mgr_grade }</td>
						<td>${ row.mgr_name }</td> 
						<td>${ row.mod_date }</td>
					</tr> 
					
				</c:forEach>
			</tbody>
		</table>
	</div>

	<jsp:include page="220_footer.jsp" />
</body>
</html>
