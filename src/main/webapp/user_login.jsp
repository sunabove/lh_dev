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

	<div class="container">
		<h2> 사용자 로그인 </h2>
		<br/>
		<form action="" class="needs-validation" id="myForm" >
			<div class="form-group">
				<label for="email">아이디:</label>
				<input type="text" class="form-control" 
					name="user_id" id="user_id" style="width:60%;"
					placeholder="아이디 입력" />
				<span id="user_id_valid" class="help-block invisible text-danger">
					잘못된 아이디입니다. 
				</span>
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
			
			<button type="button" class="btn btn-primary" onclick="check_submit();" >로그인</button>
		</form>
		<script>
			function check_submit() {
				var valid = 1 ;
				
				if( $( "#user_id").val().trim().length < 4 ) { 
					var form = $( "#user_id_valid" ) ; 
					form.removeClass( "invisible" ) ;
					
					valid = 0 ; 
				} else {
					var form = $( "#user_id_valid" ) ; 
					form.addClass( "invisible" ) ;
				}
				
				if( $( "#user_pass").val().trim().length < 6 ) { 
					var form = $( "#user_pass_valid" ) ; 
					form.removeClass( "invisible" ) ;
					
					valid = 0 ; 
				} else {
					var form = $( "#user_pass_valid" ) ; 
					form.addClass( "invisible" ) ;
				}
				
				if( valid ) {
					$( "#myForm" ).submit();
				}
				
				return 0 ; 
			}
		</script>
		<br/><br/><br/>
	</div>

	<jsp:include page="220_footer.jsp" />

</body>
</html>
