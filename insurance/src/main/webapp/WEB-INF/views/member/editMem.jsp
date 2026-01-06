<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />
<c:set var="me" value="${sessionScope.loginMember}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>회원정보 수정 - INS 커뮤니티</title>

  <link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/resources/css/member.css'/>" />
</head>

<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="wrap">

  <div class="page-title">
    <div>
      <div class="brand">보험 문의/공유 게시판</div>
      <div class="crumb">회원 &gt; 회원정보 수정</div>
    </div>
    <div class="top-actions">
      <a class="btn ghost" href="<c:url value='/member/mypage'/>">내정보로</a>
    </div>
  </div>

  <div class="card">
    <div class="card-hd">
      <div>
        <h1 class="title">회원정보 수정</h1>
        <p class="sub">변경 가능한 항목: 비밀번호 / 이름 / 이메일</p>
      </div>
    </div>

    <div class="form-body">

      <c:if test="${not empty error}">
        <div class="msg err"><c:out value="${error}"/></div>
      </c:if>
      <c:if test="${not empty msg}">
        <div class="msg ok"><c:out value="${msg}"/></div>
      </c:if>

      <c:choose>
        <c:when test="${empty me}">
          <div class="msg err">세션 정보가 없습니다. 다시 로그인 해주세요.</div>
          <a class="btn primary" href="<c:url value='/member/login'/>">로그인</a>
        </c:when>

        <c:otherwise>
          <form method="post" action="<c:url value='/member/editMem'/>" autocomplete="off">

            <div class="form-grid member">

              <!-- 읽기전용 -->
              <div class="field">
                <label>회원ID</label>
                <div class="ro-box mono">#<c:out value="${me.memberId}"/></div>
              </div>

              <div class="field">
                <label>로그인 아이디</label>
                <div class="ro-box mono"><c:out value="${me.loginId}"/></div>
              </div>

              <div class="field">
                <label>권한</label>
                <div class="ro-box mono"><c:out value="${me.role}"/></div>
              </div>

              <div class="field">
                <label>사용여부</label>
                <div class="ro-box mono"><c:out value="${me.useYn}"/></div>
              </div>

              <div class="field form-row-full">
                <label>가입일</label>
                <div class="ro-box mono"><c:out value="${me.createdAt}"/></div>
              </div>

              <!-- 변경가능 -->
              <div class="field form-row-full">
                <label>비밀번호</label>
                <input class="input" type="password" name="password" placeholder="변경 시에만 입력 (미입력 시 유지)"/>
                <div class="help">비밀번호를 변경하지 않으려면 비워두세요.</div>
              </div>

              <div class="field">
                <label>이름</label>
                <input class="input" type="text" name="name" value="<c:out value='${me.name}'/>" required/>
              </div>

              <div class="field">
                <label>이메일</label>
                <input class="input" type="email" name="email" value="<c:out value='${me.email}'/>" required/>
              </div>

            </div>

            <div class="form-actions">
              <div></div>

              <div style="display:flex; gap:10px; flex-wrap:wrap;">
                <button type="submit" class="btn primary">수정 저장</button>

                <button type="submit"
                        class="btn danger"
                        formaction="<c:url value='/member/withdraw'/>"
                        formmethod="post"
                        onclick="return confirm('정말로 회원탈퇴 하시겠습니까? \n탈퇴 후에는 로그인할 수 없습니다.');">
                  회원탈퇴
                </button>

                <a class="btn" href="<c:url value='/member/mypage'/>">취소</a>
              </div>
            </div>

          </form>
        </c:otherwise>
      </c:choose>

    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>
