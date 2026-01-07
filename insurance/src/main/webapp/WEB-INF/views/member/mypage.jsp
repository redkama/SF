<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="cpath" value="${pageContext.request.contextPath}" />
<c:set var="me" value="${sessionScope.loginMember}" />

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>내 정보 - INS 커뮤니티</title>

  <link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" />
  <link rel="stylesheet" href="<c:url value='/resources/css/member.css'/>" />
</head>

<body>
<%@ include file="/WEB-INF/views/layout/header.jsp" %>

<div class="wrap">

  <div class="page-title">
    <div>
      <div class="brand">보험 문의/공유 게시판</div>
      <div class="crumb">회원 &gt; 내 정보</div>
    </div>
    <div class="top-actions">
      <a class="btn ghost" href="<c:url value='/board/list'/>">목록으로</a>
    </div>
  </div>

  <div class="card">
    <div class="card-hd">
      <div>
        <h1 class="title">내 정보</h1>
        <p class="sub">로그인된 계정 정보를 확인합니다.</p>
      </div>
    </div>

    <div class="card-bd">

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
          <div class="kv">
            <div class="k">회원ID</div>
            <div class="v mono">#<c:out value="${me.memberId}"/></div>

            <div class="k">로그인 아이디</div>
            <div class="v mono"><c:out value="${me.loginId}"/></div>

            <div class="k">비밀번호</div>
            <div class="v">****</div>

            <div class="k">이름</div>
            <div class="v"><c:out value="${me.name}"/></div>

            <div class="k">권한</div>
            <div class="v mono"><c:out value="${me.role}"/></div>

            <div class="k">이메일</div>
            <div class="v"><c:out value="${me.email}"/></div>

            <div class="k">사용여부</div>
            <div class="v mono"><c:out value="${me.useYn}"/></div>

            <div class="k">가입일</div>
            <div class="v mono"><c:out value="${me.createdAt}"/></div>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
    
    <c:if test="${not empty me}">
	  <div class="form-actions">
	    <div></div>
	    <div style="display:flex; gap:10px; flex-wrap:wrap;">
	      <a class="btn primary" href="<c:url value='/member/editMem'/>">회원정보 수정</a>
	      <a class="btn" href="<c:url value='/board/list'/>">확인</a>
	    </div>
	  </div>
	</c:if>
    
  </div>

</div>

<%@ include file="/WEB-INF/views/layout/footer.jsp" %>
</body>
</html>
