<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<!-- login.jsp -->
	<div class="d-flex justify-content-center align-items-center vh-100 bg-light">
		<div class="card shadow p-5" style="width: 400px;">
		    <h2 class="text-center mb-4">로그인</h2>
		    <form action="/login" method="post">
		        <div class="mb-3">
		            <label class="form-label">이름</label>
		            <input type="text" class="form-control" name="username" value="${username }">
		        </div>
		        <div class="mb-3">
		            <label class="form-label">비밀번호</label>
		            <input type="password" class="form-control" name="password">
		        </div>
		        <div class="d-grid mb-3">
	                <button type="submit" class="btn btn-primary">로그인</button>
	            </div>
		    </form>
			
			<!-- 에러 처리 -->
		    <c:if test="${not empty error }">
		        <div style="color:red">${error }</div>
		    </c:if>
		    <c:if test="${param.success == '1'}">
		        <script>alert('로그인 성공!' );</script>
		    </c:if>
		    <div class="text-center mt-3">
	            계정이 없으신가요? <a href="/register">회원가입</a>
	        </div>
		</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
