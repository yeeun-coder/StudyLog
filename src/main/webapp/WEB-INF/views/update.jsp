<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
	<!-- update.jsp -->
	<div class="container mt-5">
	    <c:if test="${not empty loginUser}">
	        <div class="d-flex justify-content-end mb-4">
	            <span class="me-3">안녕하세요, ${loginUser.username}님</span>
	            <a href="/logout" class="btn btn-outline-danger btn-sm">로그아웃</a>
	        </div>
	    </c:if>
	
	    <div class="card shadow p-4 mb-4" style="border-radius:15px;">
	        <h2 class="mb-4">기록 수정</h2>
	
	        <form action="/update" method="post">
	            <input type="hidden" name="id" value="${note.id}">
	            
	            <div class="mb-3">
	                <label class="form-label">제목</label>
	                <input type="text" name="title" class="form-control" value="${note.title}">
	            </div>
	
	            <div class="mb-3">
	                <label class="form-label">날짜</label>
	                <input type="date" name="noteDate" class="form-control" value="${note.noteDate}">
	            </div>
	            
	            <div class="mb-3">
	                <label class="form-label">과목</label>
	                <input type="text" name="subject" class="form-control" value="${note.subject}">
	            </div>
	
	            <div class="mb-3">
	                <label class="form-label">내용</label>
	                <textarea name="content" rows="5" class="form-control">${note.content}</textarea>
	            </div>
	
	            <div class="mb-3">
	                <label class="form-label">코드</label>
	                <textarea name="code" rows="6" class="form-control">${note.code}</textarea>
	            </div>
	
	            <div class="text-end mt-4">
	                <button type="submit" class="btn btn-primary">수정 완료</button>
	                <a href="/detail?id=${note.id}" class="btn btn-secondary">취소</a>
	            </div>
	        </form>
	    </div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
