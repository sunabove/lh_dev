<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="100_common.jsp" />

<c:if test="${ sessionScope.login_user_id }">
	<c:redirect url="index.jsp" />
</c:if>

<c:set var="a" value="1,2354" />
<c:set scope="request" var="page_title" value="사용자 가입" />

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="200_html_head.jsp" />
</head>

<body>

	<jsp:include page="210_header.jsp" />

	<div class="container">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link" href="user_login.jsp"> <i class="fas fa-sign-in-alt"></i> 사용자 로그인</a></li>
			<li class="nav-item"><a class="nav-link active" href="user_create.jsp"> <i class="fas fa-user-plus"></i> 사용자 가입</a></li>
		</ul>

		<br/>

		<sql:query dataSource="${db}" var="result">
			SELECT "MGR_ID", "MGR_GRADE", "MGR_NAME", "MGR_PW", "MOD_DATE" 
			FROM "MA_ADMIN_MGR"
			WHERE "MGR_ID" = ? 
			LIMIT 1
			<sql:param value="${ param.user_id }" />
		</sql:query>

		<form action="" class="needs-validation" onsubmit="return check_submit();">
			<div class="form-group">
				<label>아이디 : </label> <input type="text" class="form-control" id="user_id" value="${ row.mgr_id }"
					style="width: 60%;">
					<span id="user_id_valid"
					class="help-block invisible text-danger"> 잘못된 아이디입니다. </span>
			</div>
			<div class="form-group">
				<label>등급 : </label> <input type="text" class="form-control" id="user_grade"
					value="${ row.mgr_grade }" style="width: 60%;"> <span id="user_grade_valid"
					class="help-block invisible text-danger"> 잘못된 등급입니다. </span>
			</div>
			<div class="form-group">
				<label>이름 : </label> <input type="text" class="form-control" id="user_name"
					value="${ row.mgr_name }" style="width: 60%;"> <span id="user_name_valid"
					id="user_name" class="help-block invisible text-danger"> 잘못된 이름입니다. </span>
			</div>
			<div class="form-group">
				<label>비밀번호 : </label> <input type="password" class="form-control" id="user_pass"
					name="user_pass" style="width: 60%;"> <span id="user_pass_valid"
					class="help-block invisible text-danger"> 잘못된 비밀번호입니다. </span>
			</div>
			<div class="form-group">
				<label>비밀번호 확인 : </label> <input type="password" class="form-control" id="user_pass2"
					style="width: 60%;"> <span id="user_pass2_valid"
					class="help-block invisible text-danger"> 비밀번호가 일치하지 않습니다. </span>
			</div>

			<input type="hidden" name="user_id" value="${ param.user_id }" />

			<button type="submit" class="btn btn-primary">수정</button>

			<script>
				function check_submit() {
					var valid = true;

					$(".help-block").addClass("invisible");
					
					if (valid && $("#user_id").val().trim().length < 1) {
						$("#user_id_valid").removeClass("invisible");

						valid = false;
					}

					if (valid && $("#user_grade").val().trim().length < 1) {
						$("#user_grade_valid").removeClass("invisible");

						valid = false;
					}

					if (valid && $("#user_name").val().trim().length < 1) {
						$("#user_name_valid").removeClass("invisible");

						valid = false;
					}

					var pass1 = $("#user_pass").val().trim();
					var pass2 = $("#user_pass2").val().trim();

					if (valid && pass1.length < 1) {
						$("#user_pass_valid").removeClass("invisible");

						valid = false;
					}

					if (valid && pass2.length < 1 || pass1 != pass2) {
						$("#user_pass2_valid").removeClass("invisible");

						valid = false;
					}

					return false;
				}
			</script>
		</form>

	</div>

	<jsp:include page="220_footer.jsp" />

</body>
</html>
