<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="100_common.jsp" />

<c:set var="a" value="1,2354" />
<c:set scope="request" var="page_title" value="메터 데이터 관리" />

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="200_html_head.jsp" /> 
</head>

<body>

	<jsp:include page="210_header.jsp" />

	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<h3>메타 데이터 / 모형 파일 관리</h3>
				<p>
					<c:if test="${! empty sessionScope.userId}" >
						${sessionScope.userId}
					</c:if>
					<c:if test="${empty sessionScope.userId}" >
						<a href="user_login.jsp" >사용자 로그인</a>
					</c:if>
				</p>
				<a href="user_login.jsp" >
					<img src="img/logo_01.png" title="로그인" />
				</a>
			</div>
		</div>
	</div>

	<jsp:include page="220_footer.jsp" />

</body>
</html>