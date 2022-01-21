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
				LIMIT 10
			</sql:query>

		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active"
				href="user_list.jsp"><i class="fas fa-list"></i>&nbsp; 사용자 목록</a></li>  
		</ul>
		
		<br/>

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
				<c:set var="rowNo" value="${ 0 }" />
				<c:forEach var="row" items="${result.rows}">
					<c:set var="rowNo" value="${ rowNo + 1 }" />
					<tr>
						<td><a href="user_info.jsp?user_id=${row.mgr_id}">${ row.mgr_id }</a></td>
						<td>${ row.mgr_grade }</td>
						<td>${ row.mgr_name }</td>
						<td>${ row.mod_date }</td>
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
