<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

</head>
<body>
	<!-- detail.jsp -->
	<div class="container mt-5">
	    <c:if test="${not empty loginUser }">
	        <div class="d-flex justify-content-end mb-4">
	            <span class="me-3">안녕하세요, ${loginUser.username }님</span>
	            <a href="/logout" class="btn btn-outline-danger btn-sm">로그아웃</a>
	        </div>
	    </c:if>
	
	    <div class="card shadow p-4 mb-4" style="border-radius:15px;">
	        <h2 class="card-title mb-3">${note.title }</h2>	        
	        <p class="text-muted mb-3">날짜: ${note.noteDate }</p>
	        <p class="text-muted mb-3">과목: ${note.subject }</p>
	
	        <h5>내용</h5>
	        <%
			    com.example.demo.entity.Note noteObj =
			        (com.example.demo.entity.Note) request.getAttribute("note");
			
			    String content = noteObj.getContent();
			    if (content != null) {
			        content = content.replace("\n", "<br/>");
			    }
			%>
			
			<div class="card mb-3 p-3 bg-light">
			    <%= content %>
			</div>
	
	        <c:if test="${not empty note.code}">
			    <h5>코드</h5>
			    <div class="card p-3 bg-light border rounded overflow-auto" style="max-height:300px;">
			        <pre><code>${fn:escapeXml(note.code)}</code></pre>
			    </div>
			</c:if>
			<div class="test mt-3">
				<div class="d-flex justify-content-between align-items-center mb-3">
		            <div>
			            <a href="/update?id=${note.id}" class="btn btn-primary me-2">수정</a>
			            <a href="/delete?id=${note.id}" class="btn btn-danger"
			               onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
			        </div>
					<a href="/list" class="btn btn-secondary">목록으로</a>
		        </div>
		    </div>
	    </div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

</body>
</html>