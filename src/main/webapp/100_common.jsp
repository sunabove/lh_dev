<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set scope="application" var="contextPath" value="${pageContext.request.contextPath}" />
<c:set scope="request" var="path" value="${pageContext.request.servletPath}" />

<sql:setDataSource scope="session" var="db" driver="org.postgresql.Driver" 
	url="jdbc:postgresql://localhost:5432/landbigdata" 
	user="landbigdata" password="landbigdata" 
/> 

<c:catch var="catchException">
	<sql:update dataSource="${db}" var="result">
		CREATE VIEW USERS AS 
		SELECT "MGR_ID" user_id, "MGR_GRADE" user_grade, "MGR_NAME" user_name, 
		"MGR_PW" user_pass, "MOD_DATE" mod_date
		FROM "MA_ADMIN_MGR"
	</sql:update>
</c:catch>

<c:if test="${true || catchException == null}">
	<!-- 사용자 뷰가 생성 되면 DB를 초기화 한다. -->
	<!--  db init -->
	<sql:update dataSource="${db}" var="result">
		DROP TABLE if exists access_url cascade ;
		DROP TABLE if exists user_access cascade ;

		CREATE TABLE access_url( url_id SERIAL PRIMARY KEY, url_text VARCHAR(1000 ), url_desc VARCHAR(1000) );
		CREATE TABLE user_access( user_id varchar(200), user_url_id int, url_access int default 0, primary key( user_id, user_url_id ) );
		
		INSERT INTO access_url(url_id, url_text, url_desc) values( 1, 'data_manage.jsp', '데이터 관리' );
		INSERT INTO access_url(url_id, url_text, url_desc) values( 2, 'model_manage.jsp', '모델 관리' );
		INSERT INTO access_url(url_id, url_text, url_desc) values( 3, 'user_list.jsp', '사용자 관리' );
		INSERT INTO access_url(url_id, url_text, url_desc) values( 4, 'user_info.jsp', '사용자 정보' );	 
		
		INSERT INTO user_access( user_id, user_url_id, url_access ) values( 'admin', 1, 1 );
		INSERT INTO user_access( user_id, user_url_id, url_access ) values( 'admin', 2, 1 );
		INSERT INTO user_access( user_id, user_url_id, url_access ) values( 'admin', 3, 0 ); 
		
	</sql:update>
</c:if>