<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />
<c:set var="me" value="${sessionScope.loginMember}" />

<%-- (옵션) write에서 목록 복귀 시 파라미터 유지하고 싶으면 그대로 사용 가능 --%>
<c:url var="listUrl" value="/board/list">
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
  <title>게시글 작성 - INS 커뮤니티</title>

  <link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/resources/css/board.css'/>" />
</head>

<body class="board board-form">
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="wrap">

  <div class="page-title">
    <div>
      <h1>게시글 작성</h1>
      <div class="page-meta">
        board_type / insurance_type / status / open_yn까지 모두 입력
      </div>
    </div>

    <div class="top-actions">
      <a class="btn" href="${listUrl}">목록</a>
    </div>
  </div>

  <c:if test="${not empty error}">
    <div class="msg err"><c:out value="${error}"/></div>
  </c:if>
  <c:if test="${not empty msg}">
    <div class="msg ok"><c:out value="${msg}"/></div>
  </c:if>

  <c:choose>
    <c:when test="${empty me}">
      <div class="msg err">로그인이 필요합니다. 로그인 후 글 작성이 가능합니다.</div>
      <div style="display:flex; gap:10px; flex-wrap:wrap;">
        <a class="btn primary" href="<c:url value='/member/login'/>">로그인</a>
        <a class="btn" href="${listUrl}">목록으로</a>
      </div>
    </c:when>

    <c:otherwise>
      <form method="post" action="<c:url value='/board/write'/>">
        <div class="card">

          <div class="form-body">
            <div class="form-grid">

              <div class="field">
                <label>작성자 로그인ID</label>
                <input class="inp ro" type="text" value="<c:out value='${me.loginId}'/>" readonly />
                <input type="hidden" name="memberId" value="<c:out value='${me.memberId}'/>" />
              </div>

              <div class="field">
                <label>게시글 유형</label>
                <select class="sel" name="boardType" required>
                  <option value="INQUIRY">문의</option>
                  <option value="SHARE">공유</option>
                </select>
              </div>

              <div class="field">
                <label>보험 유형</label>
                <select class="sel" name="insuranceType" required>
                  <option value="AUTO">자동차</option>
                  <option value="HEALTH">건강</option>
                  <option value="LIFE">생명</option>
                  <option value="FIRE">화재</option>
                </select>
              </div>

              <div class="field">
                <label>상태</label>
                <input class="inp ro" type="text" value="대기" readonly />
                <input type="hidden" name="status" value="WAIT" />
              </div>

              <div class="field">
                <label>공개 여부</label>
                <select class="sel" name="openYn" required>
                  <option value="Y" selected>공개</option>
                  <option value="N">비공개</option>
                </select>
              </div>

              <div class="field"></div>

              <div class="field form-row-full">
                <label>제목</label>
                <input class="inp" type="text" name="title" maxlength="200" required/>
              </div>

              <div class="field form-row-full">
                <label>내용</label>
                <textarea class="ta ta-lg" name="content" required></textarea>
              </div>

            </div>
          </div>

          <div class="form-actions">
            <a class="btn" href="${listUrl}">취소</a>
            <button class="btn primary" type="submit">등록</button>
          </div>

        </div>
      </form>
    </c:otherwise>
  </c:choose>

</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>
