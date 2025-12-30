<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="app-card bg-white p-4">
  <c:if test="${not empty errorMessage}">
    <div class="alert alert-danger mb-0">${errorMessage}</div>
  </c:if>

  <c:if test="${empty errorMessage}">
    <div class="d-flex justify-content-between align-items-start mb-3">
      <div>
        <div class="mb-2">
          <span class="badge badge-soft">${board.category}</span>
          <span class="text-muted ms-2">조회 ${board.viewCount}</span>
        </div>
        <h3 class="fw-bold mb-1"><c:out value="${board.title}"/></h3>
        <div class="text-muted-2 small">
          작성일 <fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
        </div>
      </div>

      <div class="d-flex gap-2">
        <a class="btn btn-outline-secondary btn-sm" href="<c:url value='/board/list'/>">목록</a>
        <a class="btn btn-outline-primary btn-sm" href="<c:url value='/board/edit/${board.boardId}'/>">수정</a>

        <form id="delForm" method="post" action="<c:url value='/board/delete/${board.boardId}'/>">
          <button type="button" class="btn btn-outline-danger btn-sm" onclick="confirmDelete('delForm')">삭제</button>
        </form>
      </div>
    </div>

    <hr/>

    <div style="white-space: pre-wrap; line-height: 1.7;">
      <c:out value="${board.content}"/>
    </div>
  </c:if>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
