<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="100_common.jsp" />

<c:if test="${ sessionScope.login_user_id }">
	<c:redirect url="index.jsp" />
</c:if>

<c:set scope="request" var="page_title" value="사용자 가입" />

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="200_html_head.jsp" />
</head>

<c:if test="${! empty param.user_id && ! empty param.user_pass }">
	<c:set var="user_exists" value="${ false }" />

	<sql:query dataSource="${db}" var="result">
		SELECT "MGR_ID", "MGR_GRADE", "MGR_NAME", "MGR_PW", "MOD_DATE" 
		FROM "MA_ADMIN_MGR"
		WHERE "MGR_ID" = ? 
		LIMIT 1
		<sql:param value="${ param.user_id }" />
	</sql:query>

	<c:forEach var="row" items="${result.rows}">
		<c:set var="user_exists" value="${ true }" />
	</c:forEach>

	<c:if test="${ ! user_exists }">
		<sql:update dataSource="${ db }" var="upNo">
			INSERT INTO "MA_ADMIN_MGR"
			( "SEQ", "MGR_ID", "MGR_PW", "MGR_GRADE", "MGR_NAME", "REG_ID", "REG_DATE", "MOD_ID", "MOD_DATE" )
			SELECT MAX( "SEQ" ) + 1 , ?, ?, ?, ? 
			, 'admin', TO_CHAR( NOW(), 'yyyymmddhhmiss' ),  'admin', TO_CHAR( NOW(), 'yyyymmddhhmiss' )
			FROM "MA_ADMIN_MGR" 
			
			<sql:param value="${ param.user_id }" />
			<sql:param value="${ password.encode( param.user_pass ) }" />
			<sql:param value="${ param.user_grade }" />
			<sql:param value="${ param.user_name }" /> 
		</sql:update>

		<c:if test="${ upNo == 1 }">
			<c:redirect url="index.jsp">
				<c:param name="message" value="회원 가입이 완료되었습니다."></c:param>
			</c:redirect>
		</c:if>
	</c:if>
</c:if>

<body>

	<jsp:include page="210_header.jsp" />
	
	<div class="container">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link" href="user_login.jsp"> <i class="fas fa-sign-in-alt"></i> 사용자 로그인
			</a></li>
			<li class="nav-item"><a class="nav-link active" href="user_create.jsp"> <i class="fas fa-user-plus"></i> 사용자 가입
			</a></li>
		</ul>

		<br />

		<form action="" class="needs-validation" onsubmit="return check_submit();">
			<div class="form-group">
				<label>아이디 : </label> <input type="text" class="form-control" id="user_id" name="user_id" value="${ param.user_id }"
					style="width: 60%;">
					<c:if test="${ user_exists }" > 
						<span id="user_id_valid" class="help-block text-danger"> 이미 존재하는 아이디입니다. </span>
					</c:if>
					<c:if test="${ ! user_exists }" > 
						<span id="user_id_valid" class="help-block invisible text-danger"> 잘못된 아이디입니다. </span>
					</c:if>
			</div>
			<div class="form-group">
				<label>등급 : </label> <input type="text" class="form-control" id="user_grade" name="user_grade" value="admin"
					style="width: 60%;" readonly> <span id="user_grade_valid" class="help-block invisible text-danger"> 잘못된 등급입니다.
				</span>
			</div>
			<div class="form-group">
				<label>이름 : </label> <input type="text" class="form-control" id="user_name" name="user_name" value="${ param.user_name }"
					style="width: 60%;"> <span id="user_name_valid" id="user_name" class="help-block invisible text-danger"> 잘못된
					이름입니다. </span>
			</div>
			<div class="form-group">
				<label>비밀번호 : </label> <input type="password" class="form-control" id="user_pass" name="user_pass" style="width: 60%;">
				<span id="user_pass_valid" class="help-block invisible text-danger"> 잘못된 비밀번호입니다. </span>
			</div>
			<div class="form-group">
				<label>비밀번호 확인 : </label> <input type="password" class="form-control" id="user_pass2" style="width: 60%;"> <span
					id="user_pass2_valid" class="help-block invisible text-danger"> 비밀번호가 일치하지 않습니다. </span>
			</div>

			<button type="submit" class="btn btn-primary">가입</button>

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

					if (valid && pass1.length < 6) {
						$("#user_pass_valid").removeClass("invisible");

						valid = false;
					}

					if (valid && pass2.length < 1 || pass1 != pass2) {
						$("#user_pass2_valid").removeClass("invisible");

						valid = false;
					}

					return valid;
				}
			</script>
		</form>

	</div>

	<jsp:include page="220_footer.jsp" />

</body>
</html>
