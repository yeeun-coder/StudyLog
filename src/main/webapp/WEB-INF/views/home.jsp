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
<link rel="stylesheet" href="/css/calendar.css">
<style>

</style>
</head>
<body>
	<!-- Home.jsp -->
	<c:choose>
	    <c:when test="${not empty loginUser }">
	        <div class="d-flex justify-content-end mt-2 mb-3 me-3">
	            <span class="me-3">안녕하세요, ${loginUser.username}님</span>
	            <a href="/logout" class="btn btn-outline-danger btn-sm">로그아웃</a>
	        </div>
	    </c:when>
	</c:choose>
	<div class="container text-center mt-4">
	    <div class="card shadow p-5">
		    <div class="d-flex justify-content-between align-items-center mb-3">
			    <a href="/writeForm" class="btn btn-primary btn-lg header-btn">기록 작성</a>
			    <h1 class="display-4 m-0">StudyLog</h1>
			    <a href="/list" class="btn btn-success btn-lg header-btn">기록 목록</a>
			</div>
	        <p class="lead mb-4">나만의 공부 기록을 쉽고 빠르게 관리하세요!</p>
	
	        <div class="row mt-4 mb-4 text-center">
	            <div class="col-md-4 mb-3">
	                <div class="card shadow-sm p-4 bg-light">
	                    <h5>오늘 작성한 기록</h5>
	                    <h2 class="text-primary">${todayCount} 개</h2>
	                </div>
	            </div>
	            <div class="col-md-4 mb-3">
	                <div class="card shadow-sm p-4 bg-light">
	                    <h5>이번 주 기록 수</h5>
	                    <h2 class="text-primary">${thisWeekCount}개</h2>
	                </div>
	            </div>
	            <div class="col-md-4 mb-3">
	                <div class="card shadow-sm p-4 bg-light">
	                    <h5>이번 달 총 기록</h5>
	                    <h2 class="text-success">${monthCount} 개</h2>
	                </div>
	            </div>
	        </div>
	
	        <div class="row mt-4">
	            <div class="col-md-7">
	                <div class="card shadow-sm p-4 bg-light text-center">
	                    <div class="d-flex justify-content-between align-items-center mb-3">
	                        <a href="/home?month=${prevMonth}" class="btn btn-outline-primary btn-sm">이전달</a>
	                        <h5 class="mb-0">${currentMonth}</h5>
	                        <a href="/home?month=${nextMonth}" class="btn btn-outline-primary btn-sm">다음달</a>
	                    </div>
	
	                    <div class="calendar-grid mb-2 fw-bold">
						    <div>일</div><div>월</div><div>화</div><div>수</div><div>목</div><div>금</div><div>토</div>
						</div>
						
						<div class="calendar-grid">
						    <c:if test="${firstDayOfWeek > 1}">
							    <c:forEach var="i" begin="1" end="${firstDayOfWeek - 1}">
							        <div></div>
							    </c:forEach>
							</c:if>
							
							<c:forEach var="day" begin="1" end="${lastDayOfMonth}">
							    <c:set var="fullDate" value="${currentMonthLabel}-${day lt 10 ? '0' : ''}${day}" />
							    <c:set var="count" value="${recordCountMap[fullDate]}" />
							
							    <div class="calendar-day
							        ${count == null ? '' : 
							            (count <= 1 ? ' level-1' :
							            count <= 3 ? ' level-2' :
							            ' level-3')}
							        ${fullDate == today ? ' today' : ''}">
							        ${day}
							    </div>
							</c:forEach>
						</div>
	                </div>
	            </div>
	
	            <div class="col-md-5">
	                <div class="card shadow-sm p-4 bg-light text-start mb-4">
				    <h4 class="mb-4 text-center">가장 많이 기록한 과목 TOP 3</h4>
				
				    <c:choose>
				        <c:when test="${not empty subjectStats}">
				            <c:set var="max" value="${subjectStats[0][1]}" />
				
				            <c:forEach var="row" items="${subjectStats}" begin="0" end="${fn:length(subjectStats) - 1}" varStatus="status">
				                <c:if test="${status.index < 3}">
				                    <c:set var="percent" value="${(row[1] * 100) / max}" />
				
				                    <div class="mb-3">
				                        <strong>${status.index + 1}위 - ${row[0]} (${row[1]}개)</strong>
				                        <div class="progress mt-1" style="height: 20px;">
				                            <div class="progress-bar 
				                                ${status.index == 0 ? 'bg-success' : status.index == 1 ? 'bg-primary' : 'bg-warning'}"
				                                role="progressbar"
				                                style="width: ${percent}%">
				                            </div>
				                        </div>
				                    </div>
				                </c:if>
				
				            </c:forEach>
				        </c:when>
				        <c:otherwise>
				            <p class="text-center text-muted">이번 달에는 아직 기록이 없습니다.</p>
				        </c:otherwise>
				    </c:choose>
				</div>
	            </div>
	        </div> 
	    </div>
	</div>

	<c:if test="${param.success == '1' }">
	    <script>alert('로그인 성공!');</script>
	</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

</body>
</html>