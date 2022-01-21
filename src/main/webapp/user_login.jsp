<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="100_common.jsp" />

<c:set scope="request" var="page_title" value="로그인" />

<sql:query dataSource="${db}" var="result" >
	SELECT "MGR_ID", "MGR_GRADE", "MGR_NAME", "MGR_PW" 
	FROM "MA_ADMIN_MGR"
	WHERE "MGR_ID" = ? 
	LIMIT 1
	<sql:param value="${ param.user_id }" />
</sql:query>

<c:forEach var = "row" items = "${result.rows}">
	<c:set var="mgr_id" value="${ row.mgr_id }" /> 
	<c:set var="mgr_grade" value="${ row.mgr_grade }" />
	<c:set var="mgr_name" value="${ row.mgr_name }" />
	
	<c:if test="${ ! empty mgr_id }" >
		<c:set scope="session" var="login_user_id" value="${ mgr_id }" />
		<c:set scope="session" var="login_user_grade" value="${ mgr_grade }" />  
		<c:set scope="session" var="login_user_name" value="${ mgr_name }" />
	</c:if>
	
</c:forEach>

<c:if test="${ ! empty sessionScope.login_user_id }" >
	<c:redirect url="index.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="200_html_head.jsp" />
</head>

<body>

	<jsp:include page="210_header.jsp" />

	<div class="container">
		<ul class="nav nav-tabs">
			<li class="nav-item"><a class="nav-link active" href="user_login.jsp"> <i class="fas fa-sign-in-alt"></i> 사용자 로그인</a></li>
			<li class="nav-item"><a class="nav-link" href="user_create.jsp"> <i class="fas fa-user-plus"></i> 사용자 가입</a></li>
		</ul>
		
		<br/>
		
		<form action="" id="myForm" method="GET" onsubmit="return check_submit();" >
			<div class="form-group">
				<label for="email">아이디:</label>
				<input type="text" class="form-control" 
					name="user_id" id="user_id" style="width:60%;"
					placeholder="아이디 입력" value="${param.user_id}"/>
				<c:if test="${ ! empty param.user_id }">
					<span id="user_id_valid" class="help-block text-danger">
						잘못된 아이디입니다. 
					</span>
				</c:if>
				<c:if test="${ empty param.user_id }">
					<span id="user_id_valid" class="help-block invisible text-danger">
						잘못된 아이디입니다. 
					</span>
				</c:if>
			</div>
			<div class="form-group" >
				<label for="pwd">비밀번호:</label>
				<input type="password" class="form-control"
					name="user_pass" id="user_pass" style="width:60%;" 
					placeholder="비밀번호 입력" />
				<span id="user_pass_valid" class="help-block invisible text-danger">
					잘못된 비밀번호입니다. 
				</span>
			</div>
			<div class="form-group form-check">
				<label class="form-check-label">
				<input class="form-check-input"
					type="checkbox" name="remember"> 아이디 저장
				</label>
			</div>
			
			<br/>
			
			<button type="submit" class="btn btn-primary" >로그인</button>
		</form>
		<script>
			function check_submit() {
				var valid = true ;
				
				if( $( "#user_id").val().trim().length < 2 ) { 
					var form = $( "#user_id_valid" ) ; 
					form.removeClass( "invisible" ) ;
					
					valid = false ; 
				} else {
					var form = $( "#user_id_valid" ) ; 
					form.addClass( "invisible" ) ;
				}
				
				if( $( "#user_pass").val().trim().length < 4 ) { 
					var form = $( "#user_pass_valid" ) ; 
					form.removeClass( "invisible" ) ;
					
					valid = false ; 
				} else {
					var form = $( "#user_pass_valid" ) ; 
					form.addClass( "invisible" ) ;
				} 
				
				return valid ; 
			}
		</script>
		<br/><br/><br/>
	</div>

	<jsp:include page="220_footer.jsp" />

</body>
</html>
