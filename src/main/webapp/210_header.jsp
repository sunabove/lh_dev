<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
    <div class="container px-4 px-lg-5">    
        <a class="navbar-brand" href="index.jsp">
        	<h1>주택시장 통합 플랫품</h1> 
        </a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto my-2 my-lg-0">
                <li class="nav-item"><a class="nav-link" href="#services">데이터 관리</a></li>
                <li class="nav-item"><a class="nav-link" href="#portfolio">모델 관리</a></li>
                <li class="nav-item">
                	<a class="nav-link" href="#about">
                		사용자 관리
                	</a>
                </li> 
            </ul>
        </div>
    </div>
</nav>

<div class="jumbotron text-center">
  <br/>
  <h1> ${page_title} </h1> 
</div>
  
