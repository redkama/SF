<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />
<c:set var="t" value="${target}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>회원 수정 - INS 커뮤니티</title>

  <link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/resources/css/member.css'/>" />
</head>

<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="wrap">

  <div class="page-title">
    <div>
      <div class="brand">보험 문의/공유 게시판</div>
      <div class="crumb">관리자 &gt; 회원 수정</div>
    </div>
    <div class="top-actions">
      <a class="btn ghost" href="<c:url value='/member/listMem'/>">목록으로</a>
    </div>
  </div>

  <div class="card">
    <div class="card-hd">
      <div>
        <h1 class="title">회원정보 수정</h1>
        <p class="sub">관리자 권한으로 회원 정보를 수정합니다.</p>
      </div>
    </div>

    <div class="form-body">

      <c:if test="${not empty error}">
        <div class="msg err"><c:out value="${error}"/></div>
      </c:if>
      <c:if test="${not empty msg}">
        <div class="msg ok"><c:out value="${msg}"/></div>
      </c:if>

      <c:if test="${empty t}">
        <div class="msg err">대상 회원 정보가 없습니다.</div>
        <a class="btn primary" href="<c:url value='/member/listMem'/>">목록으로</a>
      </c:if>

      <c:if test="${not empty t}">
        <form method="post" action="<c:url value='/member/editMemAdmin'/>" autocomplete="off">
          <input type="hidden" name="memberId" value="${t.memberId}"/>

          <div class="form-grid member">

            <!-- 읽기전용 -->
            <div class="field">
              <label>회원ID</label>
              <div class="ro-box mono">#<c:out value="${t.memberId}"/></div>
            </div>

            <div class="field">
              <label>로그인 아이디</label>
              <div class="ro-box mono"><c:out value="${t.loginId}"/></div>
            </div>

            <!-- 변경 가능 -->
            <div class="field form-row-full">
              <label>비밀번호</label>
              <input class="input" type="password" name="password" placeholder="변경 시에만 입력 (미입력 시 유지)"/>
              <div class="help">비밀번호를 변경하지 않으려면 비워두세요.</div>
            </div>

            <div class="field">
              <label>이름</label>
              <input class="input" type="text" name="name" value="<c:out value='${t.name}'/>" required/>
            </div>

            <div class="field">
              <label>권한</label>
              <select class="select" name="role" required>
                <option value="USER" <c:if test="${t.role eq 'USER'}">selected</c:if>>USER</option>
                <option value="COUNSELOR" <c:if test="${t.role eq 'COUNSELOR'}">selected</c:if>>COUNSELOR</option>
                <option value="ADMIN" <c:if test="${t.role eq 'ADMIN'}">selected</c:if>>ADMIN</option>
              </select>
            </div>

            <div class="field">
              <label>이메일</label>
              <input class="input" type="email" name="email" value="<c:out value='${t.email}'/>" required/>
            </div>

            <div class="field">
              <label>사용여부</label>
              <select class="select" name="useYn" required>
                <option value="Y" <c:if test="${t.useYn eq 'Y'}">selected</c:if>>Y</option>
                <option value="N" <c:if test="${t.useYn eq 'N'}">selected</c:if>>N</option>
              </select>
            </div>

          </div>

          <div class="form-actions">
            <div></div>

            <div style="display:flex; gap:10px; flex-wrap:wrap;">
              <button type="submit" class="btn primary">수정 저장</button>

              <button type="submit"
                      class="btn danger"
                      formaction="<c:url value='/member/deleteMemAdmin'/>"
                      formmethod="post"
                      onclick="return confirm('정말로 이 회원을 삭제(비활성화)하시겠습니까? \n삭제 후 로그인 불가 처리됩니다.');">
                회원 삭제
              </button>

              <a class="btn" href="<c:url value='/member/listMem'/>">취소</a>
            </div>
          </div>
        </form>
      </c:if>

    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>
