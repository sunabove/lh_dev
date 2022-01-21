<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="100_common.jsp" />

<c:set var="a" value="1,2354" />
<c:set scope="request" var="page_title" value="데이터 연계" />

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="200_html_head.jsp" />
</head>

<body>

	<jsp:include page="210_header.jsp" />

	<div class="container text-center">
	
		<c:if test="${ empty sessionScope.login_user_id }" >
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link active" href="user_login.jsp"> <i class="fas fa-sign-in-alt"></i> 사용자 로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="user_create.jsp"> <i class="fas fa-user-plus"></i> 사용자 가입</a></li>
			</ul>
		</c:if>

		<h3>&nbsp;</h3>
		<c:if test="${empty sessionScope.login_user_id}">
			<a href="user_login.jsp"> <img src="img/logo_01.png" title="로그인" />
			</a>
		</c:if>
		<c:if test="${! empty sessionScope.login_user_id}">
			<a href="data_manage.jsp"> <img src="img/logo_01.png" title="데이터 관리" />
			</a>
		</c:if>
	</div>

	<jsp:include page="220_footer.jsp" />

</body>
</html>
