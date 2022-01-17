<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="100_common.jsp" />

<c:set var="a" value="1,2354" />

<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="200_html_head.jsp" /> 
</head>

<body>

<jsp:include page="210_header.jsp" />
        
<div class="jumbotron text-center">
  <br/>
  <h1>My First Bootstrap Page</h1>
  
  <h2>${contextPath}</h2>
  <p>Resize this responsive page to see the effect!</p>
</div>
  
<div class="container">
  <div class="row">
    <div class="col-sm-4">
      <h3>Column 1</h3>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
    </div>
    <div class="col-sm-4">
      <h3>Column 2</h3>
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
    </div>
    <div class="col-sm-4">
      <h3>Column 3</h3>        
      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
    </div>
  </div>
</div>

<table border = "1" width = "100%">
    <tr>
       <th>ID</th>
       <th>NAME</th>
       <th>REG_ID</th>
    </tr>
    
    <sql:query dataSource="${db}" var="result" >
		SELECT * FROM MA_ADMIN_MGR LIMIT 5
	</sql:query>
	
    <c:forEach var = "row" items = "${result.rows}">
       <tr>
          <td> <c:out value = "${row.mgr_id}"/></td>
          <td> <c:out value = "${row.mgr_name}"/></td>
          <td> <c:out value = "${row.reg_id}"/></td>
       </tr>
    </c:forEach>
</table>

<jsp:include page="220_footer.jsp" />

</body>
</html>
