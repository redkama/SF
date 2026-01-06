<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />

<header class="site-header">
  <div class="site-bar">
    <a class="site-brand" href="${cpath}/board/list">INS 커뮤니티</a>

    <div class="site-auth">
      <c:choose>
        <c:when test="${not empty sessionScope.loginMember}">
          <a class="who-link" href="${cpath}/member/mypage">
            <strong><c:out value="${sessionScope.loginMember.name}"/></strong>님
            <span style="color:var(--muted)">(내정보)</span>
          </a>

          <c:if test="${sessionScope.loginMember.role eq 'ADMIN'}">
            <a class="btn primary" href="${cpath}/member/listMem">회원정보 리스트</a>
          </c:if>

          <form action="${cpath}/member/logout" method="post" style="display:inline;">
            <button type="submit" class="btn ghost">로그아웃</button>
          </form>
        </c:when>

        <c:otherwise>
          <a class="btn ghost" href="${cpath}/member/login">로그인</a>
          <a class="btn primary" href="${cpath}/member/join">회원가입</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</header>
