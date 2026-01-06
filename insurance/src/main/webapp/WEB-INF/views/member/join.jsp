<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>회원가입 - INS 커뮤니티</title>

  <link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/resources/css/member.css'/>" />
</head>

<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="wrap">
  <div class="page-title">
    <div>
      <div class="brand">보험 문의/공유 게시판</div>
      <div class="crumb">회원 &gt; 회원가입</div>
    </div>
    <div class="top-actions">
      <a class="btn ghost" href="<c:url value='/board/list'/>">목록으로</a>
    </div>
  </div>

  <div class="card narrow">
    <div class="card-hd">
      <div>
        <h1 class="title">회원가입</h1>
        <p class="sub">가입 후 로그인하면 글 작성/수정/삭제가 가능합니다.</p>
      </div>
    </div>

    <div class="card-bd">
      <c:if test="${not empty error}">
        <div class="msg err"><c:out value="${error}"/></div>
      </c:if>
      <c:if test="${not empty msg}">
        <div class="msg ok"><c:out value="${msg}"/></div>
      </c:if>

      <form action="<c:url value='/member/join'/>" method="post" class="auth-grid" autocomplete="off">
        <div class="field">
          <label for="loginId">아이디</label>
          <input class="input" type="text" id="loginId" name="loginId"
                 value="<c:out value='${form.loginId}'/>" placeholder="예) user01" required />
        </div>

        <div class="field">
          <label for="password">비밀번호</label>
          <input class="input" type="password" id="password" name="password"
                 placeholder="비밀번호 입력" required />
        </div>

        <div class="field">
          <label for="name">이름</label>
          <input class="input" type="text" id="name" name="name"
                 value="<c:out value='${form.name}'/>" placeholder="이름 입력" required />
        </div>

        <div class="field">
          <label for="email">이메일</label>
          <input class="input" type="email" id="email" name="email"
                 value="<c:out value='${form.email}'/>" placeholder="예) user01@email.com" required />
        </div>

        <input type="hidden" name="role" value="USER"/>

        <div class="auth-actions">
          <button type="submit" class="btn primary">가입하기</button>
          <a class="btn" href="<c:url value='/member/login'/>">로그인으로</a>
        </div>
      </form>

      <div class="help-sm">
        이미 계정이 있다면 <a href="<c:url value='/member/login'/>">로그인</a>을 진행해 주세요.
      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>
