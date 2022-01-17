<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="100_common.jsp" />

<c:set scope="session" var="login_user_id" value="" />
<c:set scope="session" var="login_user_grade" value="" />  
<c:set scope="session" var="login_user_name" value="" />

<c:if test="${ empty login_user_id }" >
	<c:redirect url="index.jsp" />
</c:if> 
 
