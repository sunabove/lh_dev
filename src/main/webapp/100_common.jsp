<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set scope="application" var="contextPath" value="${pageContext.request.contextPath}" />

<sql:setDataSource scope="session" var="db" driver="org.postgresql.Driver" 
	url="jdbc:postgresql://localhost:5432/landbigdata" 
	user="landbigdata" password="landbigdata" 
/> 

<c:set scope="request" var="path" value="${pageContext.request.servletPath}" />