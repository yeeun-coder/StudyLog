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
	<!-- write.jsp -->
	<c:if test="${not empty loginUser }">
	    <div class="d-flex justify-content-end mt-2 mb-2 me-3">
	        <span class="me-3">안녕하세요, ${loginUser.username }님</span>
	        <a href="/logout" class="btn btn-outline-danger btn-sm">로그아웃</a>
	    </div>
	</c:if>
	
	<div class="container d-flex justify-content-center mt-5">
	    <div class="card shadow p-4" style="width: 700px; border-radius: 15px;">
	        <div class="position-relative mb-4">
			    <h2 class="text-center">수업 기록 작성</h2>
			    <a href="/list" class="btn btn-secondary position-absolute" 
			       style="right: 0; top: 50%; transform: translateY(-50%);">목록으로
			    </a>
			</div>

	        <form action="/write" method="post">
	            <div class="mb-3">
	                <label class="form-label">날짜</label>
	                <input type="date" name="noteDate" class="form-control" value="${noteDate}">
	            </div>
	            <div class="mb-3">
	                <label class="form-label">과목</label>
	                <input type="text" name="subject" id="subject" class="form-control" placeholder="과목을 입력하세요" value="${subject}">
	            </div>
	            <div class="mb-3">
	                <label class="form-label">제목</label>
	                <input type="text" name="title" class="form-control" placeholder="제목을 입력하세요" value="${title}">
	            </div>
	            <div class="mb-3">
	                <label class="form-label">내용</label>
	                <textarea name="content" class="form-control" rows="5" placeholder="수업 내용을 입력하세요">${content}</textarea>
	            </div>
	            <div class="mb-3">
	                <label class="form-label">코드</label>
	                <textarea name="code" class="form-control" rows="5" placeholder="코드가 있으면 입력하세요">${code}</textarea>
	            </div>
	            <c:if test="${not empty errorMessage}">
				    <div style="color: red; font-weight: bold;">
				        ${errorMessage}
				    </div>
				</c:if>
	            <div class="text-center">
	                <button type="submit" class="btn btn-primary btn-lg shadow">저장</button>
	            </div>
	        </form>
	    </div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<script>
    document.getElementById("subject").addEventListener("input", function() {
        let value = this.value;
        value = value.toUpperCase();
        value = value.replace(/\s+/g, "");

        this.value = value;
    });
</script>
</body>
</html>