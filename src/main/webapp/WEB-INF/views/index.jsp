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
	<!-- index.jsp -->
	<div class="vh-100 d-flex flex-column justify-content-center align-items-center" style="background: linear-gradient(to right, #a8edea, #fed6e3);">
	    <div class="card shadow p-5 text-center" style="width: 500px; border-radius: 20px;backdrop-filter: blur(10px);background: rgba(255, 255, 255, 0.75);">
	        <h1 class="display-3 mb-4" style="color:#007bff;">StudyLog</h1>
	        <p class="lead mb-2 fw-bold text-dark">오늘의 학습 기록을 쉽게 관리해보세요!</p>
			<p class="text-muted small mb-4">매일의 공부를 기록하고, 나만의 성장을 확인하세요.</p>
	        <div class="d-flex justify-content-center gap-3">
	            <a href="/login" class="btn btn-primary btn-lg shadow">로그인</a>
	            <a href="/register" class="btn btn-success btn-lg shadow">회원가입</a>
	        </div>
	
	        <c:if test="${param.success == '1'}">
	            <script>alert('회원가입 성공! 로그인 해주세요.');</script>
	        </c:if>
	    </div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

</body>
</html>