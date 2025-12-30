<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/layout/header.jsp"/>

<div class="app-card bg-white p-4">
  <h4 class="fw-bold mb-3">글쓰기</h4>

  <form method="post" action="<c:url value='/board/write'/>">
    <div class="mb-3">
      <label class="form-label">카테고리</label>
      <select class="form-select" name="category" required>
        <option value="">선택</option>
        <option value="QNA">문의(QNA)</option>
        <option value="CLAIM">보상/클레임</option>
        <option value="TIP">꿀팁/공유</option>
      </select>
    </div>

    <div class="mb-3">
      <label class="form-label">제목</label>
      <input class="form-control" name="title" maxlength="100" required placeholder="예) 자동차보험 접수 절차 문의드립니다"/>
    </div>

    <div class="mb-3">
      <label class="form-label">내용</label>
      <textarea class="form-control" name="content" rows="10" required
                placeholder="상황/증상/원하는 답변을 구체적으로 적어주세요."></textarea>
    </div>

    <div class="d-flex justify-content-end gap-2">
      <a class="btn btn-outline-secondary" href="<c:url value='/board/list'/>">취소</a>
      <button class="btn btn-primary">등록</button>
    </div>
  </form>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
