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
				href="user_list.jsp?user_id=${param.user_id}"><i class="fas fa-list"></i>&nbsp; 데이터 목록</a></li>
		</ul>		
		<br/>
		
		<table class="table table-hover table-stripped">
			<thead>
				<tr class="text-center">
					<th>No.</th>
					<th>원본 파일명</th>
					<th>적재 위치</th>
					<th>데이터 출처</th>
					<th>파일 포맷</th>
					<th>파일 용도</th>
					<th>획득 시간</th>
					<th>적재 시간</th>
					<th>모델 적용 시간</th> 
				</tr>
			</thead>
			<tbody> 
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
