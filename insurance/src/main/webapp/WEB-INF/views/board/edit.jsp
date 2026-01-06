<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<%-- 목록으로 돌아갈 때 검색/필터/페이징 파라미터 유지 --%>
<c:url var="listUrl" value="/board/list">
  <c:if test="${not empty param.boardType}"><c:param name="boardType" value="${param.boardType}" /></c:if>
  <c:if test="${not empty param.insuranceType}"><c:param name="insuranceType" value="${param.insuranceType}" /></c:if>
  <c:if test="${not empty param.status}"><c:param name="status" value="${param.status}" /></c:if>
  <c:if test="${not empty param.openYn}"><c:param name="openYn" value="${param.openYn}" /></c:if>
  <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}" /></c:if>
  <c:if test="${not empty param.page}"><c:param name="page" value="${param.page}" /></c:if>
  <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}" /></c:if>
</c:url>

<%-- 상세로 돌아갈 때도 파라미터 유지 (boardId 포함) --%>
<c:url var="viewUrl" value="/board/view">
  <c:param name="boardId" value="${board.boardId}" />
  <c:if test="${not empty param.boardType}"><c:param name="boardType" value="${param.boardType}" /></c:if>
  <c:if test="${not empty param.insuranceType}"><c:param name="insuranceType" value="${param.insuranceType}" /></c:if>
  <c:if test="${not empty param.status}"><c:param name="status" value="${param.status}" /></c:if>
  <c:if test="${not empty param.openYn}"><c:param name="openYn" value="${param.openYn}" /></c:if>
  <c:if test="${not empty param.keyword}"><c:param name="keyword" value="${param.keyword}" /></c:if>
  <c:if test="${not empty param.page}"><c:param name="page" value="${param.page}" /></c:if>
  <c:if test="${not empty param.size}"><c:param name="size" value="${param.size}" /></c:if>
</c:url>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>게시글 수정 - INS 커뮤니티</title>

  <link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" />
</head>

<body class="board board-form">
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="wrap">

  <div class="page-title">
    <div>
      <h1>게시글 수정</h1>
      <div class="page-meta mono">
        #<c:out value="${board.boardId}"/> · 조회 <c:out value="${board.viewCnt}"/>
      </div>
    </div>

    <div class="top-actions">
      <a class="btn ghost" href="${listUrl}">목록</a>
      <a class="btn" href="${viewUrl}">상세</a>
    </div>
  </div>

  <c:if test="${not empty error}">
    <div class="msg err"><c:out value="${error}"/></div>
  </c:if>
  <c:if test="${not empty msg}">
    <div class="msg ok"><c:out value="${msg}"/></div>
  </c:if>

  <form method="post" action="<c:url value='/board/edit'/>">
    <input type="hidden" name="boardId" value="<c:out value='${board.boardId}'/>"/>

    <%-- (필요 시 서버에서 검증하더라도, 폼 제출 값이 필요하다면 hidden 유지) --%>
    <input type="hidden" name="memberId" value="<c:out value='${board.memberId}'/>"/>

    <div class="card">
      <div class="form-body">
        <div class="form-grid">

          <div class="field">
            <label>게시글 ID</label>
            <input class="inp ro" type="text" value="<c:out value='${board.boardId}'/>" readonly />
          </div>

          <div class="field">
            <label>조회수</label>
            <input class="inp ro" type="text" value="<c:out value='${board.viewCnt}'/>" readonly />
          </div>

          <div class="field">
            <label>작성자 회원ID</label>
            <input class="inp ro" type="text" value="<c:out value='${board.memberId}'/>" readonly />
          </div>

          <div class="field">
            <label>공개 여부</label>
            <select class="sel" name="openYn" required>
              <option value="Y" <c:if test="${board.openYn eq 'Y'}">selected</c:if>>공개</option>
              <option value="N" <c:if test="${board.openYn eq 'N'}">selected</c:if>>비공개</option>
            </select>
          </div>

          <div class="field">
            <label>게시글 유형</label>
            <select class="sel" name="boardType" required>
              <option value="INQUIRY" <c:if test="${board.boardType eq 'INQUIRY'}">selected</c:if>>문의</option>
              <option value="SHARE"   <c:if test="${board.boardType eq 'SHARE'}">selected</c:if>>공유</option>
            </select>
          </div>

          <div class="field">
            <label>보험 유형</label>
            <select class="sel" name="insuranceType" required>
              <option value="AUTO"   <c:if test="${board.insuranceType eq 'AUTO'}">selected</c:if>>자동차</option>
              <option value="HEALTH" <c:if test="${board.insuranceType eq 'HEALTH'}">selected</c:if>>건강</option>
              <option value="LIFE"   <c:if test="${board.insuranceType eq 'LIFE'}">selected</c:if>>생명</option>
              <option value="FIRE"   <c:if test="${board.insuranceType eq 'FIRE'}">selected</c:if>>화재</option>
            </select>
          </div>

          <div class="field">
            <label>상태</label>
            <select class="sel" name="status" disabled>
              <option value="WAIT"     <c:if test="${board.status eq 'WAIT'}">selected</c:if>>대기</option>
              <option value="ANSWERED" <c:if test="${board.status eq 'ANSWERED'}">selected</c:if>>답변완료</option>
              <option value="CLOSED"   <c:if test="${board.status eq 'CLOSED'}">selected</c:if>>종료</option>
            </select>
            <input type="hidden" name="status" value="<c:out value='${board.status}'/>"/>
          </div>

          <div class="field form-row-full">
            <label>제목</label>
            <input class="inp" type="text" name="title"
                   value="<c:out value='${board.title}'/>"
                   maxlength="200" required />
          </div>

          <div class="field form-row-full">
            <label>내용</label>
            <textarea class="ta ta-lg" name="content" required><c:out value="${board.content}"/></textarea>
          </div>

          <div class="field">
            <label>작성일</label>
            <input class="inp ro" type="text" value="<c:out value='${board.createdDate}'/>" readonly />
          </div>

          <div class="field">
            <label>수정일</label>
            <input class="inp ro" type="text" value="<c:out value='${board.updatedAt}'/>" readonly />
          </div>

        </div>
      </div>

      <div class="form-actions">
        <a class="btn" href="${viewUrl}">취소</a>

        <div style="display:flex; gap:10px; flex-wrap:wrap;">
          <button class="btn primary" type="submit">저장</button>
          <button class="btn danger" type="button" onclick="submitDelete()">삭제</button>
        </div>
      </div>
    </div>
  </form>

  <form id="deleteForm" method="post" action="<c:url value='/board/delete'/>" style="display:none;">
    <input type="hidden" name="boardId" value="<c:out value='${board.boardId}'/>"/>
  </form>

  <script>
    function submitDelete(){
      if(confirm('정말 삭제하시겠습니까? 삭제 후 복구가 어렵습니다.')){
        document.getElementById('deleteForm').submit();
      }
    }
  </script>

</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>
