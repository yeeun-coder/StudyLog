<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<!-- register.jsp -->
	<div class="d-flex justify-content-center align-items-center vh-100 bg-light">
	    <div class="card shadow p-5" style="width: 400px;">
	        <h2 class="text-center mb-4">회원가입</h2>
	        
	        <form action="/register" method="post">
	            <div class="mb-3">
	                <label class="form-label">이름</label>
	                <input type="text" class="form-control" name="username" value="${username }" required>
	            </div>
	            <div class="mb-3">
	                <label class="form-label">이메일</label>
	                <input type="email" class="form-control" name="email" value="${email }" required>
	            </div>
	            <div class="mb-3">
	                <label class="form-label">비밀번호</label>
	                <input type="password" class="form-control" name="password" required>
	            </div>
	            <div class="mb-3">
	                <label class="form-label">비밀번호 확인</label>
	                <input type="password" class="form-control" name="passwordCheck" required>
	            </div>
	            <div class="d-grid mb-3">
	                <button type="submit" class="btn btn-success">회원가입</button>
	            </div>
	        </form>
			
			<!-- 애러 처리 -->
	        <c:if test="${not empty error}">
	            <div class="alert alert-danger text-center">${error}</div>
	        </c:if>
	
	        <c:if test="${param.success == '1'}">
	            <script>alert('회원가입 성공! 로그인 해주세요.');</script>
	        </c:if>
	
	        <div class="text-center mt-3">
	            이미 계정이 있으신가요? <a href="/login">로그인</a>
	        </div>
	    </div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
