<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="app-card bg-white p-4">
  <c:if test="${not empty errorMessage}">
    <div class="alert alert-danger mb-0">${errorMessage}</div>
  </c:if>

  <c:if test="${empty errorMessage}">
    <h4 class="fw-bold mb-3">게시글 수정</h4>

    <form method="post" action="<c:url value='/board/edit'/>">
      <input type="hidden" name="boardId" value="${board.boardId}"/>

      <div class="mb-3">
        <label class="form-label">카테고리</label>
        <select class="form-select" name="category" required>
          <option value="QNA"   <c:if test="${board.category=='QNA'}">selected</c:if>>문의(QNA)</option>
          <option value="CLAIM" <c:if test="${board.category=='CLAIM'}">selected</c:if>>보상/클레임</option>
          <option value="TIP"   <c:if test="${board.category=='TIP'}">selected</c:if>>꿀팁/공유</option>
        </select>
      </div>

      <div class="mb-3">
        <label class="form-label">제목</label>
        <input class="form-control" name="title" value="${board.title}" maxlength="100" required/>
      </div>

      <div class="mb-3">
        <label class="form-label">내용</label>
        <textarea class="form-control" name="content" rows="10" required>${board.content}</textarea>
      </div>

      <div class="d-flex justify-content-end gap-2">
        <a class="btn btn-outline-secondary" href="<c:url value='/board/detail/${board.boardId}'/>">취소</a>
        <button class="btn btn-primary">저장</button>
      </div>
    </form>
  </c:if>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
