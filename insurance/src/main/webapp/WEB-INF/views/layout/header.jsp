<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>

  <title>보험 문의/공유 게시판</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>

  <style>
    body { background:#f6f7fb; }
    .app-card { border:0; border-radius:16px; box-shadow: 0 8px 30px rgba(0,0,0,.06); }
    .badge-soft { background: rgba(13,110,253,.12); color:#0d6efd; border:1px solid rgba(13,110,253,.18); }
    .text-muted-2 { color:#6c757d; }
    .table td, .table th { vertical-align: middle; }
  </style>
</head>
<body>
<c:choose>
  <c:when test="${not empty sessionScope.loginMember}">
    <span>${sessionScope.loginMember.name}님</span>

    <form action="${pageContext.request.contextPath}/member/logout" method="post" style="display:inline;">
      <button type="submit">로그아웃</button>
    </form>
  </c:when>

  <c:otherwise>
    <a href="${pageContext.request.contextPath}/member/login">로그인</a>
    <a href="${pageContext.request.contextPath}/member/join">회원가입</a>
  </c:otherwise>
</c:choose>
<nav class="navbar navbar-expand-lg bg-white border-bottom">
  <div class="container">
    <a class="navbar-brand fw-bold" href="<c:url value='/board/list'/>">INS 커뮤니티</a>
    <div class="ms-auto">
      <a class="btn btn-primary btn-sm" href="<c:url value='/board/write'/>">글쓰기</a>
    </div>
  </div>
</nav>

<div class="container my-4">
  <c:if test="${not empty toast}">
    <div class="alert alert-success app-card p-3 mb-3">${toast}</div>
  </c:if>
