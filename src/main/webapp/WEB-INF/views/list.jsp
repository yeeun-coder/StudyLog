<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

</head>
<body>
	<!-- list.jsp -->
	<c:if test="${not empty loginUser }">
	    <div class="d-flex justify-content-end mt-2 mb-3 me-3">
	        <span class="me-3">안녕하세요, ${loginUser.username }님</span>
	        <a href="/logout" class="btn btn-outline-danger btn-sm">로그아웃</a>
	    </div>
	</c:if>
	
	<div class="container">
	    <div class="card shadow p-4" style="border-radius: 15px;">
	        <div class="d-flex justify-content-between align-items-center mb-3">
	            <h2>수업 기록 목록</h2>
	            <form action="/list" method="get" class="d-flex flex-nowrap gap-2 align-items-center">
				    <input type="text" name="keyword" value="${keyword}" class="form-control form-control-sm"
				           placeholder="제목 또는 과목 검색" style="width:200px;">
				    <input type="date" name="date" value="${date}" class="form-control form-control-sm" style="width:150px;">
				    <button type="submit" class="btn btn-primary btn-sm">검색</button>
				</form>
	            <a href="/writeForm" class="btn btn-success">새 기록 작성</a>
	        </div>
	
	        <div class="table-responsive">
	            <table class="table table-striped table-hover align-middle">
	                <thead class="table-primary">
	                    <tr>
	                        <th>날짜</th>
	                        <th>과목</th>
	                        <th>제목</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <c:forEach var="note" items="${notes }">
	                        <tr>
	                            <td>${note.noteDate }</td>
	                            <td>${note.subject }</td>
	                            <td><a href="/detail?id=${note.id }" class="text-decoration-none">${note.title }</a></td>
	                        </tr>
	                    </c:forEach>
	                </tbody>
	            </table>
	        </div>
	
	        <div class="mt-3 text-end">
	            <a href="/home" class="btn btn-secondary">홈으로</a>
	        </div>
	    </div>
	</div>
		
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

</body>
</html>